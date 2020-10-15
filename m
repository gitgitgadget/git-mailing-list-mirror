Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D3C43467
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB3822254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn9QllbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404928AbgJORWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404910AbgJORWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE6C0613D5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y12so4498570wrp.6
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=94SAXSivWG4OcI2a7GTptHlUkUOgYpGZhKpX1SZa190=;
        b=Tn9QllbKcU+E5S4H/boip9YtVTI33YBjN/JdsXjWPzwZrvupKjIMMdhA1aZwuFI8tR
         ey4iDwnDlRozvxIy0Fa4EmO8a3tAaJ6qRhKD3aN8RW1Yp8Afy33/Os6EDXLTYbo5mnH7
         crOpu7Zp3BAsjnRp+KmtgOKt5nL7JHVfmer44GOV5018QnaorQyd9rbTF5q3oapyLLC9
         mH1XeuYcmD0ULM3Dpwuk93dlWR8rSq6jSOn9hU2tp/rBBmsKkQdlOaZAevUMwWqXjIAM
         zTl6lLP76f1EcTs36NFZnhAp9SPmGnCe/iBi5RuzvCkUSMY0ybKd+uDZHMFwVIn0wlLD
         UYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=94SAXSivWG4OcI2a7GTptHlUkUOgYpGZhKpX1SZa190=;
        b=p8haszvLLNNoamh1iMihEPT2XzY2Y7i2kzrrDKselSHhGHSdMDcRUuNoIoG15CRuzz
         iC+IPaD+A/+wrFmTAw4WgoAyA2QVojXH4LJhRCQ17QplV4opeF7aTki4zwOvTbX9Nw6Y
         t1HJjmYFP9SWj5gj4xaLGtsXWjT5ok4+Um1c/W+oB4UiTGjRcX7AaGnjCmhqtLW49Yp1
         9cAD0yHRJeZe1/D4BpCKzZzplsXqrmrsxU0tEvqfKq+iVKChpDC+ZNjenMKUAQXGzHpX
         kCGBOUHzzHErpXDESSr8O5kx9f+l9GN0t0Gi0NjcWT3Hoterto+be1HJBpIo1ewmkJGT
         u3pg==
X-Gm-Message-State: AOAM530Sq6017OsHa395xk0ELvC2VvPBoNrfVIvIcez1AQgLmAh4yd9i
        bNclXTvyaQxHE/4TpEJf9qTKtWBROj0=
X-Google-Smtp-Source: ABdhPJz0ncKbxThWradrEXiqv8NYZixc5dtU1N+9KCNuO1yvuVsmFuvA/3VFy+0HGPi+8CBrOR5c6g==
X-Received: by 2002:adf:e801:: with SMTP id o1mr5516904wrm.359.1602782530486;
        Thu, 15 Oct 2020 10:22:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm6027515wrc.23.2020.10.15.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:09 -0700 (PDT)
Message-Id: <d696848b37f10afdc1f89381a62f277cf1e9e0a1.1602782524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:22:02 +0000
Subject: [PATCH v4 6/8] maintenance: create maintenance.strategy config
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
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To provide an on-ramp for users to use background maintenance without
several 'git config' commands, create a 'maintenance.strategy' config
option. Currently, the only important value is 'incremental' which
assigns the following schedule:

* gc: never
* prefetch: hourly
* commit-graph: hourly
* loose-objects: daily
* incremental-repack: daily

These tasks are chosen to minimize disruptions to foreground Git
commands and use few compute resources.

The 'maintenance.strategy' is intended as a baseline that can be
customzied further by manually assigning 'maintenance.<task>.enabled'
and 'maintenance.<task>.schedule' config options, which will override
any recommendation from 'maintenance.strategy'. This operates similarly
to config options like 'feature.experimental' which operate as "meta"
config options that change default config values.

This presents a way forward for updating the 'incremental' strategy in
the future or adding new strategies. For example, a potential strategy
could be to include a 'full' strategy that runs the 'gc' task weekly
and no other tasks by default.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt | 15 +++++++++
 builtin/gc.c                         | 28 ++++++++++++++--
 t/t7900-maintenance.sh               | 49 ++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 70585564fa..a5ead09e4b 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -3,6 +3,21 @@ maintenance.auto::
 	`git maintenance run --auto` after doing their normal work. Defaults
 	to true.
 
