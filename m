Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241BEC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A6461BFA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhKQKYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhKQKYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:24:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8FC06122C
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so3442973wml.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUmrL/XG2zpOGV/60h5A9iyGb3Qfq9Nntx7WFjZL6WE=;
        b=TFpn8VFKaSrkb9IrIM+9ZA/SKL6VtTSLEQdBue/7SrwRQlNgrsLVq2IgTWyJvLMDVj
         BqcqJ00QO/y3g0h7I6F0l9BSleH0S8zXEFBOqEidlGL/sRS4MScJoE1g71XIdugT/Fqv
         8F4xg4o6mEcVkVcl9FfoQibug9nJz0D+IDxSnViFiPJU6+05TK9wePq4U2mp2LXB+yNB
         Uz1VKFrqLTyGyYjieT5UMjjFZhydAvNeQJEDgraskUbqE3D9KroIgpNniVm6bqD+3t4B
         I1fspYZA8t8j6ZCkNq3QlkZrMck4AYiaaZ0ThYdfvA7OjIA4y7iPPk3/ScYi2vWd0kCX
         BhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUmrL/XG2zpOGV/60h5A9iyGb3Qfq9Nntx7WFjZL6WE=;
        b=mqtUBiKcyY9DS9RtOCCtyIRfpSYpcRM/1/KElHl9ikodQzB4Mbm1hm6nNq58zL1Hk3
         aVka7y59toKgU+Kwn1jlr145U8GmyIEY/VRGy4o1J84RNItvtsenmRyXXO7G4TPgiJdL
         pTMwS6JraoCJZNA2Sn0pcfwMxyUhb8ZEteeW0GKGXTj5SXs72DvUwBcWC9S/NvpitKrI
         N+9xlWqjFH0lm5GlOw9ou2nyU9pWx24CCmrBMR1CnS6myregJSJHQow2u2xqOtXr4U00
         Vh2AuZN9nJfjMiWfMWCpmvEed40qp/2Y/1I8OEgyYYIwLCMb3HomCkbp4n0LSOHVenhx
         wTmw==
X-Gm-Message-State: AOAM531LRhpoJDlGDfZbntWXqm/KVMYXGfaDlX00lEz+30SI7lu8rIv2
        3lAVk2/Qix+cAGkjdi+0V88r+/fCBbWTzQ==
X-Google-Smtp-Source: ABdhPJy2U9LnQ/q+Df3tBZbDsAXfjHZYiwLDf3SVZR0bL0dexKdVRr5WnQdcpi+pcTWIYSL5Wg4RXA==
X-Received: by 2002:a1c:a715:: with SMTP id q21mr79666787wme.23.1637144445316;
        Wed, 17 Nov 2021 02:20:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:44 -0800 (PST)
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
Subject: [PATCH v4 23/23] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Wed, 17 Nov 2021 11:20:22 +0100
Message-Id: <patch-v4-23.23-48a3927d972-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added in 30248886ce8 (Makefile: disable default implicit
rules, 2010-01-26), let's move it to the top of "shared.mak" so it'll
apply to all our Makefiles.

This doesn't benefit the main Makefile at all, since it already had
the rule, but since we're including shared.mak in other Makefiles
starts to benefit them. E.g. running the 'man" target is now ~1.3x
faster:

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 -C Documentation man' 'make -C Documentation man' --warmup 10 -M 10
    Benchmark 1: make -C Documentation man' in 'HEAD~1
      Time (mean ± σ):      87.2 ms ±   1.0 ms    [User: 79.3 ms, System: 10.8 ms]
      Range (min … max):    86.3 ms …  89.7 ms    10 runs

    Benchmark 2: make -C Documentation man' in 'HEAD~0
      Time (mean ± σ):      64.5 ms ±   0.6 ms    [User: 54.5 ms, System: 13.0 ms]
      Range (min … max):    63.8 ms …  65.7 ms    10 runs

    Summary
      'make -C Documentation man' in 'HEAD~0' ran
        1.35 ± 0.02 times faster than 'make -C Documentation man' in 'HEAD~1'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 --
 shared.mak | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index eb1c944787b..035573c8997 100644
--- a/Makefile
+++ b/Makefile
@@ -2459,8 +2459,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
-.SUFFIXES:
-
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
diff --git a/shared.mak b/shared.mak
index 20109e6a90e..d8453bb471f 100644
--- a/shared.mak
+++ b/shared.mak
@@ -9,6 +9,11 @@
 %:: s.%
 %:: SCCS/s.%
 
+## Likewise delete default $(SUFFIXES). See:
+##
+##     info make --index-search=.DELETE_ON_ERROR
+.SUFFIXES:
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.34.0.796.g2c87ed6146a

