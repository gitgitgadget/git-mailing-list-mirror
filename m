Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D04C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378346AbiBUOsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378315AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF6630B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k1so27492054wrd.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsmC87namBfpmpFeLpdn5ujuPdebbGw+521whNKLqg8=;
        b=cW0HbkIoUvBzGO62DgN/buQ8QEbAbE2E91DGRoWt3mShiRwNm1KDx2+A2D0QmWeVW4
         vfYxxs5fu8FlURzsSgJMiKmLrAhirIYArWL64oxamIQ/POe27ckukQKZhp6iorqSt18Z
         VYfQPIZ4YOh8yF7Lm23d0EniorptwLpuHv+iUQtGjyzvZDM1O/r5sYS13+fLaHR5HTHE
         vZsL/7FByGnIR/IryCK3RzEyefgHGkYpRDZFJUKgpbXAJ/z3KUAXzn5/swv9DeuUyJlh
         cGeJWNfPwysyp051LOLeULIg+rO70Qolfd85m6cmgvJohWD6xW4wVGvetganFG0nnF7z
         NqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsmC87namBfpmpFeLpdn5ujuPdebbGw+521whNKLqg8=;
        b=RbVrnHOWjyhLfG41j3r0VAhVkBiT0yr4OmgMFpqDd+4qZxgLQmJNb3CsbHSEuDVVeA
         akHAALPEmtKqpnAHRJQPKtYSvgsg8kepFHHQ4Kmc8twzr0v8lXhCcgck8MdGDYMJHM9a
         8Yn+M4iXwQmXIWk04Bn3hK75LyxlMOrHuZlpL9tG1jwW1vAzr/Qp0Tp8HNX3jYqtRobz
         7jxuxmZBcBwh2CuqJMs1vjr1XlxadRMYD0xRTZVCy2rSXWTYbPKkzC72xE/cECyytZXI
         6yvC/PpF7CXZkDdOzDOEyJp9sL1/rlBNWkumqt4ZWQP0Z1LuKFpgZ0thlMMs8vRJQUJH
         wW/A==
X-Gm-Message-State: AOAM532Up5tY+PYp8Oa7VqiTwEQ4z/ar+e83c8PwbOVn7mB9Wm/x1B3v
        E8jdNSU2fTj6yaoDs/Lg1ULL660OyhBwJA==
X-Google-Smtp-Source: ABdhPJxVy82SHVip1MaWSE3Ir7m6jFZ1q3MwQfqUFqdRNWGgE2nZ8bi6IosfEe25dyqPi+Q79Nxcqw==
X-Received: by 2002:adf:fa0d:0:b0:1e3:f7b0:1037 with SMTP id m13-20020adffa0d000000b001e3f7b01037mr16324269wrr.188.1645454822576;
        Mon, 21 Feb 2022 06:47:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:02 -0800 (PST)
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
Subject: [PATCH 16/25] CI: combine ci/install{,-docker}-dependencies.sh
Date:   Mon, 21 Feb 2022 15:46:28 +0100
Message-Id: <patch-16.25-868613a5b06-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
2.35.1.1132.ga1fe46f8690

