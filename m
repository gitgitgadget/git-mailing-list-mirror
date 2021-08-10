Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E425C432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3086B60F94
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhHJTul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhHJTuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8CDC0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b11so11705523wrx.6
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xF4Ml5ovwsHr66snlzRz3TrGLFSkIqW9omB3/KckS/A=;
        b=rM+Vwq34lpV37sHsn8XMqoVifrSvdmoPy738QC9nJn7nhMRjM7zD3jFqxR+zBmrHZK
         JeAfmTRt2S5/bN6RcFUz53u0itMqV6n8kjmpkztB98aItvRi+QguSNGjvKutyqMBZ7yK
         jHMFxgpuzk7YGH7jooP0l+5qcoC3F1OB0skxxy9J0AepI1Grksm1HKqeZytENOrXVzYO
         vlmDGxwFiUWmz+hXhzCRAsBDafIBJsFnV3XSbbySN3ofI/aHJZMuj7UyQfN0/Sd2Kbq1
         0TRJLAQwKQZjrrQ7dsHrzg0t7TjAckd0uZQcjp/hbObCgiCh4DDIW4a2AUrgJccoEc3y
         Zhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xF4Ml5ovwsHr66snlzRz3TrGLFSkIqW9omB3/KckS/A=;
        b=njb9sk5BM1tBiiVljbDvAaK9GavJ8WKbvIHrO+fguj26SYnlrViaYFT1vDf1Xe8pxC
         KYczxI8h1cE6Agzs83TsQbLv2lRI9L+Qt/6NBdNS6VU4ccVRoAoMzdXyzlENg4oTvFdk
         aHhypqVQciqskyPSd6opWDk9K/2oxBLFrMnPqvczySEIERPJojq2s6yTsf72vgEeab1b
         onF/rFfudRd0gZZxIL6WszlFFG7XdKvZvlEjqrO0mWBzLmZcShbPZAS0DezXDU461Ab3
         l/yvi+8OW48fnbOVkxIRHF2ydiP54cK8qG9AR1h4x26wws7ljyqqAnhb/nT0MJzPYHSr
         IcVQ==
X-Gm-Message-State: AOAM532rio4M+C+WCQ3eOrL8el7AI9KpwKXYt4TCHajBOiNDRUrIik7f
        xh4Lee2+YnteWRBLAL3jUj+9juT/CYU=
X-Google-Smtp-Source: ABdhPJy9Cr3lwEIt6ED1Nq3C5Qo0WicpCpZnNi/YiiqLHEv8gKRHrPntrCvQxzJ8s1EJBVxIfrUMjw==
X-Received: by 2002:a5d:4d8e:: with SMTP id b14mr2605655wru.422.1628625016450;
        Tue, 10 Aug 2021 12:50:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14sm19093561wmq.40.2021.08.10.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:16 -0700 (PDT)
Message-Id: <fb3ff9108bf832d258155d3c6ee95c8546f21ba5.1628625013.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:07 +0000
Subject: [PATCH v2 2/8] sparse-index: silently return when not using cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 sparse-index.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index c6b4feec413..bc5900eae35 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -130,7 +130,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
-	if (istate->split_index || istate->sparse_index ||
+
+	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
@@ -158,10 +159,16 @@ int convert_to_sparse(struct index_state *istate)
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

