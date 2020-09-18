Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C5C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1DB20DD4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OYa3Q+PB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIRN1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgIRN1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 09:27:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523AC040200
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:27:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so4881223qtj.11
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TsQH4jqW7iat6YVUoWNu3TI+Z9Dj8zabF5turjUZ5jk=;
        b=OYa3Q+PBn6FTxux0bBq9gjLifXWbQOm8soBnPTKbdO8GknTVr9cERqAyEVTvD9QOJa
         XLj1gIzBzDpPSVvFSqU1XfSlAmeBdA71J3UREOuNHdGTiyHoGQ9jVu0swfUcneg/GY9l
         GAM8xGU1jvi55sYR64MQAVjiaU95opHZYaGrKkHw3VyR9lOiYR1QqSF1j3wKLlSsCTaX
         8dhH7Ai3xCodfwT8kqAmLTdAvEx6oWLnLLoPTOi427Mpkq5gz2+HKFWpdjxUaD9IKRU6
         Iot3nsiz1jMiS9amkgePw26e61QFAr/sBpxDxXVQmksbJJRyhm2WTfDIyW/zIzZP0kFI
         Fwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TsQH4jqW7iat6YVUoWNu3TI+Z9Dj8zabF5turjUZ5jk=;
        b=DfUa2bD3EM1TfTq4+YaG9Ox9GeD4D8o1rz2m5EjDTqbDunRGoycPMGQ/1H2dRk6my3
         nFuw56dGIxfLvVGLOnfSwI0bfeo/zx9dPKQVSOJ2tcHfSxqXTlCtkNVC0ZX1deS+iweB
         iOg52BtuHLwK/lt8D1r0DSckeP9xpO5fN10+q8QC9WiqXCBxgAgLZwd2BHKjgQsP+KCS
         CqiB21eUl96VYM4Rgm8dwCL0puMNTc1XUTHn+T07MlhYGBf+l87m10EGZsyhh8dtjU04
         USX/cRshmTRYVyEgBW8XePYVsancT/dKAeZ9jjFsH9WsAdvy7A3TqZCAKbrxCPEYCzxc
         TxTw==
X-Gm-Message-State: AOAM531hnz99uPpToFAFt6Vfegb+kyvP0IVvrwmqSVBANLXkY5dB3FZ8
        4i4Dh31orEOJMTonwSpG+sMNmg==
X-Google-Smtp-Source: ABdhPJxfro057n9Ze2f9kiY5D2FZwNid3UmA1z6VN1uYYkz65Yvt0pulDt+Nbjq/2baRBf2KlR/Cew==
X-Received: by 2002:ac8:2383:: with SMTP id q3mr21059922qtq.230.1600435650654;
        Fri, 18 Sep 2020 06:27:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id a24sm2035315qko.82.2020.09.18.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:27:29 -0700 (PDT)
Date:   Fri, 18 Sep 2020 09:27:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 12/13] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200918132727.GB1600256@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
 <ccb6482feb8d8606d82b5ab97e33184f26d6c5b6.1600279373.git.me@ttaylorr.com>
 <20200918092036.GA24813@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200918092036.GA24813@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 11:23:24AM +0200, SZEDER Gábor wrote:
> On Wed, Sep 16, 2020 at 02:08:10PM -0400, Taylor Blau wrote:
> > +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> > +filters (if `--changed-paths` is specified).
>
> If '--max-new-filters=42' is specified without '--changed-paths', then
> it is silently ignored instead of erroring out.  Is that intentional?

Yeah, that is intentional. The rationale is that if you're specifying "I
won't compute any more than N filters" but don't say "compute and write
changed-path Bloom filters", then you'll compute 0 < N filters, which is
fine.

I considered making this a warning, but ultimately decided against it.
In particular, I had users who might set 'commitGraph.maxNewFilters' to
some value, but only sometimes write a commit-graph with
'--changed-paths'.

> > If `n` is `-1`, no limit is
> > +enforced. Commits whose filters are not calculated are stored as a
> > +length zero Bloom filter.
>
> This last sentence goes into implementation details of the file
> format, so I don't think it should be included here.

Good idea, I'll drop that.

