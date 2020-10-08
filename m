Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41DC4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ECA217BA
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0qBZr9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgJHN46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJHN46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 09:56:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3DC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 06:56:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y12so1346299wrp.6
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EPQnwrtqXRnotRfd5BkBwcS4KzLm96Y9ramLHwlNn68=;
        b=P0qBZr9nddUdSgJsketcJD7wsmeCfdWyVzINXhpJWjh3Fgid8nW/gCynTg4qCi0HVW
         6behA14pgqu0Ra3/6i+siCi0Wle2kwphsBi7GKIigvAP/yK984dIfb/egqxUc6jLvF2h
         TF9EM9QXyg/XFz5EFF8D7sWET2u7pWKFa9AOPuiRkWjYORh4y6pa4DXPa/06eqGD7dRt
         URLnzZvthabgQdbn4Cl2E0oyN7581piUx9/7d7RJ9sYGwcGyV7BdF7dOBdVs/m9vSm1s
         dHvJtgoqtEwFl/YxZuX/xEdyYo3HICpEdb3/rDQSReXYJfk3nz+tsPp2U2du5swBpJe3
         k1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EPQnwrtqXRnotRfd5BkBwcS4KzLm96Y9ramLHwlNn68=;
        b=RjOmmEeK4ulRL8uijwXDtDrxRpXJOs1fF1Y9Nz4Mps6uus8d8J/cCuu74lKaE3GFw2
         flPU3OvP48yJ2hq+LzTdY/HPDMfwafaopdXlwNaHf0N+HlvnZasLyOnYjZGsm3NYsDU7
         DrMkYLzg/I6juvmcCQ/XxXBcOhz5UHCuT1EwSeglvESxt1o9Tc7qy8bUZOBbo2Unlex9
         TAi5Xe5A8WFUnwfutUJEdKZFPr1s3BwipRxJaWrU0uBuKQrFOxzrDk6qBVZLPwFpTNsA
         NS8vo0suSZwmn2BaSLYHUuna1Ijk41SbR66hSgcGoZuZcRo1Nc0jiJtVj+mrOZDlJQHV
         wipw==
X-Gm-Message-State: AOAM531yP7LWR1F7GQ7TEKgcLHVde/uexP0ECHe7qP2P7atzI0JXTlwl
        56SzDrurO1n5rstZjPw6wBoiQTncIt0=
X-Google-Smtp-Source: ABdhPJyL3cl0pPjI/hymDbjZRysJ8VhYz/N2aX4P4IS58QkRjhusC6Ofz8wc6zdU2Kh79h35p4Cw9Q==
X-Received: by 2002:adf:deca:: with SMTP id i10mr4200820wrn.96.1602165415106;
        Thu, 08 Oct 2020 06:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm7539847wrp.84.2020.10.08.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 06:56:54 -0700 (PDT)
Message-Id: <pull.747.git.1602165413035.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 13:56:52 +0000
Subject: [PATCH] commit-graph: ignore duplicates when merging layers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Thomas reported [1] that a "git fetch" command was failing with an error
saying "unexpected duplicate commit id". The root cause is that they had
fetch.writeCommitGraph enabled which generates commit-graph chains, and
this instance was merging two layers that both contained the same commit
ID.

[1] https://lore.kernel.org/git/55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de/

The initial assumption is that Git would not write a commit ID into a
commit-graph layer if it already exists in a lower commit-graph layer.
Somehow, this specific case did get into that situation, leading to this
error.

While unexpected, this isn't actually invalid (as long as the two layers
agree on the metadata for the commit). When we parse a commit that does
not have a graph_pos in the commit_graph_data_slab, we use binary search
in the commit-graph layers to find the commit and set graph_pos. That
position is never used again in this case. However, when we parse a
commit from the commit-graph file, we load its parents from the
commit-graph and assign graph_pos at that point. If those parents were
already parsed from the commit-graph, then nothing needs to be done.
Otherwise, this graph_pos is a valid position in the commit-graph so we
can parse the parents, when necessary.

Thus, this die() is too aggignoring the duplicates.

This leads to some additional complication that we did no have before:
if we only ignore the duplicates, then we will produce a commit-graph
that has identical commit IDs listed in adjacent positions. This excess
data will never be removed from the commit-graph, which could cascade
into significantly bloated file sizes.

Begrudgingly, the best way to fix this is to copy the commit pointers
into a new list that only contains de-duplicated commit IDs. This adds a
slight memory overhead, but it is small compared to having all of these
commits parsed in memory, so it should be an acceptable cost for
avoiding these failures.

Since the root cause for producing commit-graph layers with these
duplicate commits is currently unknown, it is difficult to create a test
for this scenario. For now, we must rely on testing the example data
graciously provided in [1]. My local test successfully merged layers,
and 'git commit-graph verify' passed.

Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    commit-graph: ignore duplicates when merging layers
    
    This wasn't quite as simple as what Peff had posted, since we really
    don't want to keep duplicate commits around in the new merged layer.
    
    I still don't have a grasp on how this happened in the first place, but
    will keep looking.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-747%2Fderrickstolee%2Fcommit-graph-dup-commits-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-747/derrickstolee/commit-graph-dup-commits-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/747

 commit-graph.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cb042bdba8..29bac78dc3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2009,6 +2009,7 @@ static int commit_compare(const void *_a, const void *_b)
 static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
+	struct packed_commit_list deduped_commits = { NULL, 0, 0 };
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -2016,6 +2017,8 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 
 	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
+	deduped_commits.alloc = ctx->commits.nr;
+	ALLOC_ARRAY(deduped_commits.list, deduped_commits.alloc);
 
 	ctx->num_extra_edges = 0;
 	for (i = 0; i < ctx->commits.nr; i++) {
@@ -2023,17 +2026,30 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
 			  &ctx->commits.list[i]->object.oid)) {
-			die(_("unexpected duplicate commit id %s"),
-			    oid_to_hex(&ctx->commits.list[i]->object.oid));
+			/*
+			 * Silently ignore duplicates. These were likely
+			 * created due to a commit appearing in multiple
+			 * layers of the chain, which is unexpected but
+			 * not invalid. We should make sure there is a
+			 * unique copy in the new layer.
+			 */
 		} else {
 			unsigned int num_parents;
 
+			deduped_commits.list[deduped_commits.nr] = ctx->commits.list[i];
+			deduped_commits.nr++;
+
 			num_parents = commit_list_count(ctx->commits.list[i]->parents);
 			if (num_parents > 2)
 				ctx->num_extra_edges += num_parents - 1;
 		}
 	}
 
+	free(ctx->commits.list);
+	ctx->commits.list = deduped_commits.list;
+	ctx->commits.nr = deduped_commits.nr;
+	ctx->commits.alloc = deduped_commits.alloc;
+
 	stop_progress(&ctx->progress);
 }
 

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
