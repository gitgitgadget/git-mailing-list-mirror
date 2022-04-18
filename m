Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01293C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346317AbiDRQdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346260AbiDRQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607830F7E
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so1761026wmq.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLFGhv8skTwxo9SLrh3rxnA7+J5n7Ngm8c5OAGy0U/k=;
        b=f7OfEGnpHVXO8MlpqGX+KLmdck2m9tu5r8pqxP1dJW1LIlWjT4pJRNB9ydtJXXyjBz
         xBH1Le2GFY0vc4UldWjuebDaorRsg4BSm4CqtQR8zpi+0SpZ1LX/wUOU1/e5esvPFT1V
         6n+52SM3lvN69azf1B1trBXOQZH/8m1GW4XgT45RCyFoUbqk184ZVV/LQ2kUC/cPT/5+
         6M7QR+q+toT64iOsyL24u6jxOGrKnPrpeCnmMGlYAVZwdq2yZK+ZVS7O/l2N70W2xnvp
         S0XUlD6QMT0frTwMLyCmodm1BI6dcACZ5xj/RLMtS3ZgyhTLw1n8C2WGs35S5N4DkBgY
         uTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLFGhv8skTwxo9SLrh3rxnA7+J5n7Ngm8c5OAGy0U/k=;
        b=mcSpfaLRubImohz7Kyt0wu44xtMKZ5VeoXJ5y6QNuzWaxxLchgi8COWK0DgYBZRIuz
         V0NuSNksXbUfWMr7VX8JVolfUD75/+ojjYPAZm5VXQfaahFPyl/MtuZezIggAJxva19C
         AhakptaCYY/hqVC/URoOVM8fs1qWWZCT5aPuFMtK6iZNlGF91M4ss7NTxwqVk9EYduwL
         o0pNGPqht6rgcxDCbvnXIqcYSc9QmUkpzacJCk5mNcsHgL53/zIGReHFqQHrNrsF28i9
         nb+latBHGFpFYuu/tv5bUyUUYQHwkGHXtn3J5b4r1922xuxqjZ2eQbFF3SnrTPnbC3/Q
         2Mcg==
X-Gm-Message-State: AOAM532JtSOYelag39pdqrwUtBDd5p+v2ulG3VftQfKgRgR6pOkBh54o
        WFsy+dviuhTyA2p6QLHWOKVyB43R+vg5Gg==
X-Google-Smtp-Source: ABdhPJyQHmgV0E6plFYE+Kj6EUUKfWx5rRsvhe/K9yCOYxPm7IddpAolcSvOHIRYHszzwVRdg/IUbQ==
X-Received: by 2002:a05:600c:a47:b0:37c:965:2b6f with SMTP id c7-20020a05600c0a4700b0037c09652b6fmr11675393wmq.31.1650299368686;
        Mon, 18 Apr 2022 09:29:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:28 -0700 (PDT)
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
Subject: [PATCH v4 17/31] CI: split up and reduce "ci/test-documentation.sh"
Date:   Mon, 18 Apr 2022 18:28:54 +0200
Message-Id: <patch-v4-17.31-5e5a5b71700-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "ci/test-documentation.sh" script to run the bash-specific
parts in as one command in the CI job itself, and to run the two "make
doc" commands at the top-level.

It'll now be obvious from the title of the step if we failed in the
asciidoc or asciidoctor step.

Since the "check_unignored_build_artifacts()" function is now only
used in "ci/check-unignored-build-artifacts.sh" move that function
there.

The recipe for the job in ".github/workflows/main.yml" is now a bit
verbose because it's effectively the same job twice, with a "make
clean" in-between. It would be better for the verbosity to run it via
a matrix as done in the alternate approach in [1] does, but then we'd
sacrifice overall CPU time for the brevity. It might still be worth
doing, but let's go for this simpler approach for now.

1. https://lore.kernel.org/git/patch-v2-6.6-7c423c8283d-20211120T030848Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml            | 16 +++++++++++++-
 ci/check-unignored-build-artifacts.sh | 10 +++++++++
 ci/lib.sh                             | 10 ---------
 ci/test-documentation.sh              | 31 +++++++++------------------
 4 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 2c23a19eac2..92b914f16fd 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -365,4 +365,18 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/test-documentation.sh
+    - run: ci/lib.sh
+    - run: make check-docs
+    - run: "make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)"
+      shell: bash
+    - run: ci/test-documentation.sh AsciiDoc
+      if: success()
+    - run: ci/check-unignored-build-artifacts.sh
+      if: success()
+    - run: make clean
+    - run: "make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)"
+      shell: bash
+    - run: ci/test-documentation.sh Asciidoctor
+      if: success()
+    - run: ci/check-unignored-build-artifacts.sh
+      if: success()
diff --git a/ci/check-unignored-build-artifacts.sh b/ci/check-unignored-build-artifacts.sh
index 56d04b0db9a..0bc04f32804 100755
--- a/ci/check-unignored-build-artifacts.sh
+++ b/ci/check-unignored-build-artifacts.sh
@@ -5,4 +5,14 @@
 
 . ${0%/*}/lib.sh
 
+check_unignored_build_artifacts ()
+{
+	! git ls-files --other --exclude-standard --error-unmatch \
+		-- ':/*' 2>/dev/null ||
+	{
+		echo "$(tput setaf 1)error: found unignored build artifacts$(tput sgr0)"
+		false
+	}
+}
+
 check_unignored_build_artifacts
diff --git a/ci/lib.sh b/ci/lib.sh
index ffc0e524aaa..35a972fa3f5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -47,16 +47,6 @@ setenv () {
 	fi
 }
 
-check_unignored_build_artifacts ()
-{
-	! git ls-files --other --exclude-standard --error-unmatch \
-		-- ':/*' 2>/dev/null ||
-	{
-		echo "$(tput setaf 1)error: found unignored build artifacts$(tput sgr0)"
-		false
-	}
-}
-
 # GitHub Action doesn't set TERM, which is required by tput
 setenv TERM ${TERM:-dumb}
 
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 6b5cce03bd7..b8a6a6f664e 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -1,10 +1,12 @@
-#!/usr/bin/env bash
+#!/bin/sh
 #
-# Perform sanity checks on documentation and build it.
+# Perform sanity checks on "make doc" output and built documentation
 #
 
 . ${0%/*}/lib.sh
 
+generator=$1
+
 filter_log () {
 	sed -e '/^GIT_VERSION = /d' \
 	    -e "/constant Gem::ConfigMap is deprecated/d" \
@@ -14,28 +16,15 @@ filter_log () {
 	    "$1"
 }
 
-make check-docs
-
-# Build docs with AsciiDoc
-make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
-cat stderr.raw
-filter_log stderr.raw >stderr.log
-test ! -s stderr.log
-test -s Documentation/git.html
-test -s Documentation/git.xml
-test -s Documentation/git.1
-grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
-
-rm -f stdout.log stderr.log stderr.raw
-check_unignored_build_artifacts
-
-# Build docs with AsciiDoctor
-make clean
-make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
 cat stderr.raw
 filter_log stderr.raw >stderr.log
 test ! -s stderr.log
 test -s Documentation/git.html
-grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
+if test "$generator" = "Asciidoctor"
+then
+	test -s Documentation/git.xml
+	test -s Documentation/git.1
+fi
+grep "<meta name=\"generator\" content=\"$generator " Documentation/git.html
 
 rm -f stdout.log stderr.log stderr.raw
-- 
2.36.0.rc2.898.gdf6bbac50ff

