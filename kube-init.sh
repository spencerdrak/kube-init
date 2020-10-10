#!/bin/bash -xe


"$(which kubectl)" create namespace cert-manager
"$(which helm)" repo add jetstack https://charts.jetstack.io
"$(which helm)" repo update

"$(which helm)" install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.2 \
  --set installCRDs=true

"$(which kubectl)" --namespace cert-manager wait --for=condition=Ready pods --all

"$(which kubectl)" apply -f ./cluster-issuer.yaml

"$(which kubectl)" create namespace ingress-nginx

"$(which helm)" repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
"$(which helm)" --namespace ingress-nginx install ingress-nginx ingress-nginx/ingress-nginx