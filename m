Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C889C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D0F22254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOKM593x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbgJORWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390145AbgJORWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A52C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e18so4486168wrw.9
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aVpP+GpRu8jI20C0/ZuzUWyt/P9WpeBowYcWosZE8tg=;
        b=qOKM593xF1QUYsgEV3KNAStxBl55YbnRFU+GIPQQls7d1+jFBOkB9nFBQE1cO/CIFh
         lkofDusurnDbNoi/fMYUesV3/6bpZnDGT5UDSoMzwB+GMRL7S6B3cMX3bW6RRsgoIuUt
         qi0WzwDWlbZTI/g2hwqJPLKOZulTqENzeP1FwL3Q6mjmI4xxppVu7SWF2neKaQiTAVVy
         +CwMoDTO6zWPaUw1XAK32ibHwdW8+we4HL1YDhAeW/fA+43DdRfwc1YZTQOh7zb0/IaG
         YPH5btQ/v1PIGgb2Hcvq8dqUD3DKvz9UbLi6oU4SYh56Vl34qIuytIOTOWITPfJKFXgz
         nklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=aVpP+GpRu8jI20C0/ZuzUWyt/P9WpeBowYcWosZE8tg=;
        b=sASei2wpAbtH2Z/u1EySSqs+w5b4gzVTkJ9YM5XKFxP8YBw0c1Y1lSfZOuXpHrW1Hu
         goPrl+m7AtqnbPxWxO6grrRMtVzXUxxzHoYnPHsrx3OcxyKgpro/kRutqA21NgLAnTF1
         OxAlzbRzdSsAhKMGhX4B+XNCh08wcimQ34g8QnDfMX/Bww4pdWUgF/RZkg2o+Vlby/h0
         Zoz6JJ3Ngp5IXcJffmzvbwBHNo69gpgyPIq9StC6sHlkwD8OvraI/S5DHbTdNcmr2mXF
         1b2FqFlBPk3jwAE9mS8+/4o7Ad8Z/nl81nzSgn5D2VKgbIc4sTDuIDmlQsfOklwdsIpI
         TBzw==
X-Gm-Message-State: AOAM530YPxQEGBSdBrmzik0Oz30ZBs8m4gh4NF6Go6/XdwbHap1b42/Y
        vDR+SW4gX0EY28yFO8tUJE60flRkx2c=
X-Google-Smtp-Source: ABdhPJyoJODJKTR8v9pn8AxYq9LouV2HpXAmnj2vb00+Y5QMftmTvTvbrEnZHZtkeSK94T5g1M+4uA==
X-Received: by 2002:adf:e685:: with SMTP id r5mr5996322wrm.340.1602782525415;
        Thu, 15 Oct 2020 10:22:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm5344134wrp.74.2020.10.15.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:04 -0700 (PDT)
Message-Id: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:21:56 +0000
Subject: [PATCH v4 0/8] Maintenance III: Background maintenance
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
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
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

A new config option "maintenance.strategy" allows users to pick from one of
a potentially-expanding number of recommended schedules. Currently, the only
one baked-in is "incremental" although the documentation specifies that
"none" will prevent any tasks from running by default. Using that value
prevents the config from being overridden in "git maintenance
(start|register)". Users can augment the incremental strategy by assigning
specific "maintenance..schedule" config options.

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

Updates in v4:

 * Thanks, Martin for pointing out a usability concern with how I was
   previously assigning a default schedule.
 * The new logic is to create a new "maintenance.strategy" config option,
   which can be explicitly disabled or augmented.
 * This approach should be a suitable blend of the two previous options, and
   gives us flexibility to adjust the schedule or add more strategies in the
   future!

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

Derrick Stolee (8):
  maintenance: optionally skip --auto process
  maintenance: add --schedule option and config
  for-each-repo: run subcommands on configured repos
  maintenance: add [un]register subcommands
  maintenance: add start/stop subcommands
  maintenance: create maintenance.strategy config
  maintenance: use 'incremental' strategy by default
  maintenance: add troubleshooting guide to docs

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  25 +++
 Documentation/git-for-each-repo.txt  |  59 ++++++
 Documentation/git-maintenance.txt    |  99 +++++++++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 281 ++++++++++++++++++++++++++-
 command-list.txt                     |   1 +
 git.c                                |   1 +
 run-command.c                        |   6 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               | 159 ++++++++++++++-
 t/test-lib.sh                        |   6 +
 17 files changed, 758 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: e841a79a131d8ce491cf04d0ca3e24f139a10b82
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-724%2Fderrickstolee%2Fmaintenance%2Fscheduled-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-724/derrickstolee/maintenance/scheduled-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/724

