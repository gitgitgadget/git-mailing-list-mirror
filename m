Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E1AC3B188
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C522073C
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="I7CTvY++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBLFr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:47:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33017 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgBLFr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so676565pfn.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 21:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SKq2qA35Y1SwtnAEclpX+WfBH92pFjXI0eWeA9ghcno=;
        b=I7CTvY++EQxR93giO76FnKpp5CEoUCM0ye+RYljgvxkpdFccQQL9Lvjdf/TcSQagOP
         D8ZMXA6xEa9c8FExoSCii1vYZ+kw+Ai5JLHk8W1qb6DFiQq1vHfOlIrjdnm8x1Qmc6Tu
         3NYIO1CwhwXJeWlwnyoskpV62iEuwtBPwH14kwPXSfpIuwUmqVqJ7eSmj5csLkqnWoHE
         ItwWE5jJzS4o4qF/x0vtpJlbo7BfqSLSxDQaHwoRO6FfmrbJaTSAjKwjxPnowTrgEnRX
         SWK5EoQMC8djDS5Uzhff4GYrWsPjVe9FTDui5g0u7OyA5P5GYS9l4FT9zzUzlRce/8Qi
         thhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SKq2qA35Y1SwtnAEclpX+WfBH92pFjXI0eWeA9ghcno=;
        b=IU2AbagYYKHReTDeu7+UV2AO725BZ9JfCCvK3SUjbLP5LrlzgRpNzOHNiRkO2SJeN7
         yRGckZLsZ/XpLQJJl8pMOB7rf7dCWnl5PNGWMY39buVUIwamymSG/1cGkNgiwO++/8Lp
         h8izbFHZojdHJnImfgMBHhIt1dLOg7O3RfttNqvV4GFQRTYkkTZxkcWGWrSCREZBeFPb
         qDnWp9gzXlJRMeOSzqvY/VoxElB/WUXG6Q29xc41i2IqcGw2mFckzXgclGlCN1wez34L
         556zlDoq7SUfpsi/B1mc0r+cZbGMDg973yQxy7jxKvcSfc0kUrwAKNxgg4doJXFmFtTG
         gsFw==
X-Gm-Message-State: APjAAAU73LqmBLxzzaXsYFmPdKLuL/1aLndTITj7973xqzRjLMenjkLm
        LkW5OlSx8gfWIJL00PAudYI77AM73o2lSg==
X-Google-Smtp-Source: APXvYqwS8xiuRIxkSdxpRwDkOc8zOqsUE/MEDivRiqniY35afleI0mCkcPMPNC8EF7vGwlXYklrWRw==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr10344007pgs.441.1581486474634;
        Tue, 11 Feb 2020 21:47:54 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:e4b4:608a:57ae:c0a6])
        by smtp.gmail.com with ESMTPSA id e26sm6439381pfl.59.2020.02.11.21.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 21:47:54 -0800 (PST)
Date:   Tue, 11 Feb 2020 21:47:53 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v3 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
Message-ID: <e1635a0e34de62095e85ee3e42222c8fa2384688.1581486293.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1581486293.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With '--split', the commit-graph machinery writes new commits in another
incremental commit-graph which is part of the existing chain, and
optionally decides to condense the chain into a single commit-graph.
This is done to ensure that the asymptotic behavior of looking up a
commit in an incremental chain is dominated by the number of
incrementals in that chain. It can be controlled by the '--max-commits'
and '--size-multiple' options.

On occasion, callers may want to ensure that 'git commit-graph write
--split' always writes an incremental, and never spends effort
condensing the incremental chain [1]. Previously, this was possible by
passing '--size-multiple=0', but this no longer the case following
63020f175f (commit-graph: prefer default size_mult when given zero,
2020-01-02).

Reintroduce a less-magical variant of the above with a new pair of
arguments to '--split': '--split=no-merge' and '--split=merge-all'. When
'--split=no-merge' is given, the commit-graph machinery will never
condense an existing chain and will always write a new incremental.
Conversely, if '--split=merge-all' is given, any invocation including it
will always condense a chain if one exists.  If '--split' is given with
no arguments, it behaves as before and defers to '--size-multiple', and
so on.

[1]: This might occur when, for example, a server administrator running
some program after each push may want to ensure that each job runs
proportional in time to the size of the push, and does not "jump" when
the commit-graph machinery decides to trigger a merge.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt | 17 ++++++++++-----
 builtin/commit-graph.c             | 35 ++++++++++++++++++++++++++----
 commit-graph.c                     | 22 ++++++++++++-------
 commit-graph.h                     |  7 ++++++
 t/t5324-split-commit-graph.sh      | 25 +++++++++++++++++++++
 5 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 28d1fee505..269c355b0a 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -57,11 +57,18 @@ or `--stdin-packs`.)
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
 +
