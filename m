Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8316BC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8B521973
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHv9uLie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIQSN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3EC061353
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3048075wrp.8
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lfbHJbIos3zMffZlHVdVDJP4JsuaHqeN2aDjXEqImOw=;
        b=IHv9uLieB/dBq67dxKkFPS/cuGehQYVHMzI6Sk4D+dDnPQ5SHgjXAAvlJe2MjDA5Ln
         DddgPlyytrG2LQ3lPTyUDtG6Mf97+S57aQ9fpmGzfGaXfkoNC7NSKCrIPe93vu7aSwTV
         Tx0RrN5ScPHj9EoTHnrr7XXWfQrbLrcfi88mS0TdxsbsLk83s2Cs2mu3j03LWgqnO8G5
         VZJsLx8EQLUGUIIMEnpC2TAQj2AoOwh0UFNvK8VG+QN6im5caarHD5JZXjAW/Z6kuRt4
         Zybt6ibGCqWUO4S/Ee+BYyaI7CdPhzd7sM8QY5A8ih+hr4D0uJRqSWFCefB79sq0w+f4
         W6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lfbHJbIos3zMffZlHVdVDJP4JsuaHqeN2aDjXEqImOw=;
        b=t9dI6PikoMQnjh9gGEEqwmUSxEChJ6RjTiQSXIRI9R3PSbGHzUNTFH+GRiYt5JhbBu
         yJbBv9S5attR3KGMryCXj4wanZqDdJThTAfaKjEuZ+bNlSN/MBKFrz/dqZs2e3kqNAO4
         suE+UnIReZ1ZEJENaMC7foeY1+Z5fCnEEEVo0RaiHxPvTv1ABSCNFljMpSmpYTkRuIRS
         B3xtv5a+eg3NS6HODG4B+X0FNzEleTKAErIqJkSaR2iiZiCSntpSs6HjYf6pQyVgrYOS
         +20PJS1+ylPeCJBH39OlShRr9XcSLvesdtEVFtxUKo6GnCbgykCpe2dI/2w5aFk+LO6v
         O93g==
X-Gm-Message-State: AOAM532bTJS78WR7DWzUVUWOi8y+KaHNWH82TXmlaKFCTWBjRi7VDkmr
        WZVEHlnstY/JAADcJ8pSuI6XSNBHugw=
X-Google-Smtp-Source: ABdhPJwYKW4JB1b97fIw4iIoLVdDOJ5aMNnQoCcZkdRNkU27fmf8yPsSMEN6PilntwLCZ3Sj17ONhA==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr33110574wrp.112.1600366318484;
        Thu, 17 Sep 2020 11:11:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u126sm524206wmu.9.2020.09.17.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:58 -0700 (PDT)
Message-Id: <8204ebbf8312b30ee8da38b73f0877cbe1865bcf.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:46 +0000
Subject: [PATCH v5 05/11] maintenance: add commit-graph task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The first new task in the 'git maintenance' builtin is the
'commit-graph' task. This updates the commit-graph file
incrementally with the command

	git commit-graph write --reachable --split

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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-maintenance.txt |  8 ++++++++
 builtin/gc.c                      | 30 ++++++++++++++++++++++++++++++
 commit-graph.c                    |  8 ++++----
 commit-graph.h                    |  1 +
 t/t7900-maintenance.sh            |  2 ++
 5 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 04fa0fe329..fc5dbcf0b9 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -35,6 +35,14 @@ run::
 TASKS
 -----
 
+commit-graph::
+	The `commit-graph` job updates the `commit-graph` files incrementally,
+	then verifies that the written data is correct. The incremental
+	write is safe to run alongside concurrent Git processes since it
+	will not expire `.graph` files that were in the previous
+	`commit-graph-chain` file. They will be deleted by a later run based
+	on the expiration delay.
+
 gc::
 	Clean up unnecessary files and optimize the local repository. "GC"
 	stands for "garbage collection," but this task performs many
diff --git a/builtin/gc.c b/builtin/gc.c
index 904fb2d9aa..86b807a008 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,6 +710,31 @@ struct maintenance_run_opts {
 	int quiet;
 };
 
+static int run_write_commit_graph(struct maintenance_run_opts *opts)
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
+static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
+{
+	close_object_store(the_repository->objects);
+	if (run_write_commit_graph(opts)) {
+		error(_("failed to write commit-graph"));
+		return 1;
+	}
+
+	return 0;
+}
+
 static int maintenance_task_gc(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -738,6 +763,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_GC,
+	TASK_COMMIT_GRAPH,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -749,6 +775,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_gc,
 		1,
 	},
+	[TASK_COMMIT_GRAPH] = {
+		"commit-graph",
+		maintenance_task_commit_graph,
+	},
 };
 
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
diff --git a/commit-graph.c b/commit-graph.c
index e51c91dd5b..a9b0db7d4a 100644
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
@@ -516,7 +516,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct stat st;
 	struct object_id *oids;
 	int i = 0, valid = 1, count;
-	char *chain_name = get_chain_filename(odb);
+	char *chain_name = get_commit_graph_chain_filename(odb);
 	FILE *fp;
 	int stat_res;
 
@@ -1668,7 +1668,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_chain_filename(ctx->odb);
+		char *lock_name = get_commit_graph_chain_filename(ctx->odb);
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
@@ -2038,7 +2038,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time = ctx->split_opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_chain_filename(ctx->odb);
+		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
diff --git a/commit-graph.h b/commit-graph.h
index 09a97030dc..765221cdcc 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -25,6 +25,7 @@ struct raw_object_store;
 struct string_list;
 
 char *get_commit_graph_filename(struct object_directory *odb);
+char *get_commit_graph_chain_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
 /*
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 5637053bf6..505a1b4d60 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -4,6 +4,8 @@ test_description='git maintenance builtin'
 
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH=0
+
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance run" err &&
-- 
gitgitgadget

