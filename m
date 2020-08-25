Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A9C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FBF2074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8pbRyCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHYSk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHYSkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DC3C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b17so13064989wru.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PhVGgGEqdc/N+TszgKfIi4lzL1p/ldjNnJzfUXIgec=;
        b=A8pbRyCrYF7YFx1AfEaT+O9XjW4rSEvsRDRg57vuGtM8WNFYvChMujz9zq33gSUEEX
         a4AvJfXp191c/SHybo4PfKWO5i833oma475yaNFCa+981h1h37DbZib6BDI8CQMHl3aG
         mhahffdIMX7k63E/I/PwmYM3O0RvSb71OuqaDz0U0KKRzOg7qXjM4l1z89cbOJD/O4eN
         vz6n+9xQnL1y3SMIOQ9IRX4qmsGPx+iXxbAOb99x1nr3UOuhKNOtAm8pkQ+HBdfFDG7E
         rjOhlpk0FHQ1JYAz1NX2ZL1PRJkOhokVsGATwleQCtty62+UdsNyXp8qFshw8gEZc7VW
         zcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3PhVGgGEqdc/N+TszgKfIi4lzL1p/ldjNnJzfUXIgec=;
        b=a0/j3esx+lXuTmRpz8ZeW0r30+zfCzb5lA0Ii0WebOT3w3eccN+iYTcRS1uTtjNUDA
         WY6pIT0CxvMdDzr8EH5ALy2457i8Cv1OCA/YDvqroZ7sBuMKXnMOA2kGFWIMgbOFRdpG
         AJFYPnpO9h9xNecNHmfjsv5bKZptHcjKsIIEHwR8lS740MmjfodM9xMNUsVxItWck4vd
         DgN1riR6Yda0Okk7nuZVJmj5t41ET1Xa4wcGkT1TAxCneG9hLnl5IpJZ0p6U/YCOzgxu
         Fot+h/5PZZxz5EbqPOdq17zczBGz+kSKNZTRiyN6tuu1aQL6dNNFjust8yzhjpUnTz6p
         1FhQ==
X-Gm-Message-State: AOAM531G8bzj0nA5EJle95gD6XoB2X/pHg3+5yXSIECy7In6yB7BB+/q
        lwRj+zvHBDDKohpPhhbz+hih1i7YhGY=
X-Google-Smtp-Source: ABdhPJx6qJhiuClVUI92Eljzv+y9mkelLHsp/ztzI1OjQxKPWH3jEQUrogqLTznkJapKQDCFcpEXRA==
X-Received: by 2002:adf:e982:: with SMTP id h2mr12723759wrm.394.1598380810614;
        Tue, 25 Aug 2020 11:40:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm21285172wrn.94.2020.08.25.11.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:09 -0700 (PDT)
Message-Id: <c0ce1267a99606e7632c8930c3b4d6c33f901101.1598380805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:40:02 +0000
Subject: [PATCH v2 5/7] maintenance: add [un]register subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In preparation for launching background maintenance from the 'git
maintenance' builtin, create register/unregister subcommands. These
commands update the new 'maintenance.repos' config option in the global
config so the background maintenance job knows which repositories to
maintain.

These commands allow users to add a repository to the background
maintenance list without disrupting the actual maintenance mechanism.

For example, a user can run 'git maintenance register' when no
background maintenance is running and it will not start the background
maintenance. A later update to start running background maintenance will
then pick up this repository automatically.

The opposite example is that a user can run 'git maintenance unregister'
to remove the current repository from background maintenance without
halting maintenance for other repositories.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 14 ++++++++
 builtin/gc.c                      | 55 ++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            | 17 +++++++++-
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 2bc02c65e4..c42a176a95 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -29,6 +29,15 @@ Git repository.
 SUBCOMMANDS
 -----------
 