-With the `--split` option, write the commit-graph as a chain of multiple
-commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
-not already in the commit-graph are added in a new "tip" file. This file
-is merged with the existing file if the following merge conditions are
-met:
+With the `--split[=<strategy>]` option, write the commit-graph as a
+chain of multiple commit-graph files stored in
+`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
+strategy and other splitting options. The new commits not already in the
+commit-graph are added in a new "tip" file. This file is merged with the
+existing file if the following merge conditions are met:
++
+* If `--split=merge-always` is specified, then a merge is always
+conducted, and the remaining options are ignored. Conversely, if
+`--split=no-merge` is specified, a merge is never performed, and the
+remaining options are ignored. A bare `--split` defers to the remaining
+options.
 +
 * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
 tip file would have `N` commits and the previous tip has `M` commits and
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4a70b33fb5..4d3c1c46c2 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,9 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] "
+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	   "[--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -19,7 +21,9 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] "
+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	   "[--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -111,6 +115,27 @@ static int graph_verify(int argc, const char **argv)
 extern int read_replace_refs;
 static struct split_commit_graph_opts split_opts;
 
+static int write_option_parse_split(const struct option *opt, const char *arg,
+				    int unset)
+{
+	enum commit_graph_split_flags *flags = opt->value;
+
+	opts.split = 1;
+	if (!arg) {
+		*flags = COMMIT_GRAPH_SPLIT_MERGE_AUTO;
+		return 0;
+	}
+
+	if (!strcmp(arg, "merge-all"))
+		*flags = COMMIT_GRAPH_SPLIT_MERGE_REQUIRED;
+	else if (!strcmp(arg, "no-merge"))
+		*flags = COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED;
+	else
+		die(_("unrecognized --split argument, %s"), arg);
+
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list *pack_indexes = NULL;
@@ -133,8 +158,10 @@ static int graph_write(int argc, const char **argv)
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
-		OPT_BOOL(0, "split", &opts.split,
-			N_("allow writing an incremental commit-graph file")),
+		OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
+			N_("allow writing an incremental commit-graph file"),
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			write_option_parse_split),
 		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
 		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
diff --git a/commit-graph.c b/commit-graph.c
index 656dd647d5..3a5cb23cd7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1533,27 +1533,33 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	int max_commits = 0;
 	int size_mult = 2;
+	enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_MERGE_AUTO;
 
 	if (ctx->split_opts) {
 		max_commits = ctx->split_opts->max_commits;
 
 		if (ctx->split_opts->size_multiple)
 			size_mult = ctx->split_opts->size_multiple;
+
+		flags = ctx->split_opts->flags;
 	}
 
 	g = ctx->r->objects->commit_graph;
 	num_commits = ctx->commits.nr;
 	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
-	while (g && (g->num_commits <= size_mult * num_commits ||
-		    (max_commits && num_commits > max_commits))) {
-		if (g->odb != ctx->odb)
-			break;
+	if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
+		while (g && (g->num_commits <= size_mult * num_commits ||
+			    (max_commits && num_commits > max_commits) ||
+			    (flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
+			if (g->odb != ctx->odb)
+				break;
 
-		num_commits += g->num_commits;
-		g = g->base_graph;
+			num_commits += g->num_commits;
+			g = g->base_graph;
 
-		ctx->num_commit_graphs_after--;
+			ctx->num_commit_graphs_after--;
+		}
 	}
 
 	ctx->new_base_graph = g;
@@ -1861,7 +1867,7 @@ int write_commit_graph(struct object_directory *odb,
 		goto cleanup;
 	}
 
-	if (!ctx->commits.nr)
+	if (!ctx->commits.nr && (!ctx->split_opts || ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))
 		goto cleanup;
 
 	if (ctx->split) {
diff --git a/commit-graph.h b/commit-graph.h
index e87a6f6360..65a7d2edae 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -82,10 +82,17 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
 };
 
+enum commit_graph_split_flags {
+	COMMIT_GRAPH_SPLIT_MERGE_AUTO       = 0,
+	COMMIT_GRAPH_SPLIT_MERGE_REQUIRED   = 1,
+	COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 2
+};
+
 struct split_commit_graph_opts {
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
+	enum commit_graph_split_flags flags;
 };
 
 /*
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 53b2e6b455..bb2b724178 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -351,4 +351,29 @@ test_expect_success 'split across alternate where alternate is not split' '
 	test_cmp commit-graph .git/objects/info/commit-graph
 '
 
+test_expect_success '--split=merge-all always merges incrementals' '
+	test_when_finished rm -rf a b c &&
+	rm -rf $graphdir $infodir/commit-graph &&
+	git reset --hard commits/10 &&
+	git rev-list -3 HEAD~4 >a &&
+	git rev-list -2 HEAD~2 >b &&
+	git rev-list -2 HEAD >c &&
+	git commit-graph write --split=no-merge --stdin-commits <a &&
+	git commit-graph write --split=no-merge --stdin-commits <b &&
+	test_line_count = 2 $graphdir/commit-graph-chain &&
+	git commit-graph write --split=merge-all --stdin-commits <c &&
+	test_line_count = 1 $graphdir/commit-graph-chain
+'
+
+test_expect_success '--split=no-merge always writes an incremental' '
+	test_when_finished rm -rf a b &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list HEAD~1 >a &&
+	git rev-list HEAD >b &&
+	git commit-graph write --split --stdin-commits <a &&
+	git commit-graph write --split=no-merge --stdin-commits <b &&
+	test_line_count = 2 $graphdir/commit-graph-chain
+'
+
 test_done
-- 
2.25.0.119.gaa12b7378b

