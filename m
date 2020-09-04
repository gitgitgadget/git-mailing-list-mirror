Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3DEC433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2832D2074D
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gii2DOQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIDPnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIDPmM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 11:42:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE57C061246
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 08:42:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so7153312wrs.11
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=77+HngzKaQv1NyOkujyScNa2sa4WOlcHsO8S6LV+Guk=;
        b=gii2DOQX66Hfi2KzBUfcpJWcYH0hK6M/W4FtnIggXOs5mw33pqDjlRRkriA1kdr8We
         jlYbK8oWXrDCuVUbzUzFsLnaoEsfOAL7899bCZ8s8GDF1fDBoCD5F5XAdr5Yu7lD4jNl
         PNcJN8GXtbA9JvHjfZyYwqrGWrYfV//CQESofuGFHAVKXtPs7dyHGc75eo0IdfSE7W8H
         frDUm3xQeuflQO6fLy/o1dXmZ4mUMPMvZ6YqQ2BkUopyMTvPKIE4m0EjnN1m5srbVHaF
         ZrHl/SE703tLqvhC5CKxmiLcY/lzZFkzU8bUKmM3wIAWJjn0zF35Bh8kWc+jTC1b162U
         FDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=77+HngzKaQv1NyOkujyScNa2sa4WOlcHsO8S6LV+Guk=;
        b=D/geTPsaAfZdod0Y1mXHgh7Ifx4h6Xd8zmxhQnG6+tuC1KKIq3d1uxR3HyLCkx+a8t
         kpg5/WuHhuyCV1lErX+OF+/hm0udhmqYl9UEgH5v/aADcE8YHQkQxe4slw99sWhQgoKx
         igPFtXaxAkbSw9Wnm7EX0SCzQf4ZExa3T8YesnvzLVyfa87gEl2tp+xLM2ONNG5agtK5
         rv0nNDJR58WKio9PI+uF1jgLdQTeULs//uFJAHd9JbFL5SffuALvC5vUKJFPRqG9WGCv
         0Tgsr19d+QCgHyDvhNxpScz/PJ/zJINNOLW/duatkJrSn4+nVdYi1OQAhj75L7R3bqHX
         FWaA==
X-Gm-Message-State: AOAM532KtVTZSIB3MHBbfeL0MXLuj8oEzGqr5vOjZk0rfMRUXQWGdI3t
        OVC6vV01Dm494IaKz8hUvKTANjDBF7Q=
X-Google-Smtp-Source: ABdhPJw+7pX3mnTFaLBgdHdvXpqJLaSBIxXFrrVG91cFXoXbqnAsELCFo3zz7p214yprlCwLhRrIWQ==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr7962910wrp.286.1599234129734;
        Fri, 04 Sep 2020 08:42:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a127sm12091511wmh.34.2020.09.04.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:42:09 -0700 (PDT)
Message-Id: <1783e80b8d3b8361d1d62947a49ba584685dacc4.1599234126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.git.1599234126.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 15:42:01 +0000
Subject: [PATCH 2/7] maintenance: add --schedule option and config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A user may want to run certain maintenance tasks based on frequency, not
conditions given in the repository. For example, the user may want to
perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
update the 'git maintenance run' command to include a
'--schedule=<frequency>' option. The allowed frequencies are 'hourly',
'daily', and 'weekly'. These values are also allowed in a new config
value 'maintenance.<task>.schedule'.

The 'git maintenance run --schedule=<frequency>' checks the '*.schedule'
config value for each enabled task to see if the configured frequency is
at least as frequent as the frequency from the '--schedule' argument. We
use the following order, for full clarity:

	'hourly' > 'daily' > 'weekly'

Use new 'enum schedule_priority' to track these values numerically.

The following cron table would run the scheduled tasks with the correct
frequencies:

  0 1-23 * * *    git -C <repo> maintenance run --scheduled=hourly
  0 0    * * 1-6  git -C <repo> maintenance run --scheduled=daily
  0 0    * * 0    git -C <repo> maintenance run --scheduled=weekly

This cron schedule will run --scheduled=hourly every hour except at
midnight. This avoids a concurrent run with the --scheduled=daily that
runs at midnight every day except the first day of the week. This avoids
a concurrent run with the --scheduled=weekly that runs at midnight on
the first day of the week. Since --scheduled=daily also runs the
'hourly' tasks and --scheduled=weekly runs the 'hourly' and 'daily'
tasks, we will still see all tasks run with the proper frequencies.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  5 +++
 Documentation/git-maintenance.txt    | 13 +++++-
 builtin/gc.c                         | 67 +++++++++++++++++++++++++---
 t/t7900-maintenance.sh               | 40 +++++++++++++++++
 4 files changed, 119 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 06db758172..70585564fa 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -10,6 +10,11 @@ maintenance.<task>.enabled::
 	`--task` option exists. By default, only `maintenance.gc.enabled`
 	is true.
 
