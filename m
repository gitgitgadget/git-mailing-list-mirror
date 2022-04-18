Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF4C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346355AbiDRQen (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbiDRQcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AD3054C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so19135069wrd.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBJiHB3IV31quln8axgYdMWlyj6CTEqL+eZG3pc4XLw=;
        b=XOHp0DEZe5V46cJNgbIHNrE6nLaFluNfHqAavsBWAK47vmY7zV7t/X0EjblfZcyHC0
         QwKdDHvM9dr+ApUNs3MiA2zC09/prxnH8TQLy2/FS3Ok4/VMwhhx1d5aNnqC+o2VnZ/j
         fhCCoai1GGva2LzkL6wHTO6d3j5J/PDZnGteGNCAnGajqWQ0FeetD/5EY/ptL4gbKBjw
         HXljAsKBlgEf4T81h3J+DZ8Z0uK60hoR0OSvNPKNZbIQ56WJFK++bqV9UQGrzxAEjsyT
         LG2EyDWFF1kbgbJgl0hQo1Q3FoXNPACDRl+P7idX0Ht9FsgfmxGiF5rwyLwss37+c5S0
         rRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBJiHB3IV31quln8axgYdMWlyj6CTEqL+eZG3pc4XLw=;
        b=DPpzBwh2ZuBG/+sk8xRd5lYvb3I13PvZwvYJXUUkZQUyo8KDg/F55H6HeyJ8uoR/Lf
         Wi35JnzODfwXLQ+ykaEUR6BSxmPT+MVu1gX2DL8OsdnUsma2NYOHuJ3AzISRYNOGnh+e
         vfC/4Udyfe3QgjYFXsBIRW/Hi9TOrpL+6PINoWMBFktpTVEoLhbgrYnqXAp7KqTJV9rS
         jfvV0p7AgaI2HMK3O/nmJ9jPk+B4FdgOgYdbmHFizaYEcMQ4ek3mWf/L5c0Abl/s20bL
         AM4JqgR1dDNIFLJqPfWomZbuTYN7nW07FUcq3fCBgE/aQGUw4nWgzJi9X7o0On+MMiXE
         M8jQ==
X-Gm-Message-State: AOAM530VezATLi3wRJllnibCct9b/1WFD3CLzsQC0Xjo5/mwsKlx1FHI
        6JIQgV92gT5CBv7VIMqEBe93hzFE9dWavA==
X-Google-Smtp-Source: ABdhPJwNnBzBy/5fCUY3O8lQtCNG030IrmncsySVySNBxe4lj/hW/KYT+JHnTMvQmYgE/zDL1Bm+5Q==
X-Received: by 2002:a5d:50ca:0:b0:207:bc3d:1026 with SMTP id f10-20020a5d50ca000000b00207bc3d1026mr8955398wrt.154.1650299374469;
        Mon, 18 Apr 2022 09:29:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:33 -0700 (PDT)
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
Subject: [PATCH v4 23/31] CI: only invoke ci/lib.sh as "steps" in main.yml
Date:   Mon, 18 Apr 2022 18:29:00 +0200
Message-Id: <patch-v4-23.31-1d95088da29-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the scripts in ci/ to stop using ci/lib.sh as a library, now
that the only thing it did for them was to "set -ex" and possibly set
TERM=dumb.

Let's create a ci/lib-tput.sh for those that need to use "tput"
instead, and have these scripts invoke "set -ex" themselves.

This makes their invocation a lot less verbose, since they'll be
relying on an earlier step in the CI job to have set the variables in
$GITHUB_ENV, and won't be spewing their own trace output to set those
variables again.

Let's also create a ci/lib-ci-type.sh, and have ci/lib.sh and
ci/print-test-failures.sh share the logic to discover the CI type. We
could have set the CI_TYPE in the environment with "setenv", but let's
avoid that verbosity for this purely internal variable.

The "ci/lib.sh" is now no longer a "Library of functions shared by all
CI scripts", so let's remove that commentary, and the misleading
comment about "set -ex" being for "installing dependencies", we're now
no longer using it in "ci/install-dependencies.sh" (but it does its
own "set -ex").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-unignored-build-artifacts.sh |  4 +++-
 ci/install-dependencies.sh            |  2 +-
 ci/lib-ci-type.sh                     |  9 +++++++++
 ci/lib-tput.sh                        |  5 +++++
 ci/lib.sh                             | 27 ++++++++++-----------------
 ci/print-test-failures.sh             |  6 +++---
 ci/select-test-slice.sh               |  2 +-
 ci/test-documentation.sh              |  2 +-
 8 files changed, 33 insertions(+), 24 deletions(-)
 create mode 100644 ci/lib-ci-type.sh
 create mode 100644 ci/lib-tput.sh

diff --git a/ci/check-unignored-build-artifacts.sh b/ci/check-unignored-build-artifacts.sh
index 0bc04f32804..c27d6a97f45 100755
--- a/ci/check-unignored-build-artifacts.sh
+++ b/ci/check-unignored-build-artifacts.sh
@@ -3,7 +3,9 @@
 # Check whether the build created anything not in our .gitignore
 #
 
-. ${0%/*}/lib.sh
+set -ex
+
+. ${0%/*}/lib-tput.sh
 
 check_unignored_build_artifacts ()
 {
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8e41747ef6f..52f2180d5b4 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -3,7 +3,7 @@
 # Install dependencies required to build and test Git on Linux and macOS
 #
 
-. ${0%/*}/lib.sh
+set -ex
 
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
diff --git a/ci/lib-ci-type.sh b/ci/lib-ci-type.sh
new file mode 100644
index 00000000000..6f01fd9e5d9
--- /dev/null
+++ b/ci/lib-ci-type.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+if test "$GITHUB_ACTIONS" = "true"
+then
+	CI_TYPE=github-actions
+else
+	echo "Could not identify CI type" >&2
+	exit 1
+fi
diff --git a/ci/lib-tput.sh b/ci/lib-tput.sh
new file mode 100644
index 00000000000..b62ef13c44c
--- /dev/null
+++ b/ci/lib-tput.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+# GitHub Action doesn't set TERM, which is required by tput
+TERM=${TERM:-dumb}
+export TERM
diff --git a/ci/lib.sh b/ci/lib.sh
index 8c574b21a67..8f7e178f3ff 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,13 +1,9 @@
 #!/bin/sh
-
-# Library of functions shared by all CI scripts
-
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-# Set tracing executed commands, primarily setting environment variables
-# and installing dependencies.
 set -ex
 
+# Helper libraries
+. ${0%/*}/lib-ci-type.sh
+
 # Starting assertions
 if test -z "$jobname"
 then
@@ -47,18 +43,14 @@ setenv () {
 	fi
 }
 
-# GitHub Action doesn't set TERM, which is required by tput
-setenv TERM ${TERM:-dumb}
-
 # How many jobs to run in parallel?
 NPROC=10
 
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=--jobs=$NPROC
 
-if test "$GITHUB_ACTIONS" = "true"
-then
-	CI_TYPE=github-actions
+case "$CI_TYPE" in
+github-actions)
 	CC="${CC:-gcc}"
 
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
@@ -66,11 +58,12 @@ then
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
-else
-	echo "Could not identify CI type" >&2
-	env >&2
+	;;
+*)
+	echo "Unhandled CI type: $CI_TYPE" >&2
 	exit 1
-fi
+	;;
+esac
 
 setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 47e2ea1ad10..29f8c332eca 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -3,10 +3,10 @@
 # Print output of failing tests
 #
 
-. ${0%/*}/lib.sh
+set -e
 
-# Tracing executed commands would produce too much noise in the loop below.
-set +x
+. ${0%/*}/lib-ci-type.sh
+. ${0%/*}/lib-tput.sh
 
 cd t/
 
diff --git a/ci/select-test-slice.sh b/ci/select-test-slice.sh
index ec602f8a053..a0332095bb3 100755
--- a/ci/select-test-slice.sh
+++ b/ci/select-test-slice.sh
@@ -3,7 +3,7 @@
 # Select a portion of the tests for testing Git in parallel
 #
 
-. ${0%/*}/lib.sh
+set -ex
 
 tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
 	t[0-9]*.sh))
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index b8a6a6f664e..64ff212cdaa 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -3,7 +3,7 @@
 # Perform sanity checks on "make doc" output and built documentation
 #
 
-. ${0%/*}/lib.sh
+set -ex
 
 generator=$1
 
-- 
2.36.0.rc2.898.gdf6bbac50ff

