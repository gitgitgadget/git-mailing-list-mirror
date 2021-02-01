Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A0C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D24764EAC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhBARP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhBARPx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:15:53 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17768C0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:15:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o10so322921wmc.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Znqfxk2Gop1qR9R898yhT0BQKTbVqCtFqS7Cp/XrlV0=;
        b=GdIipdiWK9nVYpH8wKh490l/lg/zlIOfS3JsqlBMMgASfg9/VcMiX5W7zg5vF8Oe9C
         lMbPOsehAdrllIBgfvlDrwxiJATHaQgHUa6VRS24QgXNFDLLWkJT9BYkI9piuyYH90bQ
         OjQAWarzHFzO1BrSJM0wISLL++eNfL8hTaWmMeTcXuMiIc9OlEHdLPodKEhjtfCAx7gP
         lQ2RSFXC2mvIhzR4rzzlkA3c6JkwEwgeIONjR1SnqoEbACJrgV//ckgIPc2iVc7fRB3C
         tHEHIYqhRCnu8NXsyGZMtSjnNLZ6ddmaOH6S1KsffAlGuB1mH1SOuDauZpbZ3Twb4RzF
         ClmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Znqfxk2Gop1qR9R898yhT0BQKTbVqCtFqS7Cp/XrlV0=;
        b=ulY7b8VJLfAgDvFQmzp0eKfOIZF/ggq5cSr5v0vIgUJLM1SrA7TZOs/gH4Y6BGzQwI
         JfXXHbCcpo4QiOZhMT28he2ulYV8Vsh7/h7FKEiQ5X491dzWLIuBGLDsoDUVLxVkBNDm
         u7+uBklkElXd3Eb+xY9LyZP92kt6u+7x1HzPQGn7RfMkbmf7CYfhnM3PyzRcCqTZT8Dk
         z3GMGzQucXM2qNNhvF5DH56Fswy8AW8GV/68c1rNQSUCKmLKp4WPhuiY7WNZsNLMgIio
         CfZ24Ygg29V9kfZvtcn9Xd2YDyb6Y8Q5F411xoH1X2sBDQutZu/oBNHdOvDOm+UCS33B
         JpOg==
X-Gm-Message-State: AOAM531QJhuD0dMzuObUhuG17+tYyjVS2adConvLqEONt7gRt/YaOwPD
        31Q2WqwrtGliUlF60nU8RsSMl4WK6SE=
X-Google-Smtp-Source: ABdhPJw04DTdJ63l0Me3ysJd03WMs1vXBqV9DHc65YEfAM0epkSLFNO16c/Z2hqgbCl3trxjlfJcHA==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr15866099wmh.3.1612199711308;
        Mon, 01 Feb 2021 09:15:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm27820466wrp.13.2021.02.01.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:15:10 -0800 (PST)
Message-Id: <82afa811dffa3f7b3c371de5c220b0529d96ed87.1612199707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.git.1612199707.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 17:15:04 +0000
Subject: [PATCH 2/5] commit-graph: always parse before commit_graph_data_at()
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

There is a subtle failure happening when computing corrected commit
dates with --split enabled. It requires a base layer needing the
generation_data_overflow chunk. Then, the next layer on top
erroneously thinks it needs an overflow chunk due to a bug leading
to recalculating all reachable generation numbers. The output of
the failure is

  BUG: commit-graph.c:1912: expected to write 8 bytes to
  chunk 47444f56, but wrote 0 instead

These "expected" 8 bytes are due to re-computing the corrected
commit date for the lower layer but the new layer does not need
any overflow.

Add a test to t5318-commit-graph.sh that demonstrates this bug. However,
it does not trigger consistently with the existing code.

The generation number data is stored in a slab and accessed by
commit_graph_data_at(). This data is initialized when parsing a commit,
but is otherwise used assuming it has been populated. The loop in
compute_generation_numbers() did not enforce that all reachable
commits were parsed and had correct values. This could lead to some
problems when writing a commit-graph with corrected commit dates based
on a commit-graph without them.

It has been difficult to identify the issue here becaus it was so hard
to reproduce. It relies on this uninitialized data having a non-zero
value, but also on specifically in a way that overwrites the existing
data.

This patch adds the extra parse to ensure the data is filled before we
compute the generation number of a commit. This triggers the new test
to fail because the generation number overflow count does not match
between this computation and the write for that chunk.

The actual fix will follow as the next few changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 16 ++++++++++++----
 t/t5318-commit-graph.sh | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 03e5a987968..edbb3a0f2cc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1193,7 +1193,9 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
-		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		timestamp_t offset;
+		repo_parse_commit(ctx->r, c);
+		offset = commit_graph_data_at(c)->generation - c->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
@@ -1444,15 +1446,20 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
-		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
+		struct commit *c = ctx->commits.list[i];
+		uint32_t level;
+		timestamp_t corrected_commit_date;
+
+		repo_parse_commit(ctx->r, c);
+		level = *topo_level_slab_at(ctx->topo_levels, c);
+		corrected_commit_date = commit_graph_data_at(c)->generation;
 
 		display_progress(ctx->progress, i + 1);
 		if (level != GENERATION_NUMBER_ZERO &&
 		    corrected_commit_date != GENERATION_NUMBER_ZERO)
 			continue;
 
-		commit_list_insert(ctx->commits.list[i], &list);
+		commit_list_insert(c, &list);
 		while (list) {
 			struct commit *current = list->item;
 			struct commit_list *parent;
@@ -1461,6 +1468,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			timestamp_t max_corrected_commit_date = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
+				repo_parse_commit(ctx->r, parent->item);
 				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
 				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index fa27df579a5..2cf29f425a0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -446,6 +446,27 @@ test_expect_success 'warn on improper hash version' '
 	)
 '
 
+test_expect_failure 'lower layers have overflow chunk' '
+	cd "$TRASH_DIRECTORY/full" &&
+	UNIX_EPOCH_ZERO="@0 +0000" &&
+	FUTURE_DATE="@2147483646 +0000" &&
+	rm -f .git/objects/info/commit-graph &&
+	test_commit --date "$FUTURE_DATE" future-1 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
+	git commit-graph write --reachable &&
+	test_commit --date "$FUTURE_DATE" future-2 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" old-2 &&
+	git commit-graph write --reachable --split=no-merge &&
+	test_commit extra &&
+	git commit-graph write --reachable --split=no-merge &&
+	git commit-graph write --reachable &&
+	graph_read_expect 16 "generation_data generation_data_overflow extra_edges" &&
+	mv .git/objects/info/commit-graph commit-graph-upgraded &&
+	git commit-graph write --reachable &&
+	graph_read_expect 16 "generation_data generation_data_overflow extra_edges" &&
+	test_cmp .git/objects/info/commit-graph commit-graph-upgraded
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
-- 
gitgitgadget

