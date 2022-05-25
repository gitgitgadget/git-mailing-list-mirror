Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E2C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbiEYKFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiEYKEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3C68FB0
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k30so29386402wrd.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxdyJpHHnZSDeVz0Pez10G6kzVb7IN2rA/U/3nkx5kM=;
        b=m5/zcUAudDjO3OLMRfLw4Tyy+keEWy1BBOfgaW5B4mnPbBkgUKHOA/tvEEn2H4aWV2
         whAA86Jivxf/AoyHbH2QWF2GvibdTbk14fhYxkBW3G8n7Fzm5goQJvBvgVgN+Oc4KHY+
         WUUR/3h6MvDtPgRYVFtWrL9hGJN4eAgf6L+vstr6bKXIAivLd2jFwsCIMAUUJCJcPvz5
         FcwCqgW/a0zxRgijWyFBaXdfSlqq/fob2ds5GoHKJky129tJCp4QEOQu3mNAX+eknuQM
         6a1UseYPEuz2XsB99e1q8+Vr8WcWR3h04NLFeuSA0jyfOWBeom3LFmKA1glNrm7mVbJB
         iDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxdyJpHHnZSDeVz0Pez10G6kzVb7IN2rA/U/3nkx5kM=;
        b=oGv9xaVK/lTAasxTWVlni2j+Ch1/PhgLlTd5CiLKi30oaXa1gTfKsJG1o/FDZiR3KR
         cK4azVhwm7TAqjUTvpn1LmZ32ogJmAe7xTZzNHgs9bQG5DAapFGyp8oM2ZoMj1lJO0N0
         olpqj+V5RRhZp5BWrxLoFjwiijDaTrm7q4YXR/T+QKVC9tGGKR5FcEee70eJnz7UsZrR
         ot6OuEuPQjw2kPP8ETYrzryA6J38a6jQIw+64fYgmAvomXUwYB3yPJ37tPeU2pJDm8hE
         VsJRRFT5MLC/eLNMyOy+1K4h/vMN9gbwG8HdpOQyvN4jU6yyd3A//CiugZTxi8kh3hGc
         dc6A==
X-Gm-Message-State: AOAM530djNbW1s+gHbxa2tSiVpTibm/3lG3ODGe33/Rolkvbo61fXtvS
        tB8mohPWlZbssaQjgrJC1skzEemYARckgg==
X-Google-Smtp-Source: ABdhPJwBuplKS8xyB/xBnFtotofXbZFYRkt3j5x88/j0nawDSSFaHkwC0zfmA58e1APpT8UMgbgQwg==
X-Received: by 2002:a5d:6e88:0:b0:20e:5f83:46fa with SMTP id k8-20020a5d6e88000000b0020e5f8346famr26413818wrz.475.1653473090328;
        Wed, 25 May 2022 03:04:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:49 -0700 (PDT)
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
Subject: [PATCH v6 08/29] CI: have "static-analysis" run a "make ci-static-analysis" target
Date:   Wed, 25 May 2022 12:03:47 +0200
Message-Id: <patch-v6-08.29-84e368736e2-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 61aadf3ce88..9ae7e1a373e 100644
--- a/Makefile
+++ b/Makefile
@@ -3034,6 +3034,20 @@ coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
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
@@ -3469,3 +3483,17 @@ $(FUZZ_PROGRAMS): all
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
index 50d4596f0d6..83e0aa16e7d 100644
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
2.36.1.1045.gf356b5617dd

