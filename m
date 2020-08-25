Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF7EC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C37A2076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH4329kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHYSkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYSkI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348EFC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b18so3179738wrs.7
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6MQ0DSApyzKcO+/cOsR1NuHB30X7sAIp/72JSOMMcU0=;
        b=kH4329kC3V+++e6nphsulXk5/UtCl/Qh66LeHPkR4QPxOjt2Y8BeKoWkxgZn8x6PvC
         CfNljogzvors+QPxHNSL8vWkmUpPS6Gjbt3zpO7D1zczuTcOSm8XAVdcQAxNPb5IZ9Qf
         lHTvKpUBLBEOOUt6ak+qE0CGnwAfWFCQCN53cNT2z8fbnbaEIYZE7YEXew3Aq9poklRi
         sGAJ7c3EEDWmkOiGnF4HeoGujhNY2hfKbI+QyANm/a8IUjcHRC2KZ7vD9hRv6AHkAchr
         qNtHCqMWcadpWiiKJwzlTpno+ATqNYkv0Dne20bfBmtaLNw5Fid92r49rAwnRPhgvpHF
         hlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6MQ0DSApyzKcO+/cOsR1NuHB30X7sAIp/72JSOMMcU0=;
        b=XIBGI3Im7ogMxDZlioMOMLqFN3srWlfko/qG0Kw3U4boyxdd6fO4BuOR7xjszv7ezT
         FpQHjjL15tdlvHrsVeSZl60c4xT034NBjzZ7ppNzqKhnj72GMG3gPSXlV8yL2Fu8bDQ0
         +xpsSOJ7gy8iiOo43YSpLLIjYLv2bXG+szuBBcFYxR7Fe+F8kOAyCffSDHADWqDjFr5W
         5aJNyH3/2hzcVUvD//3FBvK8f/z3ERdBPS/UWx5D/3nN8nbWezQAZwFNvYMp01Pyaapw
         X9Hx1Pn1NKDSQx8ULiYa4wpM7kGrF0bI4VT/3H4Ve7faTpZRqcgssJ/tmRUaW+AqKquF
         /o7Q==
X-Gm-Message-State: AOAM5330Ax4JgCqmVr9Dv/2OUN4MrgqHfrPObU/fm3ap4tqf/+C5b+un
        poGo3EmyRychq2HRgN+6ytGoLuF1JBU=
X-Google-Smtp-Source: ABdhPJwWg5wRaRb4tCXviFyWI6Y6cK9255WdiSA0OgSfx6dIu+ugPpHhIw16XXX4oAmy/1hAl5UBCA==
X-Received: by 2002:adf:f7cd:: with SMTP id a13mr12015650wrq.296.1598380806391;
        Tue, 25 Aug 2020 11:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm28967150wro.1.2020.08.25.11.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:05 -0700 (PDT)
Message-Id: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:39:57 +0000
Subject: [PATCH v2 0/7] [RFC] Maintenance III: background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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

Some preliminary work is done to allow a new --scheduled option that
triggers enabled tasks only if they have not been run in some amount of
time. The timestamp of the previous run is stored in the 
maintenance.<task>.lastRun config value while the interval is stored in the 
maintenance.<task>.schedule config value.

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

It could be helpful for contributors to suggest ways to configure certain
jobs to run "nightly" or "overnight on a weekend" instead of just "whenever
the last run was long enough ago." One way to do this would be to set the 
lastRun config to be at the time of day that the job should run. Another
option would be to make the cron table more complicated with multiple rows,
but I would prefer to avoid that option if there is a simpler mechanism.

Note: git maintenance (start|stop) only works on machines with cron by
design. The proper thing to do on Windows will come later. Perhaps this
command should be marked as unavailable on Windows somehow, or at least a
better error than "cron may not be available on your system". I did find
that that message is helpful sometimes: macOS worker agents for CI builds
typically do not have cron available.

Updates since RFC v1
====================

 * Some fallout from rewriting the option parsing in "Maintenance I"
   
   
 * This applies cleanly on v3 of "Maintenance II"
   
   
 * Several helpful feedback items from Đoàn Trần Công Danh are applied.
   
   
 * There is an unresolved comment around the use of approxidate("now").
   These calls are untouched from v1.
   
   

Thanks, -Stolee

Derrick Stolee (7):
  maintenance: optionally skip --auto process
  maintenance: store the "last run" time in config
  maintenance: add --scheduled option and config
  for-each-repo: run subcommands on configured repos
  maintenance: add [un]register subcommands
  maintenance: add start/stop subcommands
  maintenance: recommended schedule in register/start

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  19 ++
 Documentation/git-for-each-repo.txt  |  59 ++++++
 Documentation/git-maintenance.txt    |  44 ++++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 286 ++++++++++++++++++++++++++-
 command-list.txt                     |   1 +
 git.c                                |   1 +
 run-command.c                        |   6 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               |  95 ++++++++-
 t/test-lib.sh                        |   6 +
 17 files changed, 640 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: e9bb32f53ade2067f773bfe6e5c13ed1a5d694a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-680%2Fderrickstolee%2Fmaintenance%2Fscheduled-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-680/derrickstolee/maintenance/scheduled-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/680

