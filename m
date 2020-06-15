Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D0C433E2
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C98206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baYIclXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgFOUPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgFOUPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:15:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so855975wmh.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nFTfp9uCai7drT+aI7Cl9xtfPYT/4nUUAPnK1JhawJs=;
        b=baYIclXf/XwyJRoxbb1EhcR9fJVLTDmvP1vChF9O4cWeP6dWMe2/QxiChqXeahwqiv
         WOM+NAkTuMMH3MDKRqEZpZHsFutbj1p68RFVR479uNTbDE7szwCpmwX77sghFmg00bjo
         IOBEXkQXOxx53BFsn/HoWiL6zwbeNYnQSAL8F1TaRU806BHxO8y6y0Zn/wSmuNaC8jYV
         lzAhXMaNo2Xss00A/UU5U4Vw9iCoEQbi5r653XBtn+KJS6LS19PkeX86hvl73DOdNy7L
         V/XT+pNw94U2OX270U4I6aZ6CHUy+M59+2WEj0e5TYpa95Rt1A0zjftcayG3gI3NPq5w
         th/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nFTfp9uCai7drT+aI7Cl9xtfPYT/4nUUAPnK1JhawJs=;
        b=BcXf/QdMVRiAoxWNq72jHJPkfh/nSY8JNaqrytwHg9GWERqELD7DYoSoMYdZsn4WPM
         m8/QLqEXkGxyLRptdaQx7453TkpkKf9M0ix8YZBi/D9je6USgp/jl4cM/eqGs405xPK9
         nU93fz8CxxhIt03dBtsEvlDn3Iaf2uxhtiE87ofX5+1CpMCGe6Gu8/TEE/NHdDpna6Eb
         /2qhZvJnFE2xRth5rcfAqIBcYCh/BQOUHplClpUBHk4xtPSnORSqH/L/Nqk5WM+lCV34
         E6fVRwOcw/pLbnGup0Gt4Ia7BDej36L2SyIR/8q7/45yB5rZsl4hqKnTYoSkqUCKn6Ax
         wKNg==
X-Gm-Message-State: AOAM533mCyg/kwchLGesqfjbHhx/X+Sddww1THEnuTrCux97Re317NF4
        kwZt3qnr6OvkmXNNmk0hxInCmYRk
X-Google-Smtp-Source: ABdhPJwytdDBGZbNAZNagdotj5VQEAJ7sdEP61WZLFEBRfxYQsQuiZc8zbdkmB69NwH14Wa4NRNKGg==
X-Received: by 2002:a1c:230a:: with SMTP id j10mr1009784wmj.124.1592252101593;
        Mon, 15 Jun 2020 13:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm25648012wrm.35.2020.06.15.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:15:01 -0700 (PDT)
Message-Id: <db5b8fe843951a13b791841772f480f839bd1db5.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:53 +0000
Subject: [PATCH 8/8] commit-graph: persist existence of changed-paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters were released in v2.27.0, but have a
significant drawback. A user can opt-in to writing the changed-path
filters using the "--changed-paths" option to "git commit-graph write"
but the next write will drop the filters unless that option is
specified.

This becomes even more important when considering the interaction with
gc.writeCommitGraph (on by default) or fetch.writeCommitGraph (part of
features.experimental). These config options trigger commit-graph writes
that the user did not signal, and hence there is no --changed-paths
option available.

Allow a user that opts-in to the changed-path filters to persist the
property of "my commit-graph has changed-path filters" automatically. A
user can drop filters using the --no-changed-paths option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  5 ++++-
 builtin/commit-graph.c             |  5 ++++-
 commit-graph.c                     | 12 +++++++++++-
 commit-graph.h                     |  1 +
 t/t4216-log-bloom.sh               |  2 +-
 5 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index f4b13c005b8..369b222b08b 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -60,7 +60,10 @@ existing commit-graph file.
 With the `--changed-paths` option, compute and write information about the
 paths changed between a commit and it's first parent. This operation can
 take a while on large repositories. It provides significant performance gains
-for getting history of a directory or a file with `git log -- <path>`.
+for getting history of a directory or a file with `git log -- <path>`. If
+this option is given, future commit-graph writes will automatically assume
+that this option was intended. Use `--no-changed-paths` to stop storing this
+data.
 +
 With the `--split` option, write the commit-graph as a chain of multiple
 commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 59009837dc9..ff7b177c337 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -151,6 +151,7 @@ static int graph_write(int argc, const char **argv)
 	};
 
 	opts.progress = isatty(2);
+	opts.enable_changed_paths = -1;
 	split_opts.size_multiple = 2;
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
@@ -171,7 +172,9 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
-	if (opts.enable_changed_paths ||
+	if (!opts.enable_changed_paths)
+		flags |= COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS;
+	if (opts.enable_changed_paths == 1 ||
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
diff --git a/commit-graph.c b/commit-graph.c
index 3a64e3b382d..04eea725232 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1996,9 +1996,19 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
-	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
 	ctx->total_bloom_filter_data_size = 0;
 
+	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
+		ctx->changed_paths = 1;
+	else if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
+		prepare_commit_graph_one(ctx->r, ctx->odb);
+
+		/* We have changed-paths already. Keep them in the next graph */
+		if (ctx->r->objects->commit_graph &&
+		    ctx->r->objects->commit_graph->chunk_bloom_data)
+			ctx->changed_paths = 1;
+	}
+
 	if (ctx->split) {
 		struct commit_graph *g;
 		prepare_commit_graph(ctx->r);
diff --git a/commit-graph.h b/commit-graph.h
index f0fb13e3f28..45b1e5bca39 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -96,6 +96,7 @@ enum commit_graph_write_flags {
 	/* Make sure that each OID in the input is a valid commit OID. */
 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
 	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
+	COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS = (1 << 5),
 };
 
 struct split_commit_graph_opts {
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c13b97d3bda..30c8d9562e8 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -126,7 +126,7 @@ test_expect_success 'setup - add commit-graph to the chain without Bloom filters
 	test_commit c14 A/anotherFile2 &&
 	test_commit c15 A/B/anotherFile2 &&
 	test_commit c16 A/B/C/anotherFile2 &&
-	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0 git commit-graph write --reachable --split &&
+	git commit-graph write --reachable --split --no-changed-paths &&
 	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
 '
 
-- 
gitgitgadget
