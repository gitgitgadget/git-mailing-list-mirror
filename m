Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C812C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A5D613AB
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhHXVwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbhHXVwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D1C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso1562845wmr.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NRMabsLggRiXlRQv0kIMAy+bZxcG89mSHktSlIoVFk4=;
        b=i4wdarE4D7u6L05AXBAkvBME1uGVb99mH2kPwkYH3CvbNyymXBvU1jdLTBQl+nel2X
         ftC8lhS/5+7xhqMSQWBe5CQxiVAe4biPxoHgtacGso7P+oioY5RqaAgVSVDwgyXr4jen
         NNRpWc0IwIh1stO/QuQdmNQtrJq1H9kb5NLkjp+CSGqvOX1seXhcmlARJwHIVQl42TwZ
         WzKnt/hVMFit75JKBK3118p1mK/IRDlTys5W33gFLd7xu7gdgJ1Qs+vDHzxGI7xCivGp
         iKmNNN8EH6wtLXKiHTF50A5S63OJ9X3pYAqxd5An1WQ4lpg1bpZWKL6cOp7ffyUJrjsU
         IKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NRMabsLggRiXlRQv0kIMAy+bZxcG89mSHktSlIoVFk4=;
        b=AFEzxVjnn1CplECGpAWC5537shO9Je2UgFeaL7CQ9WmgADpxP9G4lBxdTHDDOup5SS
         DYjAszPZZ4C5OpIfRYqa/j5KvWeYOgDaR/YmLFphHTVd4OltkWD0RJhop2iwSi4tofFJ
         dFmxeCjrhp5obOEZW42lz2+JfmS10EdJqPANKJYLolhm1mS+A3PHKaszZvjcKbBaY3fG
         K80MIz7+ulxEx0NWSQ3ApYs/E3gqGFMqpJIE6mbMyqRL8uWXy0oyGHu1z7EJTcO2MEtV
         P+B+KvfYnnARPyfUSYHLbz+zsgH4HfcP0g3guRCeItTZhF1Ar3qlZnvb5bn27kNCcbb1
         dVjg==
X-Gm-Message-State: AOAM533jziIPj8cbj+ux6CUTFzht+zCROedzcIN0Yx/1aokbHncUR3rP
        q8Zpugji+UxbXt4nG2Z9caPITYxvugQ=
X-Google-Smtp-Source: ABdhPJy4jvrKm9T32JJbW6pW1nRuFgtL//UD4sIrwa60Tn2jSSoUYsZFTUQufzsU5E+tS0BNgtuVgA==
X-Received: by 2002:a05:600c:350d:: with SMTP id h13mr5776445wmq.38.1629841907022;
        Tue, 24 Aug 2021 14:51:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm19958131wrv.96.2021.08.24.14.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:46 -0700 (PDT)
Message-Id: <8660877ba7a06971bb5c443bbc1e07825e950a60.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:36 +0000
Subject: [PATCH v4 02/10] sparse-index: silently return when not using
 cone-mode patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While the sparse-index is only enabled when core.sparseCheckoutCone is
also enabled, it is possible for the user to modify the sparse-checkout
file manually in a way that does not match cone-mode patterns. In this
case, we should refuse to convert an index into a sparse index, since
the sparse_checkout_patterns will not be initialized with recursive and
parent path hashsets.

Also silently return if there are no cache entries, which is a simple
case: there are no paths to make sparse!

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index c6b4feec413..cd6e0d5f408 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -130,7 +130,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
-	if (istate->split_index || istate->sparse_index ||
+	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
@@ -158,10 +158,16 @@ int convert_to_sparse(struct index_state *istate)
 			return 0;
 	}
 
-	if (!istate->sparse_checkout_patterns->use_cone_patterns) {
-		warning(_("attempting to use sparse-index without cone mode"));
-		return -1;
-	}
+	/*
+	 * We need cone-mode patterns to use sparse-index. If a user edits
+	 * their sparse-checkout file manually, then we can detect during
+	 * parsing that they are not actually using cone-mode patterns and
+	 * hence we need to abort this conversion _without error_. Warnings
+	 * already exist in the pattern parsing to inform the user of their
+	 * bad patterns.
+	 */
+	if (!istate->sparse_checkout_patterns->use_cone_patterns)
+		return 0;
 
 	/*
 	 * NEEDSWORK: If we have unmerged entries, then stay full.
-- 
gitgitgadget

