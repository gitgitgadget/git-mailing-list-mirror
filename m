Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71164C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335AF20661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aiPF88Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgAaA2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:28:20 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35885 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgAaA2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:28:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so2066724pjb.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 16:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ce21gkx60g7pVhZdJZGurS9wpav/EZ6A5h6hNOk/X0=;
        b=aiPF88MmH2GyTe2LIDJbbkC8VNw3L7D4hwO42doKXt19VMwuZ0gQisxWYgDyKxcWK7
         ejvfyGZHghX/wbRFb59ttRgUokzDC4yjWQZatogTCwloACYlUM2DZm3uxOCCN+22ZyMC
         Myj7GKYrmsyhcezPzirmbOFNc8j3FwLb7OB34DDAUHBpEmy0/98BvipkR2/FueX0X1Jz
         R+caej0Eg5IPxIDEQMmwAzgdH+SxoGlc7bUH8Ddb8dXbeq9SOqJWSHN+/ozF1wzsthv3
         msLKoH/3baJ8tXHd12bQBsZeeaUzdR3qHGFeJ0H6M2STNtuGT7xmAP6Ca8v5ucIMavKY
         KCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ce21gkx60g7pVhZdJZGurS9wpav/EZ6A5h6hNOk/X0=;
        b=LxBK+lwa1sAd4fuLOdqF9UEE0oO+0CiRedcc+DKDfnRfIRujsH+6fsPM49Lafjo+CU
         EHgW0+Rzu36MVsgJpZpBdB8/R4qa7GhUBvwD+aBGV8LPhAimlWQw76EtplS9+UC8dk4h
         6sE5WexovxMjET3cCL8KKYnSWV079jSCrX/aYlhrBhYC5s3eHLFitzAwxvF0BeSkNmwT
         vzh9LD5JbA1IqwsUxx6PJWoJMhecTuny/yLBHEH+/gmJxnBtOp2olGgg/JsfeIFWqCQj
         RWeBtjL1aGEV6AkL5/tzfDJHO8qXAw6o8hRqau0snWdL1yISCYrAXj23Eb5+f5PspLVI
         VSJA==
X-Gm-Message-State: APjAAAXn/BPusKGbulVfU+PWULdalSqbfQ/QWhmA0yq4fHjwb0QQh67B
        3ZKFuycqmZfpGee60i5qUuzODxzifo4sKQ==
X-Google-Smtp-Source: APXvYqz+ntadsEBm0xe6OBNwErMosOKQ0RXqRLGozLgJ5E7uDEuqU4e4RtgsSGGp3MNBULrjgu9AyA==
X-Received: by 2002:a17:902:fe93:: with SMTP id x19mr7458283plm.155.1580430498442;
        Thu, 30 Jan 2020 16:28:18 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id c19sm8188178pfc.144.2020.01.30.16.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 16:28:18 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:28:17 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
Message-ID: <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With '--split', the commit-graph machinery writes new commits in another
incremental commit-graph which is part of the existing chain, and
optionally decides to condense the chain into a single commit-graph.
This is done to ensure that the aysmptotic behavior of looking up a
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
 Documentation/git-commit-graph.txt | 18 +++++++++++-----
 builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++----
 commit-graph.c                     | 19 +++++++++--------
 commit-graph.h                     |  7 +++++++
 t/t5324-split-commit-graph.sh      | 25 ++++++++++++++++++++++
 5 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 28d1fee505..8d61ba9f56 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -57,11 +57,19 @@ or `--stdin-packs`.)
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
+options. (Note that merging a chain of commit graphs replaces the
+existing chain with a length-1 chain where the first and only
+incremental holds the entire graph).
 +
 * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
 tip file would have `N` commits and the previous tip has `M` commits and
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index de321c71ad..f03b46d627 100644
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
 
@@ -101,6 +105,25 @@ static int graph_verify(int argc, const char **argv)
 extern int read_replace_refs;
 static struct split_commit_graph_opts split_opts;
 
+static int write_option_parse_split(const struct option *opt, const char *arg,
+				    int unset)
+{
+	enum commit_graph_split_flags *flags = opt->value;
+
+	opts.split = 1;
+	if (!arg)
+		return 0;
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
@@ -123,8 +146,10 @@ static int graph_write(int argc, const char **argv)
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
index 6d34829f57..02e6ad9d1f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1565,15 +1565,18 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	num_commits = ctx->commits.nr;
 	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
-	while (g && (g->num_commits <= size_mult * num_commits ||
-		    (max_commits && num_commits > max_commits))) {
-		if (g->odb != ctx->odb)
-			break;
+	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
+		while (g && (g->num_commits <= size_mult * num_commits ||
+			    (max_commits && num_commits > max_commits) ||
+			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
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
@@ -1881,7 +1884,7 @@ int write_commit_graph(struct object_directory *odb,
 		goto cleanup;
 	}
 
-	if (!ctx->commits.nr)
+	if (!ctx->commits.nr && (!ctx->split || ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))
 		goto cleanup;
 
 	if (ctx->split) {
diff --git a/commit-graph.h b/commit-graph.h
index 7d9fc9c16a..dadcc03808 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -84,10 +84,17 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
 };
 
+enum commit_graph_split_flags {
+	COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
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
2.25.0.dirty

