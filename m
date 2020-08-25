Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40320C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D162071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EupoLdo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHYSeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHYSd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE1DC061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so13813453wrl.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=305uUdjHb+4q6rX/VtEHpGfhWHIvwXgJSbT7kEvsmqc=;
        b=EupoLdo4ld3zcGKoqlPp2ycby7dhXPLpxyopDYvNABlgH7GLODujFarZJ1iZ+IOWA8
         uOOUfdwBSDs2WDK0b1h0AOui5uilM36bURFk2Q3t1tqOFvOSm8ivz3nYaoKQl/3R8wla
         V+v3LTlyusufs53h1XAySOgYNNXVNwGpyIVFezY55vOQX4wOEkrcjNX1mvT28gtpp3bd
         L62YEXSWpETT23ouw1lwAFuYoN3sKihL4sBuVvqHSn9fqmfpvjSLtWOLj54BAOxGvISV
         cjlM+A3nDC+e9qfEEOHm0126w06sagr+4Pl+KMpqcgiEfkydc8FJKpbR6gPVIwRZEyiw
         w2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=305uUdjHb+4q6rX/VtEHpGfhWHIvwXgJSbT7kEvsmqc=;
        b=Xe5JV/Nx2MVLLfbJ+KP691nuaI4nRybScY7N9BOctt28E1y1VcEQy6HlldTohaDoSk
         /hNTRvjGAIB5uegxhKVO4fHmtVN8AlXovGvVXdbjkwwCa1Bj4MYquLppLElHDBRM5k5m
         +51p5nu9WmV1spjP3jHA3qOfrK0Y/YgupzC52Wt+7TxEh0ZiYWVao59tAqiscRSRzFnN
         NxZ0mOCenFLeMZ1HsYnsfEnmWERRs5ssJc4ezhxqY/AaaWFyPBL+Z4znyMoak/T+KasU
         YAWAB0xa+/9j4akVAUnkBIaXuMJ2ya60DX8LuMraAmcPM4b0dMQ/tDX0tRP+VYvSyANZ
         c9Dw==
X-Gm-Message-State: AOAM532g1Qlv0e0uP9Ox/qRsQlXM2IZlMXLwyOgSaDLbmS/54Y3EdnKu
        iVVB2UKc13+eNR7kZ7Z55cxqLlf2mFA=
X-Google-Smtp-Source: ABdhPJx9xVX3ASg+WeencdrZzkgzWGbqqQnRW5BGCfq/uk40JCSaXjpwqJpGcMA8YXrpcy9ggfibng==
X-Received: by 2002:adf:97d5:: with SMTP id t21mr8467827wrb.376.1598380434052;
        Tue, 25 Aug 2020 11:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm6888193wmc.33.2020.08.25.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:53 -0700 (PDT)
Message-Id: <69298aee24f317b03c39eef341f4d6ebebd88bc7.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:41 +0000
Subject: [PATCH v3 06/11] maintenance: add --task option
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
index 16e567992e..e94f263c77 100644
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

