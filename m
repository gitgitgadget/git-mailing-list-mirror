Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487FC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391223AbiDUS1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDUS0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A2F4AE3F
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so7805008wrg.12
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38g2rMJXcnBmbijAYyYrd1bW4p/cJtwMwJk7Rt695jk=;
        b=gRzXx27Y1Cy0aUp7m2myEOpxcK9WBhZxwpzQdGQN/RAHKhDw6a9uZFG51RikJpDyFo
         rCOSjeJ8a713eqhK8BBfidS3WhvMkmDsnfCCGHhzHmDJsM5RrGELwQALPGCTZIC4vyYU
         qtIiu4S+92mqfYwZdHUispghUeNkhw4RLK2r54Ekng1wEYx2Gyx91fWkZ9aXdnZ0zT+8
         q2bVSR00DoJji4ixFKovw9YHXaSFx/w17H/syc0Y5PIibpiB7YU2ag7auyTpVL3tLWnl
         T2v0wuEJo4I7dCPdASu3bUZBlP5GrbDMrKDZQcwD+Q9ULJbvZyZ+Th/zmOP7mYJwxHnk
         RGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38g2rMJXcnBmbijAYyYrd1bW4p/cJtwMwJk7Rt695jk=;
        b=BnBzGwF0CxTsXMg8TOi7q2wO9OMfa0N6k2E+1Vpsu0mvJT4c2mV5tgTXC9gat0ojp+
         iny37CeHoKGqyLT4FKQnXkpLSurxT7XCEj3eQggay2HvCB6GB/uvSx6mDPEgrAgIK/Se
         Z0kfAhdtvof09Athm8pTxBxAmxrr7lhg4y6atNHsQpJPOKCnrIygriskkmJ8bUVAqmhO
         QmOekBn+vSwywR0VVnJp0RSMaD4SW3xYUuSXUAks+G2oPFWVVaGisWirU5UG0ynhuKiw
         9uZs29gJ6A10Vq63zWc7Bq4qHrFMeXFq+iTq9L8iM4Kl73alYfjfrPRF7L2jEFaW0nwU
         UXYw==
X-Gm-Message-State: AOAM533d5bHcqD0QG+fQlQeLrlkdCL1+bhc5el8nuz3H5s54KI2jieHr
        mFmHeysgy5FtMZKsVxYfpx6U4pN/rywHWw==
X-Google-Smtp-Source: ABdhPJx8FqaqngYmij96F32vtEu0Iyucf7ii9A/ugx7NVoFj9E4+CakrZr2dshcXe6nvJYK8FGsTrw==
X-Received: by 2002:a05:6000:15c8:b0:20a:92f1:c054 with SMTP id y8-20020a05600015c800b0020a92f1c054mr779994wry.146.1650565428468;
        Thu, 21 Apr 2022 11:23:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:47 -0700 (PDT)
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
Subject: [PATCH v5 14/29] CI: make ci/{lib,install-dependencies}.sh POSIX-compatible
Date:   Thu, 21 Apr 2022 20:23:09 +0200
Message-Id: <patch-v5-14.29-533dbc50c4f-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index 01006379fd0..1ad4dd7db39 100755
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
@@ -62,7 +69,7 @@ macos-latest)
 
 	if test -n "$CC_PACKAGE"
 	then
-		BREW_PACKAGE=${CC_PACKAGE/-/@}
+		BREW_PACKAGE=$(echo $CC_PACKAGE | tr '-' '@')
 		brew install "$BREW_PACKAGE"
 		brew link "$BREW_PACKAGE"
 	fi
diff --git a/ci/lib.sh b/ci/lib.sh
index 43231862aa5..2fd022c94bc 100755
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
2.36.0.879.g3659959fcca

