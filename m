Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B6C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57659208DB
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dLg2fWIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgINUNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINUND (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:13:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1171C06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:13:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so1583309qkn.11
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C7L/xyy9Arx69BCR/3GgXos/n/EkWHGjUefYzk4xdMI=;
        b=dLg2fWIECmU6WziI2ZX2b0KA65m66Krtt/8OS09ixjBM7VsXv8L5zysY7LnHgRYzDR
         AbKx/hzqd6om5t77MJMRqqMKFLmKs8LHPgdPNG5/JhIQFYmmKKGXfREKUEyuQ5lLK5Av
         1S3cUBU5j8jlz+Jk5V0NCSpf6rVYZXsjcGM35dNu97ok+PXU3IfAiMsA9okNGu8yF5ju
         NSpInVHE+1ZqcYvzPOIMUjYhTwMlskVzElByAiKygLIn6P0FQr1jTlJ96bGM6wttqzp0
         TOnyRtaxvbwqs0CfMbkFboHp59hLl8DydONLRVd7s0qSBcbINr7SwSQuSThdpwg+0cdb
         ndxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C7L/xyy9Arx69BCR/3GgXos/n/EkWHGjUefYzk4xdMI=;
        b=dISfpQnOmuIjsURSVTaPuz1S4iZB0gT9SWDJi9e5/FTTczVYfBywx4MVLCoNs4v1RG
         lB/aVy2GZZtA13LRDpxKGvxbRQnnkYYWVDqwcag/C7HZMFW90nA78y2YJA+OOYPQV/sX
         JPtzWtl+nfsPaLvl7mJQDXgMWojnCz8T4ryjwduwgG9hoqeiB2X6qtYo9EHbMQAfS5Ma
         C4zdkVTpkqWco6Pk2K8jWqnKEJ9hsv4c1V6XPr5LkxyYN0rLxs3SfxUMZwPJGSZIZ9AE
         evmGwJGgZSirDu5jS+8ZV3WmVE4mOvWKZzZEo4rsc3122Y7sYDRtILGhBCdFUqEw0bVQ
         1FUg==
X-Gm-Message-State: AOAM532T5nSqyY+C+ebde0k4oksr49gD64gwo+/6QZRVaNtu2raniLfd
        YcxJT4WNUDYcIB3DzEMmO3k1jA==
X-Google-Smtp-Source: ABdhPJw3ypleWM6mqvK+lO0qatvNsBnbaCAJN13JYSTYjD9O1naWXPRj1rjGVtGfJAPbTXtNYHXqOA==
X-Received: by 2002:a37:8ac2:: with SMTP id m185mr2285488qkd.84.1600114381806;
        Mon, 14 Sep 2020 13:13:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bc05:1f7d:98e:e354])
        by smtp.gmail.com with ESMTPSA id e23sm14384348qkl.67.2020.09.14.13.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:13:00 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:12:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200914201258.GA12431@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan>
 <20200911192555.GA3612@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911192555.GA3612@nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 03:25:55PM -0400, Taylor Blau wrote:
> On Fri, Sep 11, 2020 at 02:59:34PM -0400, Taylor Blau wrote:
> > On Fri, Sep 11, 2020 at 01:52:16PM -0400, Jeff King wrote:
> > > On Wed, Sep 09, 2020 at 11:24:00AM -0400, Taylor Blau wrote:
> > > > +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> > > > +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> > > > +enforced. Commits whose filters are not calculated are stored as a
> > > > +length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
> > > > +Overrides the `commitGraph.maxNewFilters` configuration.
> > >
> > > The BFXL chunk doesn't exist anymore in this iteration, right?
> >
> > Ack; I'll have to drop that.
>
> Junio, I know that I've already sent one replacement patch. If you don't
> mind, here's another (and if you do mind, I'm happy to re-roll the
> series).

Just kidding. Let's use *this* version which fixes a bug reading the
commitGraph.maxNewFilters configuration. At this point, the
fix-ups are:

  - This patch (attached below the scisors) instead of 12/12, and

  - This [1] patch instead of 10/12.

[1]: https://lore.kernel.org/git/20200910154516.GA32117@nand.local/

Let me know if you'd rather have a full re-roll.

--- 8< ---

Subject: [PATCH] builtin/commit-graph.c: introduce '--max-new-filters=<n>'

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
 Documentation/config/commitgraph.txt |  4 ++
 Documentation/git-commit-graph.txt   |  6 +++
 bloom.c                              |  7 ++--
 builtin/commit-graph.c               | 41 ++++++++++++++++++++-
 commit-graph.c                       |  9 ++++-
 commit-graph.h                       |  1 +
 t/t4216-log-bloom.sh                 | 55 ++++++++++++++++++++++++++++
 7 files changed, 115 insertions(+), 8 deletions(-)

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
index 17405c73a9..60df4e4bfa 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -67,6 +67,12 @@ this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
 data.
 +
+With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
+filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
+enforced. Commits whose filters are not calculated are stored as a
+length zero Bloom filter. Overrides the `commitGraph.maxNewFilters`
+configuration.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/bloom.c b/bloom.c
index d24747a1d5..230a515831 100644
--- a/bloom.c
+++ b/bloom.c
@@ -204,12 +204,11 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,

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
index f3243bd982..988445abdf 100644
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

@@ -162,6 +164,35 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
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
+static int git_commit_graph_write_config(const char *var, const char *value,
+					 void *cb)
+{
+	if (!strcmp(var, "commitgraph.maxnewfilters"))
+		write_opts.max_new_filters = git_config_int(var, value);
+	/*
+	 * No need to fall-back to 'git_default_config', since this was already
+	 * called in 'cmd_commit_graph()'.
+	 */
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
@@ -197,6 +228,9 @@ static int graph_write(int argc, const char **argv)
 			N_("maximum ratio between two levels of a split commit-graph")),
 		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
 			N_("only expire files older than a given date-time")),
+		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
+			NULL, N_("maximum number of changed-path Bloom filters to compute"),
+			0, write_option_max_new_filters),
 		OPT_END(),
 	};

@@ -205,9 +239,12 @@ static int graph_write(int argc, const char **argv)
 	write_opts.size_multiple = 2;
 	write_opts.max_commits = 0;
 	write_opts.expire_time = 0;
+	write_opts.max_new_filters = -1;

 	trace2_cmd_mode("write");

+	git_config(git_commit_graph_write_config, &opts);
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
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
index a56327ffd4..3cb766301d 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -287,5 +287,60 @@ test_expect_success 'correctly report commits with no changed paths' '
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
+	# Check specifying commitGraph.maxNewFilters over "git config" works.
+	test_config -C limits commitGraph.maxNewFilters 1 &&
+	(
+		cd limits &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
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
2.27.0.2924.ga64bac9092.dirty

