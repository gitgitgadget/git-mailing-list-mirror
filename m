Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EADC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 07:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAAA2067D
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 07:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDbCPN3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgGaHt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgGaHt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 03:49:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6602C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 00:49:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so27069807wrh.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ntcl7Lv6riesZ3iPi8+UfDPlbwO6dwnD+Up6RuhTATw=;
        b=lDbCPN3/IutzH8OQxiAuRO4xLMXjG/KXo9lfqqW2iiSs5sWLAcNeXHdR7FiQ0fouZt
         Qo5f2I6RYTuhQOpl/uQc+cA/8zeuJKw6iN4UB5C3q1WH6ClBLzaGCnTkheVQgy4pnFKZ
         5lfLCkAVFoLcsjdvFTXlFw/vxk7JkejYKIhvoPvEbvlgwG/C/qAIedlP+H1oFzKe4Mnc
         IZiXp1yZQdXFWIcu5ERV5XXWhgQglD2PVkNlMauqbso41NNEoQhcj5CeTy8CaBPji5Rn
         /C2SUqHLd/FsUJ50r3y7poBCToqC5TICbi9ZkL3zJ+pR3rvZ0fksYxDbQAMPFkW42qzp
         uqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ntcl7Lv6riesZ3iPi8+UfDPlbwO6dwnD+Up6RuhTATw=;
        b=emZg9wGmM5PqfkSRm5tnnZGBN5xQs8B6xVtqw0UQY8DHEZTVsOdjq/TolWa4Buixf/
         n/d54OqGyRRZGJhV6jEatVD1PUpqUvX1xR9dLm8EhrZgw5RC/tLBrKk3geEnb1JQWKMm
         kLbpB+gxQSQrGhnEZDCneyPGDAMc88nhMBRStgrpJMntznbhvh9BK5vxTCBtobygaoMt
         KYi+ZZBa4NyXmsIKLwk10B3ToQBYD2b8LyCXpul+rZQCluc8mo/a4dgj4opHiDiPx6xv
         QhDmsN5Qqc51kmVOmsU995w40DLJZPmbA4JjRZMtJcKKNzdy9DzxInzEorDBFTcygvl9
         zrRQ==
X-Gm-Message-State: AOAM5330nImoIhYm9zhAt6Kt0vQdrCDtnpMO1tO9vc+7j/entLClHjdj
        ZksiNd+PT6qIPHcAKUmcJgXxfJVt
X-Google-Smtp-Source: ABdhPJwBz8bC67paTJW+B2Cif3z67GQTjMkV1KdmlypU+rc5Rr5ZZZYRLhuiJwFrutZ+GFIujcQ4Ag==
X-Received: by 2002:a5d:54ca:: with SMTP id x10mr2275510wrv.36.1596181766287;
        Fri, 31 Jul 2020 00:49:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm12271527wrt.41.2020.07.31.00.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 00:49:25 -0700 (PDT)
Message-Id: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 07:49:25 +0000
Subject: [PATCH] commit-graph: add verify changed paths option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Son Luong Ngoc <sluongng@gmail.com>

Add '--has-changed-paths' option to 'git commit-graph verify' subcommand
to validate whether the commit-graph was written with '--changed-paths'
option.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
    Commit-Graph: Verify bloom filter
    
    When I was working on git-care(1) and Gitaly(2), the need to check
    whether a commit-graph (split or non-split) were built with Bloom
    filter. This is needed especially when a repository primary commit-graph
    write strategy is '--split' and the bottom chains might rarely be
    re-written (or never) thus Bloom filter is never applied to the graph.
    
    Provides users with a straight forward way to validate the existence of
    Bloom filter chunks to save user having to read the commit-graph
    manually as show in (1) and (2).
    
    References:
    
     1. https://github.com/sluongng/git-care/commit/d0feaa381ea3ec7b0e617c6596ad6e3cf16b884a
     2. https://gitlab.com/sluongng/gitaly/-/commit/78dba8b73e720b11500482b19b755346ec853025
    
    
    ------------------------------------------------------------------------
    
    It's probably going to take me a bit more time to write up some tests
    for this, so I want to send it out first for comments.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-687%2Fsluongng%2Fsluongngoc%2Fverify-bloom-filter-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-687/sluongng/sluongngoc/verify-bloom-filter-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/687

 builtin/commit-graph.c | 12 +++++++++---
 commit-graph.c         | 22 +++++++++++++++++-----
 commit-graph.h         | 12 +++++++++---
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 16c9f6101a..ce8a7cbe90 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -18,7 +18,8 @@ static char const * const builtin_commit_graph_usage[] = {
 };
 
 static const char * const builtin_commit_graph_verify_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] "
