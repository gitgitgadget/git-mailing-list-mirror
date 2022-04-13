Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CDC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiDMTzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiDMTyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78B7628B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q3so3499643wrj.7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fphnWiFu3yAnTqygU3drfwoWeRkHow1VfNgzONBkwyk=;
        b=Ki9wVCWrk/uclrldHu+xWcZzlHrsup5lJVu8qSngtYnx2CTsncnQBQsdCpcwC4tkB4
         B6TqswIYpjHuH7btLvsfLz1AT5AaHKXuUXGmF6YGnYPI6RSKZxSjtCu0qL+l8ewtIJoP
         yhI8/VS1hAChK9prDb8O6O9cTu+XMnr88m7R7hQuniaBMIAtg62Q5fZ1YdfKrKZznai9
         MPLChll4kFpprZc0W43c1e/w+aFbuuT7CvGhNdOTNks9F0s0aklso/52E8feFkbadV6X
         5XBfJGGl6gWOwyJrvPC+nwVJEyGqRDnz4ddwYT2TWqnU/rx5Alquf6mBnHRmNR/fCELC
         TG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fphnWiFu3yAnTqygU3drfwoWeRkHow1VfNgzONBkwyk=;
        b=ylFrgtFDHQyHoN2eXDeuOo5WABx9Xck7Tlzt+R3sk9frsAgELRO04H/5JGk3fJzDFc
         3NFonPhh+50MGFwCJ3NYPTlyannkiD3BXtHDL8SzKJeTAcJ/bNLBaxWX/sGsUbKhRh9I
         8SMm9uuiPpdQBustVQ3zP5euXcVrTjKEYwQfJmg0s44y+U+u+ZlFeCP43uY1Z7Bp0bwW
         k93WYFjFCTxU8dZeUlq1xD6F7q3SpDc61PjJ9zkPZWpbqKu3PBpWy9BoSuIvdKiF0W9E
         x5cvCin6ljcFwy+4FasV5Ck/4ZiQW2LsA+2QYPPKhn82t0pLErxJrnCH5f6GHgH7QYzZ
         p4lw==
X-Gm-Message-State: AOAM531ER1VqoR0FAt47B396hxeIlPS2uUflY4GKExOM19/zWB/a+VUX
        jOmPDib/4JJocEhwcg4LE1RInKn36FA0sQ==
X-Google-Smtp-Source: ABdhPJynZ0+ahaQOyZifnBNBSuzt1YhOGXDh5Bw8CFKGwm3/XfwWzkInIZW9iJNgR66mTgbbMeK1KA==
X-Received: by 2002:adf:9bd5:0:b0:207:a2a6:636a with SMTP id e21-20020adf9bd5000000b00207a2a6636amr343770wrc.480.1649879531713;
        Wed, 13 Apr 2022 12:52:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:11 -0700 (PDT)
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
Subject: [PATCH v3 18/29] CI: combine ci/install{,-docker}-dependencies.sh
Date:   Wed, 13 Apr 2022 21:51:31 +0200
Message-Id: <patch-v3-18.29-aa491990c1a-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

