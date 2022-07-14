Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46167C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbiGNTka (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiGNTkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:40:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D644A67C83
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r2so2887906wrs.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67zCS8QrRmMaaIxEzKVkATJBA2wVj3iyoC5a4Md1UR0=;
        b=mVQqHW/2Kd4oYpLh1V9NrGy8bdzEh+g5b5zqve0ek6LDqhxdE4mQNMF04/GNRGi3ao
         KXHwMZNR+9zMbw9rhEK/+fg9iUNeU7DL7hGnueZiu6AjEDsktZ5r62kNJQioGFXlf9VU
         0sQ0qDRCYIIfbXX8DvSbm9Z7PO/FcPIi5OfL38uTyckfLhQxOKcw5i33QA9FF6XYCQxl
         PGnknKcZ4Ab/tSf6k+BLbcQiTmio6NBbf0lvYzvqixf1w8sSf9rBIb5eLEKeApC93mdX
         yz3hi5mHGSbfQqC3j3opBnOumtnocC/GUv3dMdqnESdND1JMbdTGf+30rZCmOm39ASs/
         H/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67zCS8QrRmMaaIxEzKVkATJBA2wVj3iyoC5a4Md1UR0=;
        b=mG/nZiQ/d/YWklBFBxBGVtsCbPnma5pzNZyBvQPTUBTBYFCfONId4dAwnXFQA9/fEj
         BVZWl/Et+jxCog52sByCDPE724PdEphGszds54HFHajB4htcC6ObngizkpRRzxdredPn
         UPoIK75J7kSw7sGfBrPaSWbDfRSrr9gAeLCYHLGmUyTXUtup3Zy6sJm3DAVD96S7+VCu
         4Tnjo+P6U263xiG65s/05xQBRp7daOy3i+BnvOV0qXK3yJuBEUJz71Y/ZQ1zyxXDpoPP
         0RGDz0sfGy+CV3lq6/D3A5l32eDi+LD4qt087E9iLnOV6ZGFqPlBTKQz/mwldywiPVxQ
         T9Vw==
X-Gm-Message-State: AJIora/H9KBG4YPOYRhpoJiVGCCzljevUfP7EMP3rC42zSZMS0uy92Sg
        aS0QnOhtDIVM/VHxtOCL6m/a8h+tkkSSyQ==
X-Google-Smtp-Source: AGRyM1uiiaEW8yJ89YXIBg4c1kBRKJTFgi8tDQDdzxPxhr63wnwSh20OTk2eUgCRb0cDutpok78JOw==
X-Received: by 2002:a5d:434a:0:b0:21d:aa7e:b1bb with SMTP id u10-20020a5d434a000000b0021daa7eb1bbmr9974017wrr.619.1657827603065;
        Thu, 14 Jul 2022 12:40:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:40:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] CI: have "static-analysis" run a "make ci-static-analysis" target
Date:   Thu, 14 Jul 2022 21:39:46 +0200
Message-Id: <patch-09.10-95b9c3797c0-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier to run the CI logic locally by creating
"ci-static-analysis" target.

Now the "check-coccicheck" logic added in 0860a7641ba (travis-ci: fail
if Coccinelle static analysis found something to transform,
2018-07-23) can be easily tested outside of CI, and likewise the
sanity check added in 0e7696c64db (ci: disallow directional
formatting, 2021-11-04).

These targets could be improved, the "hdr-check" target will re-do all
of its work every time it's run, and could with a change similar to my
c234e8a0ecf (Makefile: make the "sparse" target non-.PHONY,
2021-09-23). The same goes for the new
"ci-check-directional-formatting" target.

But without those improvements being able to easily run a 1=1
equivalent of the checks we do in CI during a local build is already
an improvement.

This change will also make the CI check faster, since we can take
advantage of parallelism across these "make" invocations. The "make
coccicheck" command in particular takes a long to finish its last job,
at the end we might only have one job pegging 100% of one CPU
core. Now any extra cores will be free to run the rest of the targets
under "ci-static-analysis".

Because we're now going to invoke "make" directly from the CI recipe
we'll need to amend the new "setenv" wrapper to write the "MAKEFLAGS"
and other variables to "$GITHUB_ENV".

