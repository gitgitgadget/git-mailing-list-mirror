Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18BC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0955360295
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhBALSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhBALSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2DCC061786
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s3so4662527edi.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYrpTzL+7/vhLWPFh1oELrVERmlasle4kF42gBMw31M=;
        b=c2wgO3zIt42F8iXtqA3XfE3WJgStFTHiTn4h1CiLOSFNBuP5h5J737Uy7SDxhbdzk/
         kYf++a6B6VWg/HXTDAq0EW67ccbHv85xpCEKjl3JtyVSNnNrW5wFFfJViDBRfg9n4Sx/
         NSyrCWz1FjeyQEawcPExLg9eNlrXx00rDYv5Xb9onORF1mXGZmMkoSo/Hn4bbXFTSGxE
         mFIYr4UKHZSx9BfJMkT0igbYCX+OBNg/AaSmfVFrIcL9oQiHoJUGhI2ZCcXtkKZHMuUH
         BVZjNyfbyCqVcVIivEe8xhQONaK1SV2Wf8k6EnB8dczDt7Zgpvtl9ghSuxMuskLrgbnj
         z/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYrpTzL+7/vhLWPFh1oELrVERmlasle4kF42gBMw31M=;
        b=AgQ7t3C8p8fM3QvTan2MzbS+fcrGv9VxuBNRJ1bY5pm5lV3m0B8dijsncguktY+ui3
         RYT/TIDJho7xGBhGQ72SpaHi9dTc3Fhju8+YErZK3ziuWt3xAUbH9FlU/PEtrBHoM5P0
         6EMraKNozcIppIkA9Y+LGPRMZ5J6iukLO9EzaiJIsK5SF2LpsXJ4O/vgy812q79V+U5s
         ATqPn/QX+BpXKpvjozDGJ1HkhniRgIiYOoxgSXFEv/lnHLItWdbBvCuj2JFEjmWTa8+6
         NdUXEZFdvdT/Lt7RwTk2ZCpzB/+jvSc3k0jq7rz5NG/OJ3jxBEFYPPSAEUZTYaaF1MJ+
         vnyQ==
X-Gm-Message-State: AOAM530egnMPVbXhcFH03VfAPpqAmFGYvRM/L/D7e/DrLpi5CIeVRlRx
        8WfHIJS1TJQzYITs9u0L9hf5u3sdiCWZUw==
X-Google-Smtp-Source: ABdhPJxb1/6Cm/XbZR4ihXcux0yj4yjXJg3N4AHY3UDC0AZQ5Fby1Qaln3KwKuBz+fCa3/KF6FlDrg==
X-Received: by 2002:aa7:c58e:: with SMTP id g14mr10053018edq.318.1612178254123;
        Mon, 01 Feb 2021 03:17:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] Makefile: add {program,xdiff,test,git}-objs & objects targets
Date:   Mon,  1 Feb 2021 12:17:15 +0100
Message-Id: <20210201111715.10200-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add targets to compile the various *.o files we declared in commonly
used *_OBJS variables. This is useful for debugging purposes, to
e.g. get to the point where we can compile a git.o. See [1] for a
use-case for this target.

https://lore.kernel.org/git/YBCGtd9if0qtuQxx@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 07763353423..31123639f65 100644
--- a/Makefile
+++ b/Makefile
@@ -683,6 +683,7 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
+program-objs: $(PROGRAM_OBJS)
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -2383,13 +2384,16 @@ XDIFF_OBJS += xdiff/xmerge.o
 XDIFF_OBJS += xdiff/xpatience.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
+xdiff-objs: $(XDIFF_OBJS)
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+test-objs: $(TEST_OBJS)
 
 GIT_OBJS += $(LIB_OBJS)
 GIT_OBJS += $(BUILTIN_OBJS)
 GIT_OBJS += common-main.o
 GIT_OBJS += git.o
+git-objs: $(GIT_OBJS)
 
 OBJECTS += $(GIT_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
@@ -2399,6 +2403,7 @@ OBJECTS += $(FUZZ_OBJS)
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
+objects: $(OBJECTS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
-- 
2.30.0.284.gd98b1dd5eaa7

