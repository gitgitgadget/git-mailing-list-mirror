Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4264FC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241572AbiEYKHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiEYKFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49E6F4B8
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so17781523wrc.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXRS9d3MQoEDIcDCZxS4Wfp9X6wzHmVtwPn7KbEj5Lw=;
        b=cp8YPBZ8REb6GScGQchdrMp2w1XNtt0KRHvQAMADc/kLsfPv5kUY77MmUNWkyg4DQE
         wtiprjdtcf6Q1jJCEfkGCJO0sXQygLAQjq48dI96zX7/707uZ2ItzU2f34M10oR6oYIb
         xcfE49jiTJZIVSjGKI5xHwXnu9EHhOozdIikZOhS8nZXs6On6apz7CmgjnZay2gDg46A
         TZGNhbAtDzavVO3Q2efhWZfAozwg0SXty6fTWF/Xdpa42rUDOzP2GsiyfCpMWZNyjviB
         8+vCCHlZ3sAHED8XH9gVJEqf75jsG845iWNyhyNM557ypJiErhXUj05mfqsK45EQndZb
         eiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXRS9d3MQoEDIcDCZxS4Wfp9X6wzHmVtwPn7KbEj5Lw=;
        b=oEoK3hC42xZ4blHCJqACUXB1jgH3hPTQDnqmWlc5Pvn0HlVEfHkwELP4qcxWi42pRL
         FgpMvMt0PpFEh01RwEQKCy5+47e9nsOsvIMQDf4uZMcI1rGsRo5XUtzhUPfqKXrsxtWI
         OeZne2dpmM7x09trS+m+lXzXrhNswbRs7Tjk8jRU1XG/sGH+ZroHZu4YucNTCLjt4NIZ
         iy/9q0iFYGTxkVIYpZmxB1ObToDj8vr4kBvB/K1gwamTmw5EEZXBYBtuZPBJwXNFwhzf
         OyOdINTgpKCYqGGlZhhRuGlRQNa6yPTnaGGtqGrCU8FQMBdsGy5xieNdJHDspzcOkeYP
         jCiw==
X-Gm-Message-State: AOAM532gYEAo2Y8lhYw15ywQBkC/3iKGPd1bmofq3yYhG/MfeiwHiBPJ
        ypy7VHUt9kNe5gcIKAgvPXQn4RejeZDlnw==
X-Google-Smtp-Source: ABdhPJynHlH7QgS7ZipkJ2BuzgJVXkPiA9XnmNZ59UUYilqZXSaHltTDKV/ZcJ+BDbNlZO4zbcrJiA==
X-Received: by 2002:a5d:588d:0:b0:20f:f290:ed83 with SMTP id n13-20020a5d588d000000b0020ff290ed83mr5681073wrf.588.1653473099860;
        Wed, 25 May 2022 03:04:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:59 -0700 (PDT)
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
Subject: [PATCH v6 17/29] CI: split up and reduce "ci/test-documentation.sh"
Date:   Wed, 25 May 2022 12:03:56 +0200
Message-Id: <patch-v6-17.29-7fa9c69e3ca-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index ca993afd098..88eb2ef2dad 100644
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
index 8df133b840b..5141de85024 100755
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
2.36.1.1045.gf356b5617dd

