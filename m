Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E16C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D501F20885
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYwOYt4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHSRRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSRRL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:17:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA1C061342
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k20so2930811wmi.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UVTECwSWY++dvwKBt2Xi+XO49gvvSGwJiw/Y9rQyIw0=;
        b=kYwOYt4s/6paeq2WkwoaiA4zwIF5Y71x2S0H8KuL30Mlgg8wdlKTLzMf2w8lMxTy3u
         2ha+5tBEDvbujjy4hK7LHCuHvtgI2ohPD8ySQ/5WrPVw3SS4UV6Ue9rk3pTgRia7489q
         bXC7zBJB9NKW8q8blUpUKVGy7ygGHhAaTepqmu39btsLrCfQjrnA7/kMTXYiYfqzF7aq
         DED2NagqpDXo2Bp7cYoq+OT6aU6N0S8kZNuMSMNeMZggZc3G/y+KJlA0mG5ItaQnnu9g
         ym+Q2rTE0CXe7KOyVkC5XMq7VjWb6bf15WDNLOXWHVTL3tuRiggq5+OGoW5sYuMbfbAu
         sDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UVTECwSWY++dvwKBt2Xi+XO49gvvSGwJiw/Y9rQyIw0=;
        b=bRwt8D9ibuPYQs2cJ0qvd2lT2jQ0JgcBjy+XbsP1C4t0XNk7azA5o5X2CRKdIh9JNk
         kiZQbj1PMqCJrmFjM4at8z9ZzqStGAJrtUmC7iRIbZM3i5feztbZoyIo9GiPn8JrkINs
         jMrdSpqaWGzaIA189ojdN0BLQnqLbvExTst5dnCglMds27QJeomj99xWN/jmeDrnp+aW
         Yt4zcwQIYScC9XODpwH89wsEzFMuc3rgFnWzdo7S5JsuTRsbIqFwsWWjICwabC0yRIpf
         L3l03amYYbIJEmByoMtPLQ65ncJ6R3rKqLthPwGb5dvY+84Qsyt0U2E3CBhwoviDeo8A
         XEtA==
X-Gm-Message-State: AOAM5318bOss0TFkoA9HxWqEN66zunFl6g3SblOzbecR0MHG+MQlZEVC
        vVziKa1mvsQdp3m49EhO/8hJuZ1UcXo=
X-Google-Smtp-Source: ABdhPJwEFkn6cYY0nqkVPH3wuCazGVdV9H3waRSCO6805oV+sIlHgk0Ghoyf1VYvOSebU6gPZ6M6Tg==
X-Received: by 2002:a7b:cf22:: with SMTP id m2mr6095661wmg.46.1597857428266;
        Wed, 19 Aug 2020 10:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r21sm42332118wrc.2.2020.08.19.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:17:07 -0700 (PDT)
Message-Id: <4473c93b118a0e0cdb205d1758aaaa2d8bf5139a.1597857412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:44 +0000
Subject: [PATCH 3/7] maintenance: add --scheduled option and config
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
 Documentation/git-maintenance.txt    | 13 +++++++-
 builtin/gc.c                         | 50 +++++++++++++++++++++++++++-
 t/t7900-maintenance.sh               | 20 +++++++++++
 4 files changed, 90 insertions(+), 2 deletions(-)

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
index 95a333f000..e8004e7b11 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -110,7 +110,18 @@ OPTIONS
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
index 707c144fb9..352948529d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -711,6 +711,7 @@ static const char * const builtin_maintenance_usage[] = {
 
 struct maintenance_opts {
 	int auto_flag;
+	int scheduled;
 	int quiet;
 };
 
@@ -1226,7 +1227,8 @@ struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
 	maintenance_auto_fn *auto_condition;
-	unsigned enabled:1;
+	unsigned enabled:1,
+		 scheduled:1;
 
 	/* -1 if not selected. */
 	int selected_order;
@@ -1337,6 +1339,9 @@ static int maintenance_run(struct maintenance_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		if (opts->scheduled && !tasks[i].scheduled)
+			continue;
+
 		update_last_run(&tasks[i]);
 
 		trace2_region_enter("maintenance", tasks[i].name, r);
@@ -1351,6 +1356,29 @@ static int maintenance_run(struct maintenance_opts *opts)
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
@@ -1359,6 +1387,7 @@ static void initialize_task_config(void)
 
 	for (i = 0; i < TASK__COUNT; i++) {
 		int config_value;
+		char *config_str;
 
 		strbuf_setlen(&config_name, 0);
 		strbuf_addf(&config_name, "maintenance.%s.enabled",
@@ -1366,6 +1395,20 @@ static void initialize_task_config(void)
 
 		if (!git_config_get_bool(config_name.buf, &config_value))
 			tasks[i].enabled = config_value;
+
+		strbuf_setlen(&config_name, 0);
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
@@ -1409,6 +1452,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "scheduled", &opts.scheduled,
+			 N_("run tasks based on time intervals")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
 		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
@@ -1434,6 +1479,9 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 			     builtin_maintenance_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	if (opts.auto_flag + opts.scheduled > 1)
+		die(_("use at most one of the --auto and --scheduled options"));
+
 	if (argc != 1)
 		usage_with_options(builtin_maintenance_usage,
 				   builtin_maintenance_options);
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

