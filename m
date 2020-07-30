Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E7C433E3
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E828120829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZyDjsx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgG3WY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgG3WYx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDEC06174A
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so7023810wmg.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DxOZ1IOjcDH2+iLvAAYVmpQWrqgBbjvBYKjkQTk6LiE=;
        b=kZyDjsx+hjomOcV8vR1Eqw25JcPL+Z/KbtmNtqDjmb0l1fStPXM3z7YpdJ8va++WAK
         sTdKepgEvuSJee0EzM8KJ/DXoPKTBXPRC6EocKPwUC1PC4xjRRySfYFJY33RxfbhwGg4
         svHri0ZTDzmxZE1Pbp4ndyt1i7cyY3lWGmHdj+yRkqppE8T/TCzts+RUJKppDu9DmwAB
         aHTj8ZgXi7qUuT1sKgK76c13wEBWL56O9jiokrAASEzV74nMrMER5KGG56fw5m+I9wOr
         6ZBZZtuDMxdMFXO/p8mUiIFiMTBYGUndOofGQIZxCfggY8OpQyre8HswqWXuG8Typ7nX
         k31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DxOZ1IOjcDH2+iLvAAYVmpQWrqgBbjvBYKjkQTk6LiE=;
        b=m8tayMS/s8V7/qdTP4pqDyeCF0VBaI9057z/KfDjcpkQ+iy19+eI+GvBmD1Glw/RBA
         6HbWdJ1hF07+j56GICqH4f2DrCzm2XgAhBaU9Mu3E/BTHqIVg99RANlZ3hGgKyBQYCwP
         UkCpIhclnhsefDyLAHLCho6/iduE9PJiLKF8uwhjbHHcCwx4CoGMQj6W7JXfYscSoRJp
         F43Z+S/hONShC/7kLkA1nnVNH/cjbfggEu9gjq2XvYBCuLGfF96bmFg7OJ7dqqIIdwbE
         GDt7UDqBumJptHKw1XRhPdEK9OnzAKMMsY+kKyRfpu+/aA6/axzB0936304ORgSqrxeQ
         jQbQ==
X-Gm-Message-State: AOAM531WLNAcElndzXO6Pj/Y2hgNLCF6sXpn+yoXYp2DwD5FQUDNNQl+
        hMpES1Vm0v4gTwaDs8o/bbloqrRz
X-Google-Smtp-Source: ABdhPJwkGUbdeGbWmy+Caxllf70xCf8TTsHAg39uApnVrn34Z9iE/LEIiSAx+HlwkXCBYV/0iB06NQ==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr1105900wmd.143.1596147891290;
        Thu, 30 Jul 2020 15:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2sm8196961wrg.73.2020.07.30.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:50 -0700 (PDT)
Message-Id: <99840c4b8f28b33b1c7ec2e861ee78bf81fe0277.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:20 +0000
Subject: [PATCH v3 14/20] maintenance: create maintenance.<task>.enabled
 config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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
 Documentation/config/maintenance.txt |  4 ++++
 Documentation/git-maintenance.txt    |  6 +++++-
 builtin/gc.c                         | 19 +++++++++++++++++++
 t/t7900-maintenance.sh               | 12 ++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/maintenance.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef0768b91a..2783b825f9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -396,6 +396,8 @@ include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
 
+include::config/maintenance.txt[]
+
 include::config/man.txt[]
 
 include::config/merge.txt[]
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
new file mode 100644
index 0000000000..370cbfb42f
--- /dev/null
+++ b/Documentation/config/maintenance.txt
@@ -0,0 +1,4 @@
+maintenance.<task>.enabled::
+	This boolean config option controls whether the maintenance task
+	with name `<task>` is run when no `--task` option is specified.
+	By default, only `maintenance.gc.enabled` is true.
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index a598582986..1bd105918f 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -30,7 +30,11 @@ SUBCOMMANDS
 -----------
 
 run::
-	Run one or more maintenance tasks.
+	Run one or more maintenance tasks. If one or more `--task` options
+	are specified, then those tasks are run in that order. Otherwise,
+	the tasks are determined by which `maintenance.<task>.enabled`
+	config options are true. By default, only `maintenance.gc.enabled`
+	is true.
 
 TASKS
 -----
diff --git a/builtin/gc.c b/builtin/gc.c
index d94eb3e6ad..c599690591 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1171,6 +1171,24 @@ static int maintenance_run(void)
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
@@ -1224,6 +1242,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
+	initialize_task_config();
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4e9c1dfa0f..affa268dec 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -21,6 +21,18 @@ test_expect_success 'run [--auto|--quiet]' '
 	grep ",\"gc\",\"--quiet\"" run-quiet.txt
 '
 
+test_expect_success 'maintenance.<task>.enabled' '
+	git config maintenance.gc.enabled false &&
+	git config maintenance.commit-graph.enabled true &&
+	git config maintenance.loose-objects.enabled true &&
+	GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run &&
+	! grep ",\"fetch\"" run-config.txt &&
+	! grep ",\"gc\"" run-config.txt &&
+	! grep ",\"multi-pack-index\"" run-config.txt &&
+	grep ",\"commit-graph\"" run-config.txt &&
+	grep ",\"prune-packed\"" run-config.txt
+'
+
 test_expect_success 'run --task=<task>' '
 	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
 	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" git maintenance run --task=gc &&
-- 
gitgitgadget

