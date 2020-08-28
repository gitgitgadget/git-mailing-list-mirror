Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7758EC43461
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434F520678
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ3DUESr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgH1Ppm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgH1PpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:45:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE60C061232
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so1725375wrm.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SfvL3JOcL/ldtyaSQB9lmmRpnkTZTst+HjJza8s3AfA=;
        b=AJ3DUESrQD69MVTREsu3NlqBazzFXc5rVgeKCx7hY/aq/j41WOkS2YVflJfws9nysa
         9qEEEb4xw6Ur8SCE4noa6CmS5ghtaPpIdAy/E2slcgHrxKkC3R/f1wS+l8IqjENL60Uh
         Z67g9x6OsgO4I2FZh685JDLdOEw5IGhPZzxNbG0b9KVZXIBqkV7wVGwpWF0Xnu69t6Im
         f9tjPQXkKSZ9vbthvtPtl8Jfyusv+zu9kTkxDMenfYxp14GfcExd60uDfB8pFD+91pzv
         AgkZtRpnfNhURgLGzxADeKMGk5jQxra3yKcnIEC29omcEMRo5T6uCMI++OFMY1uVDpSe
         s8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SfvL3JOcL/ldtyaSQB9lmmRpnkTZTst+HjJza8s3AfA=;
        b=gg3En8v1c4OZgPygAtKaHVkQd7p7xmT9odxYjufZgufK3g3PM0Ab09hsAwnBs5CeS2
         pUBwSAwcqd9vJXEHA0vx+7hhcwq82Zu3WgZFocEH8gkSsdRAWLEVgwD/NrSw/u0jKV/O
         NhYacG3/gsD+4w3vszBSlpPr4ZzFS2++8YoPaYT3mkGsr8K5RZBh8lGloTs4cE571Fqw
         QhxIUfqMmpcxf7nfdoeFED8fLKqji/BiP6YYIC7ety5nk2M68F+EA7+5A5RHTK70bmHR
         nEE4u0pUCB/UErKI6pLX63cVXedGk7RLPe8iNraxDM5LWNz/Jb/f4jNcJSzvD+p81Itw
         8QsQ==
X-Gm-Message-State: AOAM533IjmLBNjjBnZjXWhWNMs0/Gzzuolw2Zqt3Ao0TurCYGdYoRbx8
        fT1Fa8su6B7+BXmwwjb0ICAqZ68LyJ0=
X-Google-Smtp-Source: ABdhPJxe5pNMg4npK1jrG6d90lQ6e2pdxI3aDothDtcL51HOPieKAnlfYFIrMAS6M6Lvc8ZadpJ77A==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr1960183wro.233.1598629522203;
        Fri, 28 Aug 2020 08:45:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm3198885wrg.38.2020.08.28.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:45:21 -0700 (PDT)
Message-Id: <fc741fab5a1ea46f745724c2cc2eff67e9ac5801.1598629517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
References: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Aug 2020 15:45:15 +0000
Subject: [PATCH v3 4/6] maintenance: add [un]register subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
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
index 85a3370692..ec77e8d2fa 100644
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
@@ -1416,6 +1465,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 
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

