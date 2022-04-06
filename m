Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD942C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 14:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiDFO2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiDFO2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 10:28:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DD4FBF6E
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 03:42:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r11-20020a1c440b000000b0038ccb70e239so3346237wma.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aQ2Txs/DGeUb4S7SgtNj5Apd/rZvTXHy0IY8enozCA=;
        b=pynZ+5F7OLAC1PyNrcB/ti+2Py7mI+cT1RyAGjNXuw3VmREZXkpFJMO8igsJu8z3kA
         lEt9ZiwjRiQea1Q6SuDa5ZVwzzDzv4+GX1cHgkt/oVw3TEpqYBFBWym3MKr3ft5TTEam
         T2KgOshMX/DOnlkaVdj7sHp/H+J1OCGD8Via4/CvermcNHwGzT/4Ok61wvny2p6V/dhP
         g7SvO75n+eT3G69dog177pANJyfr4w+3GJR1LoNHFDvKYeqmp+tbyNnDQqFHZwMi0LZ4
         hQ8B6ddidl3Y5NfSb8FB1ThOeUNMhyZAm1sAk2Dy65takdFfS9YHWQfxIwAIZIeA5na7
         vTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aQ2Txs/DGeUb4S7SgtNj5Apd/rZvTXHy0IY8enozCA=;
        b=a61y4LNW5UINIM8eaZVeRWm/vfNINbgDERgxed86vHaj2/qGNr0JeoEbEiIKbZj4G8
         0a3ZM3lBIvPjUHHWVpq/e4ImTdXUeVx4xSGbNQV4NQv6nbe/7OnQL7JoZhLwiyoIUVMn
         LpgOwLsrhoyKvTm88Mof7wKBsSjRtTWgLn4C4gSXWVUp4Q4LVfzm+q/fM1JNB6KqSBlY
         Dv83/LE4KfqDzA79AvHjl88QkPLRf3v93XN+Lo45KpOUuoUQ6hENJ7Dmg3+EdxFfohGI
         YZFkfZVLU3Q3XY1brsQw3ORSIeVFM1PPqxNR8q2Cdb0WllVqrh8eykatJf+EJ3+BBsoT
         Q6jQ==
X-Gm-Message-State: AOAM530Jmg/P4+ZZlmlW0sIQhKVTvn231X904LHDYCYxQ8uRkDDBTXvM
        Ev9YLH/W1yBk/SvR69LDAGYo5mYlggiKZA==
X-Google-Smtp-Source: ABdhPJyIRVMLAEZcMeGrl4djQqbrS+C+DTi6GbKUoCgoR63cIuOg+JHls/q1et+3HNbzucJCWH+Sbg==
X-Received: by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id k13-20020a7bc30d000000b003814bb9eedemr6856702wmj.74.1649241773033;
        Wed, 06 Apr 2022 03:42:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b0038cb422e3fesm4831288wmq.32.2022.04.06.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 03:42:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] run-command API users: use "env" not "env_array" in comments & names
Date:   Wed,  6 Apr 2022 12:42:45 +0200
Message-Id: <patch-3.3-8af76f39b9f-20220406T104134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc0.849.g2d5b5d9ab01
In-Reply-To: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
References: <Ybtb6Shdj56ACdub@coredump.intra.peff.net> <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up on the preceding commit which changed all references to the
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
index d89184fbf47..0f1b82fd87f 100644
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
index 89e1bda0c96..bb43ccf646e 100644
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
@@ -480,14 +480,14 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
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
index 3d0331b7689..79e14b51a23 100644
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
 
@@ -3923,7 +3923,7 @@ static int do_merge(struct repository *r,
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
2.36.0.rc0.849.g2d5b5d9ab01

