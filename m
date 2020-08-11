Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1CC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AA520774
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Vj/MC60O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHKUvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809FC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n129so164894qkd.6
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDi48ppg/58iZSGrMm41yujADK+orXTZvhekbsxyFW0=;
        b=Vj/MC60Osp62Jl9pG4V6Vui20qahtF8dBcR6wd7VYb2EYXq5GPpiYJ4ibHB/r39iG4
         RRZGTK+5pFKmSl92JXE/lZpYNCs1MGt6rNEXgP3Dy6Kmbh4bAbFQj8S0QbsGiOnc3AIE
         2L+RVnhOyXGhrah2TqlLRJbn1IM2y2zs7Y+SzH/oTBw5Ft9mJf6ubnPJguAE0mq5Hf2d
         p14HCeSY4jvrLDJI4bCzUHqosDhWuNHB2cH0SdLDRztzcxhLYJclAp4drbY44t1tVAjp
         6W1FFCu0TgKiMp7jIxGRM5M+izN2pqvpY1mPQ4+sUZL5phQPXgbWofYEZjRfts+EMj0m
         Z6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDi48ppg/58iZSGrMm41yujADK+orXTZvhekbsxyFW0=;
        b=WGGI9zH4qI38H3gYXSLj945Iq4rHaPRorH8nLmecTTkWoEpqPIw5ZaeU34alWX/waG
         6ikk5czBpmtwrT+SpTAwk0R2k1fIliWq/DFiO+uwJ10gEvblm5LH5yJo+0qeKR35pBzN
         7twmdpU3XLpcxzXIYfMnrhZaBSX1jXN+pOSIeYv+EVLPLg+39rWbrUJFLNIWQVpT+ZqM
         cwLgy/9dRWMvJxMHx3wERhbdunC7MWC3eipbwvydkgdRdmKC3S2mn1OJ4WPkQmMFyBsY
         zXvRPXELWL8MDcQ+/fJ1sPDnW+SR2JqyH72LYhFCVaVCfmGDCPG2D7NDjBv1XJmkX/A5
         63KQ==
X-Gm-Message-State: AOAM533oIBGW8gI1pHXpQmor6t3vbydmRfN4RSPSmwbQCpk1kh1ttxTE
        7MXAn7/9Sk9q4vf0t6VfNp9+F5V9MSX7l3Ld
X-Google-Smtp-Source: ABdhPJxjMW/oFGSWH/Qt+amahKH2Rp4GrmdG67ovLN7B5a20lB+einF65gt0Ul28tvUySHA/cmcrLQ==
X-Received: by 2002:a37:a187:: with SMTP id k129mr2906881qke.196.1597179107015;
        Tue, 11 Aug 2020 13:51:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id k31sm20175327qtd.60.2020.08.11.13.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:46 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <eba279487318137064eef776c779ca537a4a711d.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
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
 bloom.h               | 10 +++++++---
 commit-graph.c        | 38 +++++++++++++++++++++++++++++++++++---
 line-log.c            |  2 +-
 revision.c            |  2 +-
 t/helper/test-bloom.c |  3 ++-
 7 files changed, 57 insertions(+), 13 deletions(-)

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
index 0b9b59a6fe..baa91926db 100644
--- a/bloom.h
+++ b/bloom.h
@@ -89,9 +89,13 @@ void add_key_to_filter(const struct bloom_key *key,
 
 void init_bloom_filters(void);
 
-struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c,
-				      int compute_if_not_present);
+struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
+						 struct commit *c,
+						 int compute_if_not_present,
+						 int *computed);
+
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
index be600186ee..7f58ecc411 100644
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

