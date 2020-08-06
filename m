Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED047C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0F62311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuw+85v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHFQVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgHFQSr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:18:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEBAC002143
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so9247110wmj.5
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BTbUl878qRwWso7jC4UFCTBzi45fQN029QdP1WegGYQ=;
        b=Vuw+85v3SGUzyHsbxZNKKjMxcXkjJrgb0LEkJ+XYaIy7h0F2Du3KbJvmhrw9X4msF9
         Sc46yybNkFYwYQ3iJ/Z7f4tG4dJfyOmPk4/I5d9cYMbGJ3DKJdAeyBf0XyXE2lQvPR6n
         AYy72EnuhIQKYGsOPFZlYq+fxkWAqlmTERN5NsgDEyMdQYKM+l564cbeto/Hs9gTv+A7
         hMNjYxaZm5Jbw5xDxlYXmNkZ5n7ZqG/FGSrYAd1DvhJF2hg0MVLDQ5KGxbrx+XRqRg8N
         jxHHDBS7RPxtynRCidg3g0of2VNbVwVQBE6bwLqF/OyflwFlhEnTt6Sq/QGAUYG1cRG4
         dU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BTbUl878qRwWso7jC4UFCTBzi45fQN029QdP1WegGYQ=;
        b=c6xzSrTu0FgsEIlYFcuH2+GBzXpMw8WM94ZaG0iZHgdvEA6cxdFCF4B17OoDRH3THH
         vnsNQrQ0Vg0F2jyeiRqssDiES7VVRE5DiR0eNY1o7wDX0KtXemIFjmblpLnhBwct9cv0
         E8OyedL/1ECNDeNfxR0UNOB3ln2iVF6jck0G8jvuDbcORkGQub/7KyjLuYYSDMOOozpl
         Qpo3X7Bzq4b6LU4U0AKZ/MWDPX64cs/ZEsEtJNt+XQ5Nwqo4Eb3cqGm7cpu1YoFtnVvg
         HqBy/vUG5WLlKw1NTp8zcK321908PUfYwaYkcB9Dv8gQzansP4FdcmA13V9m5hYeatpl
         OPQA==
X-Gm-Message-State: AOAM533NSl4Rt4iv7rI46m4vZWFzbwT4Yhkn9jLIlS3DYvtkHMmNUppI
        scUgdA0PZEs0HhevHW7JqvMzyn0z
X-Google-Smtp-Source: ABdhPJxBsuYFe4DpOXkNd2cWxPv3faXwqUDdClbO5JIsY3WloH+CfIsrad2YbPK6L75qVLV+1G1uOw==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr9261870wmk.185.1596728928921;
        Thu, 06 Aug 2020 08:48:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w64sm7228436wmb.26.2020.08.06.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:48 -0700 (PDT)
Message-Id: <dddbcc4f3d28e2c00f153007b7db40733dbd572d.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:36 +0000
Subject: [PATCH 06/11] maintenance: add --task option
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
index 35b0be7d40..5911213c9c 100644
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
@@ -73,6 +75,10 @@ OPTIONS
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
index 3b7b914d60..3d50ab7ac9 100644
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
 	static struct maintenance_opts opts;
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
index 384294d111..bcc7131818 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -23,4 +23,31 @@ test_expect_success 'run [--auto|--quiet]' '
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

