Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111CC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B08622B45
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yjWGdjFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHCS5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:47 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD316C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x12so20538334qtp.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JeRO2NgYO+kIRBpTg0Hz4axY3e+jf7fqBJOKkN/8VyI=;
        b=yjWGdjFo66nzcmKkF6AumIc15tCsalw/ehRFZGL/7I7JjNi+43slDuBRj7XAiPPiET
         5FoLfJt0njNAqj3hpXeQw+8HiA//96OhaW6U8j5Im8XClCsuvThjiT/VnWBrDL5bIuA3
         HBurGh+0+WEWB7PBQI5uuknHfQkK1I9JQbE4zhdqsALqMtHmLrbOPm1BHa2RQLjCvnZp
         XDQP90dhl8CbTzJqLpOSlbJFqxDDObcW+DgHtweVNiup4JOOoK7iC2dRqUg/XtO3WGw2
         6hkGb11H+bTx9fN14pCin29PQ1UOyuaLOecwbXd2uYqXr4Lo08fJZxxDdleV03biKMTN
         SNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeRO2NgYO+kIRBpTg0Hz4axY3e+jf7fqBJOKkN/8VyI=;
        b=khBFn6sKJ4vkKCTfS5pNKKrxtS3ucDcbUfNp5pZG0PvGnAt3E77Z0M7ZTIU0DmhoRm
         v5QYjAyVY2NqmFOE/SLH/u5DtPmU5YI6jif7HOkRIWhZbHQ/W/4v4pZ3DO7GnHgtJBW/
         B1iWn7apUh8mOCaB/fwYCT9aECwDS6jNHsQCpHspd/o+ZyjJo5+n2PGC+8q31vigEGII
         xvjFVB2SGSxdC2g6+HWECJWsSpmHJ6+LIgFHF6CnZMXAD3q3x7p54BctST7uxHB6cwzd
         MSbSXHewYOIcaIPRzWAQMQJnASx0Rp9XEZUtCchIUDkNgFQMqOfe8o192lB4Etz9KiPg
         dTMQ==
X-Gm-Message-State: AOAM5329KF6R8ytHCoX8N+QSZo297B1ArKfcsC7CLKtEy9LzGkNp1hDt
        hk6am4/EFQvQ3msH0c95bcQP0/lkPr6SXw==
X-Google-Smtp-Source: ABdhPJwnOwWKGpTkaP7K+B/KDsu2Ms9YQDn1BRZcADtYPSej3azoB1rGwOwoyW0JwnoXT2dUyCbC/A==
X-Received: by 2002:ac8:51d7:: with SMTP id d23mr18062724qtn.382.1596481066345;
        Mon, 03 Aug 2020 11:57:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id i7sm18616588qtb.27.2020.08.03.11.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:45 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 10/10] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <8b670571dc24973cc5e894b866a68236d8fbfa4f.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a command-line flag and configuration variable to fill in the
'max_new_filters' variable introduced by the previous patch.

The command-line option '--max-new-filters' takes precedence over
'graph.maxNewFilters', which is the default value.
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
 commit-graph.c                       | 22 +++++++++++-----
 commit-graph.h                       |  1 +
 t/t4216-log-bloom.sh                 | 19 ++++++++++++++
 7 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index bb78e72f1b..46f48d1aa8 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -1,3 +1,7 @@
+commitgraph.maxNewFilters::
+	Specifies the default value for the `--max-new-filters` option of `git
+	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
+
 commitgraph.readChangedPaths::
 	If true, then git will use the changed-path Bloom filters in the
 	commit-graph file (if it exists, and they are present). Defaults to
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 17405c73a9..e8034ff0ac 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -67,6 +67,10 @@ this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
 data.
 +
+With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
+filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
+enforced. Overrides the `graph.maxNewFilters` configuration.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/bloom.c b/bloom.c
index a8a21762f4..1742beac9e 100644
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
index 38f5f57d15..aaf54a76db 100644
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
+			NULL, N_("maximum number of Bloom filters to compute"),
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
+	if (!strcmp(var, "graph.maxnewfilters")) {
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
index 8626024faa..87ea0437e2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1455,6 +1455,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	int *sorted_commits;
+	int max_new_filters;
 
 	init_bloom_filters();
 	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD);
@@ -1471,6 +1472,9 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
 		&ctx->commits);
 
+	max_new_filters = ctx->opts->max_new_filters >= 0 ?
+		ctx->opts->max_new_filters : ctx->commits.nr;
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		int pos = sorted_commits[i];
 		struct commit *c = ctx->commits.list[pos];
@@ -1478,13 +1482,19 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			bitmap_set(ctx->bloom_large, pos);
 			ctx->count_bloom_filter_known_large++;
 		} else {
-			struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, c, 1, NULL);
-			if (!filter->len) {
-				bitmap_set(ctx->bloom_large, pos);
-				ctx->count_bloom_filter_found_large++;
+			int computed = 0;
+			struct bloom_filter *filter = get_or_compute_bloom_filter(
+				ctx->r, c,
+				ctx->count_bloom_filter_computed < max_new_filters,
+				&computed);
+			if (computed) {
+				ctx->count_bloom_filter_computed++;
+				if (filter && !filter->len) {
+					bitmap_set(ctx->bloom_large, pos);
+					ctx->count_bloom_filter_found_large++;
+				}
 			}
-			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
-			ctx->count_bloom_filter_computed++;
+			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * (filter ? filter->len : 0);
 		}
 		display_progress(progress, i + 1);
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 4cd991cf26..0842d13744 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -112,6 +112,7 @@ struct commit_graph_opts {
 	int max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags flags;
+	int max_new_filters;
 };
 
 /*
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 231dc8a3a7..985bea23b2 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -214,4 +214,23 @@ test_expect_success 'Bloom generation does not recompute too-large filters' '
 	)
 '
 
+test_expect_success 'Bloom generation is limited by --max-new-filters' '
+	(
+		cd 513changes &&
+		test_commit c2 filter &&
+		test_commit c3 filter &&
+		test_commit c4 no-filter &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=2" \
+			1 0 2
+	)
+'
+
+test_expect_success 'Bloom generation backfills previously-skipped filters' '
+	(
+		cd 513changes &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=1" \
+			1 0 1
+	)
+'
+
 test_done
-- 
2.28.0.rc1.13.ge78abce653
