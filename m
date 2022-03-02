Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22384C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiCBMuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbiCBMu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8EC8E1A8
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so2600278wmq.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KV4EL/gQ3xnJnagwUDX1XbDjDN3zMo5QPj1uWu3z5kw=;
        b=HBx/ovzdXcKPT61i5mrYs5F527ssdwp5zfxXfXMulEdGjITzy+iMnff0aIdZs8+/Qk
         4B4Y0Oid23dut0GzylWomL7eXtZFz+68da//G0wafQA5rG2rmNiPak+A4WoRVwZumY8R
         OvMR/ZrAOni9K0NSOsFMDGRX0nAFIL3V3Tcvzh+0Z5L5J73gB72oqwAsWm8X8a5g07IE
         82+1wz1PsbH5T+XnJKpIu1SHUZ7I2kuOn1wOgSQBpD6FgVOHZp0hzQOUqz1sxGDXxvxl
         mfjgtYyNkqQd0cVkJz7KfoTRJkYDcHXbuBqP0ztS8pKZMTB264kcWCJcQBxd3Wjv2PgQ
         5Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV4EL/gQ3xnJnagwUDX1XbDjDN3zMo5QPj1uWu3z5kw=;
        b=CurZ0BDUJA7mJrWS4Cbv43yMdSCMcVaOdXDkrqiWqjBd/tRY7rE0E73Bhx5NmQs4/P
         /ZaqUYvNT52sEDyLwnUP+rXXuyXkKI1fG7FOP/FUVr2hxM1sGszZ11dZX3aP0s2xlcto
         IHj1TNAbM4BrqKFHX9cjdlXrkcQY9XucWmaJZuSfkbSkWyp3C8uZUzz1ivg8vR3fkAnV
         V7d6RnjGiXF8FoocxeDaQrjmg1sAGzEin+vn6bcYVSP12yJcHnK80sOyO5FRnqJaG6zX
         3o/0vSH2yU4JCsfeNP0RTMOgDYEF16/URa2+NplXrDDrk5xebjB3D0nC9kYGResuRlmb
         Dumg==
X-Gm-Message-State: AOAM5317eEYWAGHvSPXcqnlNbXJVmv1xE6hxWzZSuXeEWPLiSYZZNus3
        CDAaXYp0lvevpDq7wybFz2Pg97m3RRcFAQ==
X-Google-Smtp-Source: ABdhPJyzvznzKD2y6X9t78LR8euIs9q58OMLYl3P/XBoSRrB6zhH2xAUMmZtr3XqmUhIq2pW/ZIySg==
X-Received: by 2002:a1c:a186:0:b0:385:31c:4b2d with SMTP id k128-20020a1ca186000000b00385031c4b2dmr1519572wme.7.1646225382222;
        Wed, 02 Mar 2022 04:49:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:41 -0800 (PST)
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
Subject: [PATCH v4 4/9] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Wed,  2 Mar 2022 13:49:12 +0100
Message-Id: <patch-v4-4.9-ea6b835308a-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
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
2.35.1.1228.g56895c6ee86

