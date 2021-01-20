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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092FC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A194223358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403956AbhATQzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403868AbhATQyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:54:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57298C061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:03 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q7so1833879wre.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QDPQ+/9yTiAK2nGZzt9251CqQ8MsbzHs5AF++igo8I=;
        b=PfMSOSOQYDk20zXv2FCe2fxxd7xEG/3m47Bdv4FOGyiqes8PVFiaI03xhxEeOStR7F
         N0OQWOkRZP3OPkAOLaAKYXr8bY51zJFit77zQFwHe7Zlj0lXjF1J5a+u+9nIsYAnyvxe
         oPFga9qP1LVmak62ld1km+1ss3NH2Wk9OMpqyAvyYw12VX0RRFINSB0OEbZJTJcFzNxS
         NZfJdqw9bBOHelq4R9DQ26jyd5PMNHsdTr++lMzMxdOuU/mE3e98Hy3QTH2e/Vbh24oL
         1DnNHSTcyHFhv1v1DnzpA/fxU0n6pSV1RKo993SNeGfEejGWU5py7G+PrUpf23/TvjME
         XbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QDPQ+/9yTiAK2nGZzt9251CqQ8MsbzHs5AF++igo8I=;
        b=D4SPURhvWkqG63hKBi6Ef/Uo4MZnT3F6OI7dk+rvuIv8z5GcF6eOVx/GPmFnQSsgv3
         sgvL/v24PIT/tGUSDfsvOuQ7A39GgDJ9QUuger0z9isGbLTHJMnUfnYDXTCuXxiNgC69
         tdvzT9TSXqisHlSyjlBCW2YDiMmGm3qEU1XXY1Izvdi0gZTK9ghUnGNcGFUE2IxosRUc
         H0ZhPMVmRukHVWWV53BvGkwmaY3PMsfxoDnzVtHRaPytIqRscGknrHwaRNb6kSl364Vg
         LFGy+3vm4a3jY7uSqIzQkoBCeZJbZrLQAH6iDdv7IOXCutQ8x+u/mpGGBaGi8lz4gYbO
         zDQA==
X-Gm-Message-State: AOAM5327IAw83l/W3qYFCaGwOE04ekQ6v5tOm8MfBYfwn97JAX/qt89n
        SQ1JTB6bAhHeVj5oGkOnmdYYV2KbLKs=
X-Google-Smtp-Source: ABdhPJyXBjA+Q4ByR5wGfqGvDWSou7E3fCXDaJpy+lhqWMDngyWrz9u7Wdla96QcBH969NBmBiAfYg==
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr10587478wrn.242.1611161641855;
        Wed, 20 Jan 2021 08:54:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m82sm5159538wmf.29.2021.01.20.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:01 -0800 (PST)
Message-Id: <0bccfd34ae5924aef0432fd6727debb75c052da5.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:51 +0000
Subject: [PATCH 1/9] cache-tree: clean up cache_tree_update()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Make the method safer by allocating a cache_tree member for the given
index_state if it is not already present.

Also drop local variables that are used exactly once and can be found
directly from the 'istate' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 3f1a8d4f1b7..c1e49901c17 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -436,16 +436,20 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
-	struct cache_tree *it = istate->cache_tree;
-	struct cache_entry **cache = istate->cache;
-	int entries = istate->cache_nr;
-	int skip, i = verify_cache(cache, entries, flags);
+	int skip, i;
+
+	i = verify_cache(istate->cache, istate->cache_nr, flags);
 
 	if (i)
 		return i;
+
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
+
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
-	i = update_one(it, cache, entries, "", 0, &skip, flags);
+	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
+		       "", 0, &skip, flags);
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
-- 
gitgitgadget

