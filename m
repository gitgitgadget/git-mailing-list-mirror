Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F5DC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818E820661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="m1ecs5ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgAaA2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:28:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39692 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgAaA2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:28:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2000154plp.6
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOCNPIBtLhr6ituh2GewCHjv6q+ScM6+mxAZktUZGAw=;
        b=m1ecs5yasWHzMHjY5vJun8jBvLjd+9ksYs0JF1vB6KEAOYcKWtkWKeBv4zBIBKgfj8
         SU+QEfNr2aj5hKhDBKM4imppTV/wxdI8cxUai/EvLcsOHqdsyMRTGoXpTR/q2X6agsHl
         bowz2jtgRczIByp/TjT2/9WGS1BtO7TGqGSB3We4xDbxy3KNoWZHHwu5jwQgd8k0/vXr
         r+nUW555WIT9H82MjOrB7rC1LUJo8gpxTDdWmR80W8p4pf37Yri8G6qmYBQ9CIf6WDsj
         /UyFBE/dLaun0ToKhCg7Ir43ekJQBCReQ1FX3CcfiH1h4KqGEWxKeRaxigdL1J1j7qJ5
         lEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOCNPIBtLhr6ituh2GewCHjv6q+ScM6+mxAZktUZGAw=;
        b=WDwgHviSwzTcbd0ISbvRSPdxRcEGNJtvNDfxfxsfK9awHTzSXZCxAMacp0QgGA8uJU
         2bqJ53e1xQAW99eZGVPWlgfouN8OYEm+DSzuBuT5IAAc/9/k9TAGOBdsWc2OgDS9pj9y
         wfGuIODUZpCkjosYI2Izorl4wnMgOLVTY0XumYjLMsqkQfkwk0rtaaxGZDA8wUa157Sq
         scnB9iWKLVGyM60tfDfv7kDcfVvMd3tdD4UM9/dGHkxTTtRuBiinJJrv7fyCxKjoJvE5
         CRh6WU7jw6Z6AHSRjvgMLPdc5vrc5XMkULujWfSHHuiqTr5TyVkwp37O8se8NVEb78cd
         GuEg==
X-Gm-Message-State: APjAAAX+RKtsNsFc+101XvKntcZ+XMsqy8pDQl2FoFFExR38ukmUqin4
        /p3DZErGvN4PqFR6xV0M17vu9WaZpLBwkw==
X-Google-Smtp-Source: APXvYqx1HVKG2N9fcT5UkKNRO7nyBJQlTdAqSUlVWrAPGG//lCGKCjde2aFsVE3ap8QdaYCnUa8CMg==
X-Received: by 2002:a17:90a:7303:: with SMTP id m3mr9210038pjk.62.1580430510317;
        Thu, 30 Jan 2020 16:28:30 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id c19sm8188277pfc.144.2020.01.30.16.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 16:28:24 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:28:21 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <c329a8ddc087c9b74f673005f8b1e8769816ab9a.1580430057.git.me@ttaylorr.com>
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

In the previous commit, we introduced '--[no-]merge', and alluded to the
fact that '--merge' would be useful for callers who wish to always
trigger a merge of an incremental chain.

There is a problem with the above approach, which is that there is no
way to specify to the commit-graph builtin that a caller only wants to
include commits already in the graph. One can specify '--input=append'
to include all commits in the existing graphs, but the absence of
'--input=stdin-{commits,packs}' causes the builtin to call
'fill_oids_from_all_packs()'.

Passing '--input=reachable' (as in 'git commit-graph write
--split=merge-all --input=reachable --input=append') works around this
issue by making '--input=reachable' effectively a no-op, but this can be
prohibitively expensive in large repositories, making it an undesirable
choice for some users.

Teach '--input=none' as an option to behave as if '--input=append' were
given, but to consider no other sources in addition.

This, in conjunction with the option introduced in the previous patch
offers the convenient way to force the commit-graph machinery to
condense a chain of incrementals without requiring any new commits:

  $ git commit-graph write --split=merge-all --input=none

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt | 21 +++++++++++++--------
 builtin/commit-graph.c             | 13 ++++++++++---
 commit-graph.c                     |  6 ++++--
 commit-graph.h                     |  3 ++-
 t/t5324-split-commit-graph.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index cbf80226e9..d380c42e82 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -39,24 +39,29 @@ COMMANDS
 --------
 'write'::
 
-Write a commit-graph file based on the commits found in packfiles.
+Write a commit-graph file based on the commits specified:
+* With the `--input=stdin-packs` option, generate the new commit graph
+by walking objects only in the specified pack-indexes. (Cannot be
+combined with `--input=stdin-commits` or `--input=reachable`.)
 +
-With the `--input=stdin-packs` option, generate the new commit graph by
-walking objects only in the specified pack-indexes. (Cannot be combined
-with `--input=stdin-commits` or `--input=reachable`.)
-+
-With the `--input=stdin-commits` option, generate the new commit graph
+* With the `--input=stdin-commits` option, generate the new commit graph
 by walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
 `--input=stdin-packs` or `--input=reachable`.)
 +
