Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6DAC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD320885
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgW2EgiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHSRR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHSRRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:17:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64261C061344
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so22289346wrs.8
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8w+O16rls3OYS+PPfEjmild1DTwYxx/bT7BABEf6eVk=;
        b=rgW2EgiVWXLh3j/QMRosilC0r73Fhzf1GoKu+4r7d0a9P5Sq0o/CzEWEi5jFg5M0cO
         8ANUgDHoGH27wxXOXh20eg843qGg9ptCmxb4Apmir6c2X8bMzTV/df6hFomdKUsu3hgm
         fZiJ55mZlTEaP4ViGa8uS6HbRcvHy0JWEZ9JRFzHd6Ndfk1ZxPBMcZw2l6sp3AxLIlLC
         4mZhtVTX94MuYibfoGcqeEh3AIxDSeByNjhVUJqYoHbVXBuUyU/7m6Nb/kv7zHh25FJ7
         FfJzv1QiIkO2Pjwrcm/wVGmKDTNME8z3XpWZZTwe9T8FBXlA6X+coZxckDjlXSJFeN0o
         NwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8w+O16rls3OYS+PPfEjmild1DTwYxx/bT7BABEf6eVk=;
        b=l7rnMllkx7vi9uHtAC5IReBYA8pUb6MZxv7oc9CXf3MjhdRpJTDfHkj1qsZ+bVS4uw
         T3bGCt5n0nHURd0fw12mUTjSu1quVCpP4mOkDdd0MA6FN60Al20jPJqUkngd2gBN9wYW
         H32wV5hJIbwdqXeFlRKpM8KQi9Sr2BpoO65d7RNWfDkzSuX4cRP2JCZUyBGCwS7JIeLv
         an64x8nYAl1UqrRQLx7dDGaTLMLAljV/pFjy1ssU+xxY3i1xaYyCmyD7nli7SjE7XXZb
         tR6BXQF2pfV01xxDSGoafWRlMmMwsGtaHYKKr4ArJwWpQY343t97Io4Js7eoxy044HLY
         2FhA==
X-Gm-Message-State: AOAM532YJKzuo/5WyS21ukKkzp+uY+Yorl7DzEGpdwz/nEH26aAeZQ6q
        5R3jABvQiCgfkb9gWGgOPLtLYbmC4i0=
X-Google-Smtp-Source: ABdhPJygNltHiSQ4xyqHwYUxv4tU1iachGX5uy9wTcKbZJCn3kyJ+nLV8EOf6p/+OGtFnckQfpo6vA==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr25840090wrg.7.1597857429678;
        Wed, 19 Aug 2020 10:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm44095023wrb.12.2020.08.19.10.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:17:09 -0700 (PDT)
Message-Id: <f44c6a0f2032f77cc9a254c645a94830fc177896.1597857412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:46 +0000
Subject: [PATCH 5/7] maintenance: add [un]register subcommands
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
index e8004e7b11..ac6fcae678 100644
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
index 352948529d..eb8a0a52ab 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -705,7 +705,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 }
 
 static const char * const builtin_maintenance_usage[] = {
-	N_("git maintenance run [<options>]"),
+	N_("git maintenance <subcommand> [<options>]"),
 	NULL
 };
 
@@ -1445,6 +1445,55 @@ static int task_option_parse(const struct option *opt,
 	return 0;
 }
 
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
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -1486,8 +1535,12 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_maintenance_usage,
 				   builtin_maintenance_options);
 
+	if (!strcmp(argv[0], "register"))
+		return maintenance_register();
 	if (!strcmp(argv[0], "run"))
 		return maintenance_run(&opts);
+	if (!strcmp(argv[0], "unregister"))
+		return maintenance_unregister();
 
 	die(_("invalid subcommand: %s"), argv[0]);
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