Range-diff vs v1:

 1:  90de25d128 ! 1:  5fdd8188b1 maintenance: optionally skip --auto process
     @@ run-command.c: int run_processes_parallel_tr2(int n, get_next_task_fn get_next_t
       	struct child_process maint = CHILD_PROCESS_INIT;
       
      +	if (!git_config_get_bool("maintenance.auto", &enabled) &&
     -+	    !enabled) {
     -+		    fprintf(stderr, "enabled: %d\n", enabled);
     ++	    !enabled)
      +		return 0;
     -+	    }
      +
       	maint.git_cmd = 1;
       	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
 2:  bdc27fa28e ! 2:  e3ef0b9bea maintenance: store the "last run" time in config
     @@ builtin/gc.c: static int compare_tasks_by_selection(const void *a_, const void *
      +	strbuf_release(&value);
      +}
      +
     - static int maintenance_run(struct maintenance_opts *opts)
     + static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       {
       	int i, found_selected = 0;
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       		     !tasks[i].auto_condition()))
       			continue;
       
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
       		if (tasks[i].fn(opts)) {
       			error(_("task '%s' failed"), tasks[i].name);
      
     - ## git-gvfs-helper (new) ##
     - Binary files /dev/null and git-gvfs-helper differ
     -
     - ## t/helper/test-gvfs-protocol (new) ##
     - Binary files /dev/null and t/helper/test-gvfs-protocol differ
     -
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto' '
       	done
 3:  4473c93b11 ! 3:  c728c57d85 maintenance: add --scheduled option and config
     @@ Documentation/git-maintenance.txt: OPTIONS
       	Do not report progress or other information over `stderr`.
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
     +@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     + }
     + 
     + static const char * const builtin_maintenance_run_usage[] = {
     +-	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
     ++	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>] [--scheduled]"),
     + 	NULL
     + };
       
     - struct maintenance_opts {
     + struct maintenance_run_opts {
       	int auto_flag;
      +	int scheduled;
       	int quiet;
     @@ builtin/gc.c: struct maintenance_task {
       
       	/* -1 if not selected. */
       	int selected_order;
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       		     !tasks[i].auto_condition()))
       			continue;
       
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
       		update_last_run(&tasks[i]);
       
       		trace2_region_enter("maintenance", tasks[i].name, r);
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       	return result;
       }
       
     @@ builtin/gc.c: static void initialize_task_config(void)
       		int config_value;
      +		char *config_str;
       
     - 		strbuf_setlen(&config_name, 0);
     +-		strbuf_setlen(&config_name, 0);
     ++		strbuf_reset(&config_name);
       		strbuf_addf(&config_name, "maintenance.%s.enabled",
     -@@ builtin/gc.c: static void initialize_task_config(void)
     + 			    tasks[i].name);
       
       		if (!git_config_get_bool(config_name.buf, &config_value))
       			tasks[i].enabled = config_value;
      +
     -+		strbuf_setlen(&config_name, 0);
     ++		strbuf_reset(&config_name);
      +		strbuf_addf(&config_name, "maintenance.%s.schedule",
      +			    tasks[i].name);
      +
     @@ builtin/gc.c: static void initialize_task_config(void)
       	}
       
       	strbuf_release(&config_name);
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 	struct option builtin_maintenance_options[] = {
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 	struct option builtin_maintenance_run_options[] = {
       		OPT_BOOL(0, "auto", &opts.auto_flag,
       			 N_("run tasks based on the state of the repository")),
      +		OPT_BOOL(0, "scheduled", &opts.scheduled,
     @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefi
       		OPT_BOOL(0, "quiet", &opts.quiet,
       			 N_("do not report progress or other information over stderr")),
       		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 			     builtin_maintenance_usage,
     - 			     PARSE_OPT_KEEP_UNKNOWN);
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 			     builtin_maintenance_run_usage,
     + 			     PARSE_OPT_STOP_AT_NON_OPTION);
       
      +	if (opts.auto_flag + opts.scheduled > 1)
      +		die(_("use at most one of the --auto and --scheduled options"));
      +
     - 	if (argc != 1)
     - 		usage_with_options(builtin_maintenance_usage,
     - 				   builtin_maintenance_options);
     + 	if (argc != 0)
     + 		usage_with_options(builtin_maintenance_run_usage,
     + 				   builtin_maintenance_run_options);
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto' '
 4:  ccb667dc6f ! 4:  0314258c5c for-each-repo: run subcommands on configured repos
     @@ Documentation/git-for-each-repo.txt (new)
      +
      +DESCRIPTION
      +-----------
     -+Run a Git commands on a list of repositories. The arguments after the
     ++Run a Git command on a list of repositories. The arguments after the
      +known options or `--` indicator are used as the arguments for the Git
     -+command.
     ++subprocess.
     ++
     ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
      +
      +For example, we could run maintenance on each of a list of repositories
      +stored in a `maintenance.repo` config variable using
     @@ Documentation/git-for-each-repo.txt (new)
      +as available. If `git for-each-repo` is run in a directory that is not a
      +Git repository, then only the system and global config is used.
      +
     ++
     ++SUBPROCESS BEHAVIOR
     ++-------------------
     ++
     ++If any `git -C <repo> <arguments>` subprocess returns a non-zero exit code,
     ++then the `git for-each-repo` process returns that exit code without running
     ++more subprocesses.
     ++
     ++Each `git -C <repo> <arguments>` subprocess inherits the standard file
     ++descriptors `stdin`, `stdout`, and `stderr`.
     ++
     ++
      +GIT
      +---
      +Part of the linkgit:git[1] suite
     @@ builtin/for-each-repo.c (new)
      +	return result;
      +}
      
     + ## command-list.txt ##
     +@@ command-list.txt: git-fetch-pack                          synchingrepositories
     + git-filter-branch                       ancillarymanipulators
     + git-fmt-merge-msg                       purehelpers
     + git-for-each-ref                        plumbinginterrogators
     ++git-for-each-repo                       plumbinginterrogators
     + git-format-patch                        mainporcelain
     + git-fsck                                ancillaryinterrogators          complete
     + git-gc                                  mainporcelain
     +
       ## git.c ##
      @@ git.c: static struct cmd_struct commands[] = {
       	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 5:  f44c6a0f20 ! 5:  c0ce1267a9 maintenance: add [un]register subcommands
     @@ Documentation/git-maintenance.txt: run::
       
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     - }
     - 
     - static const char * const builtin_maintenance_usage[] = {
     --	N_("git maintenance run [<options>]"),
     -+	N_("git maintenance <subcommand> [<options>]"),
     - 	NULL
     - };
     - 
     -@@ builtin/gc.c: static int task_option_parse(const struct option *opt,
     - 	return 0;
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 	return maintenance_run_tasks(&opts);
       }
       
     +-static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
      +static int maintenance_register(void)
      +{
      +	struct child_process config_set = CHILD_PROCESS_INIT;
     @@ builtin/gc.c: static int task_option_parse(const struct option *opt,
      +	return run_command(&config_unset);
      +}
      +
     ++static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
     + 
       int cmd_maintenance(int argc, const char **argv, const char *prefix)
       {
     - 	int i;
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 		usage_with_options(builtin_maintenance_usage,
     - 				   builtin_maintenance_options);
       
     -+	if (!strcmp(argv[0], "register"))
     + 	if (!strcmp(argv[1], "run"))
     + 		return maintenance_run(argc - 1, argv + 1, prefix);
     ++	if (!strcmp(argv[1], "register"))
      +		return maintenance_register();
     - 	if (!strcmp(argv[0], "run"))
     - 		return maintenance_run(&opts);
     -+	if (!strcmp(argv[0], "unregister"))
     ++	if (!strcmp(argv[1], "unregister"))
      +		return maintenance_unregister();
       
     - 	die(_("invalid subcommand: %s"), argv[0]);
     + 	die(_("invalid subcommand: %s"), argv[1]);
       }
      
       ## t/t7900-maintenance.sh ##
 6:  2442071fd0 ! 6:  8a7c34035a maintenance: add start/stop subcommands
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	return update_background_schedule(0);
      +}
      +
     + static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
     + 
       int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - {
     - 	int i;
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 		return maintenance_register();
     - 	if (!strcmp(argv[0], "run"))
     - 		return maintenance_run(&opts);
     -+	if (!strcmp(argv[0], "start"))
     + 
     + 	if (!strcmp(argv[1], "run"))
     + 		return maintenance_run(argc - 1, argv + 1, prefix);
     ++	if (!strcmp(argv[1], "start"))
      +		return maintenance_start();
     -+	if (!strcmp(argv[0], "stop"))
     ++	if (!strcmp(argv[1], "stop"))
      +		return maintenance_stop();
     - 	if (!strcmp(argv[0], "unregister"))
     - 		return maintenance_unregister();
     - 
     + 	if (!strcmp(argv[1], "register"))
     + 		return maintenance_register();
     + 	if (!strcmp(argv[1], "unregister"))
      
       ## t/helper/test-crontab.c (new) ##
      @@
 7:  40b1a0546c ! 7:  9ecabeb055 maintenance: recommended schedule in register/start
     @@ Documentation/git-maintenance.txt: register::
       	Run one or more maintenance tasks. If one or more `--task` options
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int task_option_parse(const struct option *opt,
     - 	return 0;
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 	return maintenance_run_tasks(&opts);
       }
       
      +static int has_schedule_config(void)

-- 
gitgitgadget
