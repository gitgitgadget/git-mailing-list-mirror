Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ABCC433E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AD023124
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oE9uO0Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgHFQrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgHFQpH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:45:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7AAC002142
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so10151477wmi.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=303SZoeGqCA0672IdnCKWTl2RMdleMaL49S3kRHa8CY=;
        b=oE9uO0Mt0t5TloYkjvoOMiKFdp9jk5j4TwOhbYZ1EOhrJyuSACQiJzq0pDOChhrxC6
         vhOmlo9A18qla20Ru3Tlo19sG3sIDTvBTGvawu0i83/3HQLm39FU0BOryEDeV4YovuX8
         7VyQsgIqQDdMBG2EJlfWCSh1j+xN3crlNWG+HhcXdB42IW+ps+N2THSli2vfT+oHhLwq
         x7PRWkpNrE7QzCEzfgPAMyJIvVbXHNwsqGUQaIFnalBamnFGZhk8xCrROAA6KX5tDtff
         UahxFMVhB9KKmF/zjdk9lWuJCoy7k+rgtdkscwoU0E40dXgrwMYfLw5hiyTKw17ceSdM
         ysDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=303SZoeGqCA0672IdnCKWTl2RMdleMaL49S3kRHa8CY=;
        b=nJF4T4xgt9ilwS1bTgpnJyo13lih5c8zuKx7R0XFkktgDLHSNUdjZ3H6DC0yaD1wwA
         yh6Z6hNbeYk7Gq1A2mpoXfpmE/wwINcxN3yHmXOCJRKTqdYb0Sh+X6OI4LfRwXkbTxit
         j4ETjs1DyHUiPktxOaLIN9S2ysHJtXqL54Ws66JVnQjhfegYux+8q9NNPGsEGomBLY2I
         osjbLjbSxKB7MpPvy1RZF9fYLh0GP3RwJHsDFq+Yf7dASi2MPr5bocnrQ/nT+LNXdeYJ
         +rgNXe5LtSFmBOOGqDR4WzZkf4hbO5lx8lP40HhBD5+zO69o5V77V7JynMIcsH+DOz2G
         vQUw==
X-Gm-Message-State: AOAM531edXdwubnln1K64T1U+kcfRbEChbmmy1nd+pCh3hKizhTCDUYi
        I/C+ufGiRUk5rVdNx6ECN5bfXrkn
X-Google-Smtp-Source: ABdhPJxzWm4GGCV8rrDC4OHeKMRI8H4AXXwSAuel2TMtc2Uj31/0Ii7ns3Zgh8kYLQYp81DzVSxN0g==
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr8276889wmt.44.1596728928031;
        Thu, 06 Aug 2020 08:48:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm6880784wrj.94.2020.08.06.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:47 -0700 (PDT)
Message-Id: <902b742032ae19087392538936cc81768a59e0e1.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:35 +0000
Subject: [PATCH 05/11] maintenance: add commit-graph task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The first new task in the 'git maintenance' builtin is the
'commit-graph' job. It is based on the sequence of events in the
'commit-graph' job in Scalar [1]. This sequence is as follows:

1. git commit-graph write --reachable --split
2. git commit-graph verify --shallow
3. If the verify succeeds, stop.
4. Delete the commit-graph-chain file.
5. git commit-graph write --reachable --split

By writing an incremental commit-graph file using the "--split"
option we minimize the disruption from this operation. The default
behavior is to merge layers until the new "top" layer is less than
half the size of the layer below. This provides quick writes most
of the time, with the longer writes following a power law
distribution.

Most importantly, concurrent Git processes only look at the
commit-graph-chain file for a very short amount of time, so they
will verly likely not be holding a handle to the file when we try
to replace it. (This only matters on Windows.)

If a concurrent process reads the old commit-graph-chain file, but
our job expires some of the .graph files before they can be read,
then those processes will see a warning message (but not fail).
This could be avoided by a future update to use the --expire-time
argument when writing the commit-graph.

