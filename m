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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D3C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF47020874
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhPSBzhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgJENE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJENEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245DC0613B4
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:57:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so9461324wrx.7
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YZRvSJQSR01ZgZPGmy5Oy6QQ1M778dWiXzW4kSk/4UU=;
        b=bhPSBzhvCGd2Ho+hyBSyItI1GeCXwkq4wVEHZd5vK4hKL+9b4IvtBViKffs0Cr/v+b
         o9Aa8nGpMe0GbCbWmxT56SOPxuOrl0vrY82B26vgPN9VzrxMNvVDKZQU/Zq9SbOTfj51
         Wd/OPRY7su+Iiw/KgqeOB+fxPHB/bc4EIcaW07CwgJzIvv62BwU3eYaCK/dQQIsor1CB
         h+tcAw6fqJ8kb8V4AEt65UdLn9bpKVoU2F4JcR42UMRXQGgBAZJAs3A4Z2UjFZgq7KSy
         aumMg8le7wuictpJpZyUcKClslw8a0Iy5jepy5SCda+AfwaSIKS7Vw4SuD42biX0N/rs
         WS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YZRvSJQSR01ZgZPGmy5Oy6QQ1M778dWiXzW4kSk/4UU=;
        b=iS9Aw95qtKtQ2ySy337PjcNbGiCzzhIlsW5lii2jMKolvbeDTDl0/quqBYJIkMjohV
         xpZ3n+A1i/5H0CE0OWo54y6PuYymZSH96uE9OpgSHqeacU7g/mQdmozU7ERg4rUpAOwi
         qgsCCX+d6EL9pxjoEVC4XXa0NzL/nD7GlhBaW/O52MkWk2x/Aw+C7CY6FbVvHKaEm1Er
         8vRyjLc9MaVf3Ya5Weyk5aXyqTQ15hZx5Tiolls5ZQmqcQbX8zqwcAvi/mzyqJWpQ7Q2
         fD8zZ3LdohWD0nIcl/wGavWpQt1R+OywAAjvp0lEVGbtWWDjg1EdJREeFvk3hiTj2hQ0
         GKeA==
X-Gm-Message-State: AOAM530po1dwRLb+0UvmyOWpNET745A3pPFUdQiH2AJ9x56ukkHG3gMP
        aSXgXY6SStfiMrhcTdUWKbPA/vb8jPg=
X-Google-Smtp-Source: ABdhPJzHoxAu2QwDjJRzXHI5xeJqVcgXduEfh5rpEIe+E+CIKqRLZmSbbYTHMgwn44YQ7fc5qw/ZOQ==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr17815824wrv.343.1601902639869;
        Mon, 05 Oct 2020 05:57:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm12923547wmi.37.2020.10.05.05.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:57:19 -0700 (PDT)
Message-Id: <922b984c8aa4217a2f60307513dfa43f16475a00.1601902635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
References: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
        <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 12:57:11 +0000
Subject: [PATCH v3 4/7] maintenance: add [un]register subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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
index ed94f66e36..1c59fd0cb5 100644
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
index 03b24ea0db..edf1d35ce5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1407,7 +1407,56 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
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
@@ -1417,6 +1466,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[1], "run"))
 		return maintenance_run(argc - 1, argv + 1, prefix);
+	if (!strcmp(argv[1], "register"))
+		return maintenance_register();
+	if (!strcmp(argv[1], "unregister"))
+		return maintenance_unregister();
 
 	die(_("invalid subcommand: %s"), argv[1]);
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 33d73cd01c..8f383d01d9 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -9,7 +9,7 @@ GIT_TEST_MULTI_PACK_INDEX=0
 
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
-	test_i18ngrep "usage: git maintenance run" err &&
+	test_i18ngrep "usage: git maintenance <subcommand>" err &&
 	test_expect_code 128 git maintenance barf 2>err &&
 	test_i18ngrep "invalid subcommand: barf" err &&
 	test_expect_code 129 git maintenance 2>err &&
@@ -300,4 +300,19 @@ test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
 	test_subcommand git multi-pack-index write --no-progress <weekly.txt
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

