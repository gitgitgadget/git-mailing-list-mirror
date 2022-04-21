Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07C1C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391330AbiDUS0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391303AbiDUS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CE34B436
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg25so3002996wmb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDvU982G2/CYVsnX0HBg4rxjdT9bVcnyrD7SxrTWg7E=;
        b=L4OGngu5xoe3K0ySPz7Jy3vlbLooZpe1I3jKAALCo9ke96UHjXRs6NnALfKS5r+lPG
         c189aE2kjMhZpIGI0n+4wMwycXkwCcGCbyhan556OBg8uts7sSuOqC+yUNZkgjbl0ews
         gD1LORdQwQygmVm9ADtd/xCZSA9gE56IXtg+9Mk/sbIDGs8+mLyNtaJFYLhWpQYij5qf
         15s77Rw26wKKsHyNe9gAoYir32vfnvHq0E09e3b/Hq95rkF7O+gYjGrqLXL/S4yyxlgD
         5g1ZB4Iw7+l7G2f/HkGli5x0dYeqTnSQmzFH6HKercf6DiL15YJXs9JV0z3rgAKIHr1E
         iAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDvU982G2/CYVsnX0HBg4rxjdT9bVcnyrD7SxrTWg7E=;
        b=P5z8gB0V/hGyuy0z7UvTUwhx6zlsXOh0OheGgx1Mw2TjLzAJIM8WW/gIZrp7fIbAW5
         AB74pZJTR2D/wSAJlFi3zuuYy8FGyVDK9JIi6/t5ezVmpRRfht4bbvkIFxpuuA5ImFPB
         l5GsIkSCDRIUdFivPbgByrtHUyWRgf3/F9YgYCXzUn1CWMX4wIgKBY/twisSf2OKS0SF
         O0Kg6nNd7QFYTxK8JlW9SI0QFLnIOmh7L+/Dos1lYp7zBCNaXNc/LB1I/uwIeMbg2oKj
         4wpJC0L5Zul23LY5FMlI+rE/WWddEqjcMHxhHKmraYtvom4ecQjrwEOmeFFyN8efNTuj
         IUfg==
X-Gm-Message-State: AOAM531JJtAE4Uhz0Vrx2QHNcX2t1qfxJYs5aC+3UaYz0h+hU88kx8ag
        ReJBjZ7yAD597ZwWWyAfKlprbNPwYYc9ww==
X-Google-Smtp-Source: ABdhPJwGjwO9M8wrfHWbgOHdmhEuoLTp6Z3mvCIzcPpoPTVTu2ElrFdVXe4A8Z+BYdzmqkiuEF2ZfA==
X-Received: by 2002:a1c:721a:0:b0:38e:c24d:7b8d with SMTP id n26-20020a1c721a000000b0038ec24d7b8dmr9976718wmc.83.1650565422298;
        Thu, 21 Apr 2022 11:23:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:41 -0700 (PDT)
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
Subject: [PATCH v5 08/29] CI: have "static-analysis" run a "make ci-static-analysis" target
Date:   Thu, 21 Apr 2022 20:23:03 +0200
Message-Id: <patch-v5-08.29-4a58f7be8d4-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index f8bccfab5e9..8717ea7e745 100644
--- a/Makefile
+++ b/Makefile
@@ -3031,6 +3031,20 @@ coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
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
@@ -3466,3 +3480,17 @@ $(FUZZ_PROGRAMS): all
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
2.36.0.879.g3659959fcca

