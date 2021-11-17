Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D708C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F1A61BAA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhKQKYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhKQKYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:24:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346AAC061228
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b12so3619267wrh.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MW0Witr/fs4Xmm7zb6ZAP4kfuLQfPUw7K9QtXn0uJA=;
        b=kL7Kyd/xBp9GTpZcBQqCA2ygbw6+s7y/I2lYL9dVCEAqlMFnwMUPySzGjVgA/8sJ38
         /QcJkF7fW3HIyIWwzqXcKKUSES1esb92TdfoWtGsqIllRi4coMaRrrTeNuZC0WGDhjNR
         CTlI7oamJe6d0/0SpB7n5QMgW1VAW3m4wap7oO0rKbr9mmoYZogpYWZDXYq/uC/nTQuG
         kWj3hoyArj9wcwm8DAgLsTJsF9BO9W6dpFTS3pclPh0gft0CIRKwK0Lvs+rQ8luIZ9Ml
         kvuq0arsM98PtKhvtPbaRv2VC/N2at3wx0K/iZLuWMrgwx2sPy1jLZ0loMOvFasHzqLe
         Uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MW0Witr/fs4Xmm7zb6ZAP4kfuLQfPUw7K9QtXn0uJA=;
        b=IQ8nqqp6Lag4OB1mnfNUIEMwWgSgYgrh+5ICUWgeJJ5N0HrBFjapHe00F2+tWk738k
         UTRFHUdnDW7OOv4NvBUeWPiaw27h0NdZRg8eBYZLCtJnSo82HZlxTuSHv/MYOZx/z9jP
         gltREgwnnv4VEWYPdePyw+t8XYgEUDdqVtQ8FtwwajRj7MaZa2p4Dw1rR8RFVOSBWlo7
         LS4Y7hfmDbPLIUaxpiByTZwbm2Fk4kchHpFeGTpMnWQqg9B0Wb5aWJiLYnttE52NG3IT
         TK0mzzvyTdfbEWdjr2oFh34mhROMqWVRKEz6BuNNdM07EZPIqDMwmm10zBxUhXdZC8BG
         M+OQ==
X-Gm-Message-State: AOAM532hDP4U26q3sUQKqFVBpJXs7CkWcPupKm2JYdKE/WIO/b3o1r9z
        U5f3BXxdydEr8q57qg8bdLGbx887c/SMhw==
X-Google-Smtp-Source: ABdhPJx9Ce18Vq6TMWiXXTS33+6FSYvmXHOx/48uEvnXZImCWhDuWgZOeebJgSRezSKG7dLe+dGUww==
X-Received: by 2002:a5d:65c7:: with SMTP id e7mr18448286wrw.319.1637144444568;
        Wed, 17 Nov 2021 02:20:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 22/23] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Wed, 17 Nov 2021 11:20:21 +0100
Message-Id: <patch-v4-22.23-4168a7e3b30-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
index a9fa9461613..eb1c944787b 100644
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
@@ -2660,26 +2681,6 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
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
@@ -2859,9 +2860,6 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
-
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
-- 
2.34.0.796.g2c87ed6146a

