Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC902C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F57A20848
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vM1S+VeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgJENEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgJENEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049DCC0613B6
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:57:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z22so1711214wmi.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=45zsat4+nWUk+8NCAMYKXXJVlAnGS7QiFYr3T9GBVpc=;
        b=vM1S+VeXL/D/0O8Chmriu9Du9F4vfTyU1e0GOOmEQnzzXm3+wMEu3vEHD9iav9jNpE
         J01Bv5ZbJRQxKivS9WFBH6CfDyfXCWz81ou/fYpRs6h3CsCMhhu7rd8IdUgv6/rWTCUB
         nol0aB/Ba8PHUSMAKGYfgW6P3dBDWB3QMtkHT5jdy/lxleE5+DNYgfhxxJ06bq41Nc+N
         VH/hvAGGDYHU97dZmba4rPiK9MEGKz+7uNukEaOLxpB0QBoum8KHPN/+FTocQyA+KfQz
         LTXqSJdVHY2JheSapoPEMRqOAD5lUHxeTnIFOb+gerxpq8+kwgmc50JZO3yLNuIWDVg4
         J3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=45zsat4+nWUk+8NCAMYKXXJVlAnGS7QiFYr3T9GBVpc=;
        b=k7YY8pxVX8f80qmP7LSlkxrKixAHLnsMJvCNSJ1I56qPbKcWFdELoIWEpsEvTDc8ho
         7AZR69xpZBONVX+7aLFpK01l8X3qfWeJ01+1yCwKyN9NRNvKctyqXnO3nfXYywa3FhU6
         gHseiyb3t19Wrmyf/hYiEsv2dPgBW8NFiXRh1TOz5tFCuHb7erj2dsXR8Ao43Vhr4A/f
         0Bn4NbJMkd7v7w/2k28GpWOM/asx8iThPlbkfEq/EajOWqIsZU+bsjU6xAULT9pXx7XP
         RVsyj3LHllFOZ+awFKQGQOxXwTNmSsRSTUiSl7zbcT7TyzKnOAw6QPGBxAz44oxExg/8
         C8bA==
X-Gm-Message-State: AOAM530obxas2Qxsc7I/w022CTv0LzulUjIL47cvzer4S5FpOOpcLkpY
        i3kXv/VSDYc9Rtex3FPudThKfA9KICk=
X-Google-Smtp-Source: ABdhPJzkjrIDPXCl5Kj7AbkISJMlDe+VSUJ4dNL70wAXnGGlxVGJRkj+A1Sp2/ZxmHsuy1MLRqgoew==
X-Received: by 2002:a1c:bcd5:: with SMTP id m204mr8920350wmf.26.1601902641434;
        Mon, 05 Oct 2020 05:57:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm12934618wro.5.2020.10.05.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:57:20 -0700 (PDT)
Message-Id: <d833fffe89c94ecf3551c075960ba6d7607e9b17.1601902635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
References: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
        <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 12:57:13 +0000
Subject: [PATCH v3 6/7] maintenance: use default schedule if not configured
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
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git maintenance (register|start)' subcommands add the current
repository to the global Git config so maintenance will operate on that
repository. It does not specify what maintenance should occur or how
often.

If a user sets any 'maintenance.<task>.schedule' config value, then
they have chosen a specific schedule for themselves and Git should
respect that when running 'git maintenance run --schedule=<frequency>'.

To make this process extremely simple for users, assume a default
schedule when no 'maintenance.<task>.schedule' or '...enabled' config
settings are concretely set. This is only an in-process assumption, so
future versions of Git could adjust this expected schedule.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 15 ++++++++
 builtin/gc.c                      | 58 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 11 +++---
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 7628a6d157..52fff86844 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -37,6 +37,21 @@ register::
 	`maintenance.<task>.schedule`. The tasks that are enabled are safe
 	for running in the background without disrupting foreground
 	processes.
++
+If your repository has no `maintenance.<task>.schedule` configuration
+values set, then Git will use a recommended default schedule that performs
+background maintenance that will not interrupt foreground commands. The
+default schedule is as follows:
++
+* `gc`: disabled.
+* `commit-graph`: hourly.
+* `prefetch`: hourly.
+* `loose-objects`: daily.
+* `incremental-repack`: daily.
++
+`git maintenance register` will also disable foreground maintenance by
+setting `maintenance.auto = false` in the current repository. This config
+setting will remain after a `git maintenance unregister` command.
 
 run::
 	Run one or more maintenance tasks. If one or more `--task` options
diff --git a/builtin/gc.c b/builtin/gc.c
index a387f46585..965690704b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1251,6 +1251,59 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 	return b->selected_order - a->selected_order;
 }
 
+static int has_schedule_config(void)
+{
+	int i, found = 0;
+	struct strbuf config_name = STRBUF_INIT;
+	size_t prefix;
+
+	strbuf_addstr(&config_name, "maintenance.");
+	prefix = config_name.len;
+
+	for (i = 0; !found && i < TASK__COUNT; i++) {
+		char *value;
+
+		strbuf_setlen(&config_name, prefix);
+		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
+
+		if (!git_config_get_string(config_name.buf, &value)) {
+			found = 1;
+			FREE_AND_NULL(value);
+		}
+
+		strbuf_setlen(&config_name, prefix);
+		strbuf_addf(&config_name, "%s.enabled", tasks[i].name);
+
+		if (!git_config_get_string(config_name.buf, &value)) {
+			found = 1;
+			FREE_AND_NULL(value);
+		}
+	}
+
+	strbuf_release(&config_name);
+	return found;
+}
+
+static void set_recommended_schedule(void)
+{
+	if (has_schedule_config())
+		return;
+
+	tasks[TASK_GC].enabled = 0;
+
+	tasks[TASK_PREFETCH].enabled = 1;
+	tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
+
+	tasks[TASK_COMMIT_GRAPH].enabled = 1;
+	tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
+
+	tasks[TASK_LOOSE_OBJECTS].enabled = 1;
+	tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
+
+	tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
+	tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
+}
+
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
 	int i, found_selected = 0;
@@ -1280,6 +1333,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 
 	if (found_selected)
 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
+	else if (opts->schedule != SCHEDULE_NONE)
+		set_recommended_schedule();
 
 	for (i = 0; i < TASK__COUNT; i++) {
 		if (found_selected && tasks[i].selected_order < 0)
@@ -1417,6 +1472,9 @@ static int maintenance_register(void)
 	if (!the_repository || !the_repository->gitdir)
 		return 0;
 
+	/* Disable foreground maintenance */
+	git_config_set("maintenance.auto", "false");
+
 	config_get.git_cmd = 1;
 	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 7715e40391..7154987fd2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -305,11 +305,14 @@ test_expect_success 'register and unregister' '
 	git config --global --add maintenance.repo /existing1 &&
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
+
 	git maintenance register &&
-	git config --global --get-all maintenance.repo >actual &&
-	cp before after &&
-	pwd >>after &&
-	test_cmp after actual &&
+	test_cmp_config false maintenance.auto &&
+	git config --global --get-all maintenance.repo >between &&
+	cp before expect &&
+	pwd >>expect &&
+	test_cmp expect between &&
+
 	git maintenance unregister &&
 	git config --global --get-all maintenance.repo >actual &&
 	test_cmp before actual
-- 
gitgitgadget

