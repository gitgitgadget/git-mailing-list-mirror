Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54806C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245B9206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pPy9aIqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHERJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgHERDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:03:23 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9315C0617AA
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:03:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id b2so10482937qvp.9
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C8mcdF635Hj3CViDSS3+9IGExrkhj7G6YfsQfTjfGsE=;
        b=pPy9aIqUaiDCcBzt9OWGT8mM8X9HU/sO1SOPUCui4JLxXmVRtmVAC+/AzJMyx6JmsV
         MvXxezivk2KGYujs8G158iHKNzigYNyEMnSsKBTVO4PXSycpPvMkznUJqlBNxoSXAX/5
         GrqUJIfqG95ZdNmbX82xIH87rbA/cF1qwT8I5NFP4LihDFWSyE7JM0FRzm04w4d9Oph9
         yIw4DQzq9uYvAGmgK85XuIBAZUfkhqi9fB2UTz9Elg7t4pLuvJOrU41OoBPPA0YgLzvN
         h0+syZnLOg46rDxm0d+sb8HiXCbCCr9BiAApXxxBgZMVByZdclA2n1PkHsjNJvwTF95o
         SLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8mcdF635Hj3CViDSS3+9IGExrkhj7G6YfsQfTjfGsE=;
        b=KLStpiL3bvFPj4xeLsSKt0nqBQgXOZXZBjPwMWk1u2whbkr674WvezBz1P7MnKYuc4
         0rm3GCtHvNhtRSBoPDzfLJgVjDKzARJlsg/kZLjgc1sPhGDZpijVKks6LXkozacRqxN0
         TCu3bOf0zhDXB2FQtCsvNoo2PfdNMKOdh+I7QVtyGc/i9ji47jQbKKWpYk/6K7vBYKVU
         ZJvueOsYU5UOG1Lv/F1K9qiCbFH1RA5zK0M3/9bdWuIUBlIVBXyCt7EUMsg+N6hhJVHq
         7XAKcw/3expiYt1Aql3Xfla1ZfFcQ8w2MZRUkkT2fdbomGRKEzy9FZGoG+LFBe3vO4F7
         nPzQ==
X-Gm-Message-State: AOAM5311FZG42tpdnkwqth8CtevyGJfS8DzHYxA3LHlHEnfXPZCAGnaQ
        lTSjWimfo3AMB4lGbQJwOIN8UR32hRCSnw==
X-Google-Smtp-Source: ABdhPJwJtSjabKvfySo852mGGuQVSKwxSyA8iOx5t7D0jcA8mRPWnn/PJzTq3c7ye+l7tev6spgMNQ==
X-Received: by 2002:ad4:4cc3:: with SMTP id i3mr3081508qvz.17.1596646986884;
        Wed, 05 Aug 2020 10:03:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id t93sm2519392qtd.97.2020.08.05.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:03:06 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:03:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <3b66ae4a9c2aa97dd64f88904ad2bf2756ccd9ef.1596646576.git.me@ttaylorr.com>
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

Introduce a command-line flag and configuration variable to fill in the
'max_new_filters' variable introduced by the previous patch.

The command-line option '--max-new-filters' takes precedence over
'commitGraph.maxNewFilters', which is the default value.
'--no-max-new-filters' can also be provided, which sets the value back
to '-1', indicating that an unlimited number of new Bloom filters may be
generated. (OPT_INTEGER only allows setting the '--no-' variant back to
'0', hence a custom callback was used instead).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt |  4 +++
 Documentation/git-commit-graph.txt   |  4 +++
 bloom.c                              | 15 +++++++++++
 builtin/commit-graph.c               | 39 +++++++++++++++++++++++++---
 commit-graph.c                       | 16 +++++++++---
 commit-graph.h                       |  1 +
 t/t4216-log-bloom.sh                 | 19 ++++++++++++++
 7 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index cff0797b54..4582c39fc4 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -1,3 +1,7 @@
