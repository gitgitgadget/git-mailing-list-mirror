Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D21EC4332F
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiCYT3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiCYT3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:29:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EE2C77AC
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:03:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r64so4958603wmr.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8HmU7DuJgY2c7bdeUwuHeYyRmuCVGGPCGJjqI+W084=;
        b=WrJKgRhjrELIrh5JdSC0iQLuTzvRQ+QtZdDy8p0bbeYHBmdWnzIi8TtMrVOKOC//DT
         +UfS+tbyqS1xTdUAH26r8iVUrfxcJepU9SiXfjyL5ls00BfhAWvl/eAcZJvpO8F7FFsF
         LuazXWuKvfjXix+nnL0dWOGX5j32hbnNAP5MT7KjTpew/FYithdtM0NCS8CwnCqCFM0M
         s5AFK4V2ZM439bvLmLgw8YMAjj2Q91+vPyI7BcInT1cwF0aYQDUaLMdvtEiDomXyIqB4
         GZfhirKcyWE/ez1vau91ZJIZ91+inm2lsuueUW7wq+Y4wG886VqEIwS77xLZW4KG+UNl
         FUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8HmU7DuJgY2c7bdeUwuHeYyRmuCVGGPCGJjqI+W084=;
        b=W9yTrzHm4LSpXK8KLED/SHKyh07zUxcngMkoSsq94P9ntuhqeII4I1pyZ3cUprcuIl
         2maAa18XO3rIDEpqQOjNUDadu9PC5F7DnYkoPrueTEc753CBb3CsELoI/rwbfmmaWe8P
         8E5E8hcPJllYxlsxKa3F5zlPxXL0twIkTgrZa+lc2YAJFRMqE9/ZNIAosY1+muSwqXCL
         pJBAdMfWMyNm95FxtEmnxs/bM9/8sJMkl7N2UuxA6aywJt7KLod+VRYv02awDQW89eem
         /tNbpKewonQ49Owf6r1EoM9z0sJ4VTAyx/h2DbTDYn7pggpmt/KIw91NOpitbM9a2M6x
         zHyg==
X-Gm-Message-State: AOAM532l0BsItZu8imK5rztRFuo4JHisQeJO0fptsdtf2TFjbFVbIRfO
        2a5bEqNlbdsy8yfvbqzCMTL6mk+7hKRDxA==
X-Google-Smtp-Source: ABdhPJwbSLELIwGbPC710LfJYKWOeFCIp+M2jIIIlZEc7BuXdqHPbBzzM9M24gYGQTIdoWR/aFgwIQ==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id q11-20020a1cf30b000000b0037bb5dec804mr20838990wmq.166.1648233513161;
        Fri, 25 Mar 2022 11:38:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:32 -0700 (PDT)
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
Subject: [PATCH v2 15/25] CI: split up and reduce "ci/test-documentation.sh"
Date:   Fri, 25 Mar 2022 19:38:06 +0100
Message-Id: <patch-v2-15.25-dfa91ac8938-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
index 05f3dd15e27..fc6ce4d3e04 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -39,16 +39,6 @@ setenv () {
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
2.35.1.1517.g20a06c426a7