+maintenance.<task>.schedule::
+	This config option controls whether or not the given `<task>` runs
+	during a `git maintenance run --schedule=<frequency>` command. The
+	value must be one of "hourly", "daily", or "weekly".
+
 maintenance.commit-graph.auto::
 	This integer config option controls how often the `commit-graph` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index b44efb05a3..3af5907b01 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -107,7 +107,18 @@ OPTIONS
 	only if certain thresholds are met. For example, the `gc` task
 	runs when the number of loose objects exceeds the number stored
 	in the `gc.auto` config setting, or when the number of pack-files
-	exceeds the `gc.autoPackLimit` config setting.
+	exceeds the `gc.autoPackLimit` config setting. Not compatible with
+	the `--schedule` option.
+
+--schedule::
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
index f8459df04c..85a3370692 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -704,14 +704,51 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static const char * const builtin_maintenance_run_usage[] = {
-	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
+static const char *const builtin_maintenance_run_usage[] = {
+	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>] [--schedule]"),
 	NULL
 };
 
+enum schedule_priority {
+	SCHEDULE_NONE = 0,
+	SCHEDULE_WEEKLY = 1,
+	SCHEDULE_DAILY = 2,
+	SCHEDULE_HOURLY = 3,
+};
+
+static enum schedule_priority parse_schedule(const char *value)
+{
+	if (!value)
+		return SCHEDULE_NONE;
+	if (!strcasecmp(value, "hourly"))
+		return SCHEDULE_HOURLY;
+	if (!strcasecmp(value, "daily"))
+		return SCHEDULE_DAILY;
+	if (!strcasecmp(value, "weekly"))
+		return SCHEDULE_WEEKLY;
+	return SCHEDULE_NONE;
+}
+
+static int maintenance_opt_schedule(const struct option *opt, const char *arg,
+				    int unset)
+{
+	enum schedule_priority *priority = opt->value;
+
+	if (unset)
+		die(_("--no-schedule is not allowed"));
+
+	*priority = parse_schedule(arg);
+
+	if (!*priority)
+		die(_("unrecognized --schedule argument '%s'"), arg);
+
+	return 0;
+}
+
 struct maintenance_run_opts {
 	int auto_flag;
 	int quiet;
+	enum schedule_priority schedule;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -1159,6 +1196,8 @@ struct maintenance_task {
 	maintenance_auto_fn *auto_condition;
 	unsigned enabled:1;
 
+	enum schedule_priority schedule;
+
 	/* -1 if not selected. */
 	int selected_order;
 };
@@ -1250,8 +1289,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 			continue;
 
 		if (opts->auto_flag &&
-		    (!tasks[i].auto_condition ||
-		     !tasks[i].auto_condition()))
+		    (!tasks[i].auto_condition || !tasks[i].auto_condition()))
+			continue;
+
+		if (opts->schedule && tasks[i].schedule < opts->schedule)
 			continue;
 
 		trace2_region_enter("maintenance", tasks[i].name, r);
@@ -1274,13 +1315,23 @@ static void initialize_task_config(void)
 
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
+			tasks[i].schedule = parse_schedule(config_str);
+			free(config_str);
+		}
 	}
 
 	strbuf_release(&config_name);
@@ -1324,6 +1375,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
+			     N_("run tasks based on frequency"),
+			     maintenance_opt_schedule),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
 		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
@@ -1344,6 +1398,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 			     builtin_maintenance_run_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (opts.auto_flag && opts.schedule)
+		die(_("use at most one of --auto and --schedule=<frequency>"));
+
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e0ba19e1ff..328bbaa830 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -264,4 +264,44 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	done
 '
 
+test_expect_success '--auto and --schedule incompatible' '
+	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
+	test_i18ngrep "at most one" err
+'
+
+test_expect_success 'invalid --schedule value' '
+	test_must_fail git maintenance run --schedule=annually 2>err &&
+	test_i18ngrep "unrecognized --schedule" err
+'
+
+test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
+	git config maintenance.loose-objects.enabled true &&
+	git config maintenance.loose-objects.schedule hourly &&
+	git config maintenance.commit-graph.enabled true &&
+	git config maintenance.commit-graph.schedule daily &&
+	git config maintenance.incremental-repack.enabled true &&
+	git config maintenance.incremental-repack.schedule weekly &&
+
+	GIT_TRACE2_EVENT="$(pwd)/hourly.txt" \
+		git maintenance run --schedule=hourly 2>/dev/null &&
+	test_subcommand git prune-packed --quiet <hourly.txt &&
+	test_subcommand ! git commit-graph write --split --reachable \
+		--no-progress <hourly.txt &&
+	test_subcommand ! git multi-pack-index write --no-progress <hourly.txt &&
+
+	GIT_TRACE2_EVENT="$(pwd)/daily.txt" \
+		git maintenance run --schedule=daily 2>/dev/null &&
+	test_subcommand git prune-packed --quiet <daily.txt &&
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <daily.txt &&
+	test_subcommand ! git multi-pack-index write --no-progress <daily.txt &&
+
+	GIT_TRACE2_EVENT="$(pwd)/weekly.txt" \
+		git maintenance run --schedule=weekly 2>/dev/null &&
+	test_subcommand git prune-packed --quiet <weekly.txt &&
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <weekly.txt &&
+	test_subcommand git multi-pack-index write --no-progress <weekly.txt
+'
+
 test_done
-- 
gitgitgadget

