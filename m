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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA7C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F58064E9C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBBDC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhBBDCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA55C061794
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so18834936wry.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0bnFoX5kshYd6yQsZTa9+a7wKtLUiSkJzedXbC9O7CM=;
        b=sdHrd9Q8iUntZ05IZmaKNbF3vllAKlUBcW/gUsXz4AT09OVWGDp4HCN2Oy++ZZNF0+
         e5eLzm3xv2kqvNHx6fRylsZkkc9nsAvlLtl2QT5htEe7Zy14fPQ5ZHkDkAvRytxHDxJg
         Kif2AQBhHBA/xehqZ2kCUvPBRFeKkuhT+wRrRwpPH2jLb1ZfQtASm0I0dEPGthWQWxk2
         90jJ0sgnlQaFXBmpk+JB4IlTBHwFvCswtanYLwIHpBgOZR905uBt+AujpZb4Q3ZKuFKA
         yXuudY9XPir1nbJWkVJ2vfPonLoQmsGg64UmL/o7sbCBejI4PO8ZtTZLdZfgDhahW9SB
         Oqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0bnFoX5kshYd6yQsZTa9+a7wKtLUiSkJzedXbC9O7CM=;
        b=jLWj6FBDqJO/iRXIaasIs159HeoV18pGv0JQxlA2hfmNQUHW1xmBmdsk2qhw4nT9mT
         zmIvUDeviyDVHbxvtgscLvsHmHQMO/Go+vdtOkCoG/83HgBqLhvT0s0R+u0zmzED38Ls
         pXBK3OXgDHfUIRVpUY6kH7HKIF437Ge7+Kn/WvYG0G1sAv98sYMyk1XVBLOOf0yiVHSj
         XQLBbwMLb1e69bFoILZFGG25TH1BilNEflwRxoPRBr6Qyatht9aHu4RGoGFtB9cb40Wk
         DPYKsx9oAVUK2qjgNHMqZub8LM2gUzG2lKc4iExCto7RbcNz1HjS1KPm4o2FEnVkOYsY
         gWKw==
X-Gm-Message-State: AOAM532vOcnAkrzlW5C5PNjZQmEI6dR6iCs9Bw7xV9naO29KymFPzYfa
        n33gTUP8Hs7Ve/ghrKrVduVHMyK51H0=
X-Google-Smtp-Source: ABdhPJxKs2Jrq5tEcyl4DaiEaILzIDkb1AufxwSGdDpInZKbGyTR7l96aC1Nb5+UaK4JZbPD+rX7Ag==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr20956762wru.64.1612234888567;
        Mon, 01 Feb 2021 19:01:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm28668401wro.58.2021.02.01.19.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:28 -0800 (PST)
Message-Id: <05248ff222fe7f2a7976e7a7cf2ee272eec6edbb.1612234883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:21 +0000
Subject: [PATCH v2 4/6] commit-graph: compute generations separately
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gitster@pobox.com,
        abhishekkumar8222@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The compute_generation_numbers() method was introduced by 3258c663
(commit-graph: compute generation numbers, 2018-05-01) to compute what
is now known as "topological levels". These are still stored in the
commit-graph file for compatibility sake while c1a09119 (commit-graph:
implement corrected commit date, 2021-01-16) updated the method to also
compute the new version of generation numbers: corrected commit date.

It makes sense why these are grouped. They perform very similar walks of
the necessary commits and compute similar maximums over each parent.
However, having these two together conflates them in subtle ways that is
hard to separate.

In particular, the topo_level slab is used to store the topological
levels in all cases, but the commit_graph_data_at(c)->generation member
stores different values depending on the state of the existing
commit-graph file.

* If the existing commit-graph file has a "GDAT" chunk, then these
  values represent corrected commit dates.

* If the existing commit-graph file doesn't have a "GDAT" chunk, then
  these values are actually the topological levels.

This issue only occurs only when upgrading an existing commit-graph file
into one that has the "GDAT" chunk. The current change does not resolve
this upgrade problem, but splitting the implementation into two pieces
here helps with that process, which will follow in the next change.

The important thing this helps with is the case where the
num_generation_data_overflows was being incremented incorrectly,
triggering a write of the overflow chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 70 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b3f7c3bbcb3..2790f70d113 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1446,27 +1446,24 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static void compute_generation_numbers(struct write_commit_graph_context *ctx)
+static void compute_topological_levels(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-					_("Computing commit graph generation numbers"),
+					_("Computing commit graph topological levels"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		uint32_t level;
-		timestamp_t corrected_commit_date;
 
 		repo_parse_commit(ctx->r, c);
 		level = *topo_level_slab_at(ctx->topo_levels, c);
-		corrected_commit_date = commit_graph_data_at(c)->generation;
 
 		display_progress(ctx->progress, i + 1);
-		if (level != GENERATION_NUMBER_ZERO &&
-		    corrected_commit_date != GENERATION_NUMBER_ZERO)
+		if (level != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(c, &list);
@@ -1475,15 +1472,12 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit_list *parent;
 			int all_parents_computed = 1;
 			uint32_t max_level = 0;
-			timestamp_t max_corrected_commit_date = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
 				repo_parse_commit(ctx->r, parent->item);
 				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
-				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 
-				if (level == GENERATION_NUMBER_ZERO ||
-				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
+				if (level == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
@@ -1491,9 +1485,6 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 
 				if (level > max_level)
 					max_level = level;
-
-				if (corrected_commit_date > max_corrected_commit_date)
-					max_corrected_commit_date = corrected_commit_date;
 			}
 
 			if (all_parents_computed) {
@@ -1502,6 +1493,55 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
 					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+			}
+		}
+	}
+	stop_progress(&ctx->progress);
+}
+
+static void compute_generation_numbers(struct write_commit_graph_context *ctx)
+{
+	int i;
+	struct commit_list *list = NULL;
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+					_("Computing commit graph generation numbers"),
+					ctx->commits.nr);
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t corrected_commit_date;
+
+		repo_parse_commit(ctx->r, c);
+		corrected_commit_date = commit_graph_data_at(c)->generation;
+
+		display_progress(ctx->progress, i + 1);
+		if (corrected_commit_date != GENERATION_NUMBER_ZERO)
+			continue;
+
+		commit_list_insert(c, &list);
+		while (list) {
+			struct commit *current = list->item;
+			struct commit_list *parent;
+			int all_parents_computed = 1;
+			timestamp_t max_corrected_commit_date = 0;
+
+			for (parent = current->parents; parent; parent = parent->next) {
+				repo_parse_commit(ctx->r, parent->item);
+				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
+
+				if (corrected_commit_date == GENERATION_NUMBER_ZERO) {
+					all_parents_computed = 0;
+					commit_list_insert(parent->item, &list);
+					break;
+				}
+
+				if (corrected_commit_date > max_corrected_commit_date)
+					max_corrected_commit_date = corrected_commit_date;
+			}
+
+			if (all_parents_computed) {
+				pop_commit(&list);
 
 				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
@@ -2401,7 +2441,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
 
-	compute_generation_numbers(ctx);
+	compute_topological_levels(ctx);
+	if (ctx->write_generation_data)
+		compute_generation_numbers(ctx);
 
 	if (ctx->changed_paths)
 		compute_bloom_filters(ctx);
-- 
gitgitgadget

