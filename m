Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB6C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6F2207BC
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwnZ2+KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgJENES (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgJENEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6070CC0613B0
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:57:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so8677146wmh.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WgI1xxWHSptg9OcVrUSOlzq65TWa7M7BiTvuAIRDnCQ=;
        b=DwnZ2+KDnbQr3psIgYg4bpTRK/hPRPv2nzfEjfqYZmj9OUiW83Joa73gz4CfBwoYAe
         Q67wPO7GxeOdyxj64sNj0zEVOEdVKVRmyHamXZ2URqOvbpMJNBRYqEAng5WerXQ5r30n
         VrzOFDK0uLtU1rB2YF+rMAWlzVXv3SDskWvqMfepdXWCH+I+SVIh2ORDG+OomHOoCQZn
         8ElfSEXMPSt6ype4xG8rRIMGMegjkL+ija0AKjEqx2IZNHOcnNYt5Xzy4TNKNmX/J/bS
         qHro5/0Iqmcivud4NuwoBilOH69AnHFA4aYwepcg2NQvH/isRUK9PdzJHI88i0n38YFw
         7ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WgI1xxWHSptg9OcVrUSOlzq65TWa7M7BiTvuAIRDnCQ=;
        b=DlcCIUFLkigK5VOIjrpcaRZ52XhbEiYlhvGDFAh8xxlXpADmQ+kKrtNvpTvRqqsXoG
         9EF1BqboghJnK7qk5ZGDfqUZW89WTB/G8phvj6N9+xrshsJZNC2Xl7pfyF3bxFM2t3f9
         W/f+8NyU+UoBv8llcunBfqgDZ/VXv5iiff9FYwrHAHAnCMUVNTv2TJVbS47K5nRYlfR8
         pzjeR/FplgVXzNuuplSW9Y0/xqthgW1tL3DRYIuhPJea1IzLcTISiLo4V8+JEK6axARZ
         cA7hgyGsHVPhgQj/ImPadTg6FZ2M41Omt1gFR6Vduh3hSADwTNqbOy+E6frVnSkv1pWI
         ewNA==
X-Gm-Message-State: AOAM532slxaolxZ3MuU1SRAbp1NbrOYrDLwmmeRCN36odNGmnXJMLWU6
        cy+GAYU0LqfRdXnMK4DGz39x035BzNo=
X-Google-Smtp-Source: ABdhPJy7SQTzMTadyALN98TaZVU3z6fHwoaxjvH4cSNLWlT8tSc/9ASeV86DgplJuAkbS97oQzXxcA==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr5836539wmj.167.1601902636558;
        Mon, 05 Oct 2020 05:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm9326919wrh.70.2020.10.05.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:57:16 -0700 (PDT)
Message-Id: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
References: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 12:57:07 +0000
Subject: [PATCH v3 0/7] Maintenance III: Background maintenance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/maintenance-part-2 and replaces the RFC from [1].

[1] 
https://lore.kernel.org/git/pull.680.v3.git.1598629517.gitgitgadget@gmail.com/

This series introduces background maintenance to Git, through an integration
with cron and crontab.

Some preliminary work is done to allow a new --schedule option that tells
the command which tasks to run based on a maintenance.<task>.schedule config
option. The timing is not enforced by Git, but instead is expected to be
provided as a hint from a cron schedule. The options are "hourly", "daily",
and "weekly".

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

A troubleshooting guide is added to Documentation/git-maintenance.txt to
advise expert users who choose to create custom cron schedules.

The very last patch is entirely optional. It sets a recommended schedule
based on my own experience with very large repositories. I'm open to other
suggestions, but these are ones that I think work well and don't cause a
"rewrite the world" scenario like running nightly 'gc' would do.

I've been testing this scenario on my macOS laptop and Linux desktop. I have
modified my cron task to provide logging via trace2 so I can see what's
happening. A future direction here would be to add some maintenance logs to
the repository so we can track what is happening and diagnose whether the
maintenance strategy is working on real repos.

Note: git maintenance (start|stop) only works on machines with cron by
design. The proper thing to do on Windows will come later. Perhaps this
command should be marked as unavailable on Windows somehow, or at least a
better error than "cron may not be available on your system". I did find
that that message is helpful sometimes: macOS worker agents for CI builds
typically do not have cron available.

Updates in v3:

 * Instead of writing config upon "register" or "start", simply create an
   in-memory default schedule when no .schedule or .enabled configs are
   present. Thanks, Martin! This causes patch 6 to look so different that
   the range-diff considers it a dropped-and-added patch instead of showing
   a diff.
 * There are some context lines that changed because this is rebased onto a
   recent version of ds/maintenance-part-2.

Updates in v2:

 * Fixed the char/int issue in test-tool crontab, and a typo.
 * Updated commit message and patch noise in PATCH 2
 * This should fix the test failures, allowing this to be picked up in
   'seen'.

Derrick Stolee (7):
  maintenance: optionally skip --auto process
  maintenance: add --schedule option and config
  for-each-repo: run subcommands on configured repos
  maintenance: add [un]register subcommands
  maintenance: add start/stop subcommands
  maintenance: use default schedule if not configured
  maintenance: add troubleshooting guide to docs

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  10 +
 Documentation/git-for-each-repo.txt  |  59 ++++++
 Documentation/git-maintenance.txt    |  97 ++++++++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 301 ++++++++++++++++++++++++++-
 command-list.txt                     |   1 +
 git.c                                |   1 +
 run-command.c                        |   6 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               | 101 ++++++++-
 t/test-lib.sh                        |   6 +
 17 files changed, 705 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: e841a79a131d8ce491cf04d0ca3e24f139a10b82
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-724%2Fderrickstolee%2Fmaintenance%2Fscheduled-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-724/derrickstolee/maintenance/scheduled-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/724

Range-diff vs v2:

 1:  b21cd68c90 = 1:  02e7286dba maintenance: optionally skip --auto process
 2:  e2d14d66d4 ! 2:  dae8c04bb5 maintenance: add --schedule option and config
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto' '
     - 	done
     + 	test_subcommand git multi-pack-index write --no-progress <trace-B
       '
       
      +test_expect_success '--auto and --schedule incompatible' '
 3:  41a346dfbb = 3:  dd92379273 for-each-repo: run subcommands on configured repos
 4:  1f49cda18e ! 4:  922b984c8a maintenance: add [un]register subcommands
     @@ t/t7900-maintenance.sh: GIT_TEST_MULTI_PACK_INDEX=0
      -	test_i18ngrep "usage: git maintenance run" err &&
      +	test_i18ngrep "usage: git maintenance <subcommand>" err &&
       	test_expect_code 128 git maintenance barf 2>err &&
     - 	test_i18ngrep "invalid subcommand: barf" err
     - '
     + 	test_i18ngrep "invalid subcommand: barf" err &&
     + 	test_expect_code 129 git maintenance 2>err &&
      @@ t/t7900-maintenance.sh: test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
       	test_subcommand git multi-pack-index write --no-progress <weekly.txt
       '
 5:  e9b2a39c1d ! 5:  5194f6b1fa maintenance: add start/stop subcommands
     @@ Makefile: TEST_BUILTINS_OBJS += test-advise.o
      
       ## builtin/gc.c ##
      @@
     + #include "refs.h"
       #include "remote.h"
     - #include "midx.h"
       #include "object-store.h"
      +#include "exec-cmd.h"
       
 6:  f609c1bde2 ! 6:  d833fffe89 maintenance: recommended schedule in register/start
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: recommended schedule in register/start
     +    maintenance: use default schedule if not configured
      
          The 'git maintenance (register|start)' subcommands add the current
          repository to the global Git config so maintenance will operate on that
     @@ Commit message
      
          If a user sets any 'maintenance.<task>.schedule' config value, then
          they have chosen a specific schedule for themselves and Git should
     -    respect that.
     +    respect that when running 'git maintenance run --schedule=<frequency>'.
      
     -    However, in an effort to recommend a good schedule for repositories of
     -    all sizes, set new config values for recommended tasks that are safe to
     -    run in the background while users run foreground Git commands. These
     -    commands are generally everything but the 'gc' task.
     +    To make this process extremely simple for users, assume a default
     +    schedule when no 'maintenance.<task>.schedule' or '...enabled' config
     +    settings are concretely set. This is only an in-process assumption, so
     +    future versions of Git could adjust this expected schedule.
      
     +    Helped-by: Martin Ågren <martin.agren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     @@ Documentation/git-maintenance.txt: register::
       	for running in the background without disrupting foreground
       	processes.
      ++
     -+If your repository has no 'maintenance.<task>.schedule' configuration
     -+values set, then Git will set configuration values to some recommended
     -+settings. These settings disable foreground maintenance while performing
     -+maintenance tasks in the background that will not interrupt foreground Git
     -+operations.
     ++If your repository has no `maintenance.<task>.schedule` configuration
     ++values set, then Git will use a recommended default schedule that performs
     ++background maintenance that will not interrupt foreground commands. The
     ++default schedule is as follows:
     +++
     ++* `gc`: disabled.
     ++* `commit-graph`: hourly.
     ++* `prefetch`: hourly.
     ++* `loose-objects`: daily.
     ++* `incremental-repack`: daily.
     +++
     ++`git maintenance register` will also disable foreground maintenance by
     ++setting `maintenance.auto = false` in the current repository. This config
     ++setting will remain after a `git maintenance unregister` command.
       
       run::
       	Run one or more maintenance tasks. If one or more `--task` options
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     - 	return maintenance_run_tasks(&opts);
     +@@ builtin/gc.c: static int compare_tasks_by_selection(const void *a_, const void *b_)
     + 	return b->selected_order - a->selected_order;
       }
       
      +static int has_schedule_config(void)
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      +			found = 1;
      +			FREE_AND_NULL(value);
      +		}
     ++
     ++		strbuf_setlen(&config_name, prefix);
     ++		strbuf_addf(&config_name, "%s.enabled", tasks[i].name);
     ++
     ++		if (!git_config_get_string(config_name.buf, &value)) {
     ++			found = 1;
     ++			FREE_AND_NULL(value);
     ++		}
      +	}
      +
      +	strbuf_release(&config_name);
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      +
      +static void set_recommended_schedule(void)
      +{
     -+	git_config_set("maintenance.auto", "false");
     -+	git_config_set("maintenance.gc.enabled", "false");
     ++	if (has_schedule_config())
     ++		return;
     ++
     ++	tasks[TASK_GC].enabled = 0;
      +
     -+	git_config_set("maintenance.prefetch.enabled", "true");
     -+	git_config_set("maintenance.prefetch.schedule", "hourly");
     ++	tasks[TASK_PREFETCH].enabled = 1;
     ++	tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
      +
     -+	git_config_set("maintenance.commit-graph.enabled", "true");
     -+	git_config_set("maintenance.commit-graph.schedule", "hourly");
     ++	tasks[TASK_COMMIT_GRAPH].enabled = 1;
     ++	tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
      +
     -+	git_config_set("maintenance.loose-objects.enabled", "true");
     -+	git_config_set("maintenance.loose-objects.schedule", "daily");
     ++	tasks[TASK_LOOSE_OBJECTS].enabled = 1;
     ++	tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
      +
     -+	git_config_set("maintenance.incremental-repack.enabled", "true");
     -+	git_config_set("maintenance.incremental-repack.schedule", "daily");
     ++	tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
     ++	tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
      +}
      +
     - static int maintenance_register(void)
     + static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       {
     - 	struct child_process config_set = CHILD_PROCESS_INIT;
     + 	int i, found_selected = 0;
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     + 
     + 	if (found_selected)
     + 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
     ++	else if (opts->schedule != SCHEDULE_NONE)
     ++		set_recommended_schedule();
     + 
     + 	for (i = 0; i < TASK__COUNT; i++) {
     + 		if (found_selected && tasks[i].selected_order < 0)
      @@ builtin/gc.c: static int maintenance_register(void)
       	if (!the_repository || !the_repository->gitdir)
       		return 0;
       
     -+	if (!has_schedule_config())
     -+		set_recommended_schedule();
     ++	/* Disable foreground maintenance */
     ++	git_config_set("maintenance.auto", "false");
      +
       	config_get.git_cmd = 1;
       	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
       	git config --global --add maintenance.repo /existing2 &&
       	git config --global --get-all maintenance.repo >before &&
      +
     -+	# We still have maintenance.<task>.schedule config set,
     -+	# so this does not update the local schedule
     -+	git maintenance register &&
     -+	test_must_fail git config maintenance.auto &&
     -+
     -+	# Clear previous maintenance.<task>.schedule values
     -+	for task in loose-objects commit-graph incremental-repack
     -+	do
     -+		git config --unset maintenance.$task.schedule || return 1
     -+	done &&
       	git maintenance register &&
     +-	git config --global --get-all maintenance.repo >actual &&
     +-	cp before after &&
     +-	pwd >>after &&
     +-	test_cmp after actual &&
      +	test_cmp_config false maintenance.auto &&
     -+	test_cmp_config false maintenance.gc.enabled &&
     -+	test_cmp_config true maintenance.prefetch.enabled &&
     -+	test_cmp_config hourly maintenance.commit-graph.schedule &&
     -+	test_cmp_config daily maintenance.incremental-repack.schedule &&
     ++	git config --global --get-all maintenance.repo >between &&
     ++	cp before expect &&
     ++	pwd >>expect &&
     ++	test_cmp expect between &&
     ++
     + 	git maintenance unregister &&
       	git config --global --get-all maintenance.repo >actual &&
     - 	cp before after &&
     - 	pwd >>after &&
     + 	test_cmp before actual
 7:  2344eff4ba = 7:  8e42ff44ce maintenance: add troubleshooting guide to docs

-- 
gitgitgadget
