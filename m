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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD606C43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B111664E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhBAMs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhBAMsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9357C0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:47:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j18so12540905wmi.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TD3YqiwIGUfhzShNQFKZ9Adltf/LTAg7dpgLfajJDA4=;
        b=Y0cTRo6fyfjuwzMx4fLm1JyPO2N8r8IrdEBMtGAARW2c5M3utDC0IafDFpTaeQB3/A
         66QEovnb8sF1BHOT/Dk4kTS+CKZuQFGNmqhxCdCposZFQuk5rTEL9rCJpXcD7rPEB/ru
         gmjW5crIFJMEPU94DpwfEeTz/O0iHMzQnKsaXl/OlbHwDct7XGpZ7KL1y1ZMOEM7gw5j
         MfchbjMcPg4JCapTWfC+YsZ/7BSK3bX1QjvgltG67qzfy755mHbkcLlhhX8iouZ3jLB+
         GL3ZfMYuItF2n0iiKpjgt/vfOptH2W2kemiIqrnLwLNO1Q/oR7XaRVcaDGICAgX6SrXo
         uIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TD3YqiwIGUfhzShNQFKZ9Adltf/LTAg7dpgLfajJDA4=;
        b=NubnjFI+uyKSIxJR/4Ns42duA5MTh+Ny19Bc5P932Du9srCHbvCbToUrWHbw/nawMH
         jGGxl9FzAdh+DbunkXxso532W859kdpvnGcDZQ+gJc9aoRlnXBJsCV9+WmMutVlxho4Q
         //j6sA39O7AUGnlrt4Skd82VjOZxe55NxRnyeOV1YAPjq5bvwqSM6TbLAHZJVEfnoPcw
         fe0JIrJRojp0HrJZCs85Dua47t/df/gZDFh5KcMxX9VmhCLOKH1fqQaB1+PVR6Bh/+lS
         4SL8Ckd3gnkR3rzjQgq2DN50qCuXTAqrf1h8zsSy0PbBo/hi5PPqO82nuYLAaQYNZC0u
         d25Q==
X-Gm-Message-State: AOAM531QiETBe1EahzQQydyeLES3xOgrJ1sZBfgtaNYbt0k9AcZjvP4M
        1t7+C9XGH9rZifLbrDFQ+0U2+9mVCvY=
X-Google-Smtp-Source: ABdhPJxHnkW9MO6uTS8xs6LPShNpXqQAqP93cchGq6IAo7t6kldfQpIsLyNiZb5aN1hl5nnW4J+pRw==
X-Received: by 2002:a1c:ba44:: with SMTP id k65mr5409936wmf.25.1612183652581;
        Mon, 01 Feb 2021 04:47:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y67sm21716433wmg.47.2021.02.01.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:47:32 -0800 (PST)
Message-Id: <83feabeebb5f035059758fba1ca5cf74f3a22c91.1612183647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:47:26 +0000
Subject: [PATCH v2 4/5] commit-reach: use heuristic in remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Reachability algorithms in commit-reach.c frequently benefit from using
the first-parent history as a heuristic for satisfying reachability
queries. The most obvious example was implemented in 4fbcca4e
(commit-reach: make can_all_from_reach... linear, 2018-07-20).

Update the walk in remove_redundant() to use this same heuristic. Here,
we are walking starting at the parents of the input commits. Sort those
parents and walk from the highest generation to lower. Each time, use
the heuristic of searching the first parent history before continuing to
expand the walk.

The order in which we explore the commits matters, so update
compare_commits_by_gen to break generation number ties with commit date.
This has no effect when the commits are in a commit-graph file with
corrected commit dates computed, but it will assist when the commits are
in the region "above" the commit-graph with "infinite" generation
number. Note that we cannot shift to use
compare_commits_by_gen_then_commit_date as the method prototype is
different. We use compare_commits_by_gen for QSORT() as opposed to as a
priority function.

The important piece is to ensure we short-circuit the walk when we find
that there is a single non-redundant commit. This happens frequently
when looking for merge-bases or comparing several tags with 'git
merge-base --independent'. Use a new count 'count_still_independent' and
if that hits 1 we can stop walking.

To update 'count_still_independent' properly, we add use of the RESULT
flag on the input commits. Then we can detect when we reach one of these
commits and decrease the count. We need to remove the RESULT flag at
that moment because we might re-visit that commit when popping the
stack.

