Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E2EC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C872F20870
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fErt4u54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgIRC7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgIRC70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA5C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:26 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f11so2156997qvw.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H4Om09p8rKI4YTbpL0kPBGf7doKFhTmVgLs778LCS2Q=;
        b=fErt4u54TQsONjw5M/F9ykVL1fKvSzbKxqC/GsqTNxSzV1N9Wl0Jey4FFpE3wzuHA+
         djl7FyHGWtyE75agjLHVJ+HFCvW/DQqQaf0lIDQ9CFR3aFtjy/Dwwt/i6GnzX3lHxp6E
         oh+Ij+gGTPtVbIkqLxG2uuLBQAEWsJYbQLO7SxgiyZpIWglcfnQpM8HQvPsmytVwJO/V
         nu5cy7i8YvlX6wC+QHH9jJP2+NbSR0ukH8aN9fkUya/CmSaJWftg+yHONsmU4Dx9Zq40
         L6JKtkp8uyekmRgeRhNwzq/io/cC+pUm2wclKhuVRGXEOt7k1YsGU9MZMe2s4rDyLnOf
         ThUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H4Om09p8rKI4YTbpL0kPBGf7doKFhTmVgLs778LCS2Q=;
        b=uKd+8gUDWzichdaUupyT3xTP/1y9tQO/IkwW0KeWScX9qEIyzlPdnXjqLkEKF68SXQ
         szv65PjTu0WU12PMpfAsXttPZND6hZ9oVdGECHO0WNKB21SrRX1m+BSeKuSOfKcooVeJ
         KC9rut1OFxrVKjsPwhaVQ73U9u1nKjdKAz5Ax2whi6lF1wMlPdVF9goGmBg0gw4w8/T4
         tw1Z1zgdZ+ToQp8x1yAXiJWeVsOCikkL/uMtNf/LXVkReGxhifS16MIr7VqYkO+U5leB
         48Va6EY9G6Fs+Qe2pf4TJO9hVwboHmxt00I0NFKxukbi/cAy4DrpXF0Oi3awYuTggQBO
         vYcg==
X-Gm-Message-State: AOAM5306i8/xRBuQ0bzN+dxCrpsHcX/DS8bEDaN28tOvRQxdomvFP3Ey
        JuvKqQcIYNfVDYQlPKQuA0TjzAk8jMG/qUwd
X-Google-Smtp-Source: ABdhPJyGaGSfIX0CPizJTZYdhXG8QDp9CFQCSoJ4aI8kJ/0oDNLS/aRoIdwPQXtNN97OKzXkRHTmLw==
X-Received: by 2002:a0c:ca08:: with SMTP id c8mr14793968qvk.42.1600397965349;
        Thu, 17 Sep 2020 19:59:25 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id e23sm1184560qkl.67.2020.09.17.19.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:24 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 07/13] bloom: split 'get_bloom_filter()' in two
Message-ID: <407731b9425ef942c678adb10235224698d19ee4.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index ba6d4a4c6c..ecdab89e93 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -972,6 +972,10 @@ struct write_commit_graph_context {
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
+
+	int count_bloom_filter_computed;
+	int count_bloom_filter_not_computed;
+	int count_bloom_filter_trunc_large;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1183,7 +1187,7 @@ static int write_graph_chunk_bloom_indexes(struct hashfile *f,
 	uint32_t cur_pos = 0;
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 		cur_pos += len;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1223,7 +1227,7 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1393,6 +1397,16 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
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
@@ -1415,12 +1429,26 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
2.28.0.510.g375ecf1f36

