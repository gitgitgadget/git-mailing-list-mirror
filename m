Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A3C43217
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiJQRuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJQRto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36715FF8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so10558786wmb.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu1Mw+iMZUbADGlnnmkAMuktq2G8TJ6IytTSFQu4lRI=;
        b=e1qycXqi2b+h/yjl16cZWP19qSM0J3DGE9taXsCkE+p4T6heUd80AEgR6a7AZTYcMJ
         MdL2ObZNn5YPbne2aBB+HdyrsoFbFZ9Z+isQPhlIQIOQyW+HrBFr3+qcKKJVCbM02/Db
         KEXotqy+o1CjqxXxVXf5V32gus0besKfEcUQbVYQBNIl3c9DlSwPbg9IagfYgdpta9rS
         czzwJ084KY3HCtmAW4Hr/Oy6YY7Rtug2q26jfDnqTVNTT+1beaItowpvbACjhuhiCKZM
         yR5/LEMpMHd+pPpPkPL6vTgxnm5UOxodyPWB7OZ4M/SeuVlXvdKl1VyOT+zixlzGa5v/
         w25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu1Mw+iMZUbADGlnnmkAMuktq2G8TJ6IytTSFQu4lRI=;
        b=uDj4UOkIeJ/bC3xJBmwogTFj+UogK4+4vRBhFmpO9mlnQL3jpvxLdilEChDqPSjVbB
         /OWff2V0X0Y41zSYL6xByZ2aaBExtcsZ2inu88Z0P14W0JdJSHUEvfZGgWsKmQx4ESCo
         RAhzZxMeWCUezIj0RpWtFzQ47sbe7kVN6Bjql//uchG3EZnxHvoxVhTmFlbNbRG/HVRd
         N9O7C8BJ9H1Jum4cgCNa1NP+68Nn98/Ew23o7+8EPfEUv37TtQZJV9GLBZ4TswY4z35j
         Ic9CfbsO3XS2Aftg4BGxz003EZtAo9C2kSUCdK8nBnoCJUx5XFulEY13YVuXiIp7NY6X
         EZvg==
X-Gm-Message-State: ACrzQf042T+jQHWosJIToNDNI4Cg5mYeYMQj8oIxhHr99qwAOOJEB54K
        M8brd3MUeZ5BKuqkLVKrqGTXOuRay7ovGQ==
X-Google-Smtp-Source: AMsMyM6OLJ5FJJvzG+kpaLmxZJRDGsQZTO1NBZWsKn+CBdaeql25ltU9evasIwxmzP7pCggGgemmqA==
X-Received: by 2002:a05:600c:35ce:b0:3c6:809a:b5c3 with SMTP id r14-20020a05600c35ce00b003c6809ab5c3mr8160325wmq.206.1666028975345;
        Mon, 17 Oct 2022 10:49:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] run-command API & users: remove run_command_v_opt_tr2()
Date:   Mon, 17 Oct 2022 19:49:19 +0200
Message-Id: <patch-v2-08.10-4f1a051823f-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
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
 run-command.c   | 26 +++-----------------------
 run-command.h   | 19 +++----------------
 4 files changed, 22 insertions(+), 48 deletions(-)

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
index 25a978fb027..0066ace85fa 100644
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
@@ -1030,32 +1029,13 @@ int run_command_l_opt(int opt, ...)
 	return run_command(&cmd);
 }
 
-static int run_command_v_opt_1(struct child_process *cmd, int opt)
-{
-	run_command_set_opts(cmd, opt);
-	return run_command(cmd);
-}
-
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
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
-				 const char *const *env, const char *tr2_class)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+
 	strvec_pushv(&cmd.args, argv);
-	cmd.dir = dir;
-	if (env)
-		strvec_pushv(&cmd.env, (const char **)env);
-	cmd.trace2_child_class = tr2_class;
-	return run_command_v_opt_1(&cmd, opt);
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
2.38.0.1091.gf9d18265e59

