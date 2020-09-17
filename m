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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8FC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB521973
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu6nG+sE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIQSOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413CC061354
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so3034821wrl.12
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wvYhOhVVjkQBVSBry0FoipyVCLoFwBDrIPzA9kIq/tU=;
        b=Wu6nG+sERLMctlPDEISLjE+YpGWDNHz1aq5r507LDY1npM8pXzKgTovTITrLFE68du
         n8j+2TgEiAdKJlEQ1ot7ltJqfEWNJACUNdqSg6er6IuspkJJqzR+gP3QzX6le13jseG1
         vggA2xlXDVoJ4ekUlxypPaqiZ1nO/Pxr2wBTIRF33qeu7Op2KbQqqhFK7j0FFWtRUIrx
         hL5rfUG3c3z85SK0D/lqB6WqGKyfsxK9MDSZEQhCPkezEUCMNsr8PiXsy8KBOJJkLhMF
         CoNbtSJB5kW26epwrrQxsx+RgQhetkyXmgqOOjLIYzf1ik7KswzfzcJ0SdiNfvjoqNHC
         AFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wvYhOhVVjkQBVSBry0FoipyVCLoFwBDrIPzA9kIq/tU=;
        b=IPXI4WNQNHdLfM8hwdmZQj0qqN1+YGBfAThImXKTY7YO2UcgBBSfgxZPV0TqqC6AxL
         zHxEXDuGazvvXIA0gOTgoDvqQx1aKbnNpzeLO4Ajkf61ky3lD+v8dJezsv0yj7kTB+Rl
         m/gCz2+kCppydAG9zFhCtjTOXr8kr9UuZUsecRIV25PfK+zHl3HG0M0Rjh5o/Os/4ID4
         Jb4wA3ocqW2dfLYB+Mkks9ir9kpUdu+6+Jm7a+7RVy5M+I0icuNICpvgDpsdDhl7uJ3t
         ImZsJw42YncBPdSn37HxLXsxuGIo4nsLRJQFZE852M692w9PVPar3wlumUA8zssIInla
         /viw==
X-Gm-Message-State: AOAM530yT2WJ8bL1k2cLGIQcrX8/vpevp8lCqhQweDm4PWbHnRF4/DcL
        pA+moydOkCjV/hEqm0tA4JxMNlT93S8=
X-Google-Smtp-Source: ABdhPJzlIwTNHhQdfdQuEzvdaIxP0ioEc0/WUb8wJHqTyT9hpMbt3FfQqdrS1RsXYk22Id11kurkGg==
X-Received: by 2002:a5d:4152:: with SMTP id c18mr35441940wrq.277.1600366319326;
        Thu, 17 Sep 2020 11:11:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h186sm396471wmf.24.2020.09.17.11.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:58 -0700 (PDT)
Message-Id: <91b8555c9ec9f84690c7bcea01f0c546ada2de1b.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:47 +0000
Subject: [PATCH v5 06/11] maintenance: add --task option
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-maintenance.txt |  9 ++++-
 builtin/gc.c                      | 66 +++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 27 +++++++++++++
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index fc5dbcf0b9..819ca41ab6 100644
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
@@ -63,6 +65,11 @@ OPTIONS
 --quiet::
 	Do not report progress or other information over `stderr`.
 
+--task=<task>::
+	If this option is specified one or more times, then only run the
+	specified tasks in the specified order. See the 'TASKS' section
+	for the list of accepted `<task>` values.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index 86b807a008..00fff59bdb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -701,7 +701,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 }
 
 static const char * const builtin_maintenance_run_usage[] = {
-	N_("git maintenance run [--auto] [--[no-]quiet]"),
+	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
 	NULL
 };
 
@@ -759,6 +759,9 @@ struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
 	unsigned enabled:1;
+
+	/* -1 if not selected. */
+	int selected_order;
 };
 
 enum maintenance_task_label {
@@ -781,13 +784,32 @@ static struct maintenance_task tasks[] = {
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
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
-	int i;
+	int i, found_selected = 0;
 	int result = 0;
 
+	for (i = 0; !found_selected && i < TASK__COUNT; i++)
+		found_selected = tasks[i].selected_order >= 0;
+
+	if (found_selected)
+		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
+
 	for (i = 0; i < TASK__COUNT; i++) {
-		if (!tasks[i].enabled)
+		if (found_selected && tasks[i].selected_order < 0)
+			continue;
+
+		if (!found_selected && !tasks[i].enabled)
 			continue;
 
 		if (tasks[i].fn(opts)) {
@@ -799,20 +821,58 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
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
+		if (tasks[i].selected_order >= 0)
+			num_selected++;
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
+	if (task->selected_order >= 0) {
+		error(_("task '%s' cannot be selected multiple times"), arg);
+		return 1;
+	}
+
+	task->selected_order = num_selected + 1;
+
+	return 0;
+}
+
 static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
+	int i;
 	struct maintenance_run_opts opts;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
+		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
+			N_("run a specific task"),
+			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
 	};
 	memset(&opts, 0, sizeof(opts));
 
 	opts.quiet = !isatty(2);
 
+	for (i = 0; i < TASK__COUNT; i++)
+		tasks[i].selected_order = -1;
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_run_options,
 			     builtin_maintenance_run_usage,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 505a1b4d60..fb4cadd30c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -27,4 +27,31 @@ test_expect_success 'run [--auto|--quiet]' '
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

