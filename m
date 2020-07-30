Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91235C433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC9420829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVt8RD9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgG3WYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgG3WYp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB66C061575
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so21200128wrs.8
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sWYlfdDhdnxAyiX9S3sbgwmIEMoCljL5jXPkmla5wNg=;
        b=OVt8RD9gLm0ZVZnfUWngrGG8PeU2BdbpDZ7ytbUqD2768N9nzw48+GjXQqlbtruIfu
         u/NMuOoq/og5MvTDsASIezVBrUnmw9boNfX7t8w0YwXpHK9wBGZ7tkPY8aaVm5Zstpz3
         m+C2aJccJo5kxNh89475oH/Yu0sn0iZF/N3fojUtax6c/ipGakMZfuVW99lQqhCoFbLr
         MqVOq7y2exUVmkCiUEHZWhoWgm5g6bzzsSN5VuRhakt9a7Eai1Q/B7sDGyy7o6P52P3c
         hiCk50ViPeuBtTfoWL1JaaN37HpVxxKe3PqYUShpDOPZnqEPisEWw1nVm1mgsNe5kCGW
         qA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sWYlfdDhdnxAyiX9S3sbgwmIEMoCljL5jXPkmla5wNg=;
        b=Sc/WdrlDK5qmFpWnZJfBxO0B/FWdG3lCG5+F/lGXH9nubuZ647MCLbuWr0DiEaN5z0
         d7aFjJNP5Ooaq8bCdojzAhQpz9wSK7xKpK4zFYz7BGc4ra4MZXopphawcmyiB8NOi+dG
         fIBb5+3NQxy54D/EywnsDrDNxEnn+kRJf2J7ueTOQMTeHECmqv8XL/+3NPahyEy4SyJE
         AWIpP51yo1jxdJOMdySh4Uo6h3Xkyl2Uz/AtHtBqslN3y4NYLg4mpfqdH2CGK/yGCReK
         8BliaMNBM1WKRO/QPxuXqYPEZZb6IS3ftV/bMIRRbpIwcOJhQ0vdmuaM1GIUFTpz0zMz
         2hjg==
X-Gm-Message-State: AOAM530dCvQnnALeUXCi/amjtFgWvNSxpIzJEJKMiRZHkofQZxTYEKII
        qh50gl5UUF3sBTW4OaAs4Boqf+w8
X-Google-Smtp-Source: ABdhPJywGpFU6ItLLGB47YmCdvkcvfj1lOtP5ey9C0/DK5DqSZo9AsrAbUIalHwHW/3w4gq6IS2DTg==
X-Received: by 2002:adf:df06:: with SMTP id y6mr661955wrl.89.1596147883404;
        Thu, 30 Jul 2020 15:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r22sm3349750wmh.45.2020.07.30.15.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
Message-Id: <dafb0d9bbc4c8ddce82fa30dd0ad78439342ed66.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:12 +0000
Subject: [PATCH v3 06/20] maintenance: add --task option
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

Keep in mind that the 'enabled' member of the maintenance_task struct is
a placeholder for a future 'maintenance.<task>.enabled' config option.
Thus, we use the 'enabled' member to specify which tasks are run when
the user does not specify any --task=<task> arguments. The 'enabled'
member should be ignored if --task=<task> appears.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  4 +++
 builtin/gc.c                      | 59 +++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 23 ++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)

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
index ec1bbc3f9e..b7f64891cd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -708,6 +708,7 @@ static const char * const builtin_maintenance_usage[] = {
 static struct maintenance_opts {
 	int auto_flag;
 	int quiet;
+	int tasks_selected;
 } opts;
 
 static int run_write_commit_graph(void)
@@ -789,7 +790,9 @@ typedef int maintenance_task_fn(void);
 struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
-	unsigned enabled:1;
+	unsigned enabled:1,
+		 selected:1;
+	int selected_order;
 };
 
 enum maintenance_task_label {
@@ -812,13 +815,29 @@ static struct maintenance_task tasks[] = {
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
 static int maintenance_run(void)
 {
 	int i;
 	int result = 0;
 
+	if (opts.tasks_selected)
+		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
+
 	for (i = 0; i < TASK__COUNT; i++) {
-		if (!tasks[i].enabled)
+		if (opts.tasks_selected && !tasks[i].selected)
+			continue;
+
+		if (!opts.tasks_selected && !tasks[i].enabled)
 			continue;
 
 		if (tasks[i].fn()) {
@@ -830,6 +849,39 @@ static int maintenance_run(void)
 	return result;
 }
 
+static int task_option_parse(const struct option *opt,
+			     const char *arg, int unset)
+{
+	int i;
+	struct maintenance_task *task = NULL;
+
+	BUG_ON_OPT_NEG(unset);
+
+	opts.tasks_selected++;
+
+	for (i = 0; i < TASK__COUNT; i++) {
+		if (!strcasecmp(tasks[i].name, arg)) {
+			task = &tasks[i];
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
+	task->selected_order = opts.tasks_selected;
+
+	return 0;
+}
+
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_maintenance_options[] = {
@@ -837,6 +889,9 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 			 N_("run tasks based on the state of the repository")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
+		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
+			N_("run a specific task"),
+			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
 	};
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ff646abf7c..3cdccb24df 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -20,4 +20,27 @@ test_expect_success 'run [--auto|--quiet]' '
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

