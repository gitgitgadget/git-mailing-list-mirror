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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B653C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E675C613AF
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhGVMOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhGVMOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F2C061760
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i94so5835725wri.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuEBlfzrkQk5xOURYJd9UI9s7AJMfkuT1nU7IrwGr8U=;
        b=JwSyIqHsaxLmE3YgVtSyJyIFMKKFv5NwBEpWacunsZWCJebJHt9zOJ5MBMsWHqG2l9
         L0zy+LcLCYMAOUUWDT3VSrsgtkCmvAKtEaV29R1mkNK30m88jzHJ5DD/UB9Ds9yrBXw3
         UsHQZjWyN7B9RZWCnZ53oHRh3owbSiPRDcCMDQ4TwHtHyBdvIa3LoMMVLgCSShCFaxiB
         6M4Xx3iMlW1clPKe7GuduMU1bxzwhAEZHpFzPwmK8PbmGYDbgnTcJwT5mGNYsvsYDNuh
         YVme45NaMDCrc9TxgjL57T5WPZutBMZeRG/RCGKmRN5XMFJXIyztodQp1q8+P6NDzsdO
         hbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuEBlfzrkQk5xOURYJd9UI9s7AJMfkuT1nU7IrwGr8U=;
        b=bRqH88dhiPE2DuXFt8fCL3CamWAyvXN6hTCPJeK7w6IczvixdSmGOLUsKh7h4E7GGx
         XStBl+IG+ZWg7ConKuOPtGM9eCu5kRe2oCMcuYm6i75WwyzUYThvDw30KV8VyKefvq1Z
         4jNgBN16z5vqwNGRVX8QtEtOPCn4zWv2U6YQsHVEhbTCc5aLa6NjBbx2Oa6bK3MqEc/v
         H+gjyu878AASrR83LuVaZXw3ituawzJFJPOFW9tajRRKoplSJmS3CI5kP6Z0MGA/Ho5e
         mmnn7QIk+kRYNgd1h3k5NKVJo+DVCJ1BtjneiAM0lvLKrapo3+MBXQXPM7n3IFladM3f
         zv3w==
X-Gm-Message-State: AOAM530n4R6MdVi9fB3ota0QKueUuCiEpiRdRkgIKoMH/vw2jorW2LgX
        sGxyq+p+7929yKTqkOZnXV2HheWOSCSmXg==
X-Google-Smtp-Source: ABdhPJxP9GArxbJFeqZ7qLJnQdQBbGXtC5deW2V73vlirrq0yZK5HhPajh7TTBixiT/vhl0tOJwYEA==
X-Received: by 2002:a5d:4cce:: with SMTP id c14mr29806415wrt.258.1626958512954;
        Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] progress.c: call progress_interval() from progress_test_force_update()
Date:   Thu, 22 Jul 2021 14:55:02 +0200
Message-Id: <patch-4.8-ac07681f24-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define the progress_test_force_update() function in terms of
progress_interval(). For documentation purposes these two functions
have the same body, but different names. Let's just define the test
function by calling progress_interval() with SIGALRM ourselves.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 893cb0fe56..7fcc513717 100644
--- a/progress.c
+++ b/progress.c
@@ -216,7 +216,7 @@ static void progress_interval(int signum)
  */
 void progress_test_force_update(void)
 {
-	progress_update = 1;
+	progress_interval(SIGALRM);
 }
 
 static void set_progress_signal(void)
-- 
2.32.0.957.gd9e39d72fe6

