Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A4C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FC2082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Q0fS+Nks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgBEA2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:28:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38019 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgBEA2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:28:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so44608pgm.5
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zDfKFta8GDt/KGcGgNyYgxvmHnNvfcgqoaNciXKfRM=;
        b=Q0fS+NksTxJRCAFUnXeCRu6XuD6nBTpQpfzjJHGB1Y6xb9llA49pr57P5ueqBsxtv+
         sVhK381faqgiMg8S1PP40hcmpBgKpOx2KAcUSo+SlpUeqxLXFT0GzjE95pBMRPGkCpeX
         szJ5EOiSVf0Y1zmvZo8v1xEJL1x4sWaNRDE5/fQNtMDiWE95n1KODCxh5qfZ+6TBQziD
         IXrxKP31S8zIy1f3VhMucEqdRdfANCisNjwGKx1KcYh1DdOj32Abe8YKDxHRKtmdjdXj
         HAgfCs+VXJZii7uThCbRYLbtlocn8DuSPCZRrR2R+06PiPTrO5+FzDEyrGsfRzxA4JGo
         o+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zDfKFta8GDt/KGcGgNyYgxvmHnNvfcgqoaNciXKfRM=;
        b=bK+kF4i8ap1p74PJa/d2ghtoicspSL+OmojRrT+RzbGMAdb3US6i0D13roOUpi5+Hy
         xc/SJOMkjCx1aleZ1zmaDGqls85SdvQ/0oJcXoHpiRdXlqM2bBgjVREN84bFjyYu07Rl
         jpXamIRHVQ0V/1GLDiiibCV6JwyX55CUT80boN7eNFMtcXU+olXQ0NDRAsAsiVbXv410
         HPNcA0QgLScxTwWyXRy+5vsI76WYkhLEKNk3GX9ZIzGSCgvLTIt44zGLIoBdyS2qqTu3
         6MDyLtDJ+Dff0kXgr8JQFKHoeoKkNdLA/EUz+Bh+WSlrzeEeQ8LP+G2Lb4ybdbtwH7v4
         NVWw==
X-Gm-Message-State: APjAAAVzOZiKzZNskdFyoJ+6jDgpO1x+SzSAd63Q9HetWh6TZFQXrTHc
        oOHfJxVloDj8TbhdFVDKeTnOtN6dNIpyEg==
X-Google-Smtp-Source: APXvYqxBdY/faKzJJNMGeozIM2g3Jb3ZplhrRkJWeNCY/a6qqB8AX7vGbtUgsvdVRgxQSr9xEl9hrw==
X-Received: by 2002:a63:da14:: with SMTP id c20mr35322804pgh.280.1580862513957;
        Tue, 04 Feb 2020 16:28:33 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:fd92:b4b9:d992:34e6])
        by smtp.gmail.com with ESMTPSA id 70sm25748518pfw.140.2020.02.04.16.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:28:33 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:28:32 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
Message-ID: <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580862307.git.me@ttaylorr.com>
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
 Documentation/git-commit-graph.txt | 16 +++++++++-----
 builtin/commit-graph.c             | 35 ++++++++++++++++++++++++++----
 commit-graph.c                     | 22 ++++++++++++-------
 commit-graph.h                     |  7 ++++++
 t/t5324-split-commit-graph.sh      | 25 +++++++++++++++++++++
 5 files changed, 88 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 28d1fee505..b7fe65ef21 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -57,11 +57,17 @@ or `--stdin-packs`.)
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
index c24823431f..a165b48afe 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -344,4 +344,29 @@ test_expect_success 'split across alternate where alternate is not split' '
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

