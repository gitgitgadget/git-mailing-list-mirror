Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A81C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E2620716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KamWqJFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgICWrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgICWrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:47:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D56C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:47:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id v54so3262735qtj.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oYpSjtOpe7DlSv/ZCosDwLkRD+e5p4idW8ckKahgFaI=;
        b=KamWqJFuBBlIX7jALdGF+dci8xOJf3bGgjyobej34aPQa6MZJLnbEJXJbJBNF/O6W+
         jHum/H/AsoDugK1JQ2c8FSO+gJUOZeHX/V1ib4Ax6X35cMhPuXnCJaf2+pXLSCZNPqjH
         YkP0LTQvKnHOrC1loe9nVPjjJU6MUzNnUc0KVhuITd4nxYOXW9TeHFPtJ9Z8HRDud1Io
         PaPnbgh8rYJ618hjEHkjnpKvUfAdH/l8SDxL1dy7Ks9Xoiv+L4NtjDoIXG+0XpA/JVfQ
         sG6fwXkyg2uBjHU3koh87sA+hP0DR7ZjaAVxZyPKgyvIytZP78r2k9wZ3XXkmHt2TQlE
         EfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYpSjtOpe7DlSv/ZCosDwLkRD+e5p4idW8ckKahgFaI=;
        b=b0rIlEBVbD48QiL2xKxM6MRWgJ+Kuow5LlYR5uEgIzbTjP9XIdGf4O6KjECFVXViyO
         jYKDfzs75ukoVlyuiKmKDgCESqGP3RMtqRbVbj2CfSNa+Q+RlvJvUc9t9FxEwOLLOhln
         TL9eycxgBA7tsPCWCiKXdHdYzlyXq751NmsC9vjMX1JZrXPDFvpJUPhXYsAB3D/WlDpG
         QKIm4kliY1UuO927rayx36j9wVZ5jOTMeKybkKvy+kEFD27JOdoX4GHHoy2PYqJGSYqD
         wRZB1KXBWOLVK3/SCgtvqVDSlhAAMsjtEsIul/TFFcDIYrr7mL+xkbJBqIn22n9LbtWu
         9wpw==
X-Gm-Message-State: AOAM533ecEhH5QyRIr4Uyph9z+J+Sl0PxYhPeWt+LJ6W8/KqnHbSK87s
        xGVKavCUbZc+3Z4LkKPMh7v7uJKgPl3vom/W
X-Google-Smtp-Source: ABdhPJx+YxrEQ5FBnzF+YjALGZO9cYdJnRldYfZLIZasPHhqusDnEk2WjB3I4yXn5Cg7tvzmTPAgzQ==
X-Received: by 2002:aed:38c9:: with SMTP id k67mr2353072qte.6.1599173224988;
        Thu, 03 Sep 2020 15:47:04 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id t20sm3283487qke.79.2020.09.03.15.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:47:04 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:47:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <cd0a9da6390bb110ac787135e9e5cf343ffef550.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a command-line flag and configuration variable to fill in the
'max_new_filters' variable introduced two patches ago.

The command-line option '--max-new-filters' takes precedence over
'commitGraph.maxNewFilters', which is the default value.
'--no-max-new-filters' can also be provided, which sets the value back
to '-1', indicating that an unlimited number of new Bloom filters may be
generated. (OPT_INTEGER only allows setting the '--no-' variant back to
'0', hence a custom callback was used instead).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt |  4 +++
 Documentation/git-commit-graph.txt   |  6 ++++
 bloom.c                              | 13 +++++---
 builtin/commit-graph.c               | 39 ++++++++++++++++++++++--
 commit-graph.c                       | 27 ++++++++++++++---
 commit-graph.h                       |  4 ++-
 t/t4216-log-bloom.sh                 | 44 ++++++++++++++++++++++++++++
 7 files changed, 125 insertions(+), 12 deletions(-)

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
index 17405c73a9..81a2e65903 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -67,6 +67,12 @@ this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
 data.
 +
+With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
+filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
+enforced. Commits whose filters are not calculated are stored as a
+length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
+Overrides the `commitGraph.maxNewFilters` configuration.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/bloom.c b/bloom.c
index ed54e96e57..34503898ac 100644
--- a/bloom.c
+++ b/bloom.c
@@ -197,16 +197,21 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
-		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
-				return filter;
+		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
 	}
 
-	if (filter->data)
+	if (filter->data && filter->len)
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
 
+	if (filter && !filter->len &&
+	    get_bloom_filter_large_in_graph(r->objects->commit_graph, c,
+					    settings->max_changed_paths))
+		return filter;
+
+
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
 	diffopt.detect_rename = 0;
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f3243bd982..e7a1539b08 100644
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
index 33fcf01a7a..243c7253ff 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -953,7 +953,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 }
 
 int get_bloom_filter_large_in_graph(struct commit_graph *g,
-				    const struct commit *c)
+				    const struct commit *c,
+				    uint32_t max_changed_paths)
 {
 	uint32_t graph_pos;
 	if (!find_commit_in_graph(c, g, &graph_pos))
@@ -976,6 +977,17 @@ int get_bloom_filter_large_in_graph(struct commit_graph *g,
 
 	if (!g->bloom_large)
 		return 0;
+	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
+		/*
+		 * Force all commits which are subject to a different
+		 * 'max_changed_paths' limit to be recomputed from scratch.
+		 *
+		 * Note that this could likely be improved, but is ignored since
+		 * all real-world graphs set the maximum number of changed paths
+		 * at 512.
+		 */
+		return 0;
+	}
 	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
 }
 
@@ -1481,6 +1493,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	int *sorted_commits;
+	int max_new_filters;
 
 	init_bloom_filters();
 	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
@@ -1497,10 +1510,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
 		&ctx->commits);
 
+	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
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
@@ -1508,7 +1526,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			struct bloom_filter *filter = get_or_compute_bloom_filter(
 				ctx->r,
 				c,
-				1,
+				ctx->count_bloom_filter_computed < max_new_filters,
 				ctx->bloom_settings,
 				&computed);
 			if (computed) {
@@ -1518,7 +1536,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
index fe798a4047..eac4efc7a6 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -52,7 +52,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r,
 				      const struct commit *c);
 
 int get_bloom_filter_large_in_graph(struct commit_graph *g,
-				    const struct commit *c);
+				    const struct commit *c,
+				    uint32_t max_changed_paths);
 
 struct commit_graph {
 	const unsigned char *data;
@@ -120,6 +121,7 @@ struct commit_graph_opts {
 	int max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags split_flags;
+	int max_new_filters;
 };
 
 /*
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fed4929af3..571676cef2 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -291,4 +291,48 @@ test_expect_success 'Bloom generation does not recompute too-large filters' '
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
+test_expect_success 'Bloom generation backfills empty commits' '
+	git init empty &&
+	test_when_finished "rm -fr empty" &&
+	(
+		cd empty &&
+		for i in $(test_seq 1 6)
+		do
+			git commit --allow-empty -m "$i"
+		done &&
+
+		# Generate Bloom filters for empty commits 1-6, two at a time.
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			0 2 2 &&
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			2 2 2 &&
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			4 2 2 &&
+
+		# Finally, make sure that once all commits have filters, that
+		# none are subsequently recomputed.
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			6 0 0
+	)
+'
+
 test_done
-- 
2.27.0.2918.gc99a27ff8f
