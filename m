Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058CFC433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD44161247
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhKSN7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhKSN7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 08:59:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE8C061748
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:56:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7572629wme.4
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0X9f82GRCTJvZMvCaSav9/p9GcDEnxi+Jdi/P7WUMK8=;
        b=QONNB5JOQvufcpgEPDzrebMm2AanoQyz7+MgelJ3eALYHgrycoAfc/zvlZ0zERoSGz
         nnxaujiO2UmjLW5e4tJpjkQsc0ZFNzIVNaM2f9yBgCSVJm7reptTpgbljrUiLDx8jXrO
         I6nnFEi+9qQgfjOecuLKn2dyM7/sSzzZUw9flNJ+AD321EngJXATrKLTyhoW/sILfqlR
         bVPxkWh+9okdFL7mEN8U39G35AAn1+3eJkhGH5WX2yGJFXw8mq7Gmcb11TWa1Wm+O5+z
         rxK4tt956IMYyz//Qn10I4d4Q/fD6xUR904GT2fSS7rmI7vrrEggzYsUkw2B3MmzOEoK
         BnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0X9f82GRCTJvZMvCaSav9/p9GcDEnxi+Jdi/P7WUMK8=;
        b=dPhPHnJbIm7KVLE5tbUPUI8ljkan1bw25aDi+GXaSmAUR1mhSBvMBgEMsukT4gwvXW
         bxx0TPtiIgb15Nzg428KH5fAeKjSPlpE93Sazd1mOk5P/HSE8PVulrbi2nAMIE3hoZ/u
         5ev+B/4Yl9ah2EYvN+HFkWe39M/cxrQ9GJqP3THfTXBCw7GIsIUUJMBkyF7xxXc9F1kz
         DrpbsNipaMvadFalPP+10wA4/vl0OdrUYFNezGksNWixP0lDPWcJr8QwbBTn4rI93kwq
         qo55EFOhLYa0MajH/dZukzxjtZ9Ryc3/M7k+TmdXbww+/daaiGj75i+cpCFrqfwihESD
         mj9A==
X-Gm-Message-State: AOAM531YH8I5zi9oBrrajmhwn62uGodcgBmczEcpto+0MZ0+2Sr6GBHx
        5g7uI1+j0uDndV0Hg6SnKJlp3HZgveP3vw==
X-Google-Smtp-Source: ABdhPJxcsMuG30RIXthkPrKT26tfNO1AatuIk0RkpUtfixK0jgiEgtxCjXtYMs5xekgrdWK9MwboZw==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr7227871wmr.45.1637330176191;
        Fri, 19 Nov 2021 05:56:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15sm4488823wri.50.2021.11.19.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:56:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] CI: rename the "Linux32" job to lower-case "linux32"
Date:   Fri, 19 Nov 2021 14:56:07 +0100
Message-Id: <patch-2.2-9b8a3f0cdc4-20211119T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.g5753b56b5c1
In-Reply-To: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to the preceding commit's shortening of CI job names,
rename the only job that starts with an upper-case letter to be
consistent with the rest. It was added in 88dedd5e72c (Travis: also
test on 32-bit Linux, 2017-03-05).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml        | 2 +-
 .travis.yml                       | 2 +-
 ci/install-docker-dependencies.sh | 2 +-
 ci/lib.sh                         | 2 +-
 ci/run-docker-build.sh            | 2 +-
 ci/run-docker.sh                  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 8f4caa8f040..9c4af979559 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -267,7 +267,7 @@ jobs:
         - jobname: linux-musl
           os: alpine
           image: alpine
-        - jobname: Linux32
+        - jobname: linux32
           os: ubuntu32
           image: daald/ubuntu32:xenial
         - jobname: pedantic
diff --git a/.travis.yml b/.travis.yml
index 908330a0a3d..73f983776c7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -25,7 +25,7 @@ matrix:
       os: linux
       dist: trusty
       compiler:
-    - env: jobname=Linux32
+    - env: jobname=linux32
       os: linux
       compiler:
       addons:
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index 07a8c6b199d..78b7e326da6 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -4,7 +4,7 @@
 #
 
 case "$jobname" in
-Linux32)
+linux32)
 	linux32 --32bit i386 sh -c '
 		apt update >/dev/null &&
 		apt install -y build-essential libcurl4-openssl-dev \
diff --git a/ci/lib.sh b/ci/lib.sh
index 82cb17f8eea..83c2e08be79 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -222,7 +222,7 @@ osx-clang|osx-gcc)
 	;;
 linux-gcc-default)
 	;;
-Linux32)
+linux32)
 	CC=gcc
 	;;
 linux-musl)
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index 8d47a5fda3b..886fa33e148 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -15,7 +15,7 @@ then
 fi
 
 case "$jobname" in
-Linux32)
+linux32)
 	switch_cmd="linux32 --32bit i386"
 	;;
 linux-musl)
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index 37fa372052d..6663d56ade6 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -6,7 +6,7 @@
 . ${0%/*}/lib.sh
 
 case "$jobname" in
-Linux32)
+linux32)
 	CI_CONTAINER="daald/ubuntu32:xenial"
 	;;
 linux-musl)
-- 
2.34.0.823.g5753b56b5c1