In my testing the "static-analysis" job runs in just over 10 minutes
without this change, but this change cuts just over a minute off the
runtime.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  6 ++++--
 Makefile                   | 29 +++++++++++++++++++++++++++++
 ci/lib.sh                  |  7 ++++++-
 ci/run-static-analysis.sh  | 32 --------------------------------
 shared.mak                 |  1 +
 5 files changed, 40 insertions(+), 35 deletions(-)
 delete mode 100755 ci/run-static-analysis.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 8b7697df9fb..fa6d861c75a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -319,9 +319,11 @@ jobs:
     runs-on: ubuntu-18.04
     steps:
     - uses: actions/checkout@v2
+    - run: ci/lib.sh
+      env:
+        NO_CI_GROUPS: 1
     - run: ci/install-dependencies.sh
-    - run: ci/run-static-analysis.sh
-    - run: ci/check-directional-formatting.bash
+    - run: make ci-static-analysis
   sparse:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
diff --git a/Makefile b/Makefile
index 04d0fd1fe60..c328e190d64 100644
--- a/Makefile
+++ b/Makefile
@@ -3147,6 +3147,20 @@ coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
 # See contrib/coccinelle/README
 coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
 
+.PHONY: check-coccicheck
+check-coccicheck: coccicheck
+	$(QUIET_CHECK)for cocci_patch in contrib/coccinelle/*.patch; do \
+		if test -s "$$cocci_patch"; then \
+			echo "Coccinelle suggests the following changes in '$$cocci_patch':"; \
+			cat "$$cocci_patch"; \
+			fail=UnfortunatelyYes; \
+		fi \
+	done; \
+	if test -n "$$fail"; then \
+		echo "error: Coccinelle suggested some changes"; \
+		exit 1; \
+	fi
+
 .PHONY: coccicheck coccicheck-pending
 
 ### Installation rules
@@ -3589,3 +3603,18 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+### CI "check" targets
+#
+# These targets are run from the CI, see .github/workflows/main.yml,
+# but can also be run manually to run the same assertions locally.
+
+.PHONY: ci-check-directional-formatting
+ci-check-directional-formatting:
+	$(QUIET_CHECK)ci/check-directional-formatting.bash
+
+.PHONY: ci-static-analysis
+ci-static-analysis: ci-check-directional-formatting
+ci-static-analysis: check-coccicheck
+ci-static-analysis: hdr-check
+ci-static-analysis: check-pot
diff --git a/ci/lib.sh b/ci/lib.sh
index 67b7b32a0f1..14d0af2fa7f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -15,7 +15,7 @@ then
 	exit 1
 fi
 
-if test true != "$GITHUB_ACTIONS"
+if test true != "$GITHUB_ACTIONS" || test -n "$NO_CI_GROUPS"
 then
 	begin_group () { :; }
 	end_group () { :; }
@@ -89,6 +89,11 @@ setenv () {
 
 	eval "$key=\"$val\""
 	eval "export $key"
+	eval "export $key=\"$val\""
+	if test -n "$GITHUB_ENV"
+	then
+		echo "$key=$val" >>"$GITHUB_ENV"
+	fi
 }
 
 check_unignored_build_artifacts () {
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
deleted file mode 100755
index faae31f0078..00000000000
--- a/ci/run-static-analysis.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-#
-# Perform various static code analysis checks
-#
-
-. ${0%/*}/lib.sh
-
-make coccicheck
-
-set +x
-
-fail=
-for cocci_patch in contrib/coccinelle/*.patch
-do
-	if test -s "$cocci_patch"
-	then
-		echo "$(tput setaf 1)Coccinelle suggests the following changes in '$cocci_patch':$(tput sgr0)"
-		cat "$cocci_patch"
-		fail=UnfortunatelyYes
-	fi
-done
-
-if test -n "$fail"
-then
-	echo "$(tput setaf 1)error: Coccinelle suggested some changes$(tput sgr0)"
-	exit 1
-fi
-
-make hdr-check ||
-exit 1
-
-make check-pot
diff --git a/shared.mak b/shared.mak
index 4330192e9c3..3bd846aaf9e 100644
--- a/shared.mak
+++ b/shared.mak
@@ -58,6 +58,7 @@ ifndef V
 ## Used in "Makefile"
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
+	QUIET_CHECK    = @echo '   ' CHECK $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
-- 
2.37.1.996.g651fc6e809f

