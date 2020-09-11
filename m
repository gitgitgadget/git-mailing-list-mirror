Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC029C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D00421D81
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1rWhOp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgIKRtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIKRtY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:49:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22BC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so5190658wmi.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A40RKGmmOB2+xwCrKDIZbZHH7apr4nUL3cPw6l0+5Ko=;
        b=I1rWhOp4lwSixiTLx+LZAPvShKVKLeoDSLqCfddRmEaicCuKFKbL2Wut+lpStuRfhM
         2FdJAoeGew15JfsH6FugdpJxMBlEXpUHHdU8dXWdyQTxcZSpoG1LA+ms+Q7EuRmcBoAB
         q09pqHgh5P86Q1uViob9Pa3hVAJKEv2plHlb0lBSjpK3qePQ9iQcvmxENzx0dgPS/S4X
         QFQd+9SUA4S46wNo+svrhtH27Z3SagWYfRU3B/jC+D/vAOSCjuKeuhUuITiBVlgaVTMt
         FmTSvJ8bdQNLbHaoNMdu11qdUos7/e+QJ7owhfyfnbPLncsDUvZ6zu6XVTAW74/s+1mQ
         GcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A40RKGmmOB2+xwCrKDIZbZHH7apr4nUL3cPw6l0+5Ko=;
        b=e2h/klyOksjFwiri8TB64uDPh+l8OJO0NsoRCnakElT0wthUwA4E4Ej/lEYBAT9Yv3
         48+YlfJu5HobTiwubqGIRPlYf4nOGaJaMm0ruPu3rOOwkmdwnn4oOwrCQmBJXX8qsMvR
         NZeq+kjhlQM+ONovPiBmgjmVngjBv3pwLho7f8Ijq/9L7H5IqAudL9F2P9GaWmqLBaIE
         21I92rpWNx2zng6XjS5vcBFog0Psz1bRXtPlZgzGgklbTn/RHywGNni2UwAHMtZGd8N2
         eFYOPrKiGQ9NZnOLfW3+CHf7znuhyc+D+Nt2hcrf72AvKBrx66KPXINfTdiYkD/AjStm
         Y7cg==
X-Gm-Message-State: AOAM533aNQ1OIHD2NegKbXthF5gAEPgxATewG1kDErq3pZZUdKHC9snF
        Wmkcrb6xyyv04NbTHYvCeQkVcRG6c6A=
X-Google-Smtp-Source: ABdhPJywHaq43CxHDNNRsYSNu0BQsaK/bJ9bVzV7TFhzhjKZFWx7YuWf8zETjHDHiXbIjXhMuonY7Q==
X-Received: by 2002:a1c:a789:: with SMTP id q131mr3230655wme.141.1599846562255;
        Fri, 11 Sep 2020 10:49:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm5995332wro.34.2020.09.11.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:49:21 -0700 (PDT)
Message-Id: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.git.1599234126.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 17:49:13 +0000
Subject: [PATCH v2 0/7] Maintenance III: Background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
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
  maintenance: recommended schedule in register/start
  maintenance: add troubleshooting guide to docs

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  10 +
 Documentation/git-for-each-repo.txt  |  59 ++++++
 Documentation/git-maintenance.txt    |  88 +++++++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 289 ++++++++++++++++++++++++++-
 command-list.txt                     |   1 +
 git.c                                |   1 +
 run-command.c                        |   6 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               | 114 ++++++++++-
 t/test-lib.sh                        |   6 +
 17 files changed, 697 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: 6f11fba53777584b94dd9ed32976c2079d645fa2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-724%2Fderrickstolee%2Fmaintenance%2Fscheduled-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-724/derrickstolee/maintenance/scheduled-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/724

