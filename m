Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ABCC433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhKTMN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhKTMN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 07:13:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D2C06173E
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 133so10896371wme.0
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Quprb1B3MnCaCrkLuwQJ2vDP/eI2aZRBAaT5T/OgJEA=;
        b=JDIjkmQbTid5G3RFcYX1HIWaxYf4Bxfz4324ohxJr/08FFfKk3Er2Q97HevZZhkwct
         1RDPPtsV9OFCQ5CqXaHr+vbwYvcKI8kg+J+GZWLwJBhoP9MCp+oBp45TQCIoQZuw/1Gm
         U4x+gcoblmo0cdp1D+H4zb9RgH1WpFuQp/X0bnhn08pz7sF/97kMTSGgvrWzdLft9Lru
         QiRvHd1Vtn4803GU5+/I+IEfO80zKJoiw3nLJpj/agcfZPhODwl2om/WRVT7CsQPJwNu
         DGEaCnqNWNNmY3FcWQ5n4jN5sGj5Tot/Cqg+YQmIhexuw1Ibmg7sijCzCCsG2R7R5Fy/
         ++7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Quprb1B3MnCaCrkLuwQJ2vDP/eI2aZRBAaT5T/OgJEA=;
        b=aBuyUEzfTvAdaI7/kjFUVgGsnKTzy4gE7kHgWpv2LV9BwnxRH2iIcEFGZzYHeufe0q
         6iZlVdw6IULml5LmE+TgDh6zMzzqqDYp4TGTGmKUKk1zFMVSQs5Xo5yQSWSitfDxfiyW
         ZxUvSd8L3wwWqhD5mWepG/bZ0Sk8sM7KOfovY+yVyekGJc/SfsQuDd6TjELWYch/4l7X
         YKDyC3V5f/OMUTqp/z1OGyHajcAUaKiC25sMAqVXBNyVs+uV5JCjsyrtywloyMqhI965
         WYnqm27Umubf3rZ0e3eI8JdUrim9c8tY0ZRwVfcisZzy3vf0ejzh47fjctp2/UT0C/ru
         FixQ==
X-Gm-Message-State: AOAM5306VVsvYixbp0GKTzrHN2dAaSbIR/W5whxtZ1OmJmXJA9YtpCVo
        PuP9pfScdXNOc1SpJJgTMYXY0k2ipzqNJvaI
X-Google-Smtp-Source: ABdhPJxkwVmmqN1cImWNSZOIq8xfYfr0Lm6UTnSH7Ci51ICbQ3Q08X6XBU+KnWQWE67VVn+cqhBB8g==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr9743688wmh.117.1637410221189;
        Sat, 20 Nov 2021 04:10:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m36sm3128221wms.25.2021.11.20.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:10:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] CI: use "$runs_on_pool", not "$jobname" to select packages & config
Date:   Sat, 20 Nov 2021 13:10:10 +0100
Message-Id: <patch-v3-4.5-54913e775c1-20211120T115414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.818.g0f23a581583
In-Reply-To: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
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
index 91b565f75bb..d402402a18b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -227,12 +227,14 @@ jobs:
             pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
+            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
             pool: macos-latest
           - jobname: osx-gcc
             cc: gcc
+            cc_package: gcc-9
             pool: macos-latest
           - jobname: linux-gcc-default
             cc: gcc
@@ -242,7 +244,9 @@ jobs:
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
2.34.0.818.g0f23a581583