+commitGraph.maxNewFilters::
+	Specifies the default value for the `--max-new-filters` option of `git
+	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
+
 commitGraph.readChangedPaths::
 	If true, then git will use the changed-path Bloom filters in the
 	commit-graph file (if it exists, and they are present). Defaults to
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 17405c73a9..9c887d5d79 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -67,6 +67,10 @@ this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
 data.
 +
+With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
+filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
+enforced. Overrides the `commitGraph.maxNewFilters` configuration.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/bloom.c b/bloom.c
index ed54e96e57..d0c0fd049d 100644
--- a/bloom.c
+++ b/bloom.c
@@ -51,6 +51,21 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	else
 		start_index = 0;
 
+	if ((start_index == end_index) &&
+	    (g->bloom_large.word_alloc && !bitmap_get(&g->bloom_large, lex_pos))) {
+		/*
+		 * If the filter is zero-length, either (1) the filter has no
+		 * changes, (2) the filter has too many changes, or (3) it
+		 * wasn't computed (eg., due to '--max-new-filters').
+		 *
+		 * If either (1) or (2) is the case, the 'large' bit will be set
+		 * for this Bloom filter. If it is unset, then it wasn't
+		 * computed. In that case, return nothing, since we don't have
+		 * that filter in the graph.
+		 */
+		return 0;
+	}
+
 	filter->len = end_index - start_index;
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 38f5f57d15..3500a6e1f1 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -13,7 +13,8 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]progress] <split options>"),
+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
+	   "<split options>"),
 	NULL
 };
 
@@ -25,7 +26,8 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]progress] <split options>"),
+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
+	   "<split options>"),
 	NULL
 };
 
@@ -162,6 +164,23 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
 	return 0;
 }
 
+static int write_option_max_new_filters(const struct option *opt,
+					const char *arg,
+					int unset)
+{
+	int *to = opt->value;
+	if (unset)
+		*to = -1;
+	else {
+		const char *s;
+		*to = strtol(arg, (char **)&s, 10);
+		if (*s)
+			return error(_("%s expects a numerical value"),
+				     optname(opt, opt->flags));
+	}
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
@@ -197,6 +216,9 @@ static int graph_write(int argc, const char **argv)
 			N_("maximum ratio between two levels of a split commit-graph")),
 		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
 			N_("only expire files older than a given date-time")),
+		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
+			NULL, N_("maximum number of changed-path Bloom filters to compute"),
+			0, write_option_max_new_filters),
 		OPT_END(),
 	};
 
@@ -205,6 +227,7 @@ static int graph_write(int argc, const char **argv)
 	write_opts.size_multiple = 2;
 	write_opts.max_commits = 0;
 	write_opts.expire_time = 0;
+	write_opts.max_new_filters = -1;
 
 	trace2_cmd_mode("write");
 
@@ -270,6 +293,16 @@ static int graph_write(int argc, const char **argv)
 	return result;
 }
 
+static int git_commit_graph_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "commitgraph.maxnewfilters")) {
+		write_opts.max_new_filters = git_config_int(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_commit_graph_options[] = {
@@ -283,7 +316,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_graph_usage,
 				   builtin_commit_graph_options);
 
-	git_config(git_default_config, NULL);
+	git_config(git_commit_graph_config, &opts);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_commit_graph_options,
 			     builtin_commit_graph_usage,
diff --git a/commit-graph.c b/commit-graph.c
index 82fca07579..76b1238262 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -948,7 +948,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 }
 
 static int get_bloom_filter_large_in_graph(struct commit_graph *g,
-					   const struct commit *c)
+					   const struct commit *c,
+					   uint32_t max_changed_paths)
 {
 	uint32_t graph_pos = commit_graph_position(c);
 	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
@@ -1475,6 +1476,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	int *sorted_commits;
+	int max_new_filters;
 
 	init_bloom_filters();
 	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
@@ -1491,10 +1493,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
 		&ctx->commits);
 
+	max_new_filters = ctx->opts->max_new_filters >= 0 ?
+		ctx->opts->max_new_filters : ctx->commits.nr;
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		int pos = sorted_commits[i];
 		struct commit *c = ctx->commits.list[pos];
-		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
+		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph,
+						    c,
+						    ctx->bloom_settings->max_changed_paths)) {
 			bitmap_set(ctx->bloom_large, pos);
 			ctx->count_bloom_filter_known_large++;
 		} else {
@@ -1502,7 +1509,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			struct bloom_filter *filter = get_or_compute_bloom_filter(
 				ctx->r,
 				c,
-				1,
+				ctx->count_bloom_filter_computed < max_new_filters,
 				ctx->bloom_settings,
 				&computed);
 			if (computed) {
@@ -1512,7 +1519,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 					ctx->count_bloom_filter_found_large++;
 				}
 			}
-			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
+			if (filter)
+				ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		}
 		display_progress(progress, i + 1);
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 1d147b7b76..47d99ea4bf 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -115,6 +115,7 @@ struct commit_graph_opts {
 	int max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags flags;
+	int max_new_filters;
 };
 
 /*
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 6859d85369..3aab8ffbe3 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -286,4 +286,23 @@ test_expect_success 'Bloom generation does not recompute too-large filters' '
 	)
 '
 
+test_expect_success 'Bloom generation is limited by --max-new-filters' '
+	(
+		cd limits &&
+		test_commit c2 filter &&
+		test_commit c3 filter &&
+		test_commit c4 no-filter &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=2" \
+			2 0 2
+	)
+'
+
+test_expect_success 'Bloom generation backfills previously-skipped filters' '
+	(
+		cd limits &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=1" \
+			2 0 1
+	)
+'
+
 test_done
-- 
2.28.0.rc1.13.ge78abce653
