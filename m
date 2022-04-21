Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D2FC433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391458AbiDUS2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391361AbiDUS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084094B86A
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s25so2955242wrb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmhBKyKyPV6fUgUNIiudhurcU8D5YRUsUDfT8mYYhK0=;
        b=OTwbZKuqXTNKIKqVDNqrQRufQXQwIXHiZsEf+04mBsmbTKgRreRi7c5E1OeRLZLCvm
         q3WixNNoYC7g4jrO/pfJlK00AeO7tTUjADvhx3SrMNJXUK3SfDhzWl+9y6Xq4W1PrJoG
         CICH6BTiPZ9hhP1JJIA5amUhYCz1O36gp6kGxMo0mq/tdxJWRLtIt6Xrry8yet5xFtDN
         k4iQh6poCNIn7UvxaLgnxDqNG+1RHRvB2KUVEpyRTufczuh16tCjqIKa4cg/sBTiFpj+
         i+2OUiC7i3K56X9Dxxg+eoUVPva9M3d/S03/3Yg09jx42fdNsBvjavwGqs/9PrpTQt3c
         tytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmhBKyKyPV6fUgUNIiudhurcU8D5YRUsUDfT8mYYhK0=;
        b=PoZ4tgRnUE0j6oa5CFdYmB3vOQ6dcMsgUadBgoBxyFtA5Z3WXeDIpZW7NR28x+z8ge
         yGjYRNxoHRlldLUvPvJqC1JtdwxppE2lFSz5tURfV1CaZZ/9GqRN2e9QWLmnwC7oRGbg
         SGyW+/42H2/UI8fz9odl6ACri5e08GlXWd3lZFTf5E68AGkOXDG66uHn+/w2qGzOEEfE
         792dwf57HxbEHo6nb0XONyycGlptrMRAxLlbBsO4KLAvgiFkmR56YpIm/1QvZQIv/mFK
         iLReEwmQwQ8E+9UQpEIuUzMFL+FCB/AWwqwQW0eg8/hjMue+M+krYPux59Ay520iUE3X
         xQLQ==
X-Gm-Message-State: AOAM5316TFgG8AR7Ulm/4Jy0nzlbRRRk3l/3HwMvfyjQOlh4yx46VcyA
        SZ7GcHfua57+Pr8Ow2BlHJkQTi/G0k5YYA==
X-Google-Smtp-Source: ABdhPJx5QuQVIe6hkkUdZoXT3b9jnYQCf/yQ2fjfscVG9On1v/h6T7S7NEPmwFhDw2jvy80rCaB5uA==
X-Received: by 2002:adf:e944:0:b0:207:af9e:a4e7 with SMTP id m4-20020adfe944000000b00207af9ea4e7mr742792wrn.296.1650565439285;
        Thu, 21 Apr 2022 11:23:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:58 -0700 (PDT)
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
Subject: [PATCH v5 25/29] CI: set CC in MAKEFLAGS directly, don't add it to the environment
Date:   Thu, 21 Apr 2022 20:23:20 +0200
Message-Id: <patch-v5-25.29-48d99cee809-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than pass a "$CC" in the environment to be picked up in
ci/lib.sh let's instead have ci/lib.sh itself add it directly to
MAKEFLAGS. For "$CC_PACKAGE" its setting and use can stay within
ci/install-dependencies.sh.

Setting CC=gcc by default made for confusing trace output, and since a
preceding change to carry it and others over across "steps" in the
GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
confusingly has CC=gcc set, even though it builds with MSVC.

Let's instead rely on the Makefile default of CC=cc, and only override
it for those jobs where it's needed. This does mean that we'll need to
set it for the "pedantic" job, which previously relied on the default
CC=gcc in case "clang" become the default on that platform.

This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23), i.e. we're now
aiming to only set those variables specific jobs need.