We use the STALE flag to mark parents that have been added to the new
walk_start list, but we need to clear that flag before we start walking
so those flags don't halt our depth-first-search walk.

On my copy of the Linux kernel repository, the performance of 'git
merge-base --independent <all-tags>' goes from 1.1 seconds to 0.11
seconds.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 72 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 7bf52e94429..d3a6e2bdd04 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -29,6 +29,10 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 		return -1;
 	if (generation_a > generation_b)
 		return 1;
+	if (a->date < b->date)
+		return -1;
+	if (a->date > b->date)
+		return 1;
 	return 0;
 }
 
@@ -231,11 +235,10 @@ static int remove_redundant_no_gen(struct repository *r,
 static int remove_redundant_with_gen(struct repository *r,
 				     struct commit **array, int cnt)
 {
-	int i, count_non_stale = 0;
+	int i, count_non_stale = 0, count_still_independent = cnt;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 	struct commit **walk_start;
 	size_t walk_start_nr = 0, walk_start_alloc = cnt;
-	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
 	ALLOC_ARRAY(walk_start, walk_start_alloc);
 
@@ -245,6 +248,7 @@ static int remove_redundant_with_gen(struct repository *r,
 		timestamp_t generation;
 
 		repo_parse_commit(r, array[i]);
+		array[i]->object.flags |= RESULT;
 		parents = array[i]->parents;
 
 		while (parents) {
@@ -253,7 +257,6 @@ static int remove_redundant_with_gen(struct repository *r,
 				parents->item->object.flags |= STALE;
 				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
 				walk_start[walk_start_nr++] = parents->item;
-				prio_queue_put(&queue, parents->item);
 			}
 			parents = parents->next;
 		}
@@ -264,26 +267,63 @@ static int remove_redundant_with_gen(struct repository *r,
 			min_generation = generation;
 	}
 
-	/* push the STALE bits up to min generation */
-	while (queue.nr) {
-		struct commit_list *parents;
-		struct commit *c = prio_queue_get(&queue);
+	QSORT(walk_start, walk_start_nr, compare_commits_by_gen);
 
-		repo_parse_commit(r, c);
+	/* remove STALE bit for now to allow walking through parents */
+	for (i = 0; i < walk_start_nr; i++)
+		walk_start[i]->object.flags &= ~STALE;
 
-		if (commit_graph_generation(c) < min_generation)
-			continue;
+	/*
+	 * Start walking from the highest generation. Hopefully, it will
+	 * find all other items during the first-parent walk, and we can
+	 * terminate early. Otherwise, we will do the same amount of work
+	 * as before.
+	 */
+	for (i = walk_start_nr - 1; i >= 0 && count_still_independent > 1; i--) {
+		/* push the STALE bits up to min generation */
+		struct commit_list *stack = NULL;
 
-		parents = c->parents;
-		while (parents) {
-			if (!(parents->item->object.flags & STALE)) {
-				parents->item->object.flags |= STALE;
-				prio_queue_put(&queue, parents->item);
+		commit_list_insert(walk_start[i], &stack);
+		walk_start[i]->object.flags |= STALE;
+
+		while (stack) {
+			struct commit_list *parents;
+			struct commit *c = stack->item;
+
+			repo_parse_commit(r, c);
+
+			if (c->object.flags & RESULT) {
+				c->object.flags &= ~RESULT;
+				if (--count_still_independent <= 1)
+					break;
 			}
-			parents = parents->next;
+
+			if (commit_graph_generation(c) < min_generation) {
+				pop_commit(&stack);
+				continue;
+			}
+
+			parents = c->parents;
+			while (parents) {
+				if (!(parents->item->object.flags & STALE)) {
+					parents->item->object.flags |= STALE;
+					commit_list_insert(parents->item, &stack);
+					break;
+				}
+				parents = parents->next;
+			}
+
+			/* pop if all parents have been visited already */
+			if (!parents)
+				pop_commit(&stack);
 		}
+		free_commit_list(stack);
 	}
 
+	/* clear result */
+	for (i = 0; i < cnt; i++)
+		array[i]->object.flags &= ~RESULT;
+
 	/* rearrange array */
 	for (i = count_non_stale = 0; i < cnt; i++) {
 		if (!(array[i]->object.flags & STALE))
-- 
gitgitgadget