Range-diff vs v3:

 1:  02e7286dba = 1:  02e7286dba maintenance: optionally skip --auto process
 2:  dae8c04bb5 = 2:  dae8c04bb5 maintenance: add --schedule option and config
 3:  dd92379273 = 3:  dd92379273 for-each-repo: run subcommands on configured repos
 4:  922b984c8a = 4:  922b984c8a maintenance: add [un]register subcommands
 5:  5194f6b1fa = 5:  5194f6b1fa maintenance: add start/stop subcommands
 -:  ---------- > 6:  d696848b37 maintenance: create maintenance.strategy config
 6:  d833fffe89 ! 7:  145c63ed8c maintenance: use default schedule if not configured
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: use default schedule if not configured
     +    maintenance: use 'incremental' strategy by default
      
          The 'git maintenance (register|start)' subcommands add the current
          repository to the global Git config so maintenance will operate on that
          repository. It does not specify what maintenance should occur or how
          often.
      
     -    If a user sets any 'maintenance.<task>.schedule' config value, then
     -    they have chosen a specific schedule for themselves and Git should
     -    respect that when running 'git maintenance run --schedule=<frequency>'.
     -
     -    To make this process extremely simple for users, assume a default
     -    schedule when no 'maintenance.<task>.schedule' or '...enabled' config
     -    settings are concretely set. This is only an in-process assumption, so
     -    future versions of Git could adjust this expected schedule.
     +    To make it simple for users to start background maintenance with a
     +    recommended schedlue, update the 'maintenance.strategy' config option in
     +    both the 'register' and 'start' subcommands. This allows users to
     +    customize beyond the defaults using individual
     +    'maintenance.<task>.schedule' options, but also the user can opt-out of
     +    this strategy using 'maintenance.strategy=none'.
      
          Helped-by: Martin Ågren <martin.agren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ Documentation/git-maintenance.txt: register::
       	for running in the background without disrupting foreground
       	processes.
      ++
     -+If your repository has no `maintenance.<task>.schedule` configuration
     -+values set, then Git will use a recommended default schedule that performs
     -+background maintenance that will not interrupt foreground commands. The
     -+default schedule is as follows:
     ++The `register` subcomand will also set the `maintenance.strategy` config
     ++value to `incremental`, if this value is not previously set. The
     ++`incremental` strategy uses the following schedule for each maintenance
     ++task:
      ++
     ++--
      +* `gc`: disabled.
      +* `commit-graph`: hourly.
      +* `prefetch`: hourly.
      +* `loose-objects`: daily.
      +* `incremental-repack`: daily.
     ++--
      ++
      +`git maintenance register` will also disable foreground maintenance by
      +setting `maintenance.auto = false` in the current repository. This config
     @@ Documentation/git-maintenance.txt: register::
       	Run one or more maintenance tasks. If one or more `--task` options
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int compare_tasks_by_selection(const void *a_, const void *b_)
     - 	return b->selected_order - a->selected_order;
     - }
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
       
     -+static int has_schedule_config(void)
     -+{
     -+	int i, found = 0;
     -+	struct strbuf config_name = STRBUF_INIT;
     -+	size_t prefix;
     -+
     -+	strbuf_addstr(&config_name, "maintenance.");
     -+	prefix = config_name.len;
     -+
     -+	for (i = 0; !found && i < TASK__COUNT; i++) {
     -+		char *value;
     -+
     -+		strbuf_setlen(&config_name, prefix);
     -+		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
     -+
     -+		if (!git_config_get_string(config_name.buf, &value)) {
     -+			found = 1;
     -+			FREE_AND_NULL(value);
     -+		}
     -+
     -+		strbuf_setlen(&config_name, prefix);
     -+		strbuf_addf(&config_name, "%s.enabled", tasks[i].name);
     -+
     -+		if (!git_config_get_string(config_name.buf, &value)) {
     -+			found = 1;
     -+			FREE_AND_NULL(value);
     -+		}
     -+	}
     -+
     -+	strbuf_release(&config_name);
     -+	return found;
     -+}
     -+
     -+static void set_recommended_schedule(void)
     -+{
     -+	if (has_schedule_config())
     -+		return;
     -+
     -+	tasks[TASK_GC].enabled = 0;
     -+
     -+	tasks[TASK_PREFETCH].enabled = 1;
     -+	tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
     -+
     -+	tasks[TASK_COMMIT_GRAPH].enabled = 1;
     -+	tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
     -+
     -+	tasks[TASK_LOOSE_OBJECTS].enabled = 1;
     -+	tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
     -+
     -+	tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
     -+	tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
     -+}
     -+
     - static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     + static int maintenance_register(void)
       {
     - 	int i, found_selected = 0;
     -@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     - 
     - 	if (found_selected)
     - 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
     -+	else if (opts->schedule != SCHEDULE_NONE)
     -+		set_recommended_schedule();
     ++	char *config_value;
     + 	struct child_process config_set = CHILD_PROCESS_INIT;
     + 	struct child_process config_get = CHILD_PROCESS_INIT;
       
     - 	for (i = 0; i < TASK__COUNT; i++) {
     - 		if (found_selected && tasks[i].selected_order < 0)
      @@ builtin/gc.c: static int maintenance_register(void)
       	if (!the_repository || !the_repository->gitdir)
       		return 0;
       
      +	/* Disable foreground maintenance */
      +	git_config_set("maintenance.auto", "false");
     ++
     ++	/* Set maintenance strategy, if unset */
     ++	if (!git_config_get_string("maintenance.strategy", &config_value))
     ++		free(config_value);
     ++	else
     ++		git_config_set("maintenance.strategy", "incremental");
      +
       	config_get.git_cmd = 1;
       	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
       	git maintenance unregister &&
       	git config --global --get-all maintenance.repo >actual &&
       	test_cmp before actual
     +@@ t/t7900-maintenance.sh: test_expect_success 'start preserves existing schedule' '
     + 	grep "Important information!" cron.txt
     + '
     + 
     ++test_expect_success 'register preserves existing strategy' '
     ++	git config maintenance.strategy none &&
     ++	git maintenance register &&
     ++	test_config maintenance.strategy none &&
     ++	git config --unset maintenance.strategy &&
     ++	git maintenance register &&
     ++	test_config maintenance.strategy incremental
     ++'
     ++
     + test_done
 7:  8e42ff44ce = 8:  ce0ced705f maintenance: add troubleshooting guide to docs

-- 
gitgitgadget
