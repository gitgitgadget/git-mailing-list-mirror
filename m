Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10209C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9632245C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404414AbhAZQJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392730AbhAZQH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:07:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE4FC0611C2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d16so16371883wro.11
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNUjum3805oFeie3m/0ZL3PONWfjOwVbUrYB2Bwq2Ao=;
        b=Hyx56KRFLbw003lRnHiK0FyYipdgdfim2qwnortG0mlqxopux5THGtWmH8aRVzDrgi
         b01sUl5bBrFvxFiGZTU+RqtW6o8rHPmbgy63ORg0xitXh1SBmphGIyy49tSYX/fi/gil
         bQ1NzfgcDwSUjjcRUAnm1x1IO2WdftEyGpCmNS0sejerHrbTeVGlIrQA2FNMDrl1QEu/
         aNw8KN5DUxWf1PI6V00Yp7VZ6TUae78x+Eo97TsosUKmF39TwRH3MJCjO8h+stLr5Yoy
         fnBmHOOlzn0x5Nu7Bv9B3ND8Z3mV2OsZSau1TL7eNZlYbCC0A3j3rPOFZWxPbsNVHzOO
         9M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNUjum3805oFeie3m/0ZL3PONWfjOwVbUrYB2Bwq2Ao=;
        b=p7Q2Vc657hmKiQG/1zkx9LkEWgfCENTBvhLBV+TarZSdMSPoL3St3W4BvwKXcbuDmY
         VFhNqPzIij08RCXDvXkHvDTHj+SgP0qUEGM0xTHwdKt5LaKE7OuRhQqclV90l8ENJGmQ
         h0neRzfAYCZuSWWFOivYsZJPB6pasoxrd5l9qYVColb7BtQ9VQ31DIgpYBM2zmhLzPuy
         iM8EiU6xv60PosDOYsg+PzkXOtRaGhMW32V6RNP9uX9Qqjn3DjNtAl5kc0ggMRme37ko
         9wkCXcA+KTStw9HL1EKPO4pJmX4D9JS5yTU23iMD9crzvwfC+af9ET8QiXA1ZA+AoRf3
         Nfeg==
X-Gm-Message-State: AOAM532olIIzpwua+hqJfyUfMXEnzA79kIzOhCCBqw7yY5Y+dV7pnRQK
        HSk5kOPABVpo0aIPzxM1ciFoIMxiuxddag==
X-Google-Smtp-Source: ABdhPJy8MfiVczC6K3JFNAAinSzbvmEoTW5Yel56TAO+ETmxLy5vbt0dL/tkNMb0QfhA6XXI5+FEJQ==
X-Received: by 2002:adf:c642:: with SMTP id u2mr6883056wrg.243.1611677234530;
        Tue, 26 Jan 2021 08:07:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17209743wro.27.2021.01.26.08.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:07:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] Makefile: refactor assignment for subsequent change
Date:   Tue, 26 Jan 2021 17:07:05 +0100
Message-Id: <20210126160708.20903-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210126160708.20903-1-avarab@gmail.com>
References: <20210126160708.20903-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a multi-line assignment into a form that'll lend itself
better to having "ifdef" split it up in a follow-up commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4edfda3e009..36c7b8fa08b 100644
--- a/Makefile
+++ b/Makefile
@@ -656,10 +656,10 @@ clean-perl-script:
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
 
-SCRIPTS = $(SCRIPT_SH_GEN) \
-	  $(SCRIPT_PERL_GEN) \
-	  $(SCRIPT_PYTHON_GEN) \
-	  git-instaweb
+SCRIPTS  = $(SCRIPT_SH_GEN)
+SCRIPTS += $(SCRIPT_PERL_GEN)
+SCRIPTS += $(SCRIPT_PYTHON_GEN)
+SCRIPTS += git-instaweb
 
 ETAGS_TARGET = TAGS
 
-- 
2.29.2.222.g5d2a92d10f8