By using 'git commit-graph verify --shallow' we can ensure that
the file we just wrote is valid. This is an extra safety precaution
that is faster than our 'write' subcommand. In the rare situation
that the newest layer of the commit-graph is corrupt, we can "fix"
the corruption by deleting the commit-graph-chain file and rewrite
the full commit-graph as a new one-layer commit graph. This does
not completely prevent _that_ file from being corrupt, but it does
recompute the commit-graph by parsing commits from the object
database. In our use of this step in Scalar and VFS for Git, we
have only seen this issue arise because our microsoft/git fork
reverted 43d3561 ("commit-graph write: don't die if the existing
graph is corrupt" 2019-03-25) for a while to keep commit-graph
writes very fast. We dropped the revert when updating to v2.23.0.
The verify still has potential for catching corrupt data across
the layer boundary: if the new file has commit X with parent Y
in an old file but the commit ID for Y in the old file had a
bitswap, then we will notice that in the 'verify' command.

[1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/CommitGraphStep.cs

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 18 +++++++++
 builtin/gc.c                      | 63 +++++++++++++++++++++++++++++++
 commit-graph.c                    |  8 ++--
 commit-graph.h                    |  1 +
 t/t7900-maintenance.sh            |  2 +
 5 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 089fa4cedc..35b0be7d40 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -35,6 +35,24 @@ run::
 TASKS
 -----
 
+commit-graph::
+	The `commit-graph` job updates the `commit-graph` files incrementally,
+	then verifies that the written data is correct. If the new layer has an
+	issue, then the chain file is removed and the `commit-graph` is
+	rewritten from scratch.
++
+The verification only checks the top layer of the `commit-graph` chain.
+If the incremental write merged the new commits with at least one
+existing layer, then there is potential for on-disk corruption being
+carried forward into the new file. This will be noticed and the new
+commit-graph file will be clean as Git reparses the commit data from
+the object database.
++
+The incremental write is safe to run alongside concurrent Git processes
+since it will not expire `.graph` files that were in the previous
+`commit-graph-chain` file. They will be deleted by a later run based on
+the expiration delay.
+
 gc::
 	Cleanup unnecessary files and optimize the local repository. "GC"
 	stands for "garbage collection," but this task performs many
diff --git a/builtin/gc.c b/builtin/gc.c
index 150dce4301..3b7b914d60 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,6 +710,64 @@ struct maintenance_opts {
 	int quiet;
 };
 
+static int run_write_commit_graph(struct maintenance_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "commit-graph", "write",
+		     "--split", "--reachable", NULL);
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	return !!run_command(&child);
+}
+
+static int run_verify_commit_graph(struct maintenance_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "commit-graph", "verify",
+		     "--shallow", NULL);
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	return !!run_command(&child);
+}
+
+static int maintenance_task_commit_graph(struct maintenance_opts *opts)
+{
+	struct repository *r = the_repository;
+	char *chain_path;
+
+	close_object_store(r->objects);
+	if (run_write_commit_graph(opts)) {
+		error(_("failed to write commit-graph"));
+		return 1;
+	}
+
+	if (!run_verify_commit_graph(opts))
+		return 0;
+
+	warning(_("commit-graph verify caught error, rewriting"));
+
+	chain_path = get_commit_graph_chain_filename(r->objects->odb);
+	if (unlink(chain_path)) {
+		UNLEAK(chain_path);
+		die(_("failed to remove commit-graph at %s"), chain_path);
+	}
+	free(chain_path);
+
+	if (!run_write_commit_graph(opts))
+		return 0;
+
+	error(_("failed to rewrite commit-graph"));
+	return 1;
+}
+
 static int maintenance_task_gc(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -738,6 +796,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_GC,
+	TASK_COMMIT_GRAPH,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -749,6 +808,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_gc,
 		1,
 	},
+	[TASK_COMMIT_GRAPH] = {
+		"commit-graph",
+		maintenance_task_commit_graph,
+	},
 };
 
 static int maintenance_run(struct maintenance_opts *opts)
diff --git a/commit-graph.c b/commit-graph.c
index 1af68c297d..9705d237e4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -172,7 +172,7 @@ static char *get_split_graph_filename(struct object_directory *odb,
 		       oid_hex);
 }
 
-static char *get_chain_filename(struct object_directory *odb)
+char *get_commit_graph_chain_filename(struct object_directory *odb)
 {
 	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
 }
@@ -521,7 +521,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct stat st;
 	struct object_id *oids;
 	int i = 0, valid = 1, count;
-	char *chain_name = get_chain_filename(odb);
+	char *chain_name = get_commit_graph_chain_filename(odb);
 	FILE *fp;
 	int stat_res;
 
@@ -1619,7 +1619,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_chain_filename(ctx->odb);
+		char *lock_name = get_commit_graph_chain_filename(ctx->odb);
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
@@ -1996,7 +1996,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time = ctx->split_opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_chain_filename(ctx->odb);
+		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
diff --git a/commit-graph.h b/commit-graph.h
index 28f89cdf3e..3c202748c3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -25,6 +25,7 @@ struct commit;
 struct bloom_filter_settings;
 
 char *get_commit_graph_filename(struct object_directory *odb);
+char *get_commit_graph_chain_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
 /*
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 7b63b4ec0c..384294d111 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -4,6 +4,8 @@ test_description='git maintenance builtin'
 
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH=0
+
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance run" err
-- 
gitgitgadget

