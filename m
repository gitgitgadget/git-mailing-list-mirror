Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED9C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhKTDb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhKTDbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3BC061748
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so21348340wru.13
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gYprJczNc/M3DfDUsiO7gBpZhjmz1GHkoNHYckMm4M=;
        b=JBg637LThdSBQsgBh2z0rQjIdITQaRUSc6ID4NP1D8Zuw1RM/+KYiGGfvsIvwSFzu6
         1rD+l+hcn7vQrJnDrDAmIL4tBaRg142Lcm55r+hgYq5fgXx4QmMCCnNbbOqOnjs3RKDd
         CIeFfq5gG2/MqszfPnv/qyN3cjUj7PNkYd6CR0RV7Wz1NQPmjJ1wcsdgtyrwGtKQj+UQ
         4gQibHfeW5Qq5x/miG+p4Og6gpTmdC2SQmFFd0oUxMVeCci3joIsETOE4oC1vwOvfwpq
         ux1dm5jsPKR69FGGD1PDthsKpI3/3wqZzJlBtL8zXmoBpNlrmhbL9/WZL450STHuEP/D
         3LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gYprJczNc/M3DfDUsiO7gBpZhjmz1GHkoNHYckMm4M=;
        b=PCr62ryXe9ACTcnwDjmPa8drtkmLxIVi3sAK5eH2884TSPODF3M5Pw9ElCURHVFWxv
         Gwoc+56r4bo/bgITR92xYYTCDAquKSEkKDgiKwxqlgayxWDwRt7GNleASFNUKsbfO+Xr
         Ph57Ke2qpBCgcKUqzeXt0lSDMVtZB4aNBT/gF1FKbaUzG1+ur6tPYU8g/BmXK/ah75pe
         qEOl4+3KRc7lOKUPDDwGSg7cRYL6rd/Ome6qHLxlZu2Ka6MvIQTeI+cXYILbf3ElT+Ys
         yWfl0qlmZIl6v2lxui7e5Fem5WdGAC9krb3oumjXonHyJ64wvmu264Nu7/RAOHSn0O55
         CEYg==
X-Gm-Message-State: AOAM530DrbHUiTNxlcpeNLgWppAYw936kwjssT0fnuIZeIv8sJg8Pg6o
        vWlhb1JKIQXlOJj1va6/WumBgzTKAfoeGw==
X-Google-Smtp-Source: ABdhPJzGPhoRlsSE2u6lVN8kBnWyTRMKoma9xRJrnx0dPK96wmnRYkU0R55BmI35pD1XprB3HsvG9w==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr13931206wrs.200.1637378926308;
        Fri, 19 Nov 2021 19:28:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] CI: use "$runs_on_pool", not "$jobname" to select packages & config
Date:   Sat, 20 Nov 2021 04:28:34 +0100
Message-Id: <patch-v2-4.6-eca0ad08d4b-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the setup hooks for the CI to use "$runs_on_pool" for the
"$regular" job. Now we won't need as much boilerplate when adding new
jobs to the "regular" matrix, see 956d2e4639b (tests: add a test mode
for SANITIZE=leak, run it in CI, 2021-09-23) for the last such commit.

I.e. now instead of needing to enumerate each jobname when we select
packages we can install things depending on the pool we're running
in.

That we didn't do this dates back to the now gone dependency on Travis
CI, but even if we add a new CI target in the future this'll be easier
to port over, since we can probably treat "ubuntu-latest" as a
stand-in for some recent Linux that can run "apt" commands.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  4 ++++
 ci/install-dependencies.sh | 32 ++++++++++++++------------------
 ci/lib.sh                  | 21 +++++++++++----------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index a91edec46d8..097be4c4405 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -229,6 +229,7 @@ jobs:
           - jobname: linux-gcc
             cc: gcc
             os: ubuntu
+            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
@@ -237,6 +238,7 @@ jobs:
           - jobname: osx-gcc
             cc: gcc
             os: osx
+            cc_package: gcc-9
             pool: macos-latest
           - jobname: linux-gcc-default
             cc: gcc
@@ -248,7 +250,9 @@ jobs:
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
+      CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
+      runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v2
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 92e11c7198e..ca1eaa49c14 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -11,17 +11,11 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
-case "$jobname" in
-linux-clang|linux-gcc|linux-leaks)
+case "$runs_on_pool" in
+ubuntu-latest)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS
-	case "$jobname" in
-	linux-gcc)
-		sudo apt-get -q -y install gcc-8
-		;;
-	esac
-
+		$UBUNTU_COMMON_PKGS $CC_PACKAGE
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
@@ -36,7 +30,7 @@ linux-clang|linux-gcc|linux-leaks)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-osx-clang|osx-gcc)
+macos-latest)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
@@ -50,15 +44,17 @@ osx-clang|osx-gcc)
 		brew install --cask --no-quarantine perforce
 	} ||
 	brew install homebrew/cask/perforce
-	case "$jobname" in
-	osx-gcc)
-		brew install gcc@9
-		# Just in case the image is updated to contain gcc@9
-		# pre-installed but not linked.
-		brew link gcc@9
-		;;
-	esac
+
+	if test -n "$CC_PACKAGE"
+	then
+		BREW_PACKAGE=${CC_PACKAGE/-/@}
+		brew install "$BREW_PACKAGE"
+		brew link "$BREW_PACKAGE"
+	fi
 	;;
+esac
+
+case "$jobname" in
 StaticAnalysis)
 	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
diff --git a/ci/lib.sh b/ci/lib.sh
index 0b3b0144882..cbc2f8f1caa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -156,11 +156,15 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
-case "$jobname" in
-linux-clang|linux-gcc|linux-leaks)
+case "$runs_on_pool" in
+ubuntu-latest)
+	if test "$jobname" = "linux-gcc-default"
+	then
+		break
+	fi
+
 	if [ "$jobname" = linux-gcc ]
 	then
-		export CC=gcc-8
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
@@ -180,17 +184,17 @@ linux-clang|linux-gcc|linux-leaks)
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
-osx-clang|osx-gcc)
+macos-latest)
 	if [ "$jobname" = osx-gcc ]
 	then
-		export CC=gcc-9
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	fi
 	;;
-linux-gcc-default)
-	;;
+esac
+
+case "$jobname" in
 linux32)
 	CC=gcc
 	;;
@@ -200,9 +204,6 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
-esac
-
-case "$jobname" in
 linux-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
-- 
2.34.0.823.gcc3243ae16c