Since we don't need to make this generic enough to handle "gcc-9"
turning into "gcc@9" for "brew install" let's remove what was
originally a bash-specific replacement in 707d2f2fe86 (CI: use
"$runs_on_pool", not "$jobname" to select packages & config,
2021-11-23), and which a preceding commit changed to a "tr"
invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 13 -------------
 ci/install-dependencies.sh | 18 ++++++++++++++----
 ci/lib.sh                  | 23 ++++++++++++++++++++---
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index bb62b4ff725..6835e942280 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -238,37 +238,24 @@ jobs:
       matrix:
         vector:
           - jobname: linux-clang
-            cc: clang
             pool: ubuntu-latest
           - jobname: linux-sha256
-            cc: clang
             os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-gcc
-            cc: gcc
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: linux-TEST-vars
-            cc: gcc
             os: ubuntu
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
-            cc: clang
             pool: macos-latest
           - jobname: osx-gcc
-            cc: gcc
-            cc_package: gcc-9
             pool: macos-latest
           - jobname: linux-gcc-default
-            cc: gcc
             pool: ubuntu-latest
           - jobname: linux-leaks
-            cc: gcc
             pool: ubuntu-latest
     env:
-      CC: ${{matrix.vector.cc}}
-      CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
       runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4b4cdbe26e0..65548bf0b25 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,6 +9,17 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
+CC_PACKAGE=
+BREW_CC_PACKAGE=
+case "$jobname" in
+linux-gcc | linux-TEST-vars)
+	CC_PACKAGE=gcc-8
+	;;
+osx-gcc)
+	BREW_CC_PACKAGE=gcc@9
+	;;
+esac
+
 case "$runs_on_pool" in
 ubuntu-latest)
 	# The Linux build installs the defined dependency versions below.
@@ -67,11 +78,10 @@ macos-latest)
 	} ||
 	brew install homebrew/cask/perforce
 
-	if test -n "$CC_PACKAGE"
+	if test -n "$BREW_CC_PACKAGE"
 	then
-		BREW_PACKAGE=$(echo $CC_PACKAGE | tr '-' '@')
-		brew install "$BREW_PACKAGE"
-		brew link "$BREW_PACKAGE"
+		brew install "$BREW_CC_PACKAGE"
+		brew link "$BREW_CC_PACKAGE"
 	fi
 	;;
 esac
diff --git a/ci/lib.sh b/ci/lib.sh
index c8cc37c50b4..8d19ca5ced8 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,6 +79,9 @@ setenv () {
 	fi
 }
 
+# Clear variables that may come from the outside world.
+CC=
+
 # How many jobs to run in parallel?
 NPROC=10
 
@@ -98,8 +101,6 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 
 case "$CI_TYPE" in
 github-actions)
-	CC="${CC:-gcc}"
-
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
 	GIT_TEST_OPTS="--verbose-log -x"
 	test Windows != "$RUNNER_OS" ||
@@ -171,9 +172,14 @@ vs-test)
 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
 	;;
 linux-gcc)
+	CC=gcc
 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
 	;;
+linux-gcc-default)
+	CC=gcc
+	;;
 linux-TEST-vars)
+	CC=gcc
 	setenv --test GIT_TEST_SPLIT_INDEX yes
 	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
 	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
@@ -188,13 +194,22 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_WRITE_REV_INDEX 1
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
+osx-gcc)
+	CC=gcc
+	;;
+osx-clang)
+	CC=clang
+	;;
 linux-clang)
+	CC=clang
 	setenv --test GIT_TEST_DEFAULT_HASH sha1
 	;;
 linux-sha256)
+	CC=clang
 	setenv --test GIT_TEST_DEFAULT_HASH sha256
 	;;
 pedantic)
+	CC=gcc
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	setenv --build DEVOPTS pedantic
@@ -209,9 +224,11 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks)
+	CC=gcc
 	setenv --build SANITIZE leak
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
 
-setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS${CC:+ CC=$CC}"
+setenv --build MAKEFLAGS "$MAKEFLAGS"
-- 
2.36.0.879.g3659959fcca

