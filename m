Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C8FC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3554A2220D
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1eQHlnoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKT0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgIKT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:26:03 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A270C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:26:03 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so5759974qvk.11
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZyPMvsNPvidde9QqcvqroNDC+JI4qM+IvZJJbCG4FmY=;
        b=1eQHlnoSPg3hKJyn51tj8pHrt0Pd3qQ6HzUZOg0e67WtZ3QwdNzlmBfGpLUYWz0n19
         I2PtS7hhtZNraEJUe7cZAAIelAuyeKZ1TlPWfllIb6iopAbQ5xNToEScCKZICWwKmar4
         SouDDg2YyjkR2ctM8EmcGKlKeg05FDSc3Q7BrCYkFmzp1PF+cKElnA/IDP/ccz5SnqZe
         qKctrHxMbQn2xM1QpgaXFVowXlyB9XEC/FUabKciUfvSdfuBLGEwt+1VlRr+G1k+FJoR
         SqHCCrNvxidv16tcypKSkVduz9XTd9r5/Kj5aMn7rhIxStenz2VBX3fhNXMk9IKTK6zY
         FZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZyPMvsNPvidde9QqcvqroNDC+JI4qM+IvZJJbCG4FmY=;
        b=rjQHeR8C0cYX8xz8x8UZEsMPYTK7iMa4ph93jlVU6LrN27i8Ye6aXy8Wx+xxa4TuxF
         cozCvufgzUxI99ks8j/Ou013d2o1rmKEaKWpPn6PzQY62+dCvi1xiJ+JHLIDkqhPflVv
         ZGJgN2zfilKBhCgovtdCBd/U+uzi2BG4IDvch8Og9UT4BONDwZnH5ElXZAbnN6+nrYFd
         o5SpkhSfX7t4GNOSji3bssIap+YYMshRcMPaplOiUPRA9ZSAlSgr16dWdufnrMzkJjUy
         GE+aw1srgfOgQoE2W3D8A+uwv6LUtqDQfF+uDG95bcc65dEeieqD6q9tHeE5I4ZT6gNY
         /Vtw==
X-Gm-Message-State: AOAM532vclWp0FzhAFTvenerYSn+MedscqnpW1xtjtL7xWU3IAYqz1t2
        jBu6xVGshdgFGAaUTnBcMUOh2A==
X-Google-Smtp-Source: ABdhPJxIWFCIzNXoNSOG3ladeNVV+fo8xlttuiUbQTMZTlIxgfb+st8I0BJujEtVvvpS7ty95LkOEA==
X-Received: by 2002:a0c:b92f:: with SMTP id u47mr3420987qvf.24.1599852361875;
        Fri, 11 Sep 2020 12:26:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5db6:da6e:d4c0:c935])
        by smtp.gmail.com with ESMTPSA id u55sm4182078qtu.42.2020.09.11.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 12:26:01 -0700 (PDT)
Date:   Fri, 11 Sep 2020 15:25:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200911192555.GA3612@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911185934.GA2871@xor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 02:59:34PM -0400, Taylor Blau wrote:
> On Fri, Sep 11, 2020 at 01:52:16PM -0400, Jeff King wrote:
> > On Wed, Sep 09, 2020 at 11:24:00AM -0400, Taylor Blau wrote:
> > > +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> > > +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> > > +enforced. Commits whose filters are not calculated are stored as a
> > > +length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
> > > +Overrides the `commitGraph.maxNewFilters` configuration.
> >
> > The BFXL chunk doesn't exist anymore in this iteration, right?
>
> Ack; I'll have to drop that.

Junio, I know that I've already sent one replacement patch. If you don't
mind, here's another (and if you do mind, I'm happy to re-roll the
series).

Thanks.

--- >8 ---

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
2.27.0.2924.ga64bac9092.dirty

