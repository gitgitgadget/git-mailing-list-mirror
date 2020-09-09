Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB6C2D0E1
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B90A21D80
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="K/DA++s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIIRQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgIIP2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC32FC061240
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:24:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q5so2805634qkc.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9tiopOSX+4C9scUTdRLxaax+ljcX4O9qltrrnS2V54s=;
        b=K/DA++s80DuHPVnsuCYYmF41hvdOopXgw+ilFV6MThzP33UQr6BhRWHyfQem8G0fbO
         7wNF1T57X3LgFIftqP7qcxwEU7JdgZFhQ4x4ihI1+MeGN/Nr1NDyo7fH6zBrmXls9xj+
         fDdIG5ZMNe4gZnXR4dxdxXY71Jm/PnxtV2ZI9gtp5/69M3N5yitrkwdJ4TlXGasKIuQj
         HFujkuBcmMILz67rqTTBIpnA7m8z2Balf0Ol1ckbWHFQ2cLT8ESEpsgLuqwWs2DsMQrq
         2a1f0a2nnFyANITradyMAw9fODy+mfU1yUfn5+WGhQsOlDdoNGcBc+d8JH4o4qj8StjF
         yXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9tiopOSX+4C9scUTdRLxaax+ljcX4O9qltrrnS2V54s=;
        b=gwEJWt8f3QN+SgOiz23LND2pTc6xoqrxUcXJUcDofLBGxD192h5dpucq/SY+yFwIs1
         PhPNy6CUiCnLhvNsvaD8gCFa9vYHJUGsmBUEa2ySHn2T98bCMkfLDhOtmQRruXOcIR84
         VgnQHPCj/KPHdk4pz3Xa6QS5U2a26jjiZlCAEBioppbTpiBHcQTr5Ziz5wlQ8E/WUkBS
         8mDcB9jgSK/SG20Gnmiy25VLcI8WmEBFWSkBxk4kB7QQw1zetlztLAiX/cZDQF1RjwTT
         EFFIbIlLNd78hdpsFRQ6zQJLV8Zn1iBvKF9zMGeyPryWG6KzTWDK4nhPWK4y8jQU9Yet
         Au5A==
X-Gm-Message-State: AOAM532AfEb8tC/3dFby8IY787E76usiLdCKa33RF/Dlort1GN21sXqp
        ezXnrV+g7yRwCIKTnmqI4qU3R79SEnWlxREo
X-Google-Smtp-Source: ABdhPJx+qt0UuKm6F69JC0nJ9E9v6o0CySrRXnR0V5RJ9z3gyR6/WYCGT3E33chqfWUCMRW5i7DoqA==
X-Received: by 2002:a05:620a:148:: with SMTP id e8mr3846301qkn.186.1599665043985;
        Wed, 09 Sep 2020 08:24:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id k20sm3339959qtb.34.2020.09.09.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:24:03 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:24:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a command-line flag and configuration variable to specify the
maximum number of new Bloom filters that a 'git commit-graph write' is
willing to compute from scratch.

Prior to this patch, a commit-graph write with '--changed-paths' would
compute Bloom filters for all selected commits which haven't already
been computed (i.e., by a previous commit-graph write with '--split'
such that a roll-up or replacement is performed).

This behavior can cause prohibitively-long commit-graph writes for a
variety of reasons:

  * There may be lots of filters whose diffs take a long time to
    generate (for example, they have close to the maximum number of
    changes, diffing itself takes a long time, etc).

  * Old-style commit-graphs (which encode filters with too many entries
    as not having been computed at all) cause us to waste time
    recomputing filters that appear to have not been computed only to
    discover that they are too-large.

This can make the upper-bound of the time it takes for 'git commit-graph
write --changed-paths' to be rather unpredictable.

To make this command behave more predictably, introduce
'--max-new-filters=<n>' to allow computing at most '<n>' Bloom filters
from scratch. This lets "computing" already-known filters proceed
quickly, while bounding the number of slow tasks that Git is willing to
do.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt |  4 +++
 Documentation/git-commit-graph.txt   |  6 ++++
 bloom.c                              |  7 ++--
 builtin/commit-graph.c               | 39 ++++++++++++++++++--
 commit-graph.c                       |  9 +++--
 commit-graph.h                       |  1 +
 t/t4216-log-bloom.sh                 | 53 ++++++++++++++++++++++++++++
 7 files changed, 110 insertions(+), 9 deletions(-)

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
index 194b6ab8ad..022dd6e0f9 100644
--- a/bloom.c
+++ b/bloom.c
@@ -197,12 +197,11 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 
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
index dcc27b74e3..1d9f8cc7e9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1422,6 +1422,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
+	int max_new_filters;
 
 	init_bloom_filters();
 
@@ -1438,13 +1439,16 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	else
 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
+	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
+		ctx->opts->max_new_filters : ctx->commits.nr;
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		enum bloom_filter_computed computed = 0;
 		struct commit *c = sorted_commits[i];
 		struct bloom_filter *filter = get_or_compute_bloom_filter(
 			ctx->r,
 			c,
-			1,
+			ctx->count_bloom_filter_computed < max_new_filters,
 			ctx->bloom_settings,
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
@@ -1455,7 +1459,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 				ctx->count_bloom_filter_trunc_large++;
 		} else if (computed & BLOOM_NOT_COMPUTED)
 			ctx->count_bloom_filter_not_computed++;
-		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
+		ctx->total_bloom_filter_data_size += filter
+			? sizeof(unsigned char) * filter->len : 0;
 		display_progress(progress, i + 1);
 	}
 
diff --git a/commit-graph.h b/commit-graph.h
index b7914b0a7a..a22bd86701 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -110,6 +110,7 @@ struct commit_graph_opts {
 	int max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags split_flags;
+	int max_new_filters;
 };
 
 /*
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index a56327ffd4..24deb8104a 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -287,5 +287,58 @@ test_expect_success 'correctly report commits with no changed paths' '
 		grep "\"filter_trunc_large\":0" trace
 	)
 '
+test_bloom_filters_computed () {
+	commit_graph_args=$1
+	rm -f "$TRASH_DIRECTORY/trace.event" &&
+	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write \
+		$commit_graph_args &&
+	grep "\"filter_not_computed\":$2" "$TRASH_DIRECTORY/trace.event" &&
+	grep "\"filter_trunc_large\":$3" "$TRASH_DIRECTORY/trace.event" &&
+	grep "\"filter_computed\":$4" "$TRASH_DIRECTORY/trace.event"
+}
+
+test_expect_success 'Bloom generation is limited by --max-new-filters' '
+	(
+		cd limits &&
+		test_commit c2 filter &&
+		test_commit c3 filter &&
+		test_commit c4 no-filter &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=2" \
+			3 0 2
+	)
+'
+
+test_expect_success 'Bloom generation backfills previously-skipped filters' '
+	(
+		cd limits &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=1" \
+			4 0 1
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
+			4 0 2 &&
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			4 0 2 &&
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			4 0 2 &&
+
+		# Finally, make sure that once all commits have filters, that
+		# none are subsequently recomputed.
+		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+			6 0 0
+	)
+'
 
 test_done
-- 
2.28.0.462.g4ff11cec37
