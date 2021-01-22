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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C014C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93D5206A4
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhAVNKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbhAVNEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:04:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBBC061786
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o10so6674209wmc.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DnyYrk3xRM3urTEzb/6aSNWait4NhVd0JL69VV/BPEg=;
        b=Whvh/bQ/urjrF8Ja+CDUEyIucySpGtPRafxojU7g5UNl8z1busP8a4mnrI00HLycyG
         ibml/KV8XCBnBqY9QiPAnwh+ud3/04CziccOkyRYp5LmK8ZJqK8fADLnSe1XNzALxfqe
         UjeMDf6Trx8jWN40EZ9priwm9m0laoPX0nnGlUuO5inAiOh3CJswWnipamgm+2E4X9rf
         jLPy+OqUREiig8yMIebp19aWvOo8OAvwXK/hi7+E3+xOSEQNxY94uAoiH4pgCW0Id568
         Pgy70srq8QJiQjl1V+0yf8g67yoxP/IyX1+82TNwRwmV14gfKuzCviuLUhXhURG2fwQA
         1hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DnyYrk3xRM3urTEzb/6aSNWait4NhVd0JL69VV/BPEg=;
        b=nOuxUCXJ8u9lwek54FbjeO0u+BqBwQr5zXOdDtely7uJk05meUS7RT0unkJC7kX9p1
         ApYRqEPM4Ne2BIkKmzIyu1qdhqwnQT6bJ8X4oDG5RGtr52xkFrAe9h5SSbT8LcOFAYHD
         qJn8Ho68zxIBSqG3WD69dtcyUGv5CQsnwC01ZXy9QaDBBg8T5jARN4VOje3+EhL3ql/V
         VVd3wrA1sxvhK8bBLumWzGbXXCBfC4N7hVvT+Wq6H7rTBroLIM5yd+SVQI+VfePxOiuZ
         FSDqXdWcyVUEOSaJzY3wU2VopO2pA0of2e2k+CBpclS1R0ZDegNNAzb76GHRQgVsWAmi
         d+ew==
X-Gm-Message-State: AOAM533dRYQkgRpD6v00xJfLYlb3CHnojXdXtpLIiIga7OJExx9gq1HS
        zvj0ss8gozjO8TPZJceR3SDYUVrhePQ=
X-Google-Smtp-Source: ABdhPJy3Ea35bL5YLjJODnY2WVKg9r7Ev5t/dXbCi7a/xCAhvGLMo3PpblPUxdKZ+9E3ElhlT+lRwA==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr3950237wmq.92.1611320642280;
        Fri, 22 Jan 2021 05:04:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a27sm12412372wrc.94.2021.01.22.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:01 -0800 (PST)
Message-Id: <f9dccaed0acae91b06f5f9ccaf0f9116b65f3f09.1611320639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:52 +0000
Subject: [PATCH v2 1/8] cache-tree: clean up cache_tree_update()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Make the method safer by allocating a cache_tree member for the given
index_state if it is not already present. This is preferrable to a
BUG() statement or returning with an error because future callers will
want to populate an empty cache-tree using this method.

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

