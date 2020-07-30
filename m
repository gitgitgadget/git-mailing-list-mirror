Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0975C433E4
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C5820829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX/cBJTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgG3WYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgG3WYo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC67C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so5204967wmc.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FO6eJ897hgJYdcvr8miOENffZqXcaswZeSgSb+9MS5w=;
        b=CX/cBJTWG1jtRk54auIH0BdPoqN/AXTOQL7FkLv42E5MeT55OrERSt6LDiNc42Ae5w
         4B0ZiNtYtGSH3l2ltwI9jQWSssomnMCRiEvT/abvKt+Kh0ARhVF2P1SUeLic/DhVB6x5
         JBI1NN+4ygM8okxVNYz3X2uujC2OwRtJO1Mb61MtrhlwxAtzh/Hyb+ViDHqC+qdflF7M
         yJTOM1F+GUqBEuWk3KAt+43QmowjNdJGws1DDz/Fir9VjhUguaXox4arX7oXbKmgWJEx
         vrGsXlYbuJS7yTOnD8VsGQBsRP/vYPWpQa06O22Isthfee7M0R35SUL/XYXuUW120ENR
         PbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FO6eJ897hgJYdcvr8miOENffZqXcaswZeSgSb+9MS5w=;
        b=FhD6Rf2rOHb+08L6KzGfwKg523pX9OfG1pItd0VV0etiZ80P4pJo2p1ThikG0GKHPp
         Z2Hawlw4GJD7pnZCiuHCvlCUFG35bVdCDMQr9dXA3ZvtRU/Dj/ivwASdqECdVKWjT6Et
         YiLAQy5mMHxQrWF0CcdHRgld3Yy8dO8DIQMZIeRbO5jiAQmuByuaKi41jT98bUFIepbB
         Kn3aVMKQrDmNU0zs1fxRUHcjy6WG6q5GmG7ma0ifglcTPmnEaEVqwOU8XQPTgQ0LML2u
         bzUHC5eemb/8frJGc4gBEDJeNIVboAfpuGQI70r1lN+t11xX0PksaPQFtstKe2SGn/aY
         GQkw==
X-Gm-Message-State: AOAM531zQU4ay9hsF5DtbgTCRJpofaC+MAMLl/+UbIBQ8ehqN9blnVV6
        9P83sX6fyGnkgCs9BP9CysZ9ZJA3
X-Google-Smtp-Source: ABdhPJz1Cjay5KLPRwQ1W52pUiiX7d3Yr/4Z11xyE78hBVosz++1QcnQ1RMLNqPtpYwSRcFPrmxm3w==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr1203518wmt.26.1596147882456;
        Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm10948361wme.34.2020.07.30.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:41 -0700 (PDT)
Message-Id: <a4d9836bed9a08f4ba716240a6fc18d5f13da3dc.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:11 +0000
Subject: [PATCH v3 05/20] maintenance: add commit-graph task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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
index 0f15162825..ec1bbc3f9e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,6 +710,64 @@ static struct maintenance_opts {
 	int quiet;
 } opts;
 
+static int run_write_commit_graph(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "commit-graph", "write",
+		     "--split", "--reachable", NULL);
+
+	if (opts.quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	return !!run_command(&child);
+}
+
+static int run_verify_commit_graph(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "commit-graph", "verify",
+		     "--shallow", NULL);
+
+	if (opts.quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	return !!run_command(&child);
+}
+
+static int maintenance_task_commit_graph(void)
+{
+	struct repository *r = the_repository;
+	char *chain_path;
+
+	close_object_store(r->objects);
+	if (run_write_commit_graph()) {
+		error(_("failed to write commit-graph"));
+		return 1;
+	}
+
+	if (!run_verify_commit_graph())
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
+	if (!run_write_commit_graph())
+		return 0;
+
+	error(_("failed to rewrite commit-graph"));
+	return 1;
+}
+
 static int maintenance_task_gc(void)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -736,6 +794,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_GC,
+	TASK_COMMIT_GRAPH,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -747,6 +806,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_gc,
 		1,
 	},
+	[TASK_COMMIT_GRAPH] = {
+		"commit-graph",
+		maintenance_task_commit_graph,
+	},
 };
 
 static int maintenance_run(void)
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
index f08eee0977..ff646abf7c 100755
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

