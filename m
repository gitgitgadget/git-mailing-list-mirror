Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39396C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB3B61B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhKPMIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbhKPMFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABAC061234
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so2182413wmz.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0u8mrPikfpozsZuwu5lKfiwFGSebR9jdTFIZIlU2as=;
        b=ePQ+X6JL9y456U0ucmdsOiitY/dQDKqRCjPqUq1u5arbPvTBSAK+rq6udXNdbdHEoK
         WT6B8HT6TmjbpPVCoYM0iWDEFfoXOGfKEzB/IGLZaUSPnr5HE4szWFSK6m8GZ+kPW2yD
         yOgwL4MJQ9CQywUB+gDYAnk/wdXggtzEkUusThEZxUGC5LzWxjuNoWffu1/bceqrR1Sq
         E2qO8NLF1LdDywKSw4f/wOprbAb1sBuTPp5mKCHrsQZn176Mt9X2Gaa8IULY7dNgt9bO
         +CJ5hzEn2bgj8WY0UGN921n3ztHaN5mq+JEh2XMS8581Bx/tmkox/AvxJ7ywDtvSVuPZ
         eQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0u8mrPikfpozsZuwu5lKfiwFGSebR9jdTFIZIlU2as=;
        b=fIIPkAvtVLEpnl6uZXhJa11jJOI2LL6gizG5KwWnDkWzTKEnHc+yWh5Km0i2iffg0J
         op3WS8S8fnFfIYo4hGcL8QN9+evoHHaqqqh1+ZB7ohh5YWN5vOH2VlnK3S/Z+D/323+l
         Y529SQEgqedVGwHMq8phKpF3AMI3K2q1CSBmIKG3Fbc4fXuMNmkMATK8T444+V+JmzNs
         DVwkIuqydoVuQkyAwUSoROGjdvViSj0ZZwjS1gwuSe7iCv4Fq+qoVSczWNWPfxWJaEIN
         sv8USaieRhMeN59rxmUQqcxJuNTyQdUJSXlr8zyQ9v8S020Qcc+tqU1F6il0hOhT7lyf
         e3mA==
X-Gm-Message-State: AOAM531IGfkx0KQx6mbO9rEEPMZi0HnFLhXwApL7CCvChz8rj+TvGCEQ
        2Rcd2qiSssarF+xgWR09XS/eaSqbl5ipLQ==
X-Google-Smtp-Source: ABdhPJygcWUvjmgIzrLu93yFvBNM1Kb7iDVzF/JlpR9KNc+MUCp9GgP3OCRdtt/lq21gM45xMrRUsA==
X-Received: by 2002:a1c:a710:: with SMTP id q16mr70122880wme.138.1637064053615;
        Tue, 16 Nov 2021 04:00:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 22/23] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Tue, 16 Nov 2021 13:00:22 +0100
Message-Id: <patch-v3-22.23-88cfc946b37-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 all NO_TCLTK=Y' 'make NO_TCLTK=Y' --war
    mup 10 -M 10
    Benchmark 1: make NO_TCLTK=Y' in 'HEAD~1
      Time (mean ± σ):      99.5 ms ±   0.5 ms    [User: 83.4 ms, System: 20.7 ms]
      Range (min … max):    98.8 ms … 100.2 ms    10 runs

    Benchmark 2: make NO_TCLTK=Y' in 'HEAD~0
      Time (mean ± σ):      69.4 ms ±   0.5 ms    [User: 58.8 ms, System: 14.2 ms]
      Range (min … max):    68.9 ms …  70.3 ms    10 runs

    Summary
      'make NO_TCLTK=Y' in 'HEAD~0' ran
        1.43 ± 0.01 times faster than 'make NO_TCLTK=Y' in 'HEAD~1'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 54 ++++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index bae20eb1b40..1041efb6e5e 100644
--- a/Makefile
+++ b/Makefile
@@ -821,12 +821,33 @@ GENERATED_H += hook-list.h
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
@@ -2661,26 +2682,6 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)pod2man $< $@
 
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
@@ -2860,9 +2861,6 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
-
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
-- 
2.34.0.795.g1e9501ab396

