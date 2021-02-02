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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2566C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D1B64E9C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBBDCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhBBDCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178FC06178C
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so18841371wrz.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iNawx3rMk7XaAthMregzHDm9XD6OPZ1/mU6+xcSKWlk=;
        b=qjpR05p5r0XTldJHiex7wGBWWEoTsrU5bzLwLuG9t3G2UgjiefhhHUliy0mzjxZ2QO
         gympNTaJVHRlNRM1jPIPlXwTkJqkK9vRve73FO89Lls+xczENl5W1xPOL/qoYnGggNZE
         ns9dKRyVwsW9ygicXTPwOJzB8Ez4NqbL1M8+9eNvUZVqsbP9W8aigtj7VlDeMKj9OU28
         yyqLPWae7DXA3olEKGIjnMcxWZ9pVnrlJyzdPAlHfAeXTgvXK7/zP35uPBGT2xPB4HTP
         yAKUJjHJMLZeNWr66guVm2VlXWyFJ+4eAg30cbeqmzm7enzWqIYKN/44GXW03+WB8Pzz
         NB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iNawx3rMk7XaAthMregzHDm9XD6OPZ1/mU6+xcSKWlk=;
        b=KY4KgSIIjD7Aa9fdsADbyq4cZLVqLFk8rxaPqHDGgST9i4ZfK1DTUr4Eu+stjI4BRG
         FewZhYl9k/QyHW9tPS/x1uYEegqE7TWHq5KV7AoLizSEbApMQflfF20S33rOhkcuxa9X
         swOU248qVkNmH9naKEpcOPwtAn7GtdEii1WRMJ26puc9qMIaQ/bmWxNLr5FT08sM2Q6i
         uMszxc6H2uoE/3xryNBUGD4tfzzG1G8S4rqfTlU6+d+iV871j10SCJanJx0eiswfZogW
         jG2fPb09Z/N6hK964THrRWxePlsepdfosRtrmtPB/aUK0wE5Bd4ZvwOyStCpkjmm9ktH
         guPA==
X-Gm-Message-State: AOAM530bfEYsh6z74/cgsbYmNJCWzPYXgHMKYLHelPNqhcBn0JEPaNqY
        I7etpiz6A3c6eu5hVmx/Xir480KrvfU=
X-Google-Smtp-Source: ABdhPJyCe6Z+st1VratSXjjh4vzNGNjmf9vCipRpbR/g2/HIJwsyEzS/xD6dELAkeG6EI/xoGbbQpA==
X-Received: by 2002:adf:ba49:: with SMTP id t9mr21324963wrg.183.1612234886643;
        Mon, 01 Feb 2021 19:01:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm1226124wme.18.2021.02.01.19.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:26 -0800 (PST)
Message-Id: <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:19 +0000
Subject: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
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

It has been difficult to identify the issue here because it was so hard
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

