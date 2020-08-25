Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED462C433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55BF2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGpvMS6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHYSkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgHYSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221BC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b17so13064879wru.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OdzOCvRhhYnmY+eXGmtafDY7myv9Ro1QU1DnL1wqlv8=;
        b=BGpvMS6XtNzU/0ga8QVZw1dpeBlgBpbcp5enUB5Wj3qXh8HFWJExWJYTh47XJkKBGd
         EEe6Xg3ApbbpInoNYA1IAEiAM1pwxPvt1XKGzjN17DgecShoxwJaeyLCWD6KzUQLQliU
         GewoYALhdksnJQW0JupmdxlnDkqrTZYaKZ/DqJfgwGhN386//qaAtb+291bSK8q+Ynlg
         i3oXNvvAOw9fW0mOCMNiZdIHi8Ga7gt/wNhA10/9s2neqOyhYBDwQ25Qyn2dzXWOjsyk
         P84yoEzpGlqGB2D7C+MR6thXv1f5ObggZQlfQKCIBHJTGXlTknA23tZa5genk8Pc1Yr7
         w0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OdzOCvRhhYnmY+eXGmtafDY7myv9Ro1QU1DnL1wqlv8=;
        b=BsLCUnkTbDKyVcHEWVM6jHXTbutuBBwCTM5d1krXCxeOvTRbZZiQxQdZkG48tJBO/2
         x1vmIHNdNP2M41rG2LNPxADVlqZpQF7XW4NNRTBqZP7uJ3g5hH+kxxBbxhgc+UHpwyRD
         zpjTtbm5lqrq3mQA+4ik9jFiUN3heElGS3oVVa7Mn+yIeLjUHV34sks2DP8fGiM4qDTw
         9WNArQnB7iE2VO9RfamZ44UFGx12dSC57piK08NnFPthNyUoBDQTgwvq2GITkhRfnuxU
         rwkyyPXpsCrgNQPVvd2QwoW3IPtTAxPnNep/YfrJYY43B/3S0X3JBSOxOoZEtWfjFG9m
         43xQ==
X-Gm-Message-State: AOAM530YiyedUjKONRNo53+XLJv+bfQGdg09sJ6Gn08YM3Y9phEStX43
        DWyyPVwUYB2D3lYyWLd86ESg4VxXVX8=
X-Google-Smtp-Source: ABdhPJycGLTAwsFETHl26pdznc09Q6cl+KuSxDgXQ4s5+4zJzvsEEwPJBNMw7feRjQOZw796PIdG0Q==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr4497840wrr.179.1598380808683;
        Tue, 25 Aug 2020 11:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm7182940wmc.28.2020.08.25.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:08 -0700 (PDT)
Message-Id: <c728c57d85b17035d42313260620a7de5756b0c3.1598380805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:40:00 +0000
Subject: [PATCH v2 3/7] maintenance: add --scheduled option and config
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

A user may want to run certain maintenance tasks based on frequency, not
conditions given in the repository. For example, the user may want to
perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
update the 'git maintenance run --scheduled' command to check the config
for the last run of that task and add a number of seconds. The task
would then run only if the current time is beyond that minimum
timestamp.

Add a '--scheduled' option to 'git maintenance run' to only run tasks
that have had enough time pass since their last run. This is done for
each enabled task by checking if the current timestamp is at least as
large as the sum of 'maintenance.<task>.lastRun' and
'maintenance.<task>.schedule' in the Git config. This second value is
new to this commit, storing a number of seconds intended between runs.

A user could then set up an hourly maintenance run with the following
cron table:

  0 * * * * git -C <repo> maintenance run --scheduled

Then, the user could configure the repository with the following config
values:

  maintenance.prefetch.schedule  3000
  maintenance.gc.schedule       86000

These numbers are slightly lower than one hour and one day (in seconds).
The cron schedule will enforce the hourly run rate, but we can use these
schedules to ensure the 'gc' task runs once a day. The error is given
because the *.lastRun config option is specified at the _start_ of the
task run. Otherwise, a slow task run could shift the "daily" job of 'gc'
from a 10:00pm run to 11:00pm run, or later.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  9 +++++
 Documentation/git-maintenance.txt    | 13 ++++++-
 builtin/gc.c                         | 54 ++++++++++++++++++++++++++--
 t/t7900-maintenance.sh               | 20 +++++++++++
 4 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 8dd34169da..caacacd322 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -15,6 +15,15 @@ maintenance.<task>.lastRun::
 	`<task>` is run. It stores a timestamp representing the most-recent
 	run of the `<task>`.
 
+maintenance.<task>.schedule::
+	This config option controls whether or not the given `<task>` runs
+	during a `git maintenance run --scheduled` command. If the option
+	is an integer value `S`, then the `<task>` is run when the current
+	time is `S` seconds after the timestamp stored in
+	`maintenance.<task>.lastRun`. If the option has no value or a
+	non-integer value, then the task will never run with the `--scheduled`
+	option.
+
 maintenance.commit-graph.auto::
 	This integer config option controls how often the `commit-graph` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index b44efb05a3..2bc02c65e4 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -107,7 +107,18 @@ OPTIONS
 	only if certain thresholds are met. For example, the `gc` task
 	runs when the number of loose objects exceeds the number stored
 	in the `gc.auto` config setting, or when the number of pack-files
