Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA8C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCYTaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCYTaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA491F379D
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so11493093ljw.8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Arl5fNHfRDQr4YVcYs0S5N6tPNZ0U30w8Qi/kx852I=;
        b=ZlC6WtLviwyos4pD1furp+sktRJuakW21SmECDzFDADIJGromiGIBF7iVUWwpgjAck
         Sm1TFlALop8ny+22HfCo5d0H539GdolRcl47W6e7rKRd5Ne60dBs/I8sX22ZGFs6uUiT
         y5DzRhLHVFFQM83u+djQQJQVtpBFq82TH/xEaZu0FnER8S0K8uW5OJEIclCihiCLsVWa
         0s0VkB+JmmHsfD0YQ0b7DoghwsFhE8q8kb48xtKRjmXrY/xmctCHsGQO2N0myRLQgSJk
         8dvgP0lz3NNEwHKqnVb88HJM4frHLUarXIP9+5j2EkNf8Wh0dTR3N8Q+N1ZwvSPOtPHJ
         1ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Arl5fNHfRDQr4YVcYs0S5N6tPNZ0U30w8Qi/kx852I=;
        b=y3v5gAoCqU9bSyAQkM1lbwO4qYXzeCQKSt7iJvEU96Ow3651heJTJcr9MgzRZkDQm9
         Qfm+RSTfFnw1sxkp4rKXRnjcSvbp4FqXMuId6zzI5rUndPhNFi90AZETUlcnRHJTT6jz
         cu6/HYV1uc9Z/Ixo8+Xe2ylk0hvsengFPdeObltU7LUudbj8f5Txqbfd5AuC4OBJQiwz
         obyVRjEL4C7DDNGfg557Va/DdwbkmWNRVglRPjTQyY/JVDzRghfD3gjOZtmu5YmUkpyN
         irIRyuyg3RGZbYb30j2IpseGoHmJfaQgwaJYDvrEwX0w+jGgE65DV0K7/YcmardJPGs8
         pxxg==
X-Gm-Message-State: AOAM5312eaP7LPVn9Ab/ANgKGDB8d+AJQNBGxXULh/n4k8yXbPT5wi1H
        2Szx36rJz4+gLgq0fhCeLnfR8/UGm/DaNg==
X-Google-Smtp-Source: ABdhPJyJIWaud9oWspJsy+153ijrks8ybs1UB8FRfstqollZTyjGHcAWXAn/j0jbEQIJKpXAH4N5Sg==
X-Received: by 2002:a05:6000:186d:b0:204:110a:d832 with SMTP id d13-20020a056000186d00b00204110ad832mr10291524wri.47.1648233514068;
        Fri, 25 Mar 2022 11:38:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/25] CI: combine ci/install{,-docker}-dependencies.sh
Date:   Fri, 25 Mar 2022 19:38:07 +0100
Message-Id: <patch-v2-16.25-ba4ed216769-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the "ci/install-dependencies.sh" and
"ci/install-docker-dependencies.sh" into one script. The "case"
statement in the latter only cared about "$jobname", and can be folded
into the same "case" statement in the former.

The reason they split up is historical, and because the
"ci/install-dependencies.sh" used "ci/lib.sh", which requires
"bash". At least one of the docker containers doesn't have "bash". To
make the existing code POSIX-compatible we need to replace pushd/popd
with a sub-shell, but no other changes were needed.

This also fixes issue in "ci/install-docker-dependencies.sh" where
we'd hide errors due to not using "set -e". Now that we include
"ci/lib.sh" we won't have that potential issue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml        |  2 +-
 ci/install-dependencies.sh        | 27 ++++++++++++++++++++++-----
 ci/install-docker-dependencies.sh | 22 ----------------------
 3 files changed, 23 insertions(+), 28 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 92b914f16fd..3fd3e4f873c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -311,7 +311,7 @@ jobs:
     container: ${{matrix.vector.image}}
     steps:
     - uses: actions/checkout@v1
-    - run: ci/install-docker-dependencies.sh
+    - run: ci/install-dependencies.sh
     - run: ci/lib.sh
     - run: make
     - run: make test
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 01006379fd0..9388289d0ed 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 #
 # Install dependencies required to build and test Git on Linux and macOS
 #
@@ -34,18 +34,20 @@ ubuntu-latest)
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
 	mkdir --parents "$P4_PATH"
-	pushd "$P4_PATH"
+	(
+		cd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
 		chmod u+x p4d
 		chmod u+x p4
-	popd
+	)
 	mkdir --parents "$GIT_LFS_PATH"
-	pushd "$GIT_LFS_PATH"
+	(
+		cd "$GIT_LFS_PATH"
 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-	popd
+	)
 	;;
 macos-latest)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
@@ -90,6 +92,21 @@ linux-gcc-default)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
+linux32)
+	linux32 --32bit i386 sh -c '
+		apt update >/dev/null &&
+		apt install -y build-essential libcurl4-openssl-dev \
+			libssl-dev libexpat-dev gettext python >/dev/null
+	'
+	;;
+linux-musl)
+	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
+	;;
+pedantic)
+	dnf -yq update >/dev/null &&
+	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	;;
 esac
 
 if type p4d >/dev/null && type p4 >/dev/null
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
deleted file mode 100755
index 78b7e326da6..00000000000
--- a/ci/install-docker-dependencies.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-#
-# Install dependencies required to build and test Git inside container
-#
-
-case "$jobname" in
-linux32)
-	linux32 --32bit i386 sh -c '
-		apt update >/dev/null &&
-		apt install -y build-essential libcurl4-openssl-dev \
-			libssl-dev libexpat-dev gettext python >/dev/null
-	'
-	;;
-linux-musl)
-	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
-	;;
-pedantic)
-	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
-	;;
-esac
-- 
2.35.1.1517.g20a06c426a7

