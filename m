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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA60CC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF89864EAC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBARP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBARP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:15:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C52C061788
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:15:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so17463855wry.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rcseCZP2x1rpmxdurCQy/lUNoOhUFfcgvsvbOvu3pN0=;
        b=R6PfCswaoORVD3ev4e7K4a9+567SIpYRtq4i7ejo2pyYneqBQwZF8eNPgLh9A3x2A5
         +BUshlmG86HqTm/ECqKcfdl7QrXoZqB599abrkXlPbJYGTckZertDWYhLyZstCL9OMri
         4/FplQHVwHOEgY/fWL4Okq+24wKINoIKR/QqPFbCdOC0QcURDPEEShv3XnjezJSPhtpY
         NcYEzRjVjJAKWciAo+XbZ+Zqvls2YzoMPHd/k+mAIHeFTl1ITyEDetm7GkXOz7azKuX8
         VJYHrpv0ojRCEKO+X38mCXndj58LFrZQtSDqnhb+9jsK3F7aFr/tkU7uRE85GFGUewwA
         SEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rcseCZP2x1rpmxdurCQy/lUNoOhUFfcgvsvbOvu3pN0=;
        b=V3D5cU9fKq4D+JTxHhC6SNJoz8qQAl7iY466cyISjCJ4JafrhE7KqHTajegzMrbLSA
         ZCtbOXnjBfrzEsad14lrpXaExkjtBEl3tJOCsvAPUxtOcV4jcZDRgUd7aQ5B9GmO0G5P
         NW9C1ftbIACTC5MqVQxD7Tyk0Q4I6uIym9SFeI3bbp4Zzam7ces+FuihLz/qwvp9lmYM
         r8a7mpUi6q1XK8J+HpABT1J7hdzjmq6gLk0wb+l7lg0im+2s5jMP97SpzbttdiqxjXzD
         AxvWcnqDTe85ArtAssrTu3QJ4JriqkDvwBS+hdM3ayVbWL9tNBbRToZo3uurtxjwSCzy
         TwOg==
X-Gm-Message-State: AOAM532t9ZS2DsqIg7Ny3eNxTYVscrTqMb6YxYn6jzwQMPQlDf/Tl8pj
        /1BueXGI3VK7eIkiS+0tfroeb/41j0E=
X-Google-Smtp-Source: ABdhPJyp8Lhaid4weGL1tsolxiEzijLW1yFZDKwA0dBYitwVFQRFshlYllB0lW+ZVFZwygPSjzlboA==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr19060752wrs.420.1612199716403;
        Mon, 01 Feb 2021 09:15:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6sm21207166wmj.32.2021.02.01.09.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:15:15 -0800 (PST)
Message-Id: <b267a9653a7560d1e59708f20106ef054d140a9f.1612199707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.git.1612199707.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 17:15:06 +0000
Subject: [PATCH 4/5] commit-graph: be extra careful about mixed generations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gister@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When upgrading to a commit-graph with corrected commit dates from
one without, there are a few things that need to be considered.

When computing generation numbers for the new commit-graph file that
expects to add the generation_data chunk with corrected commit
dates, we need to ensure that the 'generation' member of the
commit_graph_data struct is set to zero for these commits.

Unfortunately, the fallback to use topological level for generation
number when corrected commit dates are not available are causing us
harm here: parsing commits notices that read_generation_data is
false and populates 'generation' with the topological level.

The solution is to iterate through the commits, parse the commits
to populate initial values, then reset the generation values to
zero to trigger recalculation. This loop only occurs when the
existing commit-graph data has no corrected commit dates.

While this improves our situation somewhat, we have not completely
solved the issue for correctly computing generation numbers for mixes
layers. That follows in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 13992137dd0..08148dd17f1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1033,7 +1033,8 @@ struct write_commit_graph_context {
 		 split:1,
 		 changed_paths:1,
 		 order_by_pack:1,
-		 write_generation_data:1;
+		 write_generation_data:1,
+		 trust_generation_numbers:1;
 
 	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
@@ -1452,6 +1453,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		ctx->progress = start_delayed_progress(
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
+
+	if (ctx->write_generation_data && !ctx->trust_generation_numbers) {
+		for (i = 0; i < ctx->commits.nr; i++) {
+			struct commit *c = ctx->commits.list[i];
+			repo_parse_commit(ctx->r, c);
+			commit_graph_data_at(c)->generation = GENERATION_NUMBER_ZERO;
+		}
+	}
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		uint32_t level;
@@ -1480,7 +1490,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 
 				if (level == GENERATION_NUMBER_ZERO ||
-				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
+				    (ctx->write_generation_data &&
+				     corrected_commit_date == GENERATION_NUMBER_ZERO)) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
@@ -1500,12 +1511,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 
-				if (current->date && current->date > max_corrected_commit_date)
-					max_corrected_commit_date = current->date - 1;
-				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
-
-				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
-					ctx->num_generation_data_overflows++;
+				if (ctx->write_generation_data) {
+					timestamp_t cur_g;
+					if (current->date && current->date > max_corrected_commit_date)
+						max_corrected_commit_date = current->date - 1;
+					cur_g = commit_graph_data_at(current)->generation
+					      = max_corrected_commit_date + 1;
+					if (cur_g - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
+						ctx->num_generation_data_overflows++;
+				}
 			}
 		}
 	}
@@ -2396,7 +2410,7 @@ int write_commit_graph(struct object_directory *odb,
 	} else
 		ctx->num_commit_graphs_after = 1;
 
-	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
+	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
 
 	compute_generation_numbers(ctx);
 
-- 
gitgitgadget