> What should be documented here instead is what happens later with
> those commits for which no modified path Bloom filters were computed.
> Will they ever be computed?  If yes, which commands will compute them
> (even implicitly), and thus will run slower?  What command(s) should
> the users run if they want to compute the missing filters?
>
> Let's suppose that running
>
>   git commit-graph write --reachable --changed-paths --max-new-filters=<L> --split
>
> writes a commit-graph layer containing N1 commits, and N1 > L, so N1-L
> commits won't have an associated modified path Bloom filter.  After
> creating and fetching new commits, this command is executed again to
> add information about N2 commits to the commit-graph, and N2 < L.
>
>   - If this second invocation writes a new commit-graph layer, then it
>     will only compute Bloom filters for commits in this new layer,
>     even though it still has some "Bloom-computing-capacity" left.
>     (This will happen even if this second write were invoked without
>     '--max-new-filters'.)
>
>   - If the merge strategy decides that, instead of writing a new
>     layer, the new N2 commits should be merged with the layer
>     containing the previous N1 commits, then it will compute Bloom
>     filters for some or all of those N1 commits without filters,
>     depending on whether N2-L is smaller or larger than N1-L.
>
> Is this how it is supposed to work?  We can't tell, because neither
> the commit messages nor the documentation updates talk about this.

That's a wonderful question, and yes: that's how it's supposed to work.
Implicit in all of this is that these commit-graph options are only
acting over the new layers that we are going to write. So, if we're
going to roll-up older layers, we'll start with their uncomputed
filters before computing new filters in later layers.

This is the same thing as running 'git commit-graph write --reachable
--changed-paths --split' (omitting '--max-new-filters' is not a typo
there). Because the commit-graph command only acts over new layers, old
layers do not suddenly get Bloom filters computed and those filters
rewritten. If a user wants that to happen, they can pass
'--split=replace', which will force all existing graphs to reside in a
new, single layer chain.

Let's use the following version of the patch which I think will clarify
your questions:

--- >8 ---

Subject: [PATCH] builtin/commit-graph.c: introduce '--max-new-filters=<n>'

Introduce a command-line flag to specify the maximum number of new Bloom
filters that a 'git commit-graph write' is willing to compute from
scratch.

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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit-graph.txt |  6 +++
 bloom.c                            |  7 ++-
 builtin/commit-graph.c             | 27 +++++++++++-
 commit-graph.c                     |  9 +++-
 commit-graph.h                     |  1 +
 t/t4216-log-bloom.sh               | 70 ++++++++++++++++++++++++++++++
 6 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 17405c73a9..8c75855782 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -67,6 +67,12 @@ this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
 data.
 +
+With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
+filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
+enforced. Only commits present in the new layer count against this
+limit. To retroactively compute Bloom filters over earlier layers, it is
+advised to use `--split=replace`.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/bloom.c b/bloom.c
index d234551ce0..68c73200a5 100644
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
index f3243bd982..5df9b2ef80 100644
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

diff --git a/commit-graph.c b/commit-graph.c
index d2a2f78776..d10e730f29 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1415,6 +1415,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
+	int max_new_filters;

 	init_bloom_filters();

@@ -1431,13 +1432,16 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
@@ -1448,7 +1452,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
index 15bbb626a1..af0975c841 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -310,4 +310,74 @@ test_expect_success 'correctly report commits with no changed paths' '
 	)
 '

+test_expect_success 'Bloom generation is limited by --max-new-filters' '
+	(
+		cd limits &&
+		test_commit c2 filter &&
+		test_commit c3 filter &&
+		test_commit c4 no-filter &&
+
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --split=replace \
+				--changed-paths --max-new-filters=2 &&
+
+		test_filter_computed 2 trace.event &&
+		test_filter_not_computed 3 trace.event &&
+		test_filter_trunc_empty 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
+test_expect_success 'Bloom generation backfills previously-skipped filters' '
+	(
+		cd limits &&
+
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --changed-paths \
+				--split=replace --max-new-filters=1 &&
+		test_filter_computed 1 trace.event &&
+		test_filter_not_computed 4 trace.event &&
+		test_filter_trunc_empty 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
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
+		for i in $(test_seq 1 3)
+		do
+			rm -f trace.event &&
+			GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+				git commit-graph write --reachable \
+					--changed-paths --max-new-filters=2 &&
+			test_filter_computed 2 trace.event &&
+			test_filter_not_computed 4 trace.event &&
+			test_filter_trunc_empty 2 trace.event &&
+			test_filter_trunc_large 0 trace.event
+		done &&
+
+		# Finally, make sure that once all commits have filters, that
+		# none are subsequently recomputed.
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable \
+				--changed-paths --max-new-filters=2 &&
+		test_filter_computed 0 trace.event &&
+		test_filter_not_computed 6 trace.event &&
+		test_filter_trunc_empty 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_done
--
2.28.0.510.g375ecf1f36

