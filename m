Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCBC43217
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJNPk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJNPko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A06136412
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 6-20020a1c0206000000b003c6c154d528so668500wmc.4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMmTZ84LRl1cKUH9c/6XaQnfWOvXVtaEIbKisUsW30Y=;
        b=OPcOlbawIyBraQKuCrXYQ2hOjd0cimKtUnKhNMMPjU7xN0fYXR6GihEe2RCVI2630w
         UAmUVbWn9s9ON06IIIM6i3JCaF4BbyCrD2n6HObBxVNA9KPUf+1HIoyUNOSEtOXNDav+
         wi9e3zvSOfmpjVbwaMwzlLMiTSxNFvpdYdXEOaIJSB5jgFZzr/ckHSo1f+h399uXIsYP
         oD2uQL4dvXmt5X9D1E9jN7hNwoSfntj60tQ4wNdsOjBNq0k8lSEExNbIKyvt9k9o76lo
         2XTV1jQk1+nNtZYbXMKzQBzk28bGNhLJ9LkfwLIDm4fyxkJNrXRfnlm8oUCoIT8+LgwQ
         0oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMmTZ84LRl1cKUH9c/6XaQnfWOvXVtaEIbKisUsW30Y=;
        b=H3L8yU/2c77iD43B8Mm6Y5Q9S03HXq8TQPitgVhnC93l7YpQSNg+I9XXqrs6YhEU94
         iZnLwX8RsMAWNyzRyRgL8nsrw8W/i09ehfJ7XgdpdkU0ept37r0MMNaY01cHzQQ7V6Kx
         +uElfmBzw60oEpUAaMo/fsDk79dcyOXrHAa3PNhWumRJBu4Z6PM/IRJdKf8+b8GKGzCZ
         BWlDnDd+38qDAviHxdIu+sho7HuGVNOZN83mX+tEZcx9b79q98lCqyP+Xpmi10A+do5F
         EH5j06NS90y0ms+WWtAFyooOhO05MYogvAU+z0VwAkkM14LJy+mznDN2U+Aep2aHSg4K
         DXSQ==
X-Gm-Message-State: ACrzQf1T/huHWsgoWFONkr6e/kVVPOOGAaA8vef+Ol/zVNJLhtB0I088
        j68jQ2G4gPmhBnp6RDiOzuq6T+9ASNO7VA==
X-Google-Smtp-Source: AMsMyM7CGmrdTRQkuTmeyXdTPAzickYoWktTz1SYk+4YDK1ntt8sArQawz82qz64KkmbCE51iZjGqw==
X-Received: by 2002:a05:600c:3543:b0:3b4:ba45:9945 with SMTP id i3-20020a05600c354300b003b4ba459945mr10748174wmq.58.1665762035757;
        Fri, 14 Oct 2022 08:40:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] run-command API & users: remove run_command_v_opt_tr2()
Date:   Fri, 14 Oct 2022 17:40:20 +0200
Message-Id: <patch-08.10-88e063f3b05-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit for run_command_v_opt_cd_env() that
function's users could more easily use the underlying run_command()
directly.

In the case of the "git.c" user that can be argued the other way,
given the slight line count increase here, but part of that's because
the "args" in "git.c" was being leaked, which we now don't have to
worry about.

That just leaves the spawn_daemon() user in "fsmonitor-ipc.c", it's
likewise slightly more verbose as a result, but by making it use
run_command() we can remove this entire part of the API. As noted in a
preceding commit run_command_v_opt*() should be aimed at handling
various common cases, not these one-offs.

