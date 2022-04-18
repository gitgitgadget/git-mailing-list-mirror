Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F4C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346354AbiDRQdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346284AbiDRQc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3628230F52
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k22so19135209wrd.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKD9faueiD4n946M3raJTAhu4aKkQBdDDBzTfd0jXHQ=;
        b=d1umuHli30WNWp6/KwHt5VB82tWPpsaDchPDtxs/MoRuvXUIDZMAPvhiepUmLUvL5i
         cGV3JFzSV0fbQOSLemKRBoyAIcBQ7I4a8v0WBygGKpaJYo9uIQZOP4I7SwvOvXHz9vbW
         AdGusAxjpjhuPiF3ngQ7hQAjIdDh8gewK2okHXVo9RKi84egN4gx/8FNosVnxqWRrSeX
         m2iDOChsrcNar6SOEfpEA+9iaUmPVAymPYFdLBS9lAjLJL5hTLTFsnwvJsWns5RWq8+o
         GhaVOzDPVcLuDWGzIjejjVxKlhrhbEGKGvXUQPFNQVy9BHXCLuMFtoMWe2n5eJWAaBId
         4TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKD9faueiD4n946M3raJTAhu4aKkQBdDDBzTfd0jXHQ=;
        b=uam8aVk3oks3WMMm9wQRPxJeWyQJdYMiWEbftF5usKtfz8WJEq5G8vgpvOuR0LMGkZ
         uVL5g3dniRMVk/NaIiTzVjCgD/W9M09wEvlxD9cXnxh26FkMeaspTCJngur4sNw2et17
         YXYCpHE+kUkQaBvXS2UFD6S3A9GMlyAB0Vpj8uJQxksPlqrlE1gagAsk5aXJDNkXsu1I
         c1h+gyUPC6flFlDI1kbhzExSWj0CwtpPHP7bfmjlaKhFdRsIdq+EEOgBMikAEQHQi7jV
         s03s7ct9mAfcXhKsJE/8daFFInSfjH2DRAf0Wp5PSTCE4XWjqCVlY8u7J9dCLibXpKJM
         sHXw==
X-Gm-Message-State: AOAM531TtN4J3YMQ5jkeDugjHaO8PMk8stMzXhbt6j1E+uQIev2nl2oF
        jrNoyv5lTxXR3ZrPKxlon1Eyt8FZsVhcwA==
X-Google-Smtp-Source: ABdhPJxDWrgPm/nTPHOtjWVIG20Nx4OW6VAoQnHmWeQUuEaYbh6KevirQC6cm5Jqvg/ChDqDrstDtw==
X-Received: by 2002:a5d:64e6:0:b0:20a:77db:88bd with SMTP id g6-20020a5d64e6000000b0020a77db88bdmr8633293wri.555.1650299377362;
        Mon, 18 Apr 2022 09:29:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:36 -0700 (PDT)
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
Subject: [PATCH v4 26/31] CI: set CC in MAKEFLAGS directly, don't add it to the environment
Date:   Mon, 18 Apr 2022 18:29:03 +0200
Message-Id: <patch-v4-26.31-26a34f1d4b9-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 13 -------------
 ci/install-dependencies.sh | 10 ++++++++++
 ci/lib.sh                  | 23 ++++++++++++++++++++---
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0787cadc76b..6d25ec4ae3b 100644
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
index 52f2180d5b4..1d05f43d19e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,6 +9,16 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
+CC_PACKAGE=
+case "$jobname" in
+linux-gcc | linux-TEST-vars)
+	CC_PACKAGE=gcc-8
+	;;
+osx-gcc)
+	CC_PACKAGE=gcc-9
+	;;
+esac
+
 case "$runs_on_pool" in
 ubuntu-latest)
 	# The Linux build installs the defined dependency versions below.
diff --git a/ci/lib.sh b/ci/lib.sh
index 8fb0bfd43e1..977ee6293ef 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -51,6 +51,9 @@ setenv () {
 	fi
 }
 
+# Clear variables that may come from the outside world.
+CC=
+
 # How many jobs to run in parallel?
 NPROC=10
 
@@ -70,8 +73,6 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 
 case "$CI_TYPE" in
 github-actions)
-	CC="${CC:-gcc}"
-
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
 	GIT_TEST_OPTS="--verbose-log -x"
 	test Windows != "$RUNNER_OS" ||
@@ -143,9 +144,14 @@ vs-test)
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
@@ -160,13 +166,22 @@ linux-TEST-vars)
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
@@ -181,9 +196,11 @@ linux-musl)
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
2.36.0.rc2.898.gdf6bbac50ff

