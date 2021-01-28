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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA01C433E9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C52864DF6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhA1Q0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhA1QZl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:25:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908DC0613D6
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:25:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s7so3023124wru.5
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YrpT/69il7yDuXCPWJ3jVL8tIaNytb7pQst2wWxhzB4=;
        b=XDEu4Jbr6RBWfdY/oqlVU3DQL/4TIVR92MM8c0SpkSmdksjDAh1xgLPqXNEixaVbfX
         ZL3xBWgMuVYVo71IgWKYgMKYQQRpBvhYAHuA2ZSoHt2wZu4utt5zmlmh+V0VTa6whybl
         KbWXKRjQ6mEqeRKeo2fxqd8BajfnI4n4m9hh+fydxB8k+hm48/hVNl0bK64g+MdD2z4M
         cJY/MdQq5YrEs5dsIC8EanVEc/rfAaCek+W0NhAfSnNN1qrNF8m74n17VQRnSAYwSlV1
         DlHBrW2WhOXFXWrLpRRIqrf16VkDNA8SLgrN8EEakbo/MgJjivaI9vbhKD+Gx/g65xFQ
         nIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YrpT/69il7yDuXCPWJ3jVL8tIaNytb7pQst2wWxhzB4=;
        b=eq8TUQFdHvgMfhlAzcfuemLIYsrgVG4t1KN11RdtxTvqt1eEfuHpeHMYJNlCtbItkN
         7fVWOUylCLFWyv3NMZWelU8I5oSMoXhVBVXYKa3otjG7EOKX8arxBlaSSYHJn4/PFNEl
         W/jVHxy4eFZ4cE9H4+MWToUQjlvZclF6sKUS3nFicArUIDiGZox5z8BdQVsaRIFWzSaz
         Xe/2JrSMlFVax6Uo7WJu6+Jer2SiAp2RgU4jCBC4mrwhH3xQrKZWXzzB2uh8FlSHLPqG
         MhM2fISTkrgNopvNGJHN9zXrEtU9MhRbU3BaV2oSSX2CC46CVJkgdns80F50/W0RyTfV
         p79w==
X-Gm-Message-State: AOAM530lAPyAdE5i9fWt0NeSdsxFyXs7wiLzYcoaIpVWgk/W98Q+O/Fc
        36XMroqHZPoYk4/Gmv4bFqEnuS60tDc=
X-Google-Smtp-Source: ABdhPJwkP/FgE2DWQRbDNuPLcsIc7hm8Y4cQn1JAosIL5fRg+PysavI4akvsCA55zs4Lllwy3W1ihQ==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr16744147wrw.206.1611851099018;
        Thu, 28 Jan 2021 08:24:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm8091496wrj.11.2021.01.28.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:24:58 -0800 (PST)
Message-Id: <fbe7bdc1ec2ba6014dacc3a7ffa626b24c9aa7a5.1611851095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.git.1611851095.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 16:24:54 +0000
Subject: [PATCH 3/3] commit-reach: use heuristic in remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.net,
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
index 783c604a405..6032624282e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -179,10 +179,13 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	 * the array, and return the number of commits that
 	 * are independent from each other.
 	 */
-	int i, count_non_stale = 0;
+	int i, count_non_stale = 0, count_still_independent = cnt;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 	struct commit **dup;
-	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct commit **walk_start;
+	size_t walk_start_nr = 0, walk_start_alloc = cnt;
+
+	ALLOC_ARRAY(walk_start, walk_start_alloc);
 
 	/* Mark all parents of the input as STALE */
 	for (i = 0; i < cnt; i++) {
@@ -190,13 +193,15 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 		timestamp_t generation;
 
 		repo_parse_commit(r, array[i]);
+		array[i]->object.flags |= RESULT;
 		parents = array[i]->parents;
 
 		while (parents) {
 			repo_parse_commit(r, parents->item);
 			if (!(parents->item->object.flags & STALE)) {
 				parents->item->object.flags |= STALE;
-				prio_queue_put(&queue, parents->item);
+				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
+				walk_start[walk_start_nr++] = parents->item;
 			}
 			parents = parents->next;
 		}
@@ -207,30 +212,65 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
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
+	free(walk_start);
 
 	/* rearrange array */
 	dup = xcalloc(cnt, sizeof(struct commit *));
 	COPY_ARRAY(dup, array, cnt);
 	for (i = 0; i < cnt; i++) {
+		dup[i]->object.flags &= ~RESULT;
 		if (dup[i]->object.flags & STALE) {
 			int insert = cnt - 1 - (i - count_non_stale);
 			array[insert] = dup[i];
-- 
gitgitgadget
