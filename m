Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6652C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836AE21582
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZHRAwD3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgIPSIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbgIPSHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A47C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:44 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h6so6861942qtd.6
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Lh1rTmJypFjZMoBWdiU5LBa9Psj2qZiA1TVG4tv1vw=;
        b=ZHRAwD3RSszLfENiDu0rOzMcyxD3fwehjCgpn9YJeUR1qSawQWhAc3pa5/Rp6PfzlB
         RZzaAHgFjSC+0K4kO4fB6V8BfG2jMueyYuE6Mz1U7woX+25LlUZBdd+nxFJ25h0haGZm
         GGxvOD5UVqQdIdr7w+OUt/eeteAZaAmDPs/vKLOv+VBUKlcJ5XdpyAJgvCXMbl/jz1xH
         wcPFL1u5awxUFq08pfYBmarEA9JWyr1kzcRpNGzHShAOTLRtrPutkscDM/HvnwenCZkF
         /dxUVH8ESVaHon2mJBn8+9/H/SOQ1WrTcaCi2Ylq13dZpMA7UrUYl0Lpb35VlqVecdtI
         3Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Lh1rTmJypFjZMoBWdiU5LBa9Psj2qZiA1TVG4tv1vw=;
        b=ItHhSLoiYslRsaf9oMgxb/T4emrN4sGz1FOF+yclcW1PiL2H69X9CRpC4S7OdQxURe
         UmkpRe90mBuaL6gaYBQNp0Tym/MkVXAKCmGo6t7878r716Dt2MT8QP8cMmSIQ9M39Td+
         1bgf/PBWpiFBRquzx/YK/wSPXuO+QpEtLwKfiKQrbWzCM8g1ps7V7AC/7B/LCgNU+Kw8
         Bqi4RdVdiAEXwBK25L2U7SejyDMivc1fhabEBHDpDH+za7do1r6r+aaA/S8su+gJMjE/
         QL+rel0v3Z33a6B6rn43hY1QBET99qMDvFfmBP7CZeIPhU9fPfTNmjTl6W/St3/09uhO
         o9aQ==
X-Gm-Message-State: AOAM531khKa4+/AkkzlOfxWoyD+kTbk1NixZHCZ/8YMWnM7+B5As3wkD
        oOyBXnT3+4dh2xC4XsWlt4a2LD8dv/TyUzJz
X-Google-Smtp-Source: ABdhPJy/gng48dYGjrrdoKo/ygcPLYrqJVusS8WcP4RFb1pkGylSPqosaax9iB1lbvWvYwwDV5ff8Q==
X-Received: by 2002:ac8:7b2c:: with SMTP id l12mr23562802qtu.98.1600279662018;
        Wed, 16 Sep 2020 11:07:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id r42sm20221684qtk.29.2020.09.16.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:07:35 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 07/13] bloom: split 'get_bloom_filter()' in two
Message-ID: <ee8f527a0078161f0466a75e85eef611249a0a46.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'get_bloom_filter' takes a flag to control whether it will compute a
Bloom filter if the requested one is missing. In the next patch, we'll
add yet another parameter to this method, which would force all but one
caller to specify an extra 'NULL' parameter at the end.

Instead of doing this, split 'get_bloom_filter' into two functions:
'get_bloom_filter' and 'get_or_compute_bloom_filter'. The former only
looks up a Bloom filter (and does not compute one if it's missing,
thus dropping the 'compute_if_not_present' flag). The latter does
compute missing Bloom filters, with an additional parameter to store
whether or not it needed to do so.

This simplifies many call-sites, since the majority of existing callers
to 'get_bloom_filter' do not want missing Bloom filters to be computed
(so they can drop the parameter entirely and use the simpler version of
the function).

While we're at it, instrument the new 'get_or_compute_bloom_filter()'
with counters in the 'write_commit_graph_context' struct which store
the number of filters that we did and didn't compute, as well as filters
that were truncated.

It would be nice to drop the 'compute_if_not_present' flag entirely,
since all remaining callers of 'get_or_compute_bloom_filter' pass it as
'1', but this will change in a future patch and hence cannot be removed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 blame.c               |  2 +-
 bloom.c               | 16 +++++++++++++---
 bloom.h               | 16 +++++++++++++---
 commit-graph.c        | 34 +++++++++++++++++++++++++++++++---
 line-log.c            |  2 +-
 revision.c            |  2 +-
 t/helper/test-bloom.c |  3 ++-
 7 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/blame.c b/blame.c
index 903e23af23..e5ba35dbd1 100644
--- a/blame.c
+++ b/blame.c
@@ -1276,7 +1276,7 @@ static int maybe_changed_path(struct repository *r,
 	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
 		return 1;
 
-	filter = get_bloom_filter(r, origin->commit, 0);
+	filter = get_bloom_filter(r, origin->commit);
 
 	if (!filter)
 		return 1;
diff --git a/bloom.c b/bloom.c
index cd9380ac62..393c61b4bc 100644
--- a/bloom.c
+++ b/bloom.c
@@ -177,9 +177,10 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data,
 	return strcmp(e1->path, e2->path);
 }
 
-struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c,
-				      int compute_if_not_present)
+struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
+						 struct commit *c,
+						 int compute_if_not_present,
+						 enum bloom_filter_computed *computed)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -187,6 +188,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct diff_options diffopt;
 	int max_changes = 512;
 
+	if (computed)
+		*computed = BLOOM_NOT_COMPUTED;
+
 	if (!bloom_filters.slab_size)
 		return NULL;
 
@@ -271,8 +275,14 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 			diff_free_filepair(diff_queued_diff.queue[i]);
 		filter->data = NULL;
 		filter->len = 0;
+
+		if (computed)
+			*computed |= BLOOM_TRUNC_LARGE;
 	}
 
+	if (computed)
+		*computed |= BLOOM_COMPUTED;
+
 	free(diff_queued_diff.queue);
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
diff --git a/bloom.h b/bloom.h
index 0b9b59a6fe..e2e035ad14 100644
--- a/bloom.h
+++ b/bloom.h
@@ -89,9 +89,19 @@ void add_key_to_filter(const struct bloom_key *key,
 
 void init_bloom_filters(void);
 
-struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c,
-				      int compute_if_not_present);
+enum bloom_filter_computed {
+	BLOOM_NOT_COMPUTED = (1 << 0),
+	BLOOM_COMPUTED     = (1 << 1),
+	BLOOM_TRUNC_LARGE  = (1 << 2),
+};
+
+struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
+						 struct commit *c,
+						 int compute_if_not_present,
+						 enum bloom_filter_computed *computed);
+
+#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
+	(r), (c), 0, NULL)
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
diff --git a/commit-graph.c b/commit-graph.c
index 55af498aa0..45fcd62596 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -971,6 +971,10 @@ struct write_commit_graph_context {
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
+
+	int count_bloom_filter_computed;
+	int count_bloom_filter_not_computed;
+	int count_bloom_filter_trunc_large;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1182,7 +1186,7 @@ static int write_graph_chunk_bloom_indexes(struct hashfile *f,
 	uint32_t cur_pos = 0;
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 		cur_pos += len;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1222,7 +1226,7 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1392,6 +1396,16 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
+{
+	trace2_data_intmax("commit-graph", ctx->r, "filter-computed",
+			   ctx->count_bloom_filter_computed);
+	trace2_data_intmax("commit-graph", ctx->r, "filter-not-computed",
+			   ctx->count_bloom_filter_not_computed);
+	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
+			   ctx->count_bloom_filter_trunc_large);
+}
+
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
@@ -1414,12 +1428,26 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
+		enum bloom_filter_computed computed = 0;
 		struct commit *c = sorted_commits[i];
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
+		struct bloom_filter *filter = get_or_compute_bloom_filter(
+			ctx->r,
+			c,
+			1,
+			&computed);
+		if (computed & BLOOM_COMPUTED) {
+			ctx->count_bloom_filter_computed++;
+			if (computed & BLOOM_TRUNC_LARGE)
+				ctx->count_bloom_filter_trunc_large++;
+		} else if (computed & BLOOM_NOT_COMPUTED)
+			ctx->count_bloom_filter_not_computed++;
 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		display_progress(progress, i + 1);
 	}
 
+	if (trace2_is_enabled())
+		trace2_bloom_filter_write_statistics(ctx);
+
 	free(sorted_commits);
 	stop_progress(&progress);
 }
diff --git a/line-log.c b/line-log.c
index bf73ea95ac..68eeb425f8 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1159,7 +1159,7 @@ static int bloom_filter_check(struct rev_info *rev,
 		return 1;
 
 	if (!rev->bloom_filter_settings ||
-	    !(filter = get_bloom_filter(rev->repo, commit, 0)))
+	    !(filter = get_bloom_filter(rev->repo, commit)))
 		return 1;
 
 	if (!range)
diff --git a/revision.c b/revision.c
index 6aeb764821..c53ab99e59 100644
--- a/revision.c
+++ b/revision.c
@@ -752,7 +752,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
-	filter = get_bloom_filter(revs->repo, commit, 0);
+	filter = get_bloom_filter(revs->repo, commit);
 
 	if (!filter) {
 		count_bloom_filter_not_present++;
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 5e77d56f59..9f7bb729fc 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -39,7 +39,8 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 	struct bloom_filter *filter;
 	setup_git_directory();
 	c = lookup_commit(the_repository, commit_oid);
-	filter = get_bloom_filter(the_repository, c, 1);
+	filter = get_or_compute_bloom_filter(the_repository, c, 1,
+					     NULL);
 	print_bloom_filter(filter);
 }
 
-- 
2.28.0.510.g86fdc5f89a

