Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9001C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D59A207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZuing9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHROXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHROXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80F3C061347
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so17174338wme.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JHjJU4VSqmYw0QkLeFL1p9zHlz8jMEG2I2KKfue5Smg=;
        b=hZuing9TJu0ZZtsw211wk+X9TiYUcW/2bcJ2JUsfQZnZqpPoMrZLROQ4f23SvgC/+d
         5mUVHU4pjQ2QWoaS5gh573bA+XeVZ1jjxiCoo2v1wcIsDCXfGbH8ZqnpKzM4XyBkHEfm
         vrJHpHKr0NwBC4nfOETXGrl0ckdGZvkLTrMY6z6cU+Ms/aDtB4zRnlRMoCcalI+wVk66
         v7R2uh0arr5Jkqu/QsK7BE6BzUndlzL5OFwkeQ3PQMG1+fCSew998MLg5ErtWmcsMWiz
         4cGzprn8tBgVKqCAdZHgsOxn11/jAkL11mVH3o1QD94UK6hpuqma4H7fiJ8VJWSzzsjA
         YREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JHjJU4VSqmYw0QkLeFL1p9zHlz8jMEG2I2KKfue5Smg=;
        b=V/gpqWB5tWPyTYA78n3eea/Sauu2f66tImuG0zX7zlkexNT90QePCT7cjy7BibQb6/
         1Ju/rzexL51B6dRrbFE2ObCeMhJvGRWadHYeoYEeEvR0w9MOLqVDj2Pqr6ARGnomzmUT
         6XHqS2Nk1kBGJ6LbMYhkH9RsWl5Tw6978jYEjIvdrwAgGRpcnAdjIm5dsd1vu5yxyRQv
         TG8YrgvWTHYjojKr+xXc5J2kOpYJFBsr7HVkYdsCkHVs+lxGxTce2mfRUyrPdjSlPugC
         R69yCkGYaLmOTwmrk9C8cBNoQqfAkm9DAsQq1sihH9KyWEgTS8CDh5YNLym2shH1v1JX
         SMTA==
X-Gm-Message-State: AOAM530dR48efcfZ81o5KAlTlZji8QYy5NPuDvrO7Gp4Mxq7wB7QLLDh
        5hO5VAiVNehcKMsB3Y6UiW+on9Lyp2M=
X-Google-Smtp-Source: ABdhPJyugO2uH3ln7qxa9vbQK8TRNOxFHGHr4GpeoRWah8bpD4+fyT3RaoR6KZaIxFUnX9TFmtlUKg==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr161023wml.87.1597760596178;
        Tue, 18 Aug 2020 07:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm34437150wrr.10.2020.08.18.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:15 -0700 (PDT)
Message-Id: <85268bd53ef7f4e7b3d97a8ae091290e8e74441d.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:23:03 +0000
Subject: [PATCH v2 06/11] maintenance: add --task option
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

A user may want to only run certain maintenance tasks in a certain
order. Add the --task=<task> option, which allows a user to specify an
ordered list of tasks to run. These cannot be run multiple times,
however.

Here is where our array of maintenance_task pointers becomes critical.
We can sort the array of pointers based on the task order, but we do not
want to move the struct data itself in order to preserve the hashmap
references. We use the hashmap to match the --task=<task> arguments into
the task struct data.

Keep in mind that the 'enabled' member of the maintenance_task struct is
a placeholder for a future 'maintenance.<task>.enabled' config option.
Thus, we use the 'enabled' member to specify which tasks are run when
the user does not specify any --task=<task> arguments. The 'enabled'
member should be ignored if --task=<task> appears.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  8 +++-
 builtin/gc.c                      | 61 +++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 27 ++++++++++++++
 3 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index c816fa1dcd..cf59eb258c 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -30,7 +30,9 @@ SUBCOMMANDS
 -----------
 
 run::
-	Run one or more maintenance tasks.
+	Run one or more maintenance tasks. If one or more `--task=<task>`
+	options are specified, then those tasks are run in the provided
+	order. Otherwise, only the `gc` task is run.
 
 TASKS
 -----
@@ -66,6 +68,10 @@ OPTIONS
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
index 4f9352b9d0..0231d2f8c1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -791,7 +791,9 @@ typedef int maintenance_task_fn(struct maintenance_opts *opts);
 struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
-	unsigned enabled:1;
+	unsigned enabled:1,
+		 selected:1;
+	int selected_order;
 };
 
 enum maintenance_task_label {
@@ -814,13 +816,32 @@ static struct maintenance_task tasks[] = {
 	},
 };
 
+static int compare_tasks_by_selection(const void *a_, const void *b_)
+{
+	const struct maintenance_task *a, *b;
+
+	a = (const struct maintenance_task *)&a_;
+	b = (const struct maintenance_task *)&b_;
+
+	return b->selected_order - a->selected_order;
+}
+
 static int maintenance_run(struct maintenance_opts *opts)
 {
-	int i;
+	int i, found_selected = 0;
 	int result = 0;
 
+	for (i = 0; !found_selected && i < TASK__COUNT; i++)
+		found_selected = tasks[i].selected;
+
+	if (found_selected)
+		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
+
 	for (i = 0; i < TASK__COUNT; i++) {
-		if (!tasks[i].enabled)
+		if (found_selected && !tasks[i].selected)
+			continue;
+
+		if (!found_selected && !tasks[i].enabled)
 			continue;
 
 		if (tasks[i].fn(opts)) {
@@ -832,6 +853,37 @@ static int maintenance_run(struct maintenance_opts *opts)
 	return result;
 }
 
+static int task_option_parse(const struct option *opt,
+			     const char *arg, int unset)
+{
+	int i, num_selected = 0;
+	struct maintenance_task *task = NULL;
+
+	BUG_ON_OPT_NEG(unset);
+
+	for (i = 0; i < TASK__COUNT; i++) {
+		num_selected += tasks[i].selected;
+		if (!strcasecmp(tasks[i].name, arg)) {
+			task = &tasks[i];
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
+	task->selected_order = num_selected + 1;
+
+	return 0;
+}
+
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
 	struct maintenance_opts opts;
@@ -840,6 +892,9 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 			 N_("run tasks based on the state of the repository")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
+		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
+			N_("run a specific task"),
+			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
 	};
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c0c4e6846e..792765aff7 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -25,4 +25,31 @@ test_expect_success 'run [--auto|--quiet]' '
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
+test_expect_success 'run --task=<task>' '
+	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
+		git maintenance run --task=commit-graph 2>/dev/null &&
+	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" \
+		git maintenance run --task=gc 2>/dev/null &&
+	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
+		git maintenance run --task=commit-graph 2>/dev/null &&
+	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
+		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
+	test_subcommand ! git gc --quiet <run-commit-graph.txt &&
+	test_subcommand git gc --quiet <run-gc.txt &&
+	test_subcommand git gc --quiet <run-both.txt &&
+	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
+	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
+	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
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

