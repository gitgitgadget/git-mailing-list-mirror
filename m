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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B088C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A38206F2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6v7QAzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgIDNLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbgIDNJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2114C061251
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so6661301wrl.12
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vK6iK0+RvphJs0HeXxn440+72BWzbhU3tPC7lZ3S1Hw=;
        b=P6v7QAzq1/Zjdr4RUlhplxdfHXJtz3L5YhleIey0JDqZNLiX2+n9BS+W3uHpCv9wGI
         P+E6j7/bYJ085GrNF4GquUreDEGRaQWOmtqs0XGdPc7/kTYkIj2MUq6i/HWvBjfaI3Lq
         2l3jmFAIUsbsONbdvhbpKHe3UZuVsJw1lXVqHuRxFQ+XIU/u6qg9rn1a7iMFKnseEjPw
         Pso+H4m18wNcxdeU1CVRH0G+tBAK923jJ3crrjYM7Fvy8h5Spy4+v2OoJ/pFpL7TuLXB
         UFWbc4IUg7716qa0gu1bnduLghfEz9h2kc3THSdhikFMfvidaFk/hYOvQ5sQnd7QDSfa
         z+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vK6iK0+RvphJs0HeXxn440+72BWzbhU3tPC7lZ3S1Hw=;
        b=dfVscw2HAc0T91M/eQ6Vrv2toJ9EOEzZIKKIZ1DxZ5zgOi+YyPQJbUGhManwzNiUgQ
         L1CaGKXtOiMTpmpzde/mZQBM3DG8J4HTzMjGxrFF1fO6LyAN1jDmE1na9a7lnmdIq0/P
         BPfrSvEqGz7Ijttb8nOWKeKsoLPpyu4VEuIaqji0L7xLECXorMhadnK/DSJ4PkvE4I2P
         EeQjmdCfqNR2XQNZJOrU/Kkfl5m3QHCX+EiYKFpEdIymyqVgE121n2q0bUMic8+EFHZx
         4F5JUL3kwLXqF02ZwOwCck5Dli8GkKefITo1VL4nPuMdTGYFYzUA50g6dCzc9XWr/wQB
         g3Dw==
X-Gm-Message-State: AOAM531ANhewrUTCadJrfnI/UmSt89PuPcyAqfmszm0IrxsRhnadS3ik
        uyKUqHdNCSxYzuk+a09dhR/OW2xMofk=
X-Google-Smtp-Source: ABdhPJzV7T9T6RM5GxGjHXCg96Bw22UwplnU2jx+BQzQ93eXuQ2oJSxVW1kJAw02dUjtL8ifAuaxuw==
X-Received: by 2002:adf:8405:: with SMTP id 5mr7524716wrf.393.1599224963876;
        Fri, 04 Sep 2020 06:09:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm10327039wmi.16.2020.09.04.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:23 -0700 (PDT)
Message-Id: <dc2a092366d49ae4dc4756e1f4e10b783bbc44a8.1599224956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
        <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:12 +0000
Subject: [PATCH v4 08/11] maintenance: create maintenance.<task>.enabled
 config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
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
index 1cebb7282d..67a8d405a1 100644
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
index 792765aff7..290abb7832 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -25,6 +25,14 @@ test_expect_success 'run [--auto|--quiet]' '
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