+register::
+	Initialize Git config values so any scheduled maintenance will
+	start running on this repository. This adds the repository to the
+	`maintenance.repo` config variable in the current user's global
+	config and enables some recommended configuration values for
+	`maintenance.<task>.schedule`. The tasks that are enabled are safe
+	for running in the background without disrupting foreground
+	processes.
+
 run::
 	Run one or more maintenance tasks. If one or more `--task` options
 	are specified, then those tasks are run in that order. Otherwise,
@@ -36,6 +45,11 @@ run::
 	config options are true. By default, only `maintenance.gc.enabled`
 	is true.
 
+unregister::
+	Remove the current repository from background maintenance. This
+	only removes the repository from the configured list. It does not
+	stop the background maintenance processes from running.
+
 TASKS
 -----
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 5726a9a3b3..5218d52cb7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1414,7 +1414,56 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	return maintenance_run_tasks(&opts);
 }
 
-static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
+static int maintenance_register(void)
+{
+	struct child_process config_set = CHILD_PROCESS_INIT;
+	struct child_process config_get = CHILD_PROCESS_INIT;
+
+	/* There is no current repository, so skip registering it */
+	if (!the_repository || !the_repository->gitdir)
+		return 0;
+
+	config_get.git_cmd = 1;
+	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
+		     the_repository->worktree ? the_repository->worktree
+					      : the_repository->gitdir,
+			 NULL);
+	config_get.out = -1;
+
+	if (start_command(&config_get))
+		return error(_("failed to run 'git config'"));
+
+	/* We already have this value in our config! */
+	if (!finish_command(&config_get))
+		return 0;
+
+	config_set.git_cmd = 1;
+	strvec_pushl(&config_set.args, "config", "--add", "--global", "maintenance.repo",
+		     the_repository->worktree ? the_repository->worktree
+					      : the_repository->gitdir,
+		     NULL);
+
+	return run_command(&config_set);
+}
+
+static int maintenance_unregister(void)
+{
+	struct child_process config_unset = CHILD_PROCESS_INIT;
+
+	if (!the_repository || !the_repository->gitdir)
+		return error(_("no current repository to unregister"));
+
+	config_unset.git_cmd = 1;
+	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
+		     "maintenance.repo",
+		     the_repository->worktree ? the_repository->worktree
+					      : the_repository->gitdir,
+		     NULL);
+
+	return run_command(&config_unset);
+}
+
+static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
@@ -1423,6 +1472,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[1], "run"))
 		return maintenance_run(argc - 1, argv + 1, prefix);
+	if (!strcmp(argv[1], "register"))
+		return maintenance_register();
+	if (!strcmp(argv[1], "unregister"))
+		return maintenance_unregister();
 
 	die(_("invalid subcommand: %s"), argv[1]);
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 3e0c5f1ca8..b20ee2d542 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -9,7 +9,7 @@ GIT_TEST_MULTI_PACK_INDEX=0
 
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
-	test_i18ngrep "usage: git maintenance run" err &&
+	test_i18ngrep "usage: git maintenance <subcommand>" err &&
 	test_expect_code 128 git maintenance barf 2>err &&
 	test_i18ngrep "invalid subcommand: barf" err
 '
@@ -294,4 +294,19 @@ test_expect_success '--scheduled with specific time' '
 	test_cmp_config 1595000100 maintenance.commit-graph.lastrun
 '
 
+test_expect_success 'register and unregister' '
+	test_when_finished git config --global --unset-all maintenance.repo &&
+	git config --global --add maintenance.repo /existing1 &&
+	git config --global --add maintenance.repo /existing2 &&
+	git config --global --get-all maintenance.repo >before &&
+	git maintenance register &&
+	git config --global --get-all maintenance.repo >actual &&
+	cp before after &&
+	pwd >>after &&
+	test_cmp after actual &&
+	git maintenance unregister &&
+	git config --global --get-all maintenance.repo >actual &&
+	test_cmp before actual
+'
+
 test_done
-- 
gitgitgadget

