Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62AC433FE
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiBYJF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbiBYJFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414F22EDDE
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d28so3414533wra.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aU67yUaqNPxaMKNMTB+MjujqNJpipu6UjY2jklHpieg=;
        b=UXa/7ziTUF4pj7snCBK196JRva0m44BBQdu8Fyn4mxh7+x+/nqXhL1oWgEIIwCy2d5
         BIQhkAaOfflxpgr0krHGE3XWMKON+ntM097g+2U7x3L/Vdz3PPynb7o8pJAD1bqTsy5f
         B2uP0Q0p8udbhPuk/Yx4fBSCqAA2DMnLSnw444Fy7VpDx1Z0q4NVkNvE0Q4RW3gPIxsD
         b5Sqvw+XHWk2joOB4aqJiU8qjylmeCR+R5jFHNIcceeBU3ZRVOLbmlCXIKIh9j/dDdw6
         4rnKXS4Tdhxqb/wHTtMLd53tbGm6ncXITowXzAQ8E5KCzo7/qxk5KvBrJiJIZ4E7QJyx
         IVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aU67yUaqNPxaMKNMTB+MjujqNJpipu6UjY2jklHpieg=;
        b=sC+T2OqZ2cYkgxyWdNb1YE9C+HIgsUwY/Jeb2K731gAcdFcb//8r1JgmzLEeijVmog
         E6ILQ6m1lA+KsQKHx1edxff5gZ/jNsFKJZ4KQwokPt7NnQsulTUzC1KP1RFl7YTYNfcU
         hatBdD3qYWapRtqnP100hovVD3sMcHFgblibFWz3HI+oTLV7wiwuwTmeK2wQK0Wvmia6
         /JASFIo+JqVZRYihJWxQjaMHm3j+89mdC0LIy5sfZIbIV9NvPC3zUPMJoqEZ302kMugQ
         haX/DPI9CEJ2a/S19/JosrqnVKJKvxC3zJ2MZ+4rri+B3vRKS8xO8twFZ1hdBokVQDlh
         Ezvg==
X-Gm-Message-State: AOAM531LJ+IkcdHmGFhWuxqd/BagrLV5+Me1X0rOsn+HL57BOVszIla/
        vHEKYuMAL7Q3wR2sY2Gtw58fqvNBZDtEdg==
X-Google-Smtp-Source: ABdhPJzuT253P7BhhdCQPHX5GWsJmYk4Ot4CIyR84HPra19KpEUsrjZDkHxeFqkcv25JbRqCP47jEQ==
X-Received: by 2002:adf:ed12:0:b0:1ef:585d:bfcd with SMTP id a18-20020adfed12000000b001ef585dbfcdmr3107534wro.570.1645779883274;
        Fri, 25 Feb 2022 01:04:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:42 -0800 (PST)
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
Subject: [PATCH v3 4/9] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Fri, 25 Feb 2022 10:04:30 +0100
Message-Id: <patch-v3-4.9-07cf9daa9d6-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
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
index d378ec22545..185bfa71df3 100644
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
2.35.1.1175.gf9e1b23ea35

