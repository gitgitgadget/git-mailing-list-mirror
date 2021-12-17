Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99717C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhLQBji (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhLQBjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57118C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j9so1265793wrc.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7h368rVPfWzXu3Kqbp6B08nnk4RgdyPdXIuJr0QQEc=;
        b=JYjqdl+iXs2t5yf+RcAuKOD8VVG24puOoFC/Dh+/ZOTWJ8KDkBnvCMMImcwmX73ZLE
         OFMHIvE9SZTV4bkuWqF6WB8VojPcOy0oyCx+XEhkBYTvfvqYwCqoiI67XJoH05PETbGX
         np4MexjFEGuAe9rcvRUxf39788b6y5pwPPU2DqMnxGtYt513MsDBJtxIGHgvxZ2lF3v5
         frbZri1m8NFeffUvB5ROzRs7yiR/lj/VH4PnNPq4g/+sAvrAzpe4R4kpVKQjoyZN4AgX
         NwPYI3SOLRYfNw199ATAlJpq7Ke5EVV4CD1XK6ByOqJA/fd5O5Nvqr/ZEG/aEUOlOyf0
         g+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7h368rVPfWzXu3Kqbp6B08nnk4RgdyPdXIuJr0QQEc=;
        b=qjEhDmSSsMYr3jATYobKNXLX+sBhlQX/HMZj+QGeK8y6asx/Y+7DioJ7ulufLN/nfN
         nPXu/MK4ySv1ds0xAHUOp+a/nJnhIuXX79KGRtzi5kTBUDKsxU1XcdZKjjpsWcTYrOJM
         uvjwMjCXmw+E2ns2zFW5UOhoIkRD8cy4+Lh1ZtwlWNQ2rrf7piS1ywp8UPgoO5ktgdNT
         s0pa++N0aEclDHd0CLOmqvh5CSObyjzAGgBFwmfU/BZ7hFvex4rbX+/h94m/HDItsRfZ
         pqQ54i4IlSTN8yyZCDs9X/Zkd46nYQazMwELPidEFi7Wmcgg854luZ3D+lgRaTCjrGSC
         /lsw==
X-Gm-Message-State: AOAM532e+x+7MzU4A/UWqbNa/ikmaDT8HR3z9DzE0LusncSF11DJszJ3
        n1Y5aUXPmMSpd8U8FGDFn0+oB5eexPpqkA==
X-Google-Smtp-Source: ABdhPJybr6vuj7XM4E2lHy3Ta/X+iR2Crq9U/O1m30RuzeczaTn9GhFpEHMHsH9mNOs8IAUh0mTxjw==
X-Received: by 2002:a05:6000:12d2:: with SMTP id l18mr467628wrx.289.1639705174208;
        Thu, 16 Dec 2021 17:39:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:33 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Fri, 17 Dec 2021 02:39:21 +0100
Message-Id: <patch-3.8-c6c6f7cf8d8-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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
index 9842a234790..d290a28671a 100644
--- a/Makefile
+++ b/Makefile
@@ -826,12 +826,33 @@ GENERATED_H += hook-list.h
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
@@ -2748,26 +2769,6 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
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
@@ -2977,9 +2978,6 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
-
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
-- 
2.34.1.1119.g7a3fc8778ee