-	exceeds the `gc.autoPackLimit` config setting.
+	exceeds the `gc.autoPackLimit` config setting. Not compatible with
+	the `--scheduled` option.
+
+--scheduled::
+	When combined with the `run` subcommand, run maintenance tasks
+	only if certain time conditions are met, as specified by the
+	`maintenance.<task>.schedule` config value for each `<task>`.
+	This config value specifies a number of seconds since the last
+	time that task ran, according to the `maintenance.<task>.lastRun`
+	config value. The tasks that are tested are those provided by
+	the `--task=<task>` option(s) or those with
+	`maintenance.<task>.enabled` set to true.
 
 --quiet::
 	Do not report progress or other information over `stderr`.
diff --git a/builtin/gc.c b/builtin/gc.c
index fb6f231a5c..5726a9a3b3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -705,12 +705,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 }
 
 static const char * const builtin_maintenance_run_usage[] = {
-	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
+	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>] [--scheduled]"),
 	NULL
 };
 
 struct maintenance_run_opts {
 	int auto_flag;
+	int scheduled;
 	int quiet;
 };
 
@@ -1157,7 +1158,8 @@ struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
 	maintenance_auto_fn *auto_condition;
-	unsigned enabled:1;
+	unsigned enabled:1,
+		 scheduled:1;
 
 	/* -1 if not selected. */
 	int selected_order;
@@ -1268,6 +1270,9 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		if (opts->scheduled && !tasks[i].scheduled)
+			continue;
+
 		update_last_run(&tasks[i]);
 
 		trace2_region_enter("maintenance", tasks[i].name, r);
@@ -1282,6 +1287,29 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 	return result;
 }
 
+static void fill_schedule_info(struct maintenance_task *task,
+			       const char *config_name,
+			       timestamp_t schedule_delay)
+{
+	timestamp_t now = approxidate("now");
+	char *value = NULL;
+	struct strbuf last_run = STRBUF_INIT;
+	int64_t previous_run;
+
+	strbuf_addf(&last_run, "maintenance.%s.lastrun", task->name);
+
+	if (git_config_get_string(last_run.buf, &value))
+		task->scheduled = 1;
+	else {
+		previous_run = git_config_int64(last_run.buf, value);
+		if (now >= previous_run + schedule_delay)
+			task->scheduled = 1;
+	}
+
+	free(value);
+	strbuf_release(&last_run);
+}
+
 static void initialize_task_config(void)
 {
 	int i;
@@ -1290,13 +1318,28 @@ static void initialize_task_config(void)
 
 	for (i = 0; i < TASK__COUNT; i++) {
 		int config_value;
+		char *config_str;
 
-		strbuf_setlen(&config_name, 0);
+		strbuf_reset(&config_name);
 		strbuf_addf(&config_name, "maintenance.%s.enabled",
 			    tasks[i].name);
 
 		if (!git_config_get_bool(config_name.buf, &config_value))
 			tasks[i].enabled = config_value;
+
+		strbuf_reset(&config_name);
+		strbuf_addf(&config_name, "maintenance.%s.schedule",
+			    tasks[i].name);
+
+		if (!git_config_get_string(config_name.buf, &config_str)) {
+			timestamp_t schedule_delay = git_config_int64(
+							config_name.buf,
+							config_str);
+			fill_schedule_info(&tasks[i],
+						config_name.buf,
+						schedule_delay);
+			free(config_str);
+		}
 	}
 
 	strbuf_release(&config_name);
@@ -1340,6 +1383,8 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "scheduled", &opts.scheduled,
+			 N_("run tasks based on time intervals")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
 		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
@@ -1360,6 +1405,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 			     builtin_maintenance_run_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (opts.auto_flag + opts.scheduled > 1)
+		die(_("use at most one of the --auto and --scheduled options"));
+
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a985ce3674..3e0c5f1ca8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -264,6 +264,11 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	done
 '
 
+test_expect_success '--auto and --scheduled incompatible' '
+	test_must_fail git maintenance run --auto --scheduled 2>err &&
+	test_i18ngrep "at most one" err
+'
+
 test_expect_success 'tasks update maintenance.<task>.lastRun' '
 	git config --unset maintenance.commit-graph.lastrun &&
 	GIT_TRACE2_EVENT="$(pwd)/run.txt" \
@@ -274,4 +279,19 @@ test_expect_success 'tasks update maintenance.<task>.lastRun' '
 	test_cmp_config 1595000000 maintenance.commit-graph.lastrun
 '
 
+test_expect_success '--scheduled with specific time' '
+	git config maintenance.commit-graph.schedule 100 &&
+	GIT_TRACE2_EVENT="$(pwd)/too-soon.txt" \
+		GIT_TEST_DATE_NOW=1595000099 \
+		git maintenance run --scheduled 2>/dev/null &&
+	test_subcommand ! git commit-graph write --split --reachable \
+		--no-progress <too-soon.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/long-enough.txt" \
+		GIT_TEST_DATE_NOW=1595000100 \
+		git maintenance run --scheduled 2>/dev/null &&
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <long-enough.txt &&
+	test_cmp_config 1595000100 maintenance.commit-graph.lastrun
+'
+
 test_done
-- 
gitgitgadget

