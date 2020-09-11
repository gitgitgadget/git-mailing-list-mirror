Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48011C2BC11
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B2422204
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otBlYtHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgIKRtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgIKRt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:49:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD60C061795
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so5177807wmi.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jGQQK4nF2E5hnMjqZUWTxLWXcz3JGe8SWizEjtQ8E/o=;
        b=otBlYtHlKb11VjAy3/eN54FWuqiKBgUjtZ3ZQkk77LHsBRWwPoyvBIM9+/C6FLLewd
         eo2xaqYf7NQXoZXzeJLUjSC5gWWL5B1A8pZrzelEP8alIOx9G/ZSB2flDI2XlqT33Gvj
         x6NV1iisDlUs575vgcm3W72nILHuT7vdwyaP0sGri4uDKXrOGB+mka8+CIhizUI+TA8v
         7OY81eomu3Oa9spt68/y8TKqmBoQZhQ+TR4Y/tiahv34DF1ripkZUCimo7u2uQr/fIos
         g2TgZ/suhuCJgOHB7m3gxPaB+E9iJT3xGvRAAaYFgiss1JJDpEz3ajmBwGsHeB6dgxxs
         7zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jGQQK4nF2E5hnMjqZUWTxLWXcz3JGe8SWizEjtQ8E/o=;
        b=ScaZZgOCasdWVc635yieX7laCBlldHFMVrIcyt3g2FAsgUqXYXT6sOEeWSjFxst+nX
         taxoZ7obc9w/3+6l5nEMHEDngwkAFTXT/LkqcWkJtpMin2Da/mc20Etz45XxEIbh97vJ
         awqqQdqwfEVU/2PSFPeZXozbFDU81OJtZ3eoIkEUoKPGJPyUQDGwbxwrBA3abrJjBf2J
         vFbaBGeZ7m8/Vv1uNF/8Q7lak8uK7ouuAYH8cRD/2UByUtsMkPdMeTdCsUsh/Swm/RBs
         7jfPlcb+f51H44sPInxUOv1RcWEnRCiPTLL0gczURGH90ywZnWg/ooGGlQoqKfcTWrrV
         nzcg==
X-Gm-Message-State: AOAM532uVD33yfXwgg10cCWtWROE0n2csoAr1DgA3J4p4k5oVGW/9bRK
        Ii/9/aL8DJF+u4rMQzGDO0Xzp0WBEWo=
X-Google-Smtp-Source: ABdhPJxgyKB3RfEyL1mysGYRzU+fYpKhIQyTWfnii/yIeOStFtTz36uWFm34JBoQI5znPuZIhCV0FQ==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr3460730wmj.66.1599846565641;
        Fri, 11 Sep 2020 10:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm5692128wrn.56.2020.09.11.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:49:25 -0700 (PDT)
Message-Id: <1f49cda18ee8d6c585807506cf89c365de642ea7.1599846561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
        <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 17:49:17 +0000
Subject: [PATCH v2 4/7] maintenance: add [un]register subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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
index 3af5907b01..78d0d8df91 100644
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
index e28561b6c5..0290b249c9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1408,7 +1408,56 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
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
index 328bbaa830..272d1605d2 100755
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
@@ -304,4 +304,19 @@ test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
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

