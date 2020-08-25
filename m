Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4040BC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FB02071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IshS51jV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHYSeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYSd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BBC0613ED
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so13854135wrm.6
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DYDzdATbEtsle88tIWHcnPVQI2YF/b2jAlzqwzreowg=;
        b=IshS51jVytdvJ6hgPu1aYhBxsWZfeciZO0NUmGjvFVGJ4R9tXuIFe2ZczpQcPq0b1a
         pfXsI1Xrf4VLZtyBSx3lTSRwEm11sDKsjdz4x4oMfFpquNGaDwJQfKzCk90bIa9fxofV
         S4QWwtHyU6tma0MI5AgHa7BD820XX4oJAA8CQvuRPxJPXso5xSeatgqCczOtdHc9zKGi
         KpPgaNS2qZ2Rd4J2tPf+fJuLHr2X/ijsMLsoIF2OL8/6IgbjeYJbvgoXOf2R0u0ZFATL
         zhm8BfTWm9EOEq1YH2IbyBdCXG2olqU0k7UQLDHV4GS1V4+3HMxhZ5E6hpRU1Cw1ZcaR
         hhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DYDzdATbEtsle88tIWHcnPVQI2YF/b2jAlzqwzreowg=;
        b=VpEvG1C6oSbQXwbJhIcgW23wVGF0r9VcIgdqZm2LEwUfcXBJ9kmCq2MMluvmbbeOBa
         l2LcR+7WMYWZmQ9pgyPKiU31bwAnqtAU+/qjsA1KWKYzLTtdUwwkY5+uBqDHQssv7xd5
         nqQsj2KsJ8vyhLUwvrLuGU0PcTXcjiVNVLQ9+NjWkMbUwKWXt1UGAr/vxiPp8FbXckSR
         RewCP1cdZiwZ4BXGKSrSHVTeQ2+nqQjfyIio9ySY2FXjy/W4GaFeWN4OlpbORSV41xoa
         IhOppTejIfydG7t5K+Bguyfk/EZasTzL62IEw040PJs3m6iuYzqGulteFrfl7Tnq7+Bt
         l1ww==
X-Gm-Message-State: AOAM5324ZrmBiYxSFkV/VB3FZ8bhuwIPX1BijmqETOgW0O0YpFs8NPy+
        3UqgWE0Vfd+jN3GlQR/TzMI0I97H0vM=
X-Google-Smtp-Source: ABdhPJyF3wsTu+UDWsRmOBhlnIenNJW7ySrFT4c2iqCS1106+EAOU3jaxdKiYKHW2y5isjaefGtiVQ==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr8674867wrv.212.1598380433176;
        Tue, 25 Aug 2020 11:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm7615870wmj.14.2020.08.25.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:52 -0700 (PDT)
Message-Id: <06984a42bfc892b82f7b39a1aa366158fcf3fd20.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:40 +0000
Subject: [PATCH v3 05/11] maintenance: add commit-graph task
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
index 81643515e5..16e567992e 100644
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
index 47d512464c..c0c4e6846e 100755
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

