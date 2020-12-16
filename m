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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA67C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8208723433
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgLPSvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgLPSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:48 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91812C061257
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a9so50973248lfh.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENbr56fqXEr+thNLGBeJb6mhbVotLLSkZGnz/ah8PXI=;
        b=cp0dpNQjKZLwRRBIySrrsdDQ/0AYfH+x+25zU5+jHUydOBO8Z8Szaa+/JxkHsRUGD7
         kJ/j/PGWu4InQHJ58JDwCYxsIIu0vkKJWOX933D3T+ScIXpyRGp63Qd3Z8H/qT5GHUq9
         ZZmUXqbRkWilIQwrDqAIxXhEan4/06O1+0Yr4DAb09sIJ8fromN3WF4l2qnODSsDHQ4s
         UNVnrtnHx2aEdwuJhQstbaRnia2JOftmm2Zoc33nQolwOj58cs8aX/Vs/sR0twCHaxB2
         /lCF3mmwfDxl1x6628Gkl/tAsQqlP3JK9tOvRYT2a+x50bHU3N9ZdIPMLQx1cPuPO1Yr
         nlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENbr56fqXEr+thNLGBeJb6mhbVotLLSkZGnz/ah8PXI=;
        b=CBus9QAmmvo+UrWogxmh5ySOFl/GS+e5QheVJNCyNhSANEJSLQAnJmQ9xEkiKM4tx4
         6lGHg910MjLnXYZNawGzCGdDfOCRLsumhELs6SbsLARDQwLmVN6jqd9IuBNqtr8gteoo
         lPd1jV+JaulS235up+L04c1go8W1OQ3CW3eHdyOBxX+l0P15H7iastsWDD/VZwoCXNSd
         8hIN/apfuv3Czosg/+0A9+1DsZIRhmkIzKHHuy8B5Syyyh45EKvhkCSKHZUDTxV4+uxi
         /Ch2+ZT6nwTvh2rwkUcuLn82MqJCLUaEZmaIFjzfoFIsPtvIWrC2LZAAldX5woLb99Fz
         nkdg==
X-Gm-Message-State: AOAM5329snO0rO4MyvvmR8ZXG/YM/c7X+FAV4K91WMFRK88Xf1DJGeDD
        vJrXpJeLT2yDSwda4DJX7k0=
X-Google-Smtp-Source: ABdhPJxvXI6/8vY9J3aiJCvuq3geitveKPXV8FKW+7V43KLtmlePSa2zYbFoRSz17JOCcjoQ0xcQyg==
X-Received: by 2002:a19:797:: with SMTP id 145mr12944731lfh.651.1608144634177;
        Wed, 16 Dec 2020 10:50:34 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:33 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 09/33] diff-merges: re-arrange functions to match the order they are called in
Date:   Wed, 16 Dec 2020 21:49:05 +0300
Message-Id: <20201216184929.3924-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For clarity, define public functions in the order they are called, to
make logic inter-dependencies easier to grok.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 24 ++++++++++++++----------
 diff-merges.h |  7 +++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 19b85bfdba6f..a3b732c34717 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,10 @@
 
 #include "revision.h"
 
+/*
+ * Public functions. They are in the order they are called.
+ */
+
 void diff_merges_init_revs(struct rev_info *revs) {
 	revs->ignore_merges = -1;
 }
@@ -44,16 +48,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	return argcount;
 }
 
-void diff_merges_setup_revs(struct rev_info *revs)
-{
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
-}
-
 void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
@@ -68,3 +62,13 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs) {
 		}
 	}
 }
+
+void diff_merges_setup_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
diff --git a/diff-merges.h b/diff-merges.h
index 18861dc5480e..243ef915c4cd 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -13,11 +13,10 @@ void diff_merges_init_revs(struct rev_info *revs);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
-void diff_merges_setup_revs(struct rev_info *revs);
-
-void diff_merges_default_to_dense_combined(struct rev_info *revs);
-
 void diff_merges_default_to_first_parent(struct rev_info *revs);
 
+void diff_merges_default_to_dense_combined(struct rev_info *revs);
+
+void diff_merges_setup_revs(struct rev_info *revs);
 
 #endif
-- 
2.25.1