+maintenance.strategy::
+	This string config option provides a way to specify one of a few
+	recommended schedules for background maintenance. This only affects
+	which tasks are run during `git maintenance run --schedule=X`
+	commands, provided no `--task=<task>` arguments are provided.
+	Further, if a `maintenance.<task>.schedule` config value is set,
+	then that value is used instead of the one provided by
+	`maintenance.strategy`. The possible strategy strings are:
++
+* `none`: This default setting implies no task are run at any schedule.
+* `incremental`: This setting optimizes for performing small maintenance
+  activities that do not delete any data. This does not schedule the `gc`
+  task, but runs the `prefetch` and `commit-graph` tasks hourly and the
+  `loose-objects` and `incremental-repack` tasks daily.
+
 maintenance.<task>.enabled::
 	This boolean config option controls whether the maintenance task
 	with name `<task>` is run when no `--task` option is specified to
diff --git a/builtin/gc.c b/builtin/gc.c
index a387f46585..a8248e7a45 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1308,12 +1308,35 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 	return result;
 }
 
-static void initialize_task_config(void)
+static void initialize_maintenance_strategy(void)
+{
+	char *config_str;
+
+	if (git_config_get_string("maintenance.strategy", &config_str))
+		return;
+
+	if (!strcasecmp(config_str, "incremental")) {
+		tasks[TASK_GC].schedule = SCHEDULE_NONE;
+		tasks[TASK_COMMIT_GRAPH].enabled = 1;
+		tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
+		tasks[TASK_PREFETCH].enabled = 1;
+		tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
+		tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
+		tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
+		tasks[TASK_LOOSE_OBJECTS].enabled = 1;
+		tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
+	}
+}
+
+static void initialize_task_config(int schedule)
 {
 	int i;
 	struct strbuf config_name = STRBUF_INIT;
 	gc_config();
 
+	if (schedule)
+		initialize_maintenance_strategy();
+
 	for (i = 0; i < TASK__COUNT; i++) {
 		int config_value;
 		char *config_str;
@@ -1389,7 +1412,6 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 
 	opts.quiet = !isatty(2);
-	initialize_task_config();
 
 	for (i = 0; i < TASK__COUNT; i++)
 		tasks[i].selected_order = -1;
@@ -1402,6 +1424,8 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	if (opts.auto_flag && opts.schedule)
 		die(_("use at most one of --auto and --schedule=<frequency>"));
 
+	initialize_task_config(opts.schedule);
+
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 7715e40391..7440a0ea19 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -300,6 +300,55 @@ test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
 	test_subcommand git multi-pack-index write --no-progress <weekly.txt
 '
 
+test_expect_success 'maintenance.strategy inheritance' '
+	for task in commit-graph loose-objects incremental-repack
+	do
+		git config --unset maintenance.$task.schedule || return 1
+	done &&
+
+	test_when_finished git config --unset maintenance.strategy &&
+	git config maintenance.strategy incremental &&
+
+	GIT_TRACE2_EVENT="$(pwd)/incremental-hourly.txt" \
+		git maintenance run --schedule=hourly --quiet &&
+	GIT_TRACE2_EVENT="$(pwd)/incremental-daily.txt" \
+		git maintenance run --schedule=daily --quiet &&
+
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <incremental-hourly.txt &&
+	test_subcommand ! git prune-packed --quiet <incremental-hourly.txt &&
+	test_subcommand ! git multi-pack-index write --no-progress \
+		<incremental-hourly.txt &&
+
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <incremental-daily.txt &&
+	test_subcommand git prune-packed --quiet <incremental-daily.txt &&
+	test_subcommand git multi-pack-index write --no-progress \
+		<incremental-daily.txt &&
+
+	# Modify defaults
+	git config maintenance.commit-graph.schedule daily &&
+	git config maintenance.loose-objects.schedule hourly &&
+	git config maintenance.incremental-repack.enabled false &&
+
+	GIT_TRACE2_EVENT="$(pwd)/modified-hourly.txt" \
+		git maintenance run --schedule=hourly --quiet &&
+	GIT_TRACE2_EVENT="$(pwd)/modified-daily.txt" \
+		git maintenance run --schedule=daily --quiet &&
+
+	test_subcommand ! git commit-graph write --split --reachable \
+		--no-progress <modified-hourly.txt &&
+	test_subcommand git prune-packed --quiet <modified-hourly.txt &&
+	test_subcommand ! git multi-pack-index write --no-progress \
+		<modified-hourly.txt &&
+
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <modified-daily.txt &&
+	test_subcommand git prune-packed --quiet <modified-daily.txt &&
+	test_subcommand ! git multi-pack-index write --no-progress \
+		<modified-daily.txt
+'
+
 test_expect_success 'register and unregister' '
 	test_when_finished git config --global --unset-all maintenance.repo &&
 	git config --global --add maintenance.repo /existing1 &&
-- 
gitgitgadget