+	    "[--has-changed-paths] [--[no-]progress]"),
 	NULL
 };
 
@@ -37,6 +38,7 @@ static struct opts_commit_graph {
 	int append;
 	int split;
 	int shallow;
+	int has_changed_paths;
 	int progress;
 	int enable_changed_paths;
 } opts;
@@ -71,12 +73,14 @@ static int graph_verify(int argc, const char **argv)
 	int open_ok;
 	int fd;
 	struct stat st;
-	int flags = 0;
+	enum commit_graph_verify_flags flags = 0;
 
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			   N_("dir"),
 			   N_("The object directory to store the graph")),
+		OPT_BOOL(0, "has-changed-paths", &opts.has_changed_paths,
+			 N_("verify that the commit-graph includes changed paths")),
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
@@ -94,8 +98,10 @@ static int graph_verify(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.shallow)
 		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
+	if (opts.has_changed_paths)
+		flags |= COMMIT_GRAPH_VERIFY_CHANGED_PATHS;
 	if (opts.progress)
-		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+		flags |= COMMIT_GRAPH_VERIFY_PROGRESS;
 
 	odb = find_odb(the_repository, opts.obj_dir);
 	graph_name = get_commit_graph_filename(odb);
diff --git a/commit-graph.c b/commit-graph.c
index 1af68c297d..d83f5a2325 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -250,7 +250,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
 	return ret;
 }
 
-static int verify_commit_graph_lite(struct commit_graph *g)
+static int verify_commit_graph_lite(struct commit_graph *g, int verify_changed_path)
 {
 	/*
 	 * Basic validation shared between parse_commit_graph()
@@ -276,6 +276,16 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 		error("commit-graph is missing the Commit Data chunk");
 		return 1;
 	}
+	if (verify_changed_path) {
+		if (!g->chunk_bloom_indexes) {
+			error("commit-graph is missing Bloom Index chunk");
+			return 1;
+		}
+		if (!g->chunk_bloom_data) {
+			error("commit-graph is missing Bloom Data chunk");
+			return 1;
+		}
+	}
 
 	return 0;
 }
@@ -439,7 +449,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 
 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
 
-	if (verify_commit_graph_lite(graph))
+	if (verify_commit_graph_lite(graph, 0))
 		goto free_and_return;
 
 	return graph;
@@ -2216,7 +2226,9 @@ static void graph_report(const char *fmt, ...)
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
+int verify_commit_graph(struct repository *r,
+			struct commit_graph *g,
+			enum commit_graph_verify_flags flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid, checksum;
@@ -2231,7 +2243,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		return 1;
 	}
 
-	verify_commit_graph_error = verify_commit_graph_lite(g);
+	verify_commit_graph_error = verify_commit_graph_lite(g, flags & COMMIT_GRAPH_VERIFY_CHANGED_PATHS);
 	if (verify_commit_graph_error)
 		return verify_commit_graph_error;
 
@@ -2284,7 +2296,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
-	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
+	if (flags & COMMIT_GRAPH_VERIFY_PROGRESS)
 		progress = start_progress(_("Verifying commits in commit graph"),
 					g->num_commits);
 
diff --git a/commit-graph.h b/commit-graph.h
index 28f89cdf3e..29c01b5000 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -94,6 +94,12 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3),
 };
 
+enum commit_graph_verify_flags {
+	COMMIT_GRAPH_VERIFY_SHALLOW       = (1 << 0),
+	COMMIT_GRAPH_VERIFY_CHANGED_PATHS = (1 << 1),
+	COMMIT_GRAPH_VERIFY_PROGRESS      = (1 << 2),
+};
+
 enum commit_graph_split_flags {
 	COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
 	COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 1,
@@ -122,9 +128,9 @@ int write_commit_graph(struct object_directory *odb,
 		       enum commit_graph_write_flags flags,
 		       const struct split_commit_graph_opts *split_opts);
 
-#define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
-
-int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
+int verify_commit_graph(struct repository *r,
+			struct commit_graph *g,
+			enum commit_graph_verify_flags flags);
 
 void close_commit_graph(struct raw_object_store *);
 void free_commit_graph(struct commit_graph *);

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
