Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE78C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiDMTzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbiDMTyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2975F4D0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1830083wmz.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxPCloD++6LtuowtMXehLXgj0gHRGotIIMkXvAnTFc8=;
        b=hclXciiqn1BZtTiQ2K9EhR1cxx4KMeYWAbIapBMYzWaJXRrLsayJhoMQjCLtrKRdqk
         QjA+yrMCm6FWxct8GhlNUdK/rmsn6gQmcaxF3AWyCt8m0w+njYzJ3e900VTolYJIzfiB
         ChKG1ugqqh+kp4z/2tnGDdGVRfHcuph906Itvz3pCxBdBqmOKYr7mtJQq0q0+7Jd7oWY
         PVbL0Oxszn/8UN7H/6j+eg8rmiyMprPwdxiEo/uoY6N+ISIrCo+BOnS6WfzayaDjs0v2
         52ZwJ9XcWbfXWJdsUNZxUCTVW/v5YpFSTm5YQBoomYhFuPLWD5t/9XDGM2+OqRKO5CuL
         dtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxPCloD++6LtuowtMXehLXgj0gHRGotIIMkXvAnTFc8=;
        b=UVgA2vSGTaNfuTOAQaWJwvHPCS924+APxryZANEF7vHAgdBxEBYDDBWUkJAIOLT5qz
         s2auaqM5Ur7PclZrCGCN2fQbug2WcUaz2ijI/kVB7dTemNSFgCiK1fz4L5zx7VbJJ3cW
         I4/+5EcUr5AwcD7UQYeP4EWP0f8fQc4vYPaEcgSunjA9HkWQYN4CXZawgLRtILrvBCsk
         0dZPLTzH6YmbbKzQ17UjTz7sjqGdJYMglwimubZLTxXsIgh/Gbg12PDInFTsZ4Xps5kf
         7ep7cBQ5jSgGt/Uefd4bjTashqJLMlHlB2Z74/xsqk8i6NUhJOlGoOcltVOXXj9Y3lPr
         6K6g==
X-Gm-Message-State: AOAM530oNdQKRJmS6rhbvoDHTmKlSaAapRrjqy388yMoaIEmgVmqWiGa
        AFjhTfQG37v96KeUzuoMss8dfIJ1MOkW5w==
X-Google-Smtp-Source: ABdhPJz6bQJERRG2g3qzU2X8K7+DnarNNTm07SJgRQJeuKn+0WdubNjKqublcH5ZGVNyzSK7iB9JJw==
X-Received: by 2002:a05:600c:6013:b0:38e:ad43:24d6 with SMTP id az19-20020a05600c601300b0038ead4324d6mr289982wmb.78.1649879530523;
        Wed, 13 Apr 2022 12:52:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:10 -0700 (PDT)
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
Subject: [PATCH v3 17/29] CI: split up and reduce "ci/test-documentation.sh"
Date:   Wed, 13 Apr 2022 21:51:30 +0200
Message-Id: <patch-v3-17.29-8837bfa5433-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "ci/test-documentation.sh" script to run the bash-specific
parts in as one command in the CI job itself, and to run the two "make
doc" commands at the top-level.

It'll now be obvious from the title of the step if if we failed in the
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
2.36.0.rc2.843.g193535c2aa7

