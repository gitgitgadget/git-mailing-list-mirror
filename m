Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C855C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD84320678
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU4XHBFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgH1Pph (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgH1PpV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:45:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4BC061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x9so1329884wmi.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L6ydvAtKZh57wyabJmRQ85IpliikeefEUMVb3BPMDbM=;
        b=JU4XHBFKTthv93rsdgauqxd+EYE2Nrw2GomGc7ID9VgIgNKyeTLl3E+jIMn4MU42h/
         Sq0nJX+BwbpwzwCOrR/wNhKcF5PK7mkOmottmNnQuWtztN/mCv4IzxXYBjIdT8R0j/nD
         aEPLmT116jLPPJFQWG2gl5tfmnHgQdD4Gt/26S+EyFFGBlnk5zvXPA8dfyGIz3gkdCSh
         U5F5mtQIYbgPC8cRYIV4rQjzITVD0MdEa/i7ihQRMGpETiU5vcKD/NeNv1+wDggO0q/k
         OFpNfUilMa5zvwTadcAEX4+8o2K8GtUTl6O/cY7pBnHT92O7njd0ZnFqjiVG9+FytE77
         YVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L6ydvAtKZh57wyabJmRQ85IpliikeefEUMVb3BPMDbM=;
        b=Bsfo8Bg2Ez3Xa8Gu9HqIRSQNZ7kDUZWLInolflxEKwsNBsH5ShIwKvTA8cEpqO0C45
         zJ4UTooy57M5rkYa28vlV/V521f6XdSWPyVvodD8W6ZFERyjQ8S65i6vobTc3YPbv0m3
         UEyq6dv9XUWZh4RAJnt76wTn7jQretLynf+Lddu32lctjAVHZrSb43Z2PKDc/8/IdOyC
         6UQuOtXD5DRpaIkculXpsSrtJb901uV22AcyFlCSembK0dYvWOG9n1VL8W3vQ+4UDfga
         KYBaJBFd7KWY61XT/vZzFFcKk317SZyBmKk0AfAAnn+7+Nrc954/mw75m22wnrTPPqEV
         sVZw==
X-Gm-Message-State: AOAM533uiIeyPzOwskrfIXLWa1r4h6pVAwwjKbpVSnWf+U6iO36krt1w
        K9jIOFATOQR8PFHArKx8TFk8EH9/GfE=
X-Google-Smtp-Source: ABdhPJwObjN3snPzSBmRZEDRISs19ciY9phkO2XVMHjTSEwa/Fzs9E3OOHsw8va5VkgZmO4NMZu6uA==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr2167522wmn.27.1598629518892;
        Fri, 28 Aug 2020 08:45:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14sm2717044wmc.5.2020.08.28.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:45:18 -0700 (PDT)
Message-Id: <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Aug 2020 15:45:11 +0000
Subject: [PATCH v3 0/6] [RFC] Maintenance III: background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on v3 of Part II (ds/maintenance-part-2) [1].

[1] 
https://lore.kernel.org/git/pull.696.v3.git.1598380599.gitgitgadget@gmail.com/

This RFC is intended to show how I hope to integrate true background
maintenance into Git. As opposed to my original RFC [2], this entirely
integrates with cron (through crontab [-e|-l]) to launch maintenance
commands in the background.

[2] 
https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/

Some preliminary work is done to allow a new --schedule option that tells
the command which tasks to run based on a maintenance.<task>.schedule config
option. The timing is not enforced by Git, but instead is expected to be
provided as a hint from a cron schedule.

A new for-each-repo builtin runs Git commands on every repo in a given list.
Currently, the list is stored as a config setting, allowing a new 
maintenance.repos config list to store the repositories registered for
background maintenance. Others may want to add a --file=<file> option for
their own workflows, but I focused on making this as simple as possible for
now.

The updates to the git maintenance builtin include new register/unregister 
subcommands and start/stop subcommands. The register subcommand initializes
the config while the start subcommand does everything register does plus 
update the cron table. The unregister and stop commands reverse this
process.

The very last patch is entirely optional. It sets a recommended schedule
based on my own experience with very large repositories. I'm open to other
suggestions, but these are ones that I think work well and don't cause a
"rewrite the world" scenario like running nightly 'gc' would do.

I've been testing this scenario on my macOS laptop for a while and my Linux
machine. I have modified my cron task to provide logging via trace2 so I can
see what's happening. A future direction here would be to add some
maintenance logs to the repository so we can track what is happening and
diagnose whether the maintenance strategy is working on real repos.

Note: git maintenance (start|stop) only works on machines with cron by
design. The proper thing to do on Windows will come later. Perhaps this
command should be marked as unavailable on Windows somehow, or at least a
better error than "cron may not be available on your system". I did find
that that message is helpful sometimes: macOS worker agents for CI builds
typically do not have cron available.

Updates since RFC v2
====================

 * Update the cron schedule with three lines saying "run hourly except at
   midnight", "run daily except on first day of week", and "run weekly".
   This avoids parallel processes competing for the object database lock.
   
   
 * Update the --schedule= and 'maintenance..schedule' config options. This
   is reflected in the recommended schedule at the end.
   
   
 * Drop the *.lastRun config option. It was going to trash config files but
   it is also not needed by the new cron schedule.
   
   

I expect this to be my final RFC version before restarting the thread with a
v1 next week. Please throw any and all critique at the plan here!

Updates since RFC v1
====================

 * Some fallout from rewriting the option parsing in "Maintenance I"
   
   
 * This applies cleanly on v3 of "Maintenance II"
   
   
 * Several helpful feedback items from Đoàn Trần Công Danh are applied.
   
   
 * There is an unresolved comment around the use of approxidate("now").
   These calls are untouched from v1.
   
   

Thanks, -Stolee

Cc: sandals@crustytoothpaste.net [sandals@crustytoothpaste.net], 
steadmon@google.com [steadmon@google.com], jrnieder@gmail.com
[jrnieder@gmail.com], peff@peff.net [peff@peff.net], congdanhqx@gmail.com
[congdanhqx@gmail.com], phillip.wood123@gmail.com
[phillip.wood123@gmail.com], emilyshaffer@google.com
[emilyshaffer@google.com], sluongng@gmail.com [sluongng@gmail.com], 
jonathantanmy@google.com [jonathantanmy@google.com]

Derrick Stolee (6):
  maintenance: optionally skip --auto process
  maintenance: add --schedule option and config
  for-each-repo: run subcommands on configured repos
  maintenance: add [un]register subcommands
  maintenance: add start/stop subcommands
  maintenance: recommended schedule in register/start

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  10 +
 Documentation/git-for-each-repo.txt  |  59 ++++++
 Documentation/git-maintenance.txt    |  44 +++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 292 ++++++++++++++++++++++++++-
 command-list.txt                     |   1 +
 git.c                                |   1 +
 run-command.c                        |   6 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               | 114 ++++++++++-
 t/test-lib.sh                        |   6 +
 17 files changed, 654 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: e9bb32f53ade2067f773bfe6e5c13ed1a5d694a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-680%2Fderrickstolee%2Fmaintenance%2Fscheduled-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-680/derrickstolee/maintenance/scheduled-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/680

Range-diff vs v2:

 1:  5fdd8188b1 = 1:  5fdd8188b1 maintenance: optionally skip --auto process
 2:  e3ef0b9bea < -:  ---------- maintenance: store the "last run" time in config
 3:  c728c57d85 ! 2:  41a067894d maintenance: add --scheduled option and config
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: add --scheduled option and config
     +    maintenance: add --schedule option and config
      
          A user may want to run certain maintenance tasks based on frequency, not
          conditions given in the repository. For example, the user may want to
          perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
     -    update the 'git maintenance run --scheduled' command to check the config
     -    for the last run of that task and add a number of seconds. The task
     -    would then run only if the current time is beyond that minimum
     -    timestamp.
     +    update the 'git maintenance run' command to include a
     +    '--schedule=<frequency>' option. The allowed frequencies are 'hourly',
     +    'daily', and 'weekly'. These values are also allowed in a new config
     +    value 'maintenance.<task>.schedule'.
      
     -    Add a '--scheduled' option to 'git maintenance run' to only run tasks
     -    that have had enough time pass since their last run. This is done for
     -    each enabled task by checking if the current timestamp is at least as
     -    large as the sum of 'maintenance.<task>.lastRun' and
     -    'maintenance.<task>.schedule' in the Git config. This second value is
     -    new to this commit, storing a number of seconds intended between runs.
     +    The 'git maintenance run --schedule=<frequency>' checks the '*.schedule'
     +    config value for each enabled task to see if the configured frequency is
     +    at least as frequent as the frequency from the '--schedule' argument. We
     +    use the following order, for full clarity:
      
     -    A user could then set up an hourly maintenance run with the following
     -    cron table:
     +            'hourly' > 'daily' > 'weekly'
      
     -      0 * * * * git -C <repo> maintenance run --scheduled
     +    Use new 'enum schedule_priority' to track these values numerically.
      
     -    Then, the user could configure the repository with the following config
     -    values:
     +    The following cron table would run the scheduled tasks with the correct
     +    frequencies:
      
     -      maintenance.prefetch.schedule  3000
     -      maintenance.gc.schedule       86000
     +      0 1-23 * * *    git -C <repo> maintenance run --scheduled=hourly
     +      0 0    * * 1-6  git -C <repo> maintenance run --scheduled=daily
     +      0 0    * * 0    git -C <repo> maintenance run --scheduled=weekly
      
     -    These numbers are slightly lower than one hour and one day (in seconds).
     -    The cron schedule will enforce the hourly run rate, but we can use these
     -    schedules to ensure the 'gc' task runs once a day. The error is given
     -    because the *.lastRun config option is specified at the _start_ of the
     -    task run. Otherwise, a slow task run could shift the "daily" job of 'gc'
     -    from a 10:00pm run to 11:00pm run, or later.
     +    This cron schedule will run --scheduled=hourly every hour except at
     +    midnight. This avoids a concurrent run with the --scheduled=daily that
     +    runs at midnight every day except the first day of the week. This avoids
     +    a concurrent run with the --scheduled=weekly that runs at midnight on
     +    the first day of the week. Since --scheduled=daily also runs the
     +    'hourly' tasks and --scheduled=weekly runs the 'hourly' and 'daily'
     +    tasks, we will still see all tasks run with the proper frequencies.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/config/maintenance.txt ##
     -@@ Documentation/config/maintenance.txt: maintenance.<task>.lastRun::
     - 	`<task>` is run. It stores a timestamp representing the most-recent
     - 	run of the `<task>`.
     +@@ Documentation/config/maintenance.txt: maintenance.<task>.enabled::
     + 	`--task` option exists. By default, only `maintenance.gc.enabled`
     + 	is true.
       
      +maintenance.<task>.schedule::
      +	This config option controls whether or not the given `<task>` runs
     -+	during a `git maintenance run --scheduled` command. If the option
     -+	is an integer value `S`, then the `<task>` is run when the current
     -+	time is `S` seconds after the timestamp stored in
     -+	`maintenance.<task>.lastRun`. If the option has no value or a
     -+	non-integer value, then the task will never run with the `--scheduled`
     -+	option.
     ++	during a `git maintenance run --schedule=<frequency>` command. The
     ++	value must be one of "hourly", "daily", or "weekly".
      +
       maintenance.commit-graph.auto::
       	This integer config option controls how often the `commit-graph` task
     @@ Documentation/git-maintenance.txt: OPTIONS
       	in the `gc.auto` config setting, or when the number of pack-files
      -	exceeds the `gc.autoPackLimit` config setting.
      +	exceeds the `gc.autoPackLimit` config setting. Not compatible with
     -+	the `--scheduled` option.
     ++	the `--schedule` option.
      +
     -+--scheduled::
     ++--schedule::
      +	When combined with the `run` subcommand, run maintenance tasks
      +	only if certain time conditions are met, as specified by the
      +	`maintenance.<task>.schedule` config value for each `<task>`.
     @@ Documentation/git-maintenance.txt: OPTIONS
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     + 	return 0;
       }
       
     - static const char * const builtin_maintenance_run_usage[] = {
     +-static const char * const builtin_maintenance_run_usage[] = {
      -	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
     -+	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>] [--scheduled]"),
     ++static const char *const builtin_maintenance_run_usage[] = {
     ++	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>] [--schedule]"),
       	NULL
       };
       
     ++enum schedule_priority {
     ++	SCHEDULE_NONE = 0,
     ++	SCHEDULE_WEEKLY = 1,
     ++	SCHEDULE_DAILY = 2,
     ++	SCHEDULE_HOURLY = 3,
     ++};
     ++
     ++static enum schedule_priority parse_schedule(const char *value)
     ++{
     ++	if (!value)
     ++		return SCHEDULE_NONE;
     ++	if (!strcasecmp(value, "hourly"))
     ++		return SCHEDULE_HOURLY;
     ++	if (!strcasecmp(value, "daily"))
     ++		return SCHEDULE_DAILY;
     ++	if (!strcasecmp(value, "weekly"))
     ++		return SCHEDULE_WEEKLY;
     ++	return SCHEDULE_NONE;
     ++}
     ++
     ++static int maintenance_opt_schedule(const struct option *opt, const char *arg,
     ++				    int unset)
     ++{
     ++	enum schedule_priority *priority = opt->value;
     ++
     ++	if (unset)
     ++		die(_("--no-schedule is not allowed"));
     ++
     ++	*priority = parse_schedule(arg);
     ++
     ++	if (!*priority)
     ++		die(_("unrecognized --schedule argument '%s'"), arg);
     ++
     ++	return 0;
     ++}
     ++
       struct maintenance_run_opts {
       	int auto_flag;
     -+	int scheduled;
       	int quiet;
     ++	enum schedule_priority schedule;
       };
       
     + /* Remember to update object flag allocation in object.h */
      @@ builtin/gc.c: struct maintenance_task {
     - 	const char *name;
     - 	maintenance_task_fn *fn;
       	maintenance_auto_fn *auto_condition;
     --	unsigned enabled:1;
     -+	unsigned enabled:1,
     -+		 scheduled:1;
     + 	unsigned enabled:1;
       
     ++	enum schedule_priority schedule;
     ++
       	/* -1 if not selected. */
       	int selected_order;
     + };
      @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     - 		     !tasks[i].auto_condition()))
       			continue;
       
     -+		if (opts->scheduled && !tasks[i].scheduled)
     + 		if (opts->auto_flag &&
     +-		    (!tasks[i].auto_condition ||
     +-		     !tasks[i].auto_condition()))
     ++		    (!tasks[i].auto_condition || !tasks[i].auto_condition()))
      +			continue;
      +
     - 		update_last_run(&tasks[i]);
     ++		if (opts->schedule && tasks[i].schedule < opts->schedule)
     + 			continue;
       
       		trace2_region_enter("maintenance", tasks[i].name, r);
     -@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     - 	return result;
     - }
     - 
     -+static void fill_schedule_info(struct maintenance_task *task,
     -+			       const char *config_name,
     -+			       timestamp_t schedule_delay)
     -+{
     -+	timestamp_t now = approxidate("now");
     -+	char *value = NULL;
     -+	struct strbuf last_run = STRBUF_INIT;
     -+	int64_t previous_run;
     -+
     -+	strbuf_addf(&last_run, "maintenance.%s.lastrun", task->name);
     -+
     -+	if (git_config_get_string(last_run.buf, &value))
     -+		task->scheduled = 1;
     -+	else {
     -+		previous_run = git_config_int64(last_run.buf, value);
     -+		if (now >= previous_run + schedule_delay)
     -+			task->scheduled = 1;
     -+	}
     -+
     -+	free(value);
     -+	strbuf_release(&last_run);
     -+}
     -+
     - static void initialize_task_config(void)
     - {
     - 	int i;
      @@ builtin/gc.c: static void initialize_task_config(void)
       
       	for (i = 0; i < TASK__COUNT; i++) {
     @@ builtin/gc.c: static void initialize_task_config(void)
      +			    tasks[i].name);
      +
      +		if (!git_config_get_string(config_name.buf, &config_str)) {
     -+			timestamp_t schedule_delay = git_config_int64(
     -+							config_name.buf,
     -+							config_str);
     -+			fill_schedule_info(&tasks[i],
     -+						config_name.buf,
     -+						schedule_delay);
     ++			tasks[i].schedule = parse_schedule(config_str);
      +			free(config_str);
      +		}
       	}
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
       	struct option builtin_maintenance_run_options[] = {
       		OPT_BOOL(0, "auto", &opts.auto_flag,
       			 N_("run tasks based on the state of the repository")),
     -+		OPT_BOOL(0, "scheduled", &opts.scheduled,
     -+			 N_("run tasks based on time intervals")),
     ++		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
     ++			     N_("run tasks based on frequency"),
     ++			     maintenance_opt_schedule),
       		OPT_BOOL(0, "quiet", &opts.quiet,
       			 N_("do not report progress or other information over stderr")),
       		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
       			     builtin_maintenance_run_usage,
       			     PARSE_OPT_STOP_AT_NON_OPTION);
       
     -+	if (opts.auto_flag + opts.scheduled > 1)
     -+		die(_("use at most one of the --auto and --scheduled options"));
     ++	if (opts.auto_flag && opts.schedule)
     ++		die(_("use at most one of --auto and --schedule=<frequency>"));
      +
       	if (argc != 0)
       		usage_with_options(builtin_maintenance_run_usage,
     @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
       	done
       '
       
     -+test_expect_success '--auto and --scheduled incompatible' '
     -+	test_must_fail git maintenance run --auto --scheduled 2>err &&
     ++test_expect_success '--auto and --schedule incompatible' '
     ++	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
      +	test_i18ngrep "at most one" err
      +'
      +
     - test_expect_success 'tasks update maintenance.<task>.lastRun' '
     - 	git config --unset maintenance.commit-graph.lastrun &&
     - 	GIT_TRACE2_EVENT="$(pwd)/run.txt" \
     -@@ t/t7900-maintenance.sh: test_expect_success 'tasks update maintenance.<task>.lastRun' '
     - 	test_cmp_config 1595000000 maintenance.commit-graph.lastrun
     - '
     - 
     -+test_expect_success '--scheduled with specific time' '
     -+	git config maintenance.commit-graph.schedule 100 &&
     -+	GIT_TRACE2_EVENT="$(pwd)/too-soon.txt" \
     -+		GIT_TEST_DATE_NOW=1595000099 \
     -+		git maintenance run --scheduled 2>/dev/null &&
     ++test_expect_success 'invalid --schedule value' '
     ++	test_must_fail git maintenance run --schedule=annually 2>err &&
     ++	test_i18ngrep "unrecognized --schedule" err
     ++'
     ++
     ++test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
     ++	git config maintenance.loose-objects.enabled true &&
     ++	git config maintenance.loose-objects.schedule hourly &&
     ++	git config maintenance.commit-graph.enabled true &&
     ++	git config maintenance.commit-graph.schedule daily &&
     ++	git config maintenance.incremental-repack.enabled true &&
     ++	git config maintenance.incremental-repack.schedule weekly &&
     ++
     ++	GIT_TRACE2_EVENT="$(pwd)/hourly.txt" \
     ++		git maintenance run --schedule=hourly 2>/dev/null &&
     ++	test_subcommand git prune-packed --quiet <hourly.txt &&
      +	test_subcommand ! git commit-graph write --split --reachable \
     -+		--no-progress <too-soon.txt &&
     -+	GIT_TRACE2_EVENT="$(pwd)/long-enough.txt" \
     -+		GIT_TEST_DATE_NOW=1595000100 \
     -+		git maintenance run --scheduled 2>/dev/null &&
     ++		--no-progress <hourly.txt &&
     ++	test_subcommand ! git multi-pack-index write --no-progress <hourly.txt &&
     ++
     ++	GIT_TRACE2_EVENT="$(pwd)/daily.txt" \
     ++		git maintenance run --schedule=daily 2>/dev/null &&
     ++	test_subcommand git prune-packed --quiet <daily.txt &&
     ++	test_subcommand git commit-graph write --split --reachable \
     ++		--no-progress <daily.txt &&
     ++	test_subcommand ! git multi-pack-index write --no-progress <daily.txt &&
     ++
     ++	GIT_TRACE2_EVENT="$(pwd)/weekly.txt" \
     ++		git maintenance run --schedule=weekly 2>/dev/null &&
     ++	test_subcommand git prune-packed --quiet <weekly.txt &&
      +	test_subcommand git commit-graph write --split --reachable \
     -+		--no-progress <long-enough.txt &&
     -+	test_cmp_config 1595000100 maintenance.commit-graph.lastrun
     ++		--no-progress <weekly.txt &&
     ++	test_subcommand git multi-pack-index write --no-progress <weekly.txt
      +'
      +
       test_done
 4:  0314258c5c = 3:  b29b68614b for-each-repo: run subcommands on configured repos
 5:  c0ce1267a9 ! 4:  fc741fab5a maintenance: add [un]register subcommands
     @@ t/t7900-maintenance.sh: GIT_TEST_MULTI_PACK_INDEX=0
       	test_expect_code 128 git maintenance barf 2>err &&
       	test_i18ngrep "invalid subcommand: barf" err
       '
     -@@ t/t7900-maintenance.sh: test_expect_success '--scheduled with specific time' '
     - 	test_cmp_config 1595000100 maintenance.commit-graph.lastrun
     +@@ t/t7900-maintenance.sh: test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
     + 	test_subcommand git multi-pack-index write --no-progress <weekly.txt
       '
       
      +test_expect_success 'register and unregister' '
 6:  8a7c34035a ! 5:  e9672c6a6c maintenance: add start/stop subcommands
     @@ Commit message
          maintenance using 'cron', when available. This integration is as simple
          as I could make it, barring some implementation complications.
      
     -    For now, the background maintenance is scheduled to run hourly via the
     -    following cron table row (ignore line breaks):
     +    The schedule is laid out as follows:
      
     -            0 * * * * $p/git --exec-path=$p
     -                    for-each-repo --config=maintenance.repo
     -                    maintenance run --scheduled
     +      0 1-23 * * *   $cmd maintenance run --schedule=hourly
     +      0 0    * * 1-6 $cmd maintenance run --schedule=daily
     +      0 0    * * 0   $cmd maintenance run --schedule=weekly
      
     -    Future extensions may want to add more complex schedules or some form of
     -    logging. For now, hourly runs seem frequent enough to satisfy the needs
     -    of tasks like 'prefetch' without being so frequent that users would
     -    complain about many no-op commands.
     +    where $cmd is a properly-qualified 'git for-each-repo' execution:
      
     -    Here, "$p" is a placeholder for the path to the current Git executable.
     -    This is critical for systems with multiple versions of Git.
     -    Specifically, macOS has a system version at '/usr/bin/git' while the
     -    version that users can install resides at '/usr/local/bin/git' (symlinked
     -    to '/usr/local/libexec/git-core/git'). This will also use your
     -    locally-built version if you build and run this in your development
     +    $cmd=$path/git --exec-path=$path for-each-repo --config=maintenance.repo
     +
     +    where $path points to the location of the Git executable running 'git
     +    maintenance start'. This is critical for systems with multiple versions
     +    of Git. Specifically, macOS has a system version at '/usr/bin/git' while
     +    the version that users can install resides at '/usr/local/bin/git'
     +    (symlinked to '/usr/local/libexec/git-core/git'). This will also use
     +    your locally-built version if you build and run this in your development
          environment without installing first.
      
     +    This conditional schedule avoids having cron launch multiple 'git
     +    for-each-repo' commands in parallel. Such parallel commands would likely
     +    lead to the 'hourly' and 'daily' tasks competing over the object
     +    database lock. This could lead to to some tasks never being run! Since
     +    the --schedule=<frequency> argument will run all tasks with _at least_
     +    the given frequency, the daily runs will also run the hourly tasks.
     +    Similarly, the weekly runs will also run the daily and hourly tasks.
     +
          The GIT_TEST_CRONTAB environment variable is not intended for users to
          edit, but instead as a way to mock the 'crontab [-l]' command. This
          variable is set in test-lib.sh to avoid a future test from accidentally
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	}
      +
      +	if (run_maintenance) {
     ++		struct strbuf line_format = STRBUF_INIT;
      +		const char *exec_path = git_exec_path();
      +
     -+		fprintf(cron_in, "\n%s\n", BEGIN_LINE);
     -+		fprintf(cron_in, "# The following schedule was created by Git\n");
     ++		fprintf(cron_in, "%s\n", BEGIN_LINE);
     ++		fprintf(cron_in,
     ++			"# The following schedule was created by Git\n");
      +		fprintf(cron_in, "# Any edits made in this region might be\n");
     -+		fprintf(cron_in, "# replaced in the future by a Git command.\n\n");
     -+
      +		fprintf(cron_in,
     -+			"0 * * * * \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --scheduled\n",
     -+			exec_path, exec_path);
     ++			"# replaced in the future by a Git command.\n\n");
     ++
     ++		strbuf_addf(&line_format,
     ++			    "%%s %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
     ++			    exec_path, exec_path);
     ++		fprintf(cron_in, line_format.buf, "0", "1-23", "*", "hourly");
     ++		fprintf(cron_in, line_format.buf, "0", "0", "1-6", "daily");
     ++		fprintf(cron_in, line_format.buf, "0", "0", "0", "weekly");
     ++		strbuf_release(&line_format);
      +
      +		fprintf(cron_in, "\n%s\n", END_LINE);
      +	}
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	grep "for-each-repo --config=maintenance.repo maintenance run --scheduled" cron.txt
     ++	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
     ++	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
     ++	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
      +'
      +
      +test_expect_success 'stop from existing schedule' '
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	# The newline is preserved
     -+	echo >empty &&
     -+	test_cmp empty cron.txt &&
     -+
      +	# Operation is idempotent
      +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
     -+	test_cmp empty cron.txt
     ++	test_must_be_empty cron.txt
      +'
      +
      +test_expect_success 'start preserves existing schedule' '
 7:  9ecabeb055 ! 6:  62e8db8b2a maintenance: recommended schedule in register/start
     @@ Commit message
          repository. It does not specify what maintenance should occur or how
          often.
      
     -    If a user sets any 'maintenance.<task>.scheduled' config value, then
     +    If a user sets any 'maintenance.<task>.schedule' config value, then
          they have chosen a specific schedule for themselves and Git should
          respect that.
      
     @@ Commit message
          schedule we use in Scalar and VFS for Git for very large repositories
          using the GVFS protocol. While the schedule works in that environment,
          it is possible that "normal" Git repositories could benefit from
     -    something more obvious (such as running 'gc' once a day). However, this
     +    something more obvious (such as running 'gc' weekly). However, this
          patch gives us a place to start a conversation on what we should
          recommend. For my purposes, Scalar will set these config values so we
          can always differ from core Git's recommendations.
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      +	prefix = config_name.len;
      +
      +	for (i = 0; !found && i < TASK__COUNT; i++) {
     -+		int value;
     ++		char *value;
      +
      +		strbuf_setlen(&config_name, prefix);
      +		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
      +
     -+		if (!git_config_get_int(config_name.buf, &value))
     ++		if (!git_config_get_string(config_name.buf, &value)) {
      +			found = 1;
     ++			FREE_AND_NULL(value);
     ++		}
      +	}
      +
      +	strbuf_release(&config_name);
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      +	git_config_set("maintenance.gc.enabled", "false");
      +
      +	git_config_set("maintenance.prefetch.enabled", "true");
     -+	git_config_set("maintenance.prefetch.schedule", "3500");
     ++	git_config_set("maintenance.prefetch.schedule", "hourly");
      +
      +	git_config_set("maintenance.commit-graph.enabled", "true");
     -+	git_config_set("maintenance.commit-graph.schedule", "3500");
     ++	git_config_set("maintenance.commit-graph.schedule", "hourly");
      +
      +	git_config_set("maintenance.loose-objects.enabled", "true");
     -+	git_config_set("maintenance.loose-objects.schedule", "86000");
     ++	git_config_set("maintenance.loose-objects.schedule", "daily");
      +
      +	git_config_set("maintenance.incremental-repack.enabled", "true");
     -+	git_config_set("maintenance.incremental-repack.schedule", "86000");
     ++	git_config_set("maintenance.incremental-repack.schedule", "daily");
      +}
      +
       static int maintenance_register(void)
     @@ builtin/gc.c: static int maintenance_register(void)
       	if (!the_repository || !the_repository->gitdir)
       		return 0;
       
     -+	if (has_schedule_config())
     ++	if (!has_schedule_config())
      +		set_recommended_schedule();
      +
       	config_get.git_cmd = 1;
     @@ builtin/gc.c: static int maintenance_register(void)
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
     + 	git config --global --add maintenance.repo /existing1 &&
       	git config --global --add maintenance.repo /existing2 &&
       	git config --global --get-all maintenance.repo >before &&
     ++
     ++	# We still have maintenance.<task>.schedule config set,
     ++	# so this does not update the local schedule
     ++	git maintenance register &&
     ++	test_must_fail git config maintenance.auto &&
     ++
     ++	# Clear previous maintenance.<task>.schedule values
     ++	for task in loose-objects commit-graph incremental-repack
     ++	do
     ++		git config --unset maintenance.$task.schedule || return 1
     ++	done &&
       	git maintenance register &&
      +	test_cmp_config false maintenance.auto &&
      +	test_cmp_config false maintenance.gc.enabled &&
      +	test_cmp_config true maintenance.prefetch.enabled &&
     -+	test_cmp_config 3500 maintenance.commit-graph.schedule &&
     -+	test_cmp_config 86000 maintenance.incremental-repack.schedule &&
     ++	test_cmp_config hourly maintenance.commit-graph.schedule &&
     ++	test_cmp_config daily maintenance.incremental-repack.schedule &&
       	git config --global --get-all maintenance.repo >actual &&
       	cp before after &&
       	pwd >>after &&

-- 
gitgitgadget
