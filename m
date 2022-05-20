Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0CAC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 07:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiETHZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbiETHZC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 03:25:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B715AB39
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so3852206wms.5
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xrny4A1Wif/iYhxdKe9YylPx9l49mQfn6ckxMzWHS1g=;
        b=TkP/iwu/t0yNj6DoXwjVZt0JKWACATSKxIw0YboCNFfO8HsMZ1Y9I8kxG23s1Sl7BJ
         CvupY8E5w2G1pw7iwbeP31o1+kVtIUO+2Ge9Q/JRp6STkbFUxioRVtdKFWbhb3dDl7b1
         Q3tOQAy2pdI6TM4i5/WS5aPCpvYBgHFxDOq9dwVYLApdyoSjPGPp0ofCYilCaATFVbOh
         nDnmxOzuXBdgSxumtV5vCcc4uPtz7N08In/GEErItecxU6iqWjHd+iFbxH7eEM+m9mCZ
         YxJ/eEIG8XQfqd343HfKwavcLVY8+GREldI9o+0bIVlo4IYR9Qy7eAlq0NjgILstS+hA
         +ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xrny4A1Wif/iYhxdKe9YylPx9l49mQfn6ckxMzWHS1g=;
        b=osW5UixllT1+hu786Ia+GWjeNwPofTwHdFxmtIO1TXRj3D6neojJ2xuVrcuIV6nek7
         VDGR8FuHgjJrfTjJ0j//qp/RBcvA+TcKLKxOa/9RvGH84xK5b8r0oewvfZJEYcaYqye6
         sr1hvSSvrS6R/2TeuaNE2bNbJm9DIaiZ3YcF7MIOgibmK+LMjYIL0t+hQpH0TmSe8BIH
         TKJ8UKh3UigekqEv7rPiu/CiKchVgvNhNGvzM/dqL96uxE3gFAZIe7uzTd1iD5+TnvBJ
         Ga8zJvBsRU4YS1d16sT5oCt+bV6bmYVtIrek4NjFF1HAIp1z/+M1wYuRGaiCCL1W9rhI
         vurA==
X-Gm-Message-State: AOAM530MxaeWLxJDnBW9kEg3nYLZfIWJ2Eto4hKkmpF5cOkgoFflXC4Q
        orkRNoIuFR37kC3Se2nys8IoWjHLeDL8gQ==
X-Google-Smtp-Source: ABdhPJyNYYDTfCgjHcjDOCh53UflBlOV7uar9TgW5MHFCtVmnJ8oeXHIREAOGAJuczhN3Ux5Dh6nWQ==
X-Received: by 2002:a7b:ce04:0:b0:394:1f46:213 with SMTP id m4-20020a7bce04000000b003941f460213mr6768360wmc.157.1653031495982;
        Fri, 20 May 2022 00:24:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16-20020adfa2d0000000b0020d0a070c80sm1668429wra.35.2022.05.20.00.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:24:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] run-command API users: use "env" not "env_array" in comments & names
Date:   Fri, 20 May 2022 09:24:42 +0200
Message-Id: <patch-v2-4.4-5419f839c74-20220520T072122Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up on a preceding commit which changed all references to the
"env_array" when referring to the "struct child_process" member. These
changes are all unnecessary for the compiler, but help the code's
human readers.

All the comments that referred to "env_array" have now been updated,
as well as function names and variables that had "env_array" in their
name, they now refer to "env".

In addition the "out" name for the submodule.h prototype was
inconsistent with the function definition's use of "env_array" in
submodule.c. Both of them use "env" now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c |  2 +-
 run-command.c               |  6 +++---
 run-command.h               | 10 +++++-----
 sequencer.c                 |  6 +++---
 submodule.h                 |  4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b855e544bd6..0d37b9dd5bb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -513,7 +513,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		 * on windows. And since environment variables are
 		 * case-insensitive in windows, it interferes with the
 		 * existing PATH variable. Hence, to avoid that, we expose