Range-diff vs v1:

 1:  bd95729009 = 1:  b21cd68c90 maintenance: optionally skip --auto process
 2:  1783e80b8d ! 2:  e2d14d66d4 maintenance: add --schedule option and config
     @@ Metadata
       ## Commit message ##
          maintenance: add --schedule option and config
      
     -    A user may want to run certain maintenance tasks based on frequency, not
     -    conditions given in the repository. For example, the user may want to
     -    perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
     -    update the 'git maintenance run' command to include a
     -    '--schedule=<frequency>' option. The allowed frequencies are 'hourly',
     -    'daily', and 'weekly'. These values are also allowed in a new config
     -    value 'maintenance.<task>.schedule'.
     +    Maintenance currently triggers when certain data-size thresholds are
     +    met, such as number of pack-files or loose objects. Users may want to
     +    run certain maintenance tasks based on frequency instead. For example,
     +    a user may want to perform a 'prefetch' task every hour, or 'gc' task
     +    every day. To help these users, update the 'git maintenance run' command
     +    to include a '--schedule=<frequency>' option. The allowed frequencies
     +    are 'hourly', 'daily', and 'weekly'. These values are also allowed in a
     +    new config value 'maintenance.<task>.schedule'.
      
          The 'git maintenance run --schedule=<frequency>' checks the '*.schedule'
          config value for each enabled task to see if the configured frequency is
     @@ Commit message
          The following cron table would run the scheduled tasks with the correct
          frequencies:
      
     -      0 1-23 * * *    git -C <repo> maintenance run --scheduled=hourly
     -      0 0    * * 1-6  git -C <repo> maintenance run --scheduled=daily
     -      0 0    * * 0    git -C <repo> maintenance run --scheduled=weekly
     +      0 1-23 * * *    git -C <repo> maintenance run --schedule=hourly
     +      0 0    * * 1-6  git -C <repo> maintenance run --schedule=daily
     +      0 0    * * 0    git -C <repo> maintenance run --schedule=weekly
      
     -    This cron schedule will run --scheduled=hourly every hour except at
     -    midnight. This avoids a concurrent run with the --scheduled=daily that
     +    This cron schedule will run --schedule=hourly every hour except at
     +    midnight. This avoids a concurrent run with the --schedule=daily that
          runs at midnight every day except the first day of the week. This avoids
     -    a concurrent run with the --scheduled=weekly that runs at midnight on
     -    the first day of the week. Since --scheduled=daily also runs the
     -    'hourly' tasks and --scheduled=weekly runs the 'hourly' and 'daily'
     +    a concurrent run with the --schedule=weekly that runs at midnight on
     +    the first day of the week. Since --schedule=daily also runs the
     +    'hourly' tasks and --schedule=weekly runs the 'hourly' and 'daily'
          tasks, we will still see all tasks run with the proper frequencies.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ builtin/gc.c: struct maintenance_task {
       	int selected_order;
       };
      @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     + 		     !tasks[i].auto_condition()))
       			continue;
       
     - 		if (opts->auto_flag &&
     --		    (!tasks[i].auto_condition ||
     --		     !tasks[i].auto_condition()))
     -+		    (!tasks[i].auto_condition || !tasks[i].auto_condition()))
     ++		if (opts->schedule && tasks[i].schedule < opts->schedule)
      +			continue;
      +
     -+		if (opts->schedule && tasks[i].schedule < opts->schedule)
     - 			continue;
     - 
       		trace2_region_enter("maintenance", tasks[i].name, r);
     + 		if (tasks[i].fn(opts)) {
     + 			error(_("task '%s' failed"), tasks[i].name);
      @@ builtin/gc.c: static void initialize_task_config(void)
       
       	for (i = 0; i < TASK__COUNT; i++) {
 3:  6082d939eb = 3:  41a346dfbb for-each-repo: run subcommands on configured repos
 4:  b7775b3aaf = 4:  1f49cda18e maintenance: add [un]register subcommands
 5:  e02641881d ! 5:  e9b2a39c1d maintenance: add start/stop subcommands
     @@ t/helper/test-crontab.c (new)
      +/*
      + * Usage: test-tool cron <file> [-l]
      + *
     -+ * If -l is specified, then write the contents of <file> to stdou.
     ++ * If -l is specified, then write the contents of <file> to stdout.
      + * Otherwise, write from stdin into <file>.
      + */
      +int cmd__crontab(int argc, const char **argv)
      +{
     -+	char a;
     ++	int a;
      +	FILE *from, *to;
      +
      +	if (argc == 3 && !strcmp(argv[2], "-l")) {
 6:  8a285e00e6 = 6:  f609c1bde2 maintenance: recommended schedule in register/start
 7:  c00de53906 = 7:  2344eff4ba maintenance: add troubleshooting guide to docs

-- 
gitgitgadget
