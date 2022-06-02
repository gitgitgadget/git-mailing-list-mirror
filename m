Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85893C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiFBJKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiFBJKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:10:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9DC2A90FD
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:10:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so2428449wmz.2
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CsWyKkAwaoVhR1g9p7QReXHHtq5pNKexnBKpoqiq5c=;
        b=RrNMjmRZzPR3kbG+/Az4Ruj1NEgg6YQFQzSNoWA/rQ/kS2z0EIi64EP0Od+aK7n6Gs
         dBFrrw+KMZblouMcNJvfwdfxrqbn/LDBI8sS83XWwckiSTdW2TzHiW1dv0jXKx5JzD+G
         QUgOdGo3s25bqDq4rzkKSRYkhADo8WdGLJ3OUvecbw+kahqZOlkwnNJpA9+D4D7FvOiX
         oDlEBfqTCH7gHhaapdFiltTpWTUSPtBJAyuWkc0Pv4AZu1kZcN0yKLkrFuiURjw0e/Cf
         uor3679MQxHZO+E2PBsf8muM2TLRnpu2ejrZn8wUcemc2R7qixW5WnaS9jGPQ0kAW/4E
         vBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CsWyKkAwaoVhR1g9p7QReXHHtq5pNKexnBKpoqiq5c=;
        b=G2UBFOjW0KevxI3o0uv3Aq6d7sK+8KeFfakOxByx33jj0OU829pDEM2tKSjSh8Khm0
         eBtKZPfvesZMzJgp9X9pxeLIXZRzDRetHIWSUH+lXGXrwKIOg+fMSqyDnwQd7DtXCmfo
         4GXo1tLSDn2zTUiclAIqEH1hhc6JxBxE+TxNkkLW39X6jg0+FrF9Lw5O4GEh3IHT0Jtc
         APOR1aToBOSJ61CB3FVM8a+wtYDCFJuJDu87HdaVBv0Y7FhCl1sR2u/5WikLjmJWU8dT
         IIiVYsyzfnDMW9LrEVzCiTeh800KJZRcF5ZdSlS7RRybmHNxt5eAFroyRNdZ+HG1hYGb
         4GXQ==
X-Gm-Message-State: AOAM533rpGyYK3Qjr5tLhRp4xrcXIWlkq9Ji29gmRi3uvl3uRmEaQQg5
        Nim15k3Qf6POZagwK68ENBLFYKsnpBFJdA==
X-Google-Smtp-Source: ABdhPJzyhzeAEGygQWb3/9WOagAQZtXYsDgI10hMYEiga3859p1ter1lyWOAnjhvyFSFZVGBpViNog==
X-Received: by 2002:a05:600c:601f:b0:397:6b94:74cc with SMTP id az31-20020a05600c601f00b003976b9474ccmr2946180wmb.111.1654161015654;
        Thu, 02 Jun 2022 02:10:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h42-20020a05600c49aa00b003973d425a7fsm4833088wmp.41.2022.06.02.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:10:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] run-command API users: use "env" not "env_array" in comments & names
Date:   Thu,  2 Jun 2022 11:09:51 +0200
Message-Id: <patch-v3-2.2-4039fec4f29-20220602T090745Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com>
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
index 437bc96e05e..bfaa9da1868 100644
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
2.36.1.1103.gb3ecdfb3e6a