-		 * path via the args strvec and not via env_array.
+		 * path via the args strvec and not via env.
 		 */
 		sq_quote_buf(&sb, path);
 		strvec_pushf(&cp.args, "path=%s; %s",
diff --git a/run-command.c b/run-command.c
index 5f7ea713f06..789eaa59750 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1816,16 +1816,16 @@ int run_auto_maintenance(int quiet)
 	return run_command(&maint);
 }
 
-void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
+void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
 {
 	const char * const *var;
 
 	for (var = local_repo_env; *var; var++) {
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
 		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
-			strvec_push(env_array, *var);
+			strvec_push(env, *var);
 	}
-	strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
+	strvec_pushf(env, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
 }
 
 enum start_bg_result start_bg_command(struct child_process *cmd,
diff --git a/run-command.h b/run-command.h
index d52ebc42b97..8a700da0998 100644
--- a/run-command.h
+++ b/run-command.h
@@ -58,7 +58,7 @@ struct child_process {
 	struct strvec args;
 
 	/**
-	 * Like .args the .env_array is a `struct strvec'.
+	 * Like .args the .env is a `struct strvec'.
 	 *
 	 * To modify the environment of the sub-process, specify an array of
 	 * environment settings. Each string in the array manipulates the
@@ -70,7 +70,7 @@ struct child_process {
 	 * - If the string does not contain '=', it names an environment
 	 *   variable that will be removed from the child process's environment.
 	 *
-	 * The memory in .env_array will be cleaned up automatically during
+	 * The memory in .env will be cleaned up automatically during
 	 * `finish_command` (or during `start_command` when it is unsuccessful).
 	 */
 	struct strvec env;
@@ -479,14 +479,14 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
 			       const char *tr2_category, const char *tr2_label);
 
 /**
- * Convenience function which prepares env_array for a command to be run in a
- * new repo. This adds all GIT_* environment variables to env_array with the
+ * Convenience function which prepares env for a command to be run in a
+ * new repo. This adds all GIT_* environment variables to env with the
  * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
  * corresponding environment variables to be unset in the subprocess) and adds
  * an environment variable pointing to new_git_dir. See local_repo_env in
  * cache.h for more information.
  */
-void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
+void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);
 
 /**
  * Possible return values for start_bg_command().
diff --git a/sequencer.c b/sequencer.c
index 701e420cddd..2ef6bf22e87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -919,7 +919,7 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
-static const char *author_date_from_env_array(const struct strvec *env)
+static const char *author_date_from_env(const struct strvec *env)
 {
 	int i;
 	const char *date;
@@ -1011,7 +1011,7 @@ static int run_git_commit(const char *defmsg,
 		strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
 			     opts->ignore_date ?
 			     "" :
-			     author_date_from_env_array(&cmd.env));
+			     author_date_from_env(&cmd.env));
 	if (opts->ignore_date)
 		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
 
@@ -3922,7 +3922,7 @@ static int do_merge(struct repository *r,
 			strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
 				     opts->ignore_date ?
 				     "" :
-				     author_date_from_env_array(&cmd.env));
+				     author_date_from_env(&cmd.env));
 		if (opts->ignore_date)
 			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
 
diff --git a/submodule.h b/submodule.h
index 40c14452377..2ac7a04e726 100644
--- a/submodule.h
+++ b/submodule.h
@@ -158,11 +158,11 @@ int submodule_move_head(const char *path,
 void submodule_unset_core_worktree(const struct submodule *sub);
 
 /*
- * Prepare the "env_array" parameter of a "struct child_process" for executing
+ * Prepare the "env" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific environment variables, but
  * retaining any config in the environment.
  */
-void prepare_submodule_repo_env(struct strvec *out);
+void prepare_submodule_repo_env(struct strvec *env);
 
 #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
 void absorb_git_dir_into_superproject(const char *path,
-- 
2.36.1.957.g2c13267e09b

