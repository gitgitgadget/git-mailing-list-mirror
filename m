Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F10C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B9D21919
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="E3PWezdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgIIRTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgIIP17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17AC0619D3
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:23:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w186so2806486qkd.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ed/p05KNT2ha2ye02bbF8wtMQRHBsX0sBud6bq5eOfc=;
        b=E3PWezdNf+mHlPlcT59Myz5u1wTaORLJb9Wsu14D+7iBh8sUNrafH56p5kzPSlt7Eq
         I4u8XDEYHPDhqjMzkItP7GbtXB4XXzEL9ilSzo09PhkexfLUlsDAFMoy4UOUoc1OJHsR
         HCYYLQmiNKug7Cru4gUdTorWR+DBlfuYbgqPX3gZqRURO4E4A2kENiv3sX64kQJGHqOf
         aGD6RaV0uxnnE+503EggwJto4wFAcL1/pWW4I3ujX5Ej5Y14cvsbaU1xRgLAbpx51uRf
         QGKXApoQ2xy3TzBtoedg1sCDQYsD2DDHzYt4oVebJZpLl7f9VyTLrNVGHJigObe5WNIS
         YllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ed/p05KNT2ha2ye02bbF8wtMQRHBsX0sBud6bq5eOfc=;
        b=J2wFNtcB6TbC324zEoBp4utGO0ptXs7PH7MbgOeMbZ3G64+hH+rzoU4y+ei6166bXa
         XK7cQSPVIHJzHkdqSNSxqWTe3rW70B9P8TYDYX5I92A2XIibCS3yYNqcMiZo3lPCRMN1
         mcqvR5Kh6bmHNCtjnZiv8zTic3DgxOSXKuxa57AP91oHtN9t1OF2ONKaVqtnYp6U8HIi
         o2e2kDq+fjoa2h0I1O+lB/HCqly6lWbjWBosp6OepCA8fmxq8Ioj1E38kDZNjacPMWNv
         Gtkk31kPnjMsnurFyUowN3P5+jqu1bbzbjlth0sEEm0OXUzbK7jeDq5k3M/E0bbBCowR
         5dKw==
X-Gm-Message-State: AOAM532tRQQf64fpMADLKm1fYrtZso6YdvC5KFbmZkaxXsk+OYDwWt6r
        B7QEuvzyPkYBZbIvfzfUtuxIFO6dUN1GblVi
X-Google-Smtp-Source: ABdhPJzruS1DtTYs71sWyyHaxqyx5jf5yvOuzBOczvlV4zxYlZtmETQOWVAY8YytQrfWEcAPeBm7UQ==
X-Received: by 2002:a05:620a:55d:: with SMTP id o29mr3822870qko.12.1599665009017;
        Wed, 09 Sep 2020 08:23:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id a20sm3041300qtw.45.2020.09.09.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:23:28 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:23:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 07/12] bloom: split 'get_bloom_filter()' in two
Message-ID: <7475ce47ebcdb9c666e658ab8727b2d1df384c8d.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
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
 commit-graph.c        | 42 +++++++++++++++++++++++++++++++++++++++---
 line-log.c            |  2 +-
 revision.c            |  2 +-
 t/helper/test-bloom.c |  3 ++-
 7 files changed, 70 insertions(+), 13 deletions(-)

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
index 55af498aa0..b8b2c7ca65 100644
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
@@ -1392,6 +1396,24 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_computed",
+			 ctx->count_bloom_filter_computed);
+	jw_object_intmax(&jw, "filter_not_computed",
+			 ctx->count_bloom_filter_not_computed);
+	jw_object_intmax(&jw, "filter_trunc_large",
+			 ctx->count_bloom_filter_trunc_large);
+	jw_end(&jw);
+
+	trace2_data_json("commit-graph", the_repository, "bloom_statistics", &jw);
+
+	jw_release(&jw);
+}
+
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
@@ -1414,12 +1436,26 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
index 857274408c..f4be5d1650 100644
--- a/revision.c
+++ b/revision.c
@@ -751,7 +751,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
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
2.28.0.462.g4ff11cec37

