Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF1C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378329AbiBUOro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7795FA8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j17so818240wrc.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqYChkBLuiLY4LNO1CIj1mE6XKgBlp82KYad2s48vsg=;
        b=plMYYHeuuv6BhqR9uvTcig1mFMQP9WfhJOpDxXGOwTc+keVd/kaX05639ZEanJt/OB
         yIePGr6qMZR+0BAaCb3pNu/7yiRNO34q63p0i2LRGJi2HIcDz4/VtyzaQyJrJ2yLU3T7
         ffzOHIlXLTXNR7N5m0BE1Ij1i985qykOV+jjtb4n5WIra+ORt+vMnCvKBL4XyR8gNW84
         9dgUTcVpspWl8ILtcsEpPuSpTsEP4+iQijxExRR0wA7v07QPqcCiqFZ970288/49CERP
         OxcgYYITBwbgtecO/TzaQJx1yZCW/8ZVaJyxAlIrbbG98v8Im0jrgD8TVYed58DlkEKH
         TGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqYChkBLuiLY4LNO1CIj1mE6XKgBlp82KYad2s48vsg=;
        b=xvtyu7vuivhd9F0oRVMyd+5mPuLrvjDxjKNzrmXGQkkUJcFAnCqf9JO0f9+EaQU+Hb
         7zVZKRjixB48/GP0bOvDG282NTMq8NBfIyEPEDtBrbBxe7eGxlUyAwd/xmFzqJ3tSXJV
         NqHWpBiYijUd81Qn0njXpwYcw+gaQddtLEoq3g6LSFO5xUaayCe+Brz2S8+a3BXXIxWU
         RyNxCG7veNSPBmGMV79EQVVRz0iZ3kPRs3E9dDpoxIbg7wunFnmv/du+pyKGj1v2dOni
         wVEB26bvoXxSvU3mgi7lLOqMn2pf4py5HdLcs3MUHEMavrvaMqStzkRY2LZHV3V8FahZ
         huUQ==
X-Gm-Message-State: AOAM531bXInKnSU0VeCyB+6bbSIOdO9dcVNdBgLkbi3u2nZY7mcuwyNV
        KJ2DDb9uaEUvKUdZhgVTb0vFo+Vi2o3HgQ==
X-Google-Smtp-Source: ABdhPJxRPvRL07JcqICqMCcAHoNx8o6MtR99wtNgb1s4ugsF1ZtIjXEbBKd6vxFZ+ut+i2Z94gTXgA==
X-Received: by 2002:adf:dc90:0:b0:1e4:a5fe:9b42 with SMTP id r16-20020adfdc90000000b001e4a5fe9b42mr15977352wrj.98.1645454813885;
        Mon, 21 Feb 2022 06:46:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:53 -0800 (PST)
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
Subject: [PATCH 07/25] CI: have "static-analysis" run a "make ci-static-analysis" target
Date:   Mon, 21 Feb 2022 15:46:19 +0100
Message-Id: <patch-07.25-836ef20fdcc-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
an improvement. Subsequent commits will expand on this ability.

This change will also make the CI check faster, since we can take
advantage of parallelism. The "make coccicheck" takes a very long
time, and at the tail end we might only have one job pegging 100% of
one CPU core for a long time. Now any extra cores will be free to run
the rest of the targets under "ci-static-analysis".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  3 +--
 Makefile                   | 29 +++++++++++++++++++++++++++++
 ci/run-static-analysis.sh  | 30 ------------------------------
 3 files changed, 30 insertions(+), 32 deletions(-)
 delete mode 100755 ci/run-static-analysis.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 309b9141249..ad752010102 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -317,8 +317,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/run-static-analysis.sh
-    - run: ci/check-directional-formatting.bash
+    - run: make ci-static-analysis
   sparse:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
diff --git a/Makefile b/Makefile
index 6f0b4b775fe..02cd563e216 100644
--- a/Makefile
+++ b/Makefile
@@ -2005,6 +2005,7 @@ ifndef V
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_CHECK    = @echo '   ' CHECK $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -3052,6 +3053,20 @@ coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
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
@@ -3487,3 +3502,17 @@ $(FUZZ_PROGRAMS): all
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
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
deleted file mode 100755
index 5a87b1cac96..00000000000
--- a/ci/run-static-analysis.sh
+++ /dev/null
@@ -1,30 +0,0 @@
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
-- 
2.35.1.1132.ga1fe46f8690

