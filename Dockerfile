FROM node:18-alpine AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

ENV REACT_APP_BASE_URL=

RUN npm run build

# Use separate stage for deployable image
FROM nginx:stable-alpine-perl

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /usr/src/app/build/ /usr/share/nginx/html

EXPOSE 8080
