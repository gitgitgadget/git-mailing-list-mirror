Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCAC4332F
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiCCQFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCCQFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B06197B43
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so2686834wmf.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zducfQTH4wQrdohNjeNlff+31JqYmwpRVXIf/4QALlQ=;
        b=TFp7p95sKAhdGqXovINoExK4gMKaLZv9B63vFeFAK5CEs1Q3ZztFnDisTkgcVbObDS
         D6/rwtXluDKN9TIcQRSYs/FMYzJn2vSgDpIcWpozDJJk1/ETxIRTy2UZl4D0/i8mhF1k
         /sB9gly1/oStDAbSnHLhQb+ynTzdydbmQeEjKG6QWGMraxUwAFoF2tj4GKdZlpWGvlb3
         W3yYe1qlDemO+Ml9iw8DcjkcEPlHmizv3SX2TNDB6pj37S9OK687yfBCLdPxEYQgRxz/
         O3GSrgiY6h+2fO/LF0TUMgtF53MRtBSaaO0RRl1dWRZxrNj2ZyRmscaUWWgSkYTpC4Bf
         timg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zducfQTH4wQrdohNjeNlff+31JqYmwpRVXIf/4QALlQ=;
        b=65zuGyRoMrXcsf6rm4YpA9v+iV3At6Gs0SmCIgXPXnR9lc1kIfNnipbwyIzbCbmdI1
         PJ9Rp7v4BPJivSCNnMA1OhSKxyIGLtIJ5pn3VER8HmxKJuj6ZCozIKyc1m/p+PF6/8ad
         botlrZMRbMcMPKL+Px1uj0oq1mwJg85AFMjmxeOWdcwmsN8hDyPnsErhXyVrrbeMo7zm
         MmoIY8dylZLLgsBr4G05aN5LC0AgwWPMJD/cMIv22i5fS5dI9z2IucpRZztJCHIvPDNR
         32pOntNpK3lAxU0xHm28P2leMMBTzwkadhTAvBbTXr2hHd5Wb3ri0s/a6y4Jkfby4v5A
         houg==
X-Gm-Message-State: AOAM530MOksr45Iu52rzaf3xWJLnvDZKAdaSxeCTvTzPg1lb/XZhD6Nq
        00OcYs55+Ps0/Ylcyql0e+A8+zoxVj/LtA==
X-Google-Smtp-Source: ABdhPJxXX+uxQJpuc1oev1TabKupkpa7VGqNKu4zMRKlZ3PR2ObtmjFgECwmHasuBvGAwXbu35pmWA==
X-Received: by 2002:a1c:a595:0:b0:385:92a:a135 with SMTP id o143-20020a1ca595000000b00385092aa135mr4193878wme.182.1646323484349;
        Thu, 03 Mar 2022 08:04:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/8] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Thu,  3 Mar 2022 17:04:15 +0100
Message-Id: <patch-v5-4.8-034779ff7fb-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the definitions of $(FIND_SOURCE_FILES) and $(LIB_H) to speed
up the Makefile, as these are the two main expensive $(shell) commands
that we execute unconditionally.

When see what was in $(FOUND_SOURCE_FILES) that wasn't in $(LIB_H) via
the ad-hoc test of:

    $(error $(filter-out $(LIB_H),$(filter %.h,$(ALL_SOURCE_FILES))))
    $(error $(filter-out $(ALL_SOURCE_FILES),$(filter %.h,$(LIB_H))))

We'll get, respectively:

    Makefile:850: *** t/helper/test-tool.h.  Stop.
    Makefile:850: *** .  Stop.

I.e. we only had a discrepancy when it came to
t/helper/test-tool.h. In terms of correctness this was broken before,
but now works:

    $ make t/helper/test-tool.hco
        HDR t/helper/test-tool.h

This speeds things up a lot:

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make NO_TCLTK=Y' 'make -j1 NO_TCLTK=Y' --warmup 10 -M 10
    Benchmark 1: make -j1 NO_TCLTK=Y' in 'HEAD~1
      Time (mean ± σ):     159.9 ms ±   6.8 ms    [User: 137.2 ms, System: 28.0 ms]
      Range (min … max):   154.6 ms … 175.9 ms    10 runs

    Benchmark 2: make -j1 NO_TCLTK=Y' in 'HEAD~0
      Time (mean ± σ):     100.0 ms ±   1.3 ms    [User: 84.2 ms, System: 20.2 ms]
      Range (min … max):    98.8 ms … 102.8 ms    10 runs

    Summary
      'make -j1 NO_TCLTK=Y' in 'HEAD~0' ran
        1.60 ± 0.07 times faster than 'make -j1 NO_TCLTK=Y' in 'HEAD~1'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 54 ++++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index aa5ff001b6e..1ac924bd844 100644
--- a/Makefile
+++ b/Makefile
@@ -833,12 +833,33 @@ GENERATED_H += hook-list.h
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
 
-LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
+## Exhaustive lists of our source files, either dynamically generated,
+## or hardcoded.
+SOURCES_CMD = ( \
+	git ls-files \
+		'*.[hcS]' \
+		'*.sh' \
+		':!*[tp][0-9][0-9][0-9][0-9]*' \
+		':!contrib' \
+		2>/dev/null || \
 	$(FIND) . \
-	-name .git -prune -o \
-	-name t -prune -o \
-	-name Documentation -prune -o \
-	-name '*.h' -print)))
+		\( -name .git -type d -prune \) \
+		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
+		-o \( -name contrib -type d -prune \) \
+		-o \( -name build -type d -prune \) \
+		-o \( -name 'trash*' -type d -prune \) \
+		-o \( -name '*.[hcS]' -type f -print \) \
+		-o \( -name '*.sh' -type f -print \) \
+		| sed -e 's|^\./||' \
+	)
+FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
+
+FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
+FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
+
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+
+LIB_H = $(FOUND_H_SOURCES)
 
 LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
@@ -2789,26 +2810,6 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	pod2man $< $@
 
-FIND_SOURCE_FILES = ( \
-	git ls-files \
-		'*.[hcS]' \
-		'*.sh' \
-		':!*[tp][0-9][0-9][0-9][0-9]*' \
-		':!contrib' \
-		2>/dev/null || \
-	$(FIND) . \
-		\( -name .git -type d -prune \) \
-		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
-		-o \( -name contrib -type d -prune \) \
-		-o \( -name build -type d -prune \) \
-		-o \( -name 'trash*' -type d -prune \) \
-		-o \( -name '*.[hcS]' -type f -print \) \
-		-o \( -name '*.sh' -type f -print \) \
-		| sed -e 's|^\./||' \
-	)
-
-FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
-
 $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) $@+ && \
 	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o $@+ && \
@@ -3018,9 +3019,6 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
-
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
-- 
2.35.1.1230.ga6e6579e98c