-With the `--input=reachable` option, generate the new commit graph by
+* With the `--input=reachable` option, generate the new commit graph by
 walking commits starting at all refs. (Cannot be combined with
 `--input=stdin-commits` or `--input=stdin-packs`.)
 +
-With the `--input=append` option, include all commits that are present
+* With the `--input=append` option, include all commits that are present
 in the existing commit-graph file.
 +
+* With the `--input=none` option, behave as if `input=append` were
+given, but do not walk other packs to find additional commits.
+
+If none of the above options are given, then commits found in
+packfiles are specified.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 03d815e652..937b98e99e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,8 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
+	   "[--split[=<strategy>]] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|none>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -22,7 +23,8 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
+	   "[--split[=<strategy>]] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|none>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -31,7 +33,8 @@ enum commit_graph_input {
 	COMMIT_GRAPH_INPUT_REACHABLE     = (1 << 1),
 	COMMIT_GRAPH_INPUT_STDIN_PACKS   = (1 << 2),
 	COMMIT_GRAPH_INPUT_STDIN_COMMITS = (1 << 3),
-	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4)
+	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4),
+	COMMIT_GRAPH_INPUT_NONE          = (1 << 5)
 };
 
 static struct opts_commit_graph {
@@ -59,6 +62,8 @@ static int option_parse_input(const struct option *opt, const char *arg,
 		*to |= COMMIT_GRAPH_INPUT_STDIN_COMMITS;
 	else if (!strcmp(arg, "append"))
 		*to |= COMMIT_GRAPH_INPUT_APPEND;
+	else if (!strcmp(arg, "none"))
+		*to |= (COMMIT_GRAPH_INPUT_APPEND | COMMIT_GRAPH_INPUT_NONE);
 	else
 		die(_("unrecognized --input source, %s"), arg);
 	return 0;
@@ -211,6 +216,8 @@ static int graph_write(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.input & COMMIT_GRAPH_INPUT_APPEND)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
+	if (opts.input & COMMIT_GRAPH_INPUT_NONE)
+		flags |= COMMIT_GRAPH_WRITE_NO_INPUT;
 	if (opts.split)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
diff --git a/commit-graph.c b/commit-graph.c
index 02e6ad9d1f..a5d7624073 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -808,7 +808,8 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1;
+		 check_oids:1,
+		 no_input:1;
 
 	const struct split_commit_graph_opts *split_opts;
 };
@@ -1802,6 +1803,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
+	ctx->no_input = flags & COMMIT_GRAPH_WRITE_NO_INPUT ? 1 : 0;
 
 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1860,7 +1862,7 @@ int write_commit_graph(struct object_directory *odb,
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!ctx->no_input && !pack_indexes && !commit_hex)
 		fill_oids_from_all_packs(ctx);
 
 	close_reachable(ctx);
diff --git a/commit-graph.h b/commit-graph.h
index dadcc03808..dd8c00a2d8 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -81,7 +81,8 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
+	COMMIT_GRAPH_WRITE_NO_INPUT   = (1 << 4)
 };
 
 enum commit_graph_split_flags {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index dd74295885..296b5a9185 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -369,4 +369,30 @@ test_expect_success '--split=no-merge always writes an incremental' '
 	test_line_count = 2 $graphdir/commit-graph-chain
 '
 
+test_expect_success '--split=no-merge, --input=none writes nothing' '
+	test_when_finished rm -rf a graphs.before graphs.after &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list -1 HEAD~1 >a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	ls $graphdir/graph-*.graph >graphs.before &&
+	test_line_count = 1 $graphdir/commit-graph-chain &&
+	git commit-graph write --split --input=none &&
+	ls $graphdir/graph-*.graph >graphs.after &&
+	test_cmp graphs.before graphs.after
+'
+
+test_expect_success '--split=merge-all, --input=none merges the chain' '
+	test_when_finished rm -rf a b &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list -1 HEAD~1 >a &&
+	git rev-list -1 HEAD >b &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
+	test_line_count = 2 $graphdir/commit-graph-chain &&
+	git commit-graph write --split=merge-all --input=none &&
+	test_line_count = 1 $graphdir/commit-graph-chain
+'
+
 test_done
-- 
2.25.0.dirty
