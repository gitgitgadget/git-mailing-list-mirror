Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442FFC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiEYKHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiEYKFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859746D94A
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r82-20020a1c4455000000b003975cedb52bso221422wma.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtFDoWsa11wQreI4soCiOzKYIe9CS7KqDO77PyDrAMQ=;
        b=MU8clROUv1vgfnENzEkZ2AxUQqdbppaYxLy2/0lywcdXY8krAR5qYlMIrOElM+DlT1
         6QzeKp6wNFQom1UJIAw05gDhpybVQzcA2HXcQBm4mYJmeKsrPvRcWalxylyEABY3NN4p
         QoSSjVWV60A9FauLHsKFUjH//uuma7WH/EjAlUj66WS5KKxkRn1NALMpPxFxhu+ao5wr
         LZTrgy6W+gpkF0g5kdod+jGmz9GzWTdIXjK5BTsI/X9Gp57Z6LhPeWrhSKgr4w69EJaI
         8VIkGIetA0ozzbQsWuzrLie5Ny6hg7xSeeCSBgz37A+1iAhv0JAsl7R801gHGKi/b6Iy
         15oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtFDoWsa11wQreI4soCiOzKYIe9CS7KqDO77PyDrAMQ=;
        b=WEskXEO0xtr3vz5FEBNlV2GXNg9SvaZZZ/BKoYMC70QNdM7xs4jI9pSIULrNGRvAoU
         nQAEeCNunneJHW8welmr1T67BT+vFEOrlV3fyJhU7h5n4HqECdeR3vnw9e31EO5gQn+I
         Xz5hOIRDmHdMh7fAopSD8J6CzoMtOPStjNnTgtxhWASNg8riZ2MIAv/SEQwwUDDpjXQa
         pnRhzSywSRtllhrok97/DWut14m2yWLRgiPfmVFKQldan+jaqRxVbYu5Q5uuKsZm+QPm
         wpLlx+DLMtkgb56G10bgUDJ8wJ8v2BY3RNfsoV3uiBzgVVo3vRWjXVYuGtZyI2Z+C65s
         YXJg==
X-Gm-Message-State: AOAM5330TFn0OirmizFuBdA/JST2zXHF1Zg1pO6QZCyu/RUHjnwbHKlJ
        jvo+vuEWD+nbQNb4g1WNnCjRUVECkHu/Hg==
X-Google-Smtp-Source: ABdhPJxFmWa76TMJfNeYt3pJmMB0IfyJ4bBj5BFhO/+dI0pTi77qW8X+T9CyfkypGoPH+v7EyimI1g==
X-Received: by 2002:a05:600c:348d:b0:397:55ca:78e3 with SMTP id a13-20020a05600c348d00b0039755ca78e3mr7354572wmq.167.1653473096755;
        Wed, 25 May 2022 03:04:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:55 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/29] CI: make ci/{lib,install-dependencies}.sh POSIX-compatible
Date:   Wed, 25 May 2022 12:03:53 +0200
Message-Id: <patch-v6-14.29-0488e29859b-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the unportable constructs in the "ci/install-dependencies.sh"
scripts to use POSIX replacements, and have it run under "/bin/sh"
instead of "/usr/bin/env bash". We needed to:

* Replace pushd/popd with a sub-shell.
* Change "mkdir --parents" to "mkdir -p".
* Use POSIX "export" syntax.

This is in preparation for combining this script and
"ci/install-docker-dependencies.sh", which doesn't have access to
"bash".

While we're at it change "if [" to "if test" in ci/lib.sh. This isn't
strictly speaking a case of POSIX-incompatibility, but that syntax was
being used there because this code was using idiomatic bash
constructs. Let's have it use our usual style of "if test" instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 27 +++++++++++++++++----------
 ci/lib.sh                  |  4 ++--
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5d50604e724..3e05d38d4ab 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 #
 # Install dependencies required to build and test Git on Linux and macOS
 #
@@ -21,7 +21,8 @@ ubuntu-latest)
 
 	P4_PATH="$HOME/custom/p4"
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	export PATH
 	if test -n "$GITHUB_PATH"
 	then
 		echo "$PATH" >>"$GITHUB_PATH"
@@ -33,22 +34,28 @@ ubuntu-latest)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
-	mkdir --parents "$P4_PATH"
-	pushd "$P4_PATH"
+	mkdir -p "$P4_PATH"
+	(
+		cd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
 		chmod u+x p4d
 		chmod u+x p4
-	popd
-	mkdir --parents "$GIT_LFS_PATH"
-	pushd "$GIT_LFS_PATH"
+	)
+	mkdir -p "$GIT_LFS_PATH"
+	(
+		cd "$GIT_LFS_PATH"
 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-	popd
+	)
 	;;
 macos-latest)
-	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
+	HOMEBREW_NO_AUTO_UPDATE=1
+	export HOMEBREW_NO_AUTO_UPDATE
+	HOMEBREW_NO_INSTALL_CLEANUP=1
+	export HOMEBREW_NO_INSTALL_CLEANUP
+
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
 	brew link --force gettext
@@ -64,7 +71,7 @@ macos-latest)
 
 	if test -n "$CC_PACKAGE"
 	then
-		BREW_PACKAGE=${CC_PACKAGE/-/@}
+		BREW_PACKAGE=$(echo $CC_PACKAGE | tr '-' '@')
 		brew install "$BREW_PACKAGE"
 		brew link "$BREW_PACKAGE"
 	fi
diff --git a/ci/lib.sh b/ci/lib.sh
index d18ee1a91e7..8df133b840b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -94,7 +94,7 @@ ubuntu-latest)
 		break
 	fi
 
-	if [ "$jobname" = linux-gcc ]
+	if test "$jobname" = linux-gcc
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
@@ -104,7 +104,7 @@ ubuntu-latest)
 	setenv --test GIT_TEST_HTTPD true
 	;;
 macos-latest)
-	if [ "$jobname" = osx-gcc ]
+	if test "$jobname" = osx-gcc
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
-- 
2.36.1.1045.gf356b5617dd

