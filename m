Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8BAC433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2A320771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpYWoDxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGGOVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgGGOVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0DBC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so46739858wmf.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BWMSOA3bUbpVVfYgI613510ZMBUh6U6Jqosu3zla9Y8=;
        b=EpYWoDxHyK3OtD0Ht77exFPnEMGLP5V5S24yzNSSLlIZ/4E3eQwxUsq9vCZhXiuvyG
         yWrf/Z4FbIxNulo6bq2EmzEw3dtYiinXS6bVxHH6ewPHWV7tWGUnyLirO3Vx8IIe0Ub9
         kmHPGjElrsEXYPhtUfe1X0YZ09HuwnT2eUdTcYgFy7ylcXxDYNRePmPwu4EV3LEErJLl
         lzBxOPdvzv4se59BlovHdsXXmOZZVP/+aJq4QAPWYoAB5umbEkp4bax5JLedSvoazLQR
         bUJ9K5KIOqYV2/pwRYFT/Cmy1RJIcOk3boTsGhif4YKk9GCtQQgHdPmtfI9iNFol4lrh
         2WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BWMSOA3bUbpVVfYgI613510ZMBUh6U6Jqosu3zla9Y8=;
        b=kDPE377A/PrFIxnlgHM4h9jvooLDIt4vZfrOOYOatueZs7gofrIcvYA65If+2xhmU/
         uWHO2qmuBZu/SZTSeS1EP/vtq+xl9ACJv5syIkUKYpc7m1w+i9Xp4NlEZuBnaxktfaaM
         kDAuwxWRabNMDfih6yH6+bylRsXwP4fLcelcqRwEsuN6tn7ULjQ0TNop68hKd0847965
         X5m1yv7rNc3mR2lQsN8YxVhNcsyyg8s/TXsJGq6W3TIWzFVPdQ52ZsPosg+E/gmfa1ck
         BZ5vDPB+HBmVaGbSgHJf3VApuC/p1IwFEALDC7aSG6UK2cARxj6rwUT9YD6mhyjeqkUS
         l3sg==
X-Gm-Message-State: AOAM5332BMsQUUz0RapYaxxqcMoTi+jSClkZzwUt+Isid5+5oUQEFYGv
        pF13ufq/E4ONh5WBygXc3t7OgLhk
X-Google-Smtp-Source: ABdhPJz+UVOEbfBdo0L/ed//ucY1rTGGXMXwHWTTCDKCWAVQViiXwZy4GVBf14YAIt5TRaSC8oDvcg==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr4425065wmc.32.1594131704216;
        Tue, 07 Jul 2020 07:21:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm1323418wru.9.2020.07.07.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:43 -0700 (PDT)
Message-Id: <c8fbd14d41093e12905027ff628b98652cd931d0.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:23 +0000
Subject: [PATCH 09/21] maintenance: add commit-graph task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
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
 Documentation/git-maintenance.txt | 18 ++++++++
 builtin/gc.c                      | 76 ++++++++++++++++++++++++++++++-
 commit-graph.c                    |  8 ++--
 commit-graph.h                    |  1 +
 t/t7900-maintenance.sh            |  2 +-
 5 files changed, 99 insertions(+), 6 deletions(-)

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
index c143bf50df..a6b080627f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -705,7 +705,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-#define MAX_NUM_TASKS 1
+#define MAX_NUM_TASKS 2
 
 static const char * const builtin_maintenance_usage[] = {
 	N_("git maintenance run [<options>]"),
@@ -717,6 +717,76 @@ struct maintenance_opts {
 	int quiet;
 } opts;
 
+static int run_write_commit_graph(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&cmd, "-C", r->worktree,
+			 "commit-graph", "write",
+			 "--split", "--reachable",
+			 NULL);
+
+	if (opts.quiet)
+		argv_array_pushl(&cmd, "--no-progress", NULL);
+
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	argv_array_clear(&cmd);
+
+	return result;
+}
+
+static int run_verify_commit_graph(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&cmd, "-C", r->worktree,
+			 "commit-graph", "verify",
+			 "--shallow", NULL);
+
+	if (opts.quiet)
+		argv_array_pushl(&cmd, "--no-progress", NULL);
+
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	argv_array_clear(&cmd);
+
+	return result;
+}
+
+static int maintenance_task_commit_graph(struct repository *r)
+{
+	char *chain_path;
+
+	/* Skip commit-graph when --auto is specified. */
+	if (opts.auto_flag)
+		return 0;
+
+	close_object_store(r->objects);
+	if (run_write_commit_graph(r)) {
+		error(_("failed to write commit-graph"));
+		return 1;
+	}
+
+	if (!run_verify_commit_graph(r))
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
+	if (!run_write_commit_graph(r))
+		return 0;
+
+	error(_("failed to rewrite commit-graph"));
+	return 1;
+}
+
 static int maintenance_task_gc(struct repository *r)
 {
 	int result;
@@ -790,6 +860,10 @@ static void initialize_tasks(void)
 	tasks[num_tasks]->enabled = 1;
 	num_tasks++;
 
+	tasks[num_tasks]->name = "commit-graph";
+	tasks[num_tasks]->fn = maintenance_task_commit_graph;
+	num_tasks++;
+
 	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
 
 	for (i = 0; i < num_tasks; i++) {
diff --git a/commit-graph.c b/commit-graph.c
index fdd1c4fa7c..57278a9ab5 100644
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
@@ -520,7 +520,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct stat st;
 	struct object_id *oids;
 	int i = 0, valid = 1, count;
-	char *chain_name = get_chain_filename(odb);
+	char *chain_name = get_commit_graph_chain_filename(odb);
 	FILE *fp;
 	int stat_res;
 
@@ -1635,7 +1635,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_chain_filename(ctx->odb);
+		char *lock_name = get_commit_graph_chain_filename(ctx->odb);
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
@@ -2012,7 +2012,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
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
index e4e4036e50..216ac0b19e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -12,7 +12,7 @@ test_expect_success 'help text' '
 	test_i18ngrep "usage: git maintenance run" err
 '
 
-test_expect_success 'gc [--auto|--quiet]' '
+test_expect_success 'run [--auto|--quiet]' '
 	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run --no-quiet &&
 	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
 	GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
-- 
gitgitgadget