The "fsmonitor-ipc.c" caller would be nicer with a hypothetical
run_command_l_opt_tr2(), but let's not maintain such a thing only for
it, as it would be its only user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsmonitor-ipc.c | 10 +++++++---
 git.c           | 15 +++++++++------
 run-command.c   | 28 ++--------------------------
 run-command.h   | 19 +++----------------
 4 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..7251f48e456 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -56,10 +56,14 @@ enum ipc_active_state fsmonitor_ipc__get_state(void)
 
 static int spawn_daemon(void)
 {
-	const char *args[] = { "fsmonitor--daemon", "start", NULL };
+	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
-				    "fsmonitor");
+	cmd.git_cmd = 1;
+	cmd.no_stdin = 1;
+	cmd.trace2_child_class = "fsmonitor";
+	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
+
+	return run_command(&cmd);
 }
 
 int fsmonitor_ipc__send_query(const char *since_token,
diff --git a/git.c b/git.c
index da411c53822..ccf444417b5 100644
--- a/git.c
+++ b/git.c
@@ -787,7 +787,7 @@ static int run_argv(int *argcp, const char ***argv)
 		if (!done_alias)
 			handle_builtin(*argcp, *argv);
 		else if (get_builtin(**argv)) {
-			struct strvec args = STRVEC_INIT;
+			struct child_process cmd = CHILD_PROCESS_INIT;
 			int i;
 
 			/*
@@ -804,18 +804,21 @@ static int run_argv(int *argcp, const char ***argv)
 
 			commit_pager_choice();
 
-			strvec_push(&args, "git");
+			strvec_push(&cmd.args, "git");
 			for (i = 0; i < *argcp; i++)
-				strvec_push(&args, (*argv)[i]);
+				strvec_push(&cmd.args, (*argv)[i]);
 
-			trace_argv_printf(args.v, "trace: exec:");
+			trace_argv_printf(cmd.args.v, "trace: exec:");
 
 			/*
 			 * if we fail because the command is not found, it is
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
-			i = run_command_v_opt_tr2(args.v, RUN_SILENT_EXEC_FAILURE |
-						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
+			cmd.silent_exec_failure = 1;
+			cmd.clean_on_exit = 1;
+			cmd.wait_after_clean = 1;
+			cmd.trace2_child_class = "git_alias";
+			i = run_command(&cmd);
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
 			die("could not execute builtin %s", **argv);
diff --git a/run-command.c b/run-command.c
index 6132a9f19f0..0066ace85fa 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1010,7 +1010,6 @@ static void run_command_set_opts(struct child_process *cmd, int opt)
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 	cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
-	cmd->clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd->wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
 	cmd->close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
 }
@@ -1031,35 +1030,12 @@ int run_command_l_opt(int opt, ...)
 }
 
 int run_command_v_opt(const char **argv, int opt)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
-}
-
-int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
-}
-
-static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, int opt,
-					  const char *dir,
-					  const char *const *env,
-					  const char *tr2_class)
-{
-	run_command_set_opts(cmd, opt);
-	cmd->dir = dir;
-	if (env)
-		strvec_pushv(&cmd->env, (const char **)env);
-	cmd->trace2_child_class = tr2_class;
-	return run_command(cmd);
-}
-
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
-				 const char *const *env, const char *tr2_class)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	strvec_pushv(&cmd.args, argv);
-	return run_command_v_opt_cd_env_tr2_1(&cmd, opt, dir, env, tr2_class);
+	run_command_set_opts(&cmd, opt);
+	return run_command(&cmd);
 }
 
 #ifndef NO_PTHREADS
diff --git a/run-command.h b/run-command.h
index 2574d46cb70..2b1fe3cde5c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -228,12 +228,11 @@ int run_auto_maintenance(int quiet);
 #define RUN_GIT_CMD			(1<<1)
 #define RUN_SILENT_EXEC_FAILURE		(1<<2)
 #define RUN_USING_SHELL			(1<<3)
-#define RUN_CLEAN_ON_EXIT		(1<<4)
-#define RUN_WAIT_AFTER_CLEAN		(1<<5)
-#define RUN_CLOSE_OBJECT_STORE		(1<<6)
+#define RUN_WAIT_AFTER_CLEAN		(1<<4)
+#define RUN_CLOSE_OBJECT_STORE		(1<<5)
 
 /**
- * The run_command_v_opt*() API is a convenience wrapper for an
+ * The run_command_v_opt() function is a convenience wrapper for an
  * underlying run_command().
  *
  * It's intended to be used when the user already has an "argv" they'd
@@ -250,21 +249,9 @@ int run_auto_maintenance(int quiet);
  *	- RUN_GIT_CMD: .git_cmd
  *	- RUN_SILENT_EXEC_FAILURE: .silent_exec_failure
  *	- RUN_USING_SHELL: .use_shell
- *	- RUN_CLEAN_ON_EXIT: .clean_on_exit
- *	- RUN_WAIT_AFTER_CLEAN: .wait_after_clean
  *	- RUN_CLOSE_OBJECT_STORE: .close_object_store
- *
- * The argument dir corresponds the member .dir. The argument env
- * corresponds to the member .env.
  */
 int run_command_v_opt(const char **argv, int opt);
-int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class);
-/*
- * env (the environment) is to be formatted like environ: "VAR=VALUE".
- * To unset an environment variable use just "VAR".
- */
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
-				 const char *const *env, const char *tr2_class);
 
 /**
  * The run_command_l_opt() function run_command_v_opt() takes a list
-- 
2.38.0.1092.g8c0298861b0

