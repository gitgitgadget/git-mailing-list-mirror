Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4EC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E2622254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kla8VphI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404920AbgJORWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbgJORWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579EC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so4533179wrl.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sy1fNp0IvDLU7VY072G0Tf6lU7VIhiL8U5UrQvwJNbo=;
        b=kla8VphIgdiAWEXX7kzqoMaKnNt5+wcZx4DRTW0lgvOj0iH8HTOhdVVBRBD2H8OIxP
         VOBQFtEYEGYDiGiVS8Z94jJvaxbUEs3KBv52tpT7/cfcURRQ+q9DFDkqYvGu7kksZxG0
         yX4FgQJUfoJ+5tzA0wS4XnC/VqnDjQftH4uyloG4F/NPf90RmXmH3pFhLCo7sJV8+JhA
         cQe7Vfzz2DQ8caHG+pihQxXB7AY349mU647UTS059COFCq3IU5Vc4J6JD1Gy3xqD9xN6
         ZXf/LyOtSn14s7fot2MputsKHKdfh3DgYTfnepkfZF0TEjcBp2Rk/VmwzkURiQSJCF/d
         SRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sy1fNp0IvDLU7VY072G0Tf6lU7VIhiL8U5UrQvwJNbo=;
        b=Qy7RpqEKbeLN5EDkf955he5N2X4WXeW+rAThedAXuFZn2/HVYbo0qZ7zOiL1GVnd+2
         kYecW9eox5J1Ar+NEPGxOl/s4CcIw/ms3pgJaZjpnCLIZhRpzn2bgNErHS6cNURbDFlb
         ZGAD9nHq5d9GBvb7xuaqZHiXoZPoX7OhRw6U8CgQe2DfM0yGBIiXeE2TQ1Jcu2Y6UzuV
         pFSYCf8wQVOVjNGPqSNJhpeH/lQSlkv5J9IE0sbhXh60Hju8BHGULRyPOG3GqzfU0qq8
         2yonya5gtiRMezl7DFeI/Kx2CH+Ew2N560GmhbtO7tTWgumZX/LylWrvN6DbAgNCpA53
         SrMQ==
X-Gm-Message-State: AOAM531smS492wuEGZsz3qv6VQIMZR5Ocq7fWo3/oA9W6Z42VaT+LbK3
        5EhQ9etH00NYRDU2zTPdQE2QVptdF54=
X-Google-Smtp-Source: ABdhPJxF+8TPKo3MUvSSHlboCp9LXclYIgnSxLVxMGdbMttd6qebiMxsz+mHMwzakHpq5KrZ5VtFBQ==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr5264175wrx.46.1602782526964;
        Thu, 15 Oct 2020 10:22:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm6109544wra.38.2020.10.15.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:06 -0700 (PDT)
Message-Id: <dae8c04bb5523c9b63c770862a1104a0ff4aa6c4.1602782524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:21:58 +0000
Subject: [PATCH v4 2/8] maintenance: add --schedule option and config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Maintenance currently triggers when certain data-size thresholds are
met, such as number of pack-files or loose objects. Users may want to
run certain maintenance tasks based on frequency instead. For example,
a user may want to perform a 'prefetch' task every hour, or 'gc' task
every day. To help these users, update the 'git maintenance run' command
to include a '--schedule=<frequency>' option. The allowed frequencies
are 'hourly', 'daily', and 'weekly'. These values are also allowed in a
new config value 'maintenance.<task>.schedule'.

The 'git maintenance run --schedule=<frequency>' checks the '*.schedule'
config value for each enabled task to see if the configured frequency is
at least as frequent as the frequency from the '--schedule' argument. We
use the following order, for full clarity:

	'hourly' > 'daily' > 'weekly'

Use new 'enum schedule_priority' to track these values numerically.

The following cron table would run the scheduled tasks with the correct
frequencies:

  0 1-23 * * *    git -C <repo> maintenance run --schedule=hourly
  0 0    * * 1-6  git -C <repo> maintenance run --schedule=daily
  0 0    * * 0    git -C <repo> maintenance run --schedule=weekly

This cron schedule will run --schedule=hourly every hour except at
midnight. This avoids a concurrent run with the --schedule=daily that
runs at midnight every day except the first day of the week. This avoids
a concurrent run with the --schedule=weekly that runs at midnight on
the first day of the week. Since --schedule=daily also runs the
'hourly' tasks and --schedule=weekly runs the 'hourly' and 'daily'
tasks, we will still see all tasks run with the proper frequencies.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  5 +++
 Documentation/git-maintenance.txt    | 13 +++++-
 builtin/gc.c                         | 64 ++++++++++++++++++++++++++--
 t/t7900-maintenance.sh               | 40 +++++++++++++++++
 4 files changed, 118 insertions(+), 4 deletions(-)

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
index 3f5d8946b4..ed94f66e36 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -110,7 +110,18 @@ OPTIONS
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
index 2b99596ec8..03b24ea0db 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -703,14 +703,51 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
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
@@ -1158,6 +1195,8 @@ struct maintenance_task {
 	maintenance_auto_fn *auto_condition;
 	unsigned enabled:1;
 
+	enum schedule_priority schedule;
+
 	/* -1 if not selected. */
 	int selected_order;
 };
@@ -1253,6 +1292,9 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		if (opts->schedule && tasks[i].schedule < opts->schedule)
+			continue;
+
 		trace2_region_enter("maintenance", tasks[i].name, r);
 		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
@@ -1273,13 +1315,23 @@ static void initialize_task_config(void)
 
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
@@ -1323,6 +1375,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
+			     N_("run tasks based on frequency"),
+			     maintenance_opt_schedule),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
 		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
@@ -1343,6 +1398,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 			     builtin_maintenance_run_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (opts.auto_flag && opts.schedule)
+		die(_("use at most one of --auto and --schedule=<frequency>"));
+
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c7caaa7a55..33d73cd01c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -260,4 +260,44 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	test_subcommand git multi-pack-index write --no-progress <trace-B
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

