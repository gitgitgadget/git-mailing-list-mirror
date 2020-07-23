Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB38C433F2
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262BE206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIyrU8RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgGWR4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgGWR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E126C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so5740980wmi.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CUbjUytCK5g/a7uEnKFWBVCBMHu0YhuF13HTppvxZ8I=;
        b=GIyrU8RYYZsLDBYgOFdioa2krejG1mjK7L0sCC5OHLkxV0yfD4SPqlczINXs6HG7Je
         TzYyfYW85pBCP21gqhx9SmAYXoMUd2dmY4e4lINkELNFuzUywInl8zCx2Io20F6d9K1W
         VJCFUg43/LaR+ImsaU/KJStz/xYoE6z9b9E/Hy+d4wQhAUULXWANyG40kaUHcMEHy55U
         j+USialNehHXBD7F/pEqHg8vo1wFX7ANDX6mevJ6Ipa8kfBNq0u1Zo7FtCZLyEXbi0jL
         xBqnTRPuPKiCKTA74vJXlPYw7tK9ZP7ZqhoJl9mH00v+MpTYGw7buhahkvo2yO6vWDb1
         GKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CUbjUytCK5g/a7uEnKFWBVCBMHu0YhuF13HTppvxZ8I=;
        b=plW8WzdRaPGhsCvUnHzFzKRRLvR9Rl97eYMvuZpg2IvmwfmeVeVTxJX83uDcz6Ryf2
         2c86TPDdS2E7clJHbcdgqA59VyqsujwLsdvNGq51PUhhPQyycIEJ8ezxunO+gQHuqRgM
         2kqv29RJbeic3C20HhM3U/j9/FKY74F9kP1bnSPrP+KerQG91hERI3Cacf95yRNrvox6
         C94aNklhZf3nk8rII221OrL+eTMN9NrLbWq9uStRYlWcDgIX5H20jZZUOG2vasK/Dys7
         Qd3kveP4FM1Z1hhCGKsBresfnSWlCGlSAhoysGJLUL3HI+/6f9Y2R0Wyxok1GJgM9bY7
         z1Sg==
X-Gm-Message-State: AOAM533UhhmKsytJBD1va7rpsHWLRDG1PRGWG0g5MA2imipp0l4zgPCF
        tASp9ie636tiLGaBoU0uNlhilPZb
X-Google-Smtp-Source: ABdhPJz6wMRk+ghH8j5fxcNMXEx/PuCUpCnVBLnllMKRD5B5MenuGTgbiZMzHvvtNav6bCgOXkBb5g==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr4961242wmb.108.1595527007903;
        Thu, 23 Jul 2020 10:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm4681564wrs.77.2020.07.23.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:47 -0700 (PDT)
Message-Id: <a09b1c16874c0fad6dd0df3ace573a2ffe34519e.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:28 +0000
Subject: [PATCH v2 06/18] maintenance: add --task option
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

A user may want to only run certain maintenance tasks in a certain
order. Add the --task=<task> option, which allows a user to specify an
ordered list of tasks to run. These cannot be run multiple times,
however.

Here is where our array of maintenance_task pointers becomes critical.
We can sort the array of pointers based on the task order, but we do not
want to move the struct data itself in order to preserve the hashmap
references. We use the hashmap to match the --task=<task> arguments into
the task struct data.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  4 ++
 builtin/gc.c                      | 64 ++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            | 23 +++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 35b0be7d40..9204762e21 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -73,6 +73,10 @@ OPTIONS
 --quiet::
 	Do not report progress or other information over `stderr`.
 
+--task=<task>::
+	If this option is specified one or more times, then only run the
+	specified tasks in the specified order.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index 2cd17398ec..c58dea6fa5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,6 +710,7 @@ static const char * const builtin_maintenance_usage[] = {
 static struct maintenance_opts {
 	int auto_flag;
 	int quiet;
+	int tasks_selected;
 } opts;
 
 static int run_write_commit_graph(void)
@@ -804,20 +805,38 @@ typedef int maintenance_task_fn(void);
 struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
-	unsigned enabled:1;
+	int task_order;
+	unsigned enabled:1,
+		 selected:1;
 };
 
 static struct maintenance_task *tasks[MAX_NUM_TASKS];
 static int num_tasks;
 
+static int compare_tasks_by_selection(const void *a_, const void *b_)
+{
+	const struct maintenance_task *a, *b;
+	a = (const struct maintenance_task *)a_;
+	b = (const struct maintenance_task *)b_;
+
+	return b->task_order - a->task_order;
+}
+
 static int maintenance_run(void)
 {
 	int i;
 	int result = 0;
 
+	if (opts.tasks_selected)
+		QSORT(tasks, num_tasks, compare_tasks_by_selection);
+
 	for (i = 0; !result && i < num_tasks; i++) {
-		if (!tasks[i]->enabled)
+		if (opts.tasks_selected && !tasks[i]->selected)
+			continue;
+
+		if (!opts.tasks_selected && !tasks[i]->enabled)
 			continue;
+
 		result = tasks[i]->fn();
 	}
 
@@ -842,6 +861,44 @@ static void initialize_tasks(void)
 	num_tasks++;
 }
 
+static int task_option_parse(const struct option *opt,
+			     const char *arg, int unset)
+{
+	int i;
+	struct maintenance_task *task = NULL;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg || !strlen(arg)) {
+		error(_("--task requires a value"));
+		return 1;
+	}
+
+	opts.tasks_selected++;
+
+	for (i = 0; i < MAX_NUM_TASKS; i++) {
+		if (tasks[i] && !strcasecmp(tasks[i]->name, arg)) {
+			task = tasks[i];
+			break;
+		}
+	}
+
+	if (!task) {
+		error(_("'%s' is not a valid task"), arg);
+		return 1;
+	}
+
+	if (task->selected) {
+		error(_("task '%s' cannot be selected multiple times"), arg);
+		return 1;
+	}
+
+	task->selected = 1;
+	task->task_order = opts.tasks_selected;
+
+	return 0;
+}
+
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_maintenance_options[] = {
@@ -849,6 +906,9 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 			 N_("run tasks based on the state of the repository")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
+		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
+			N_("run a specific task"),
+			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
 	};
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 216ac0b19e..c09a9eb90b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -21,4 +21,27 @@ test_expect_success 'run [--auto|--quiet]' '
 	grep ",\"gc\",\"--quiet\"" run-quiet.txt
 '
 
+test_expect_success 'run --task=<task>' '
+	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
+	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" git maintenance run --task=gc &&
+	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
+	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" git maintenance run --task=commit-graph --task=gc &&
+	! grep ",\"gc\"" run-commit-graph.txt  &&
+	grep ",\"gc\"" run-gc.txt  &&
+	grep ",\"gc\"" run-both.txt  &&
+	grep ",\"commit-graph\",\"write\"" run-commit-graph.txt  &&
+	! grep ",\"commit-graph\",\"write\"" run-gc.txt  &&
+	grep ",\"commit-graph\",\"write\"" run-both.txt
+'
+
+test_expect_success 'run --task=bogus' '
+	test_must_fail git maintenance run --task=bogus 2>err &&
+	test_i18ngrep "is not a valid task" err
+'
+
+test_expect_success 'run --task duplicate' '
+	test_must_fail git maintenance run --task=gc --task=gc 2>err &&
+	test_i18ngrep "cannot be selected multiple times" err
+'
+
 test_done
-- 
gitgitgadget

