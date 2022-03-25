Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17708C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiCYTeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCYTcS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161164BE2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:06:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4939918wmb.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StgURa+QQ7MI9Fz7PRC/Y58g6n0TJrcDd38nLcmRm0c=;
        b=PMtc5tlSutGIJj8fCLWIa9i+ICUGfEhK9Jw3ZAcvZVKYul3CXITSwZ7nMN+JqNQrzc
         sxFOuljJLuW2foocZT8fDJjCLmxCElkiRUPCVTafyrocmC9mdGtEAls7Z7GqZ7sGo/zA
         nnYrQczhhd82mdeD65/giV0UfluPf9KodsuwhaPfzDSYsWOZRhXtCEDE3D2V6MF8J9wb
         lDB/Aupl60dvNsQxTjYOrezRK5sYCV89ZjaLd7RQkyFa31Bas2aENwJy6JeWM0KCxypr
         g7/3OqbhwTkO5Ru80qcX09LLm1LZPitMAht+yUJi6rHVZJwbNM+Bc1tcWoaXjIZ2y9oI
         Rafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StgURa+QQ7MI9Fz7PRC/Y58g6n0TJrcDd38nLcmRm0c=;
        b=5bYi83Q8nipVCKflxI1OOkV2CjCTzTtnYuhl7jxMVbjOa9yaQRNSXDuh6qVVwekgiM
         glQjfxrOEczPgdCJX7s4uvl8RQsURpV6/Jq7hefmgIZWl9ElYUDa5Tjt2/RnbNbiGl4m
         Qz80aaZQIswiFv1NOYPZyqNnbEumwSASmWKHTsj1Tl5LKxWWgMBnxD/JRjcANmOavugF
         a5DITdkuWCa3WoXCxPlG/84S8QmTpPqhUkefXkL3lJwougXPG+4mg/REiOEelBlPUFsG
         NTsqeqhMzPYF9AlXm23w7XarsLFdLRFLaugfX/RgDwcEeKCqI3fLDDmE0H7ZzEWxh7T6
         geoA==
X-Gm-Message-State: AOAM531XVc+3asgnMfdHZroDmsIAvDPzwMiN4FozVAzcJzENEAGsr/jS
        1yUvZ4Xr5bBT/Ue2eVJFeEGusC8GivRpIg==
X-Google-Smtp-Source: ABdhPJzVVWYIZKEH2KX/k7SXaioW2wOB9BO7p4UPJTbyu1DS1lvtu2MG/e1Op9jL7G3HwKcGpIwX9Q==
X-Received: by 2002:a05:600c:511b:b0:38c:cb1f:b90f with SMTP id o27-20020a05600c511b00b0038ccb1fb90fmr11147204wms.109.1648233505543;
        Fri, 25 Mar 2022 11:38:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:24 -0700 (PDT)
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
Subject: [PATCH v2 07/25] CI: have "static-analysis" run a "make ci-static-analysis" target
Date:   Fri, 25 Mar 2022 19:37:58 +0100
Message-Id: <patch-v2-07.25-5d46d5b34c9-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
 Makefile                   | 28 ++++++++++++++++++++++++++++
 ci/run-static-analysis.sh  | 30 ------------------------------
 shared.mak                 |  1 +
 4 files changed, 30 insertions(+), 32 deletions(-)
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
index 70f0a004e75..d30862a23a2 100644
--- a/Makefile
+++ b/Makefile
@@ -3007,6 +3007,20 @@ coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
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
@@ -3442,3 +3456,17 @@ $(FUZZ_PROGRAMS): all
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
diff --git a/shared.mak b/shared.mak
index 4e1b62ee99e..0593b3c98be 100644
--- a/shared.mak
+++ b/shared.mak
@@ -68,6 +68,7 @@ ifndef V
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_CHECK    = @echo '   ' CHECK $@;
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.35.1.1517.g20a06c426a7

