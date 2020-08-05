Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EEBC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A603C22D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="G7yN9MVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHERFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgHERCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C4C0617A1
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p25so1843563qkp.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxGYE6AhgiSWhnfGqWbnFIHNGIk0jQ+QaGHE5qSqdW0=;
        b=G7yN9MVfkSc7R4xHI2aa8qC2Lsi0x4j0F/QnacjUk/IBPFyiy/fP2OPPbd3Qt2M/OB
         VQ6e5F3Q4JxkrFHTOgAg9klwttU9quDPOZOfxup9u+XoXfHcLqyz6AM26hMr8VbmeUzV
         QsNsAc450/SNyNccc3JZp05hHm/qI01iFUnj7DDuIs+7dKvi1aOso9GsmHJSU5uEI7NC
         CzbZwVXQNv1/hBq/Kx1nqS/aDqDieKpzsSvDRksmYy3Yr6RVTVEAvcikEyfVv88gdZjb
         XrNBjR5lzzKboBz73f06/ezWQzK6Pk1xS6kteKqbAva10wgp17OlOjubdquxADQ2x0Fr
         WOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XxGYE6AhgiSWhnfGqWbnFIHNGIk0jQ+QaGHE5qSqdW0=;
        b=OGcagy7Vtld65PxITOMMP+DAx+FB8gfNKkLvPdM9eqluo1iQnMgMMEnACVT4QEOYGd
         guTGhTrIwXetE6ncFha3CXUJ+nq/OLyuhw65IDzaWRmgSOD4aUCzCIkqb17gE0nLuBWp
         E/YGaDA3hj9FwSaqu5MM/F0xSu/PUMonJzhDVa4oaQNy8xvyydhapTTWjBU4B64dWtvb
         uWiYmFTCajdI0PW+0Eoyd20qmlZX1jreyyK15gPS223wISnqC6qCuZ4HiNRNhYwiKDwJ
         kCnjrn2f8A8MmQX9GLQbGssvwiHGbJNd6STTPTH8u4LEOA6jELhNNdi4t6uVNdRE60p2
         brvg==
X-Gm-Message-State: AOAM530AamIJfSLuHrTHUJtpQiUyk5s5viGBE2VNLY4N2tKsjHIa59dd
        EsJkHpgUWKikky04/8tIK+suDd4yBNKX0g==
X-Google-Smtp-Source: ABdhPJzHTuw140ab2fpleGbfGQqzNKr/tRewpnlsmBMsvdeLG7qv7NyZeoGiKqfvPPRUarb9zrUBkA==
X-Received: by 2002:a37:a503:: with SMTP id o3mr4214761qke.162.1596646961228;
        Wed, 05 Aug 2020 10:02:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id l45sm1105974qtf.11.2020.08.05.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:40 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <23525947c8c3bf9fc5faf59d9a7b6da65cec4e12.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
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
with two counters in the 'write_commit_graph_context' struct which store
the number of filters that we computed, and the number of those which
were too large to store.

It would be nice to drop the 'compute_if_not_present' flag entirely,
since all remaining callers of 'get_or_compute_bloom_filter' pass it as
'1', but this will change in a future patch and hence cannot be removed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 blame.c               |  2 +-
 bloom.c               | 13 ++++++++++---
 bloom.h               | 11 ++++++++---
 commit-graph.c        | 38 +++++++++++++++++++++++++++++++++++---
 line-log.c            |  2 +-
 revision.c            |  2 +-
 t/helper/test-bloom.c |  3 ++-
 7 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/blame.c b/blame.c
index 3e5f8787bc..756285fca7 100644
--- a/blame.c
+++ b/blame.c
@@ -1275,7 +1275,7 @@ static int maybe_changed_path(struct repository *r,
 	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
 		return 1;
 
-	filter = get_bloom_filter(r, origin->commit, 0);
+	filter = get_bloom_filter(r, origin->commit);
 
 	if (!filter)
 		return 1;
diff --git a/bloom.c b/bloom.c
index cd9380ac62..a8a21762f4 100644
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
+						 int *computed)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -187,6 +188,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct diff_options diffopt;
 	int max_changes = 512;
 
+	if (computed)
+		*computed = 0;
+
 	if (!bloom_filters.slab_size)
 		return NULL;
 
@@ -273,6 +277,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		filter->len = 0;
 	}
 
+	if (computed)
+		*computed = 1;
+
 	free(diff_queued_diff.queue);
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
diff --git a/bloom.h b/bloom.h
index 0b9b59a6fe..c4107a6415 100644
--- a/bloom.h
+++ b/bloom.h
@@ -89,9 +89,14 @@ void add_key_to_filter(const struct bloom_key *key,
 
 void init_bloom_filters(void);
 
-struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c,
-				      int compute_if_not_present);
+struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
+						 struct commit *c,
+						 int compute_if_not_present,
+						 int *computed);
+
+#define DEFAULT_BLOOM_MAX_CHANGES 512
+#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
+	(r), (c), 0, NULL)
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
diff --git a/commit-graph.c b/commit-graph.c
index 86dd4b979e..ba2a2cfb22 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -964,6 +964,9 @@ struct write_commit_graph_context {
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
+
+	int count_bloom_filter_found_large;
+	int count_bloom_filter_computed;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1175,7 +1178,7 @@ static int write_graph_chunk_bloom_indexes(struct hashfile *f,
 	uint32_t cur_pos = 0;
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 		cur_pos += len;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1215,7 +1218,7 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1385,6 +1388,22 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_found_large",
+			 ctx->count_bloom_filter_found_large);
+	jw_object_intmax(&jw, "filter_computed",
+			 ctx->count_bloom_filter_computed);
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
@@ -1407,12 +1426,25 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
+		int computed = 0;
 		struct commit *c = sorted_commits[i];
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
+		struct bloom_filter *filter = get_or_compute_bloom_filter(
+			ctx->r,
+			c,
+			1,
+			&computed);
+		if (computed) {
+			ctx->count_bloom_filter_computed++;
+			if (filter && !filter->len)
+				ctx->count_bloom_filter_found_large++;
+		}
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
index c53692834d..9e58fd185a 100644
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
index c45ed1076e..b7ec712755 100644
--- a/revision.c
+++ b/revision.c
@@ -753,7 +753,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
-	filter = get_bloom_filter(revs->repo, commit, 0);
+	filter = get_bloom_filter(revs->repo, commit);
 
 	if (!filter) {
 		count_bloom_filter_not_present++;
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f0aa80b98e..531af439c2 100644
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
2.28.0.rc1.13.ge78abce653

