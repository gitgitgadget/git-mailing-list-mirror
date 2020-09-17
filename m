Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA7AC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1B222208
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NacZJ7Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIQSRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179FC061356
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so2849985wmj.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tz5sP7sFiEQwxuNL1ysFFdMmvvIMmfCgdRD4pehezDg=;
        b=NacZJ7Bw1y+3uip9bkoI7aK3EHk4kRHXOr4jct7c1wDgx1Our72p376pFeS7M61QkF
         1RBA9g0dic0qVZjVHmYs1imZ08ZmBIWcJv5PLDYMW1XzSM4ewaHAq6zi5s0sI8ggq6C+
         zTxA/UU0VFNDPsOcWxgWGoOnk011tBnU91TylntC3AF1UBMR5ORS+zs/eOCj77fqsgeG
         v3vfuXYhiuWWGKfnsqc1PP7PPQaNuSnzaxdczejDKIrBtTyf6GgqpGO8yaV85kFzNKUL
         z3BYumv7PGyHyS8x1SQJtvkmyI6VvfWDne2i+/eDIjWipqFOewtD3Z6xXSUEo/AewG9y
         7Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tz5sP7sFiEQwxuNL1ysFFdMmvvIMmfCgdRD4pehezDg=;
        b=tDgeasQ8Yt5ZmYbLI1WrreF/rs5AXgUUb2SWyFZZYpIFHwVieEotc2WpocjP0q27Cr
         WCRKsrwK2jRj5onSnhD3IPL6vbB50OywcXyOu3hQWclhweIHpVNdwkH5jSiLn/IHiROp
         uCViAoDPrHPccLzcyykr/wYfxT/t0u1Nco/8rFRjTmHlSGN/fJYl3wGdCQEK11yH7LK+
         eIycltBp906XQWJMXxscMM4awwP8gO+hLb/2LG9+lOtEvt0tbCMQ90L6kzCprCthCydQ
         Aa2EdgDKI1rAhR3ErHw7/ANL/mFBRp9mW81y3rPzbKMiG6K5r9q/P19HRgjWgXBDIN3W
         zd8g==
X-Gm-Message-State: AOAM5331ly4u7FNW8vlyO9H7Sw58ryCuJSeyAXlzOvpQYw3x4jC+ruq8
        Cl5+gbdmR7ESwexQk9LSxhWSvmu4/Bk=
X-Google-Smtp-Source: ABdhPJzgYrJAGyKXpcMC4N3d0+4pw4iuGQEoMctEhfsMvU7pBM7v27p3+M0Ao1gzcabC1KJW4056bw==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr11921123wmb.90.1600366320982;
        Thu, 17 Sep 2020 11:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm468151wrv.94.2020.09.17.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:12:00 -0700 (PDT)
Message-Id: <713207b4a188e16e952b8587f062488f97d403f8.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:49 +0000
Subject: [PATCH v5 08/11] maintenance: create maintenance.<task>.enabled
 config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Currently, a normal run of "git maintenance run" will only run the 'gc'
task, as it is the only one enabled. This is mostly for backwards-
compatible reasons since "git maintenance run --auto" commands replaced
previous "git gc --auto" commands after some Git processes. Users could
manually run specific maintenance tasks by calling "git maintenance run
--task=<task>" directly.

Allow users to customize which steps are run automatically using config.
The 'maintenance.<task>.enabled' option then can turn on these other
tasks (or turn off the 'gc' task).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt             |  2 ++
 Documentation/config/maintenance.txt |  6 ++++++
 Documentation/git-maintenance.txt    | 14 +++++++++-----
 builtin/gc.c                         | 19 +++++++++++++++++++
 t/t7900-maintenance.sh               |  8 ++++++++
 5 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3042d80978..f93b6837e4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -398,6 +398,8 @@ include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
 
+include::config/maintenance.txt[]
+
 include::config/man.txt[]
 
 include::config/merge.txt[]
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
new file mode 100644
index 0000000000..4402b8b49f
--- /dev/null
+++ b/Documentation/config/maintenance.txt
@@ -0,0 +1,6 @@
+maintenance.<task>.enabled::
+	This boolean config option controls whether the maintenance task
+	with name `<task>` is run when no `--task` option is specified to
+	`git maintenance run`. These config values are ignored if a
+	`--task` option exists. By default, only `maintenance.gc.enabled`
+	is true.
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 819ca41ab6..6abcb8255a 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -30,9 +30,11 @@ SUBCOMMANDS
 -----------
 
 run::
-	Run one or more maintenance tasks. If one or more `--task=<task>`
-	options are specified, then those tasks are run in the provided
-	order. Otherwise, only the `gc` task is run.
+	Run one or more maintenance tasks. If one or more `--task` options
+	are specified, then those tasks are run in that order. Otherwise,
+	the tasks are determined by which `maintenance.<task>.enabled`
+	config options are true. By default, only `maintenance.gc.enabled`
+	is true.
 
 TASKS
 -----
@@ -67,8 +69,10 @@ OPTIONS
 
 --task=<task>::
 	If this option is specified one or more times, then only run the
-	specified tasks in the specified order. See the 'TASKS' section
-	for the list of accepted `<task>` values.
+	specified tasks in the specified order. If no `--task=<task>`
+	arguments are specified, then only the tasks with
+	`maintenance.<task>.enabled` configured as `true` are considered.
+	See the 'TASKS' section for the list of accepted `<task>` values.
 
 GIT
 ---
diff --git a/builtin/gc.c b/builtin/gc.c
index 7ba9c6f7c9..55a3d836f0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -841,6 +841,24 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 	return result;
 }
 
+static void initialize_task_config(void)
+{
+	int i;
+	struct strbuf config_name = STRBUF_INIT;
+	for (i = 0; i < TASK__COUNT; i++) {
+		int config_value;
+
+		strbuf_setlen(&config_name, 0);
+		strbuf_addf(&config_name, "maintenance.%s.enabled",
+			    tasks[i].name);
+
+		if (!git_config_get_bool(config_name.buf, &config_value))
+			tasks[i].enabled = config_value;
+	}
+
+	strbuf_release(&config_name);
+}
+
 static int task_option_parse(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -889,6 +907,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 
 	opts.quiet = !isatty(2);
+	initialize_task_config();
 
 	for (i = 0; i < TASK__COUNT; i++)
 		tasks[i].selected_order = -1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index fb4cadd30c..8a162a18ba 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -27,6 +27,14 @@ test_expect_success 'run [--auto|--quiet]' '
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
+test_expect_success 'maintenance.<task>.enabled' '
+	git config maintenance.gc.enabled false &&
+	git config maintenance.commit-graph.enabled true &&
+	GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run 2>err &&
+	test_subcommand ! git gc --quiet <run-config.txt &&
+	test_subcommand git commit-graph write --split --reachable --no-progress <run-config.txt
+'
+
 test_expect_success 'run --task=<task>' '
 	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
 		git maintenance run --task=commit-graph 2>/dev/null &&
-- 
gitgitgadget

