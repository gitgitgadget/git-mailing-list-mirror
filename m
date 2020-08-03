Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A89C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961F8206D4
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+FB/o+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgHCSl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgHCSl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:41:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85FDC061757
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:41:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so35142333wrl.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x7mt8q9mrmBv6ufF03Gh1PR5EdY4MRfFqXa2dOXs0tE=;
        b=F+FB/o+HIFdvLRon1iM5wyFD13Rhzvbdey0hxjT99MNdTdxkC29jI4CezyIe4x2Xy1
         Kd8ZbXvg1obUeapdnz9j2GMQVfsEU5IsKJyQEXdt0q7d7kuZXDs9NlcLFfW98v0jSAX6
         ZS8/7AdV6kR2Myzjpg5DLgBV4xdS5zvJhC1ewqGgn2JBGkTURWX/O9y35tS9xCgln2HG
         1t5OWhiiB6UAjezINQE1LBzugDwMcfnBL4fRvd1yliVlsN/5rDkRi7/tFl4cSiRRsgof
         688tINWfaVNvobMprXWbT1B2artPSWCQDtdVLVOzkNZH8VLUyTqod/sDfnnEBjGrRPhp
         JI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x7mt8q9mrmBv6ufF03Gh1PR5EdY4MRfFqXa2dOXs0tE=;
        b=VJJG2ceoBuQxdI0dgmJLOIDsNypLEl+nk6jIU/U/ZPfi/CpnBW/++ik0qM/vm/fzmI
         Qz5WnZ5vULAy25cDHqInreXn9Mtj2HXSu+5gredNnmkEwrrO3bFCw/N18AkHTCYnleWm
         NMnK3o+hQDgZe4cT+Yd/dud/XOp0CmDgK0c50sYaR/Q9ptcm+tMBH7h+vQUAsKfD9rM4
         aOwOhzx7LFC7W5RnlNXXrcoA3gO9Oh4BtMvpGua2LguatVErdCogoUf9xQLNxodcjI5h
         cOP9IOSgMvS8G69UahTWvn//6RoFxe9+hw11/cxaTLNlxL5c6cPbNPrORMdBCbdYW3BY
         xsLA==
X-Gm-Message-State: AOAM5308Gy9seacjuARIb35pqIIMylurQAqCJAEk0FwuLfPmv6VQMb7v
        GTBMniOWemsEp4pQKDTggUG7mNNY
X-Google-Smtp-Source: ABdhPJxlWJ8Cx63q8g7LbVON609bF3F5Pcr/rf7mFyI2yXSwtSIfRJEVBSebcZl7XXuHiA0p+FY/SQ==
X-Received: by 2002:a5d:6a41:: with SMTP id t1mr6772571wrw.388.1596480085364;
        Mon, 03 Aug 2020 11:41:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j24sm29049007wrb.49.2020.08.03.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:41:24 -0700 (PDT)
Message-Id: <36e08a75a3b9fdb0d5ca643f214fe4524578716f.1596480080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 18:41:20 +0000
Subject: [PATCH v2 4/4] checkout: support renormalization with checkout -m
 <paths>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 18c49034c4..2837195491 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -239,6 +239,8 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	mmbuffer_t result_buf;
 	struct object_id threeway[3];
 	unsigned mode = 0;
+	struct ll_merge_options ll_opts;
+	int renormalize = 0;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < active_nr) {
@@ -259,13 +261,12 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	read_mmblob(&ours, &threeway[1]);
 	read_mmblob(&theirs, &threeway[2]);
 
-	/*
-	 * NEEDSWORK: re-create conflicts from merges with
-	 * merge.renormalize set, too
-	 */
+	memset(&ll_opts, 0, sizeof(ll_opts));
+	git_config_get_bool("merge.renormalize", &renormalize);
+	ll_opts.renormalize = renormalize;
 	status = ll_merge(&result_buf, path, &ancestor, "base",
 			  &ours, "ours", &theirs, "theirs",
-			  state->istate, NULL);
+			  state->istate, &ll_opts);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
-- 
gitgitgadget
