Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1494C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A880922DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgLEBrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgLEBrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD034C08E861
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v12so9330276ybi.6
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=o8KZDdUJzRd1GBk+8PwuUt5xSveC2sAaaXwufSZuVz8=;
        b=jim91O/WxeTKb63gfKQyDJ9r7RwFlQ7SErgkySU5VbIOTlfHK7vnMwkRLWYHm1XFx+
         xRO1NG25rlz8mOYzsE2gypRIOegT5BULrLb1OFddq1f8429I9HvH5NeJlXGkj29fyfMG
         sJF7YyndIgi3MA72hThtiBj1p3chPxzl0liAuGK1x1ermkZKm17SshepPoWrPObgXmNU
         bPBAZFeEJN6Cj6aamHnfFArfgtnh8LniZBzrwzGk8KsGLFn6cDlw7ffhq16GpjTA5q9z
         eDmBjSQugAm5TFjzQgSAlnk52sRiJHMGmg8sme9KSY1VHLd+dbi1QW2EcNzMHI0W7Th3
         rpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o8KZDdUJzRd1GBk+8PwuUt5xSveC2sAaaXwufSZuVz8=;
        b=ijiEYPy1KyEdCkoViRDZk0owhfNOutixQU9Rs7P5/q5x1JsIQcU5Bs9gqH+pZoSwoN
         16Y7DXXNhlDWPt+Z7Bq/dn216kbR5zSXCUu0bFEksk2L5hDSscQVd5/Q+KIQG1Nygbgv
         06OAzSdIiU1JWz3GORdEJ5FVjftI1MXqoAEu1nEPPJ87EmBsRBObEgz0WVBhCuNX/gz7
         ipOildGka3pJpdKNn3oRpaHC0kouFBzFIbss20j+Y1cxbRI7zUI67RO3q0inhpZ+BtjM
         qnfRCpS3jIKU43paVaJELxFL6ZYWBZO8qIZdPwMht1NirpfGVlHuGClvCVykSqYi4CxP
         16FQ==
X-Gm-Message-State: AOAM533Lqo/wyNmH/uwyrZywXHi146dzn2lT/oNl8uwtI/fn1uhj4Pjj
        II5nEnR9L5C9Ky1PnYMbkwMn21ziBjBNAZhx8uCeuTbORymJR+V7aJyVxiHt6HbQLQUlVtRvwJY
        3bGQny27Bkj3isDnxKyPqd7KJ8YFDjo92XrZcoXnSNX+vb0lxTUSY8NbnG1P2t6FDZbEDy6KK6Q
        ==
X-Google-Smtp-Source: ABdhPJxx3y2KO84KYYdtGzDyEtlyamkKrvnmYdEF3ibnuf3PMWdsiWy/ZSJNl9l1PqcogOW3kdCcXGdKH4kYUVdQ8ts=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:37c6:: with SMTP id
 e189mr8980790yba.89.1607132796896; Fri, 04 Dec 2020 17:46:36 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:02 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 12/17] hook: allow parallel hook execution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many cases, there's no reason not to allow hooks to execute in
parallel. run_processes_parallel() is well-suited - it's a task queue
that runs its housekeeping in series, which means users don't
need to worry about thread safety on their callback data. True
multithreaded execution with the async_* functions isn't necessary here.
Synchronous hook execution can be achieved by only allowing 1 job to run
at a time.

Teach run_hooks() to use that function for simple hooks which don't
require stdin or capture of stderr.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Per AEvar's request - parallel hook execution on day zero.
    
    In most ways run_processes_parallel() worked great for me - but it didn't
    have great support for hooks where we pipe to and from. I had to add this
    support later in the series.
    
    Since I modified an existing and in-use library I'd appreciate a keen look on
    these patches.
    
     - Emily

 Documentation/config/hook.txt |   5 ++
 Documentation/git-hook.txt    |  15 +++-
 builtin/hook.c                |   6 +-
 hook.c                        | 142 ++++++++++++++++++++++++++--------
 hook.h                        |  28 ++++++-
 5 files changed, 158 insertions(+), 38 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 75312754ae..a423d13781 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -12,3 +12,8 @@ hook.runHookDir::
 	Controls how hooks contained in your hookdir are executed. Can be any of
 	"yes", "warn", "interactive", or "no". Defaults to "yes". See
 	linkgit:git-hook[1] and linkgit:git-config[1] "core.hooksPath").
+
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to the number of processors on
+	the current system.
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index cce30a80d0..c2678c61b2 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git hook' list <hook-name>
 'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>]
-	<hook-name>
+	[(-j|--jobs) <n>] <hook-name>
 
 DESCRIPTION
 -----------
@@ -66,7 +66,8 @@ in the order they should be run, and print the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
 This output is human-readable and the format is subject to change over time.
 
-run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
+run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>]
+	[(-j|--jobs)<n>]`<hook-name>`::
 
 Runs hooks configured for `<hook-name>`, in the same order displayed by `git
 hook list`. Hooks configured this way are run prepended with `sh -c`, so paths
@@ -98,6 +99,16 @@ Specify environment variables to set for every hook that is run.
 Specify a file which will be streamed into stdin for every hook that is run.
 Each hook will receive the entire file from beginning to EOF.
 
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specified, use
+the value of the `hook.jobs` config. If the config is not specified, use the
+number of CPUs on the current system. Some hooks may be ineligible for
+parallelization: for example, 'commit-msg' intends hooks modify the commit
+message body and cannot be parallelized.
+
 CONFIGURATION
 -------------
 include::config/hook.txt[]
diff --git a/builtin/hook.c b/builtin/hook.c
index e45831e01d..064a0fea29 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -10,7 +10,7 @@
 static const char * const builtin_hook_usage[] = {
 	N_("git hook list <hookname>"),
 	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...]"
-	   "[--to-stdin=<path>] <hookname>"),
+	   "[--to-stdin=<path>] [(-j|--jobs) <count>] <hookname>"),
 	NULL
 };
 
@@ -90,7 +90,7 @@ static int list(int argc, const char **argv, const char *prefix)
 static int run(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf hookname = STRBUF_INIT;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	int rc = 0;
 
 	struct option run_options[] = {
@@ -100,6 +100,8 @@ static int run(int argc, const char **argv, const char *prefix)
 			   N_("argument to pass to hook")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_INTEGER('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index c7fdf556fe..edea54f95c 100644
--- a/hook.c
+++ b/hook.c
@@ -136,6 +136,14 @@ enum hookdir_opt configured_hookdir_opt(void)
 	return hookdir_unknown;
 }
 
+int configured_hook_jobs(void)
+{
+	int n = online_cpus();
+	git_config_get_int("hook.jobs", &n);
+
+	return n;
+}
+
 static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
 {
 	struct strbuf prompt = STRBUF_INIT;
@@ -223,6 +231,7 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
 	strvec_init(&o->env);
 	strvec_init(&o->args);
 	o->run_hookdir = configured_hookdir_opt();
+	o->jobs = configured_hook_jobs();
 }
 
 int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
@@ -246,11 +255,96 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
 	strvec_clear(&o->args);
 }
 
+
+static int pick_next_hook(struct child_process *cp,
+			  struct strbuf *out,
+			  void *pp_cb,
+			  void **pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+
+	struct hook *hook = list_entry(hook_cb->run_me, struct hook, list);
+
+	if (hook_cb->head == hook_cb->run_me)
+		return 0;
+
+	cp->env = hook_cb->options->env.v;
+	cp->stdout_to_stderr = 1;
+	cp->trace2_hook_name = hook->command.buf;
+
+	/* reopen the file for stdin; run_command closes it. */
+	if (hook_cb->options->path_to_stdin) {
+		cp->no_stdin = 0;
+		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else {
+		cp->no_stdin = 1;
+	}
+
+	/*
+	 * Commands from the config could be oneliners, but we know
+	 * for certain that hookdir commands are not.
+	 */
+	if (hook->from_hookdir)
+		cp->use_shell = 0;
+	else
+		cp->use_shell = 1;
+
+	/* add command */
+	strvec_push(&cp->args, hook->command.buf);
+
+	/*
+	 * add passed-in argv, without expanding - let the user get back
+	 * exactly what they put in
+	 */
+	strvec_pushv(&cp->args, hook_cb->options->args.v);
+
+	/* Provide context for errors if necessary */
+	*pp_task_cb = hook;
+
+	/* Get the next entry ready */
+	hook_cb->run_me = hook_cb->run_me->next;
+
+	return 1;
+}
+
+static int notify_start_failure(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cp)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct hook *attempted = pp_task_cp;
+
+	/* |= rc in cb */
+	hook_cb->rc |= 1;
+
+	strbuf_addf(out, _("Couldn't start '%s', configured in '%s'\n"),
+		    attempted->command.buf,
+		    attempted->from_hookdir ? "hookdir"
+		    	: config_scope_name(attempted->origin));
+
+	/* NEEDSWORK: if halt_on_error is desired, do it here. */
+	return 0;
+}
+
+static int notify_hook_finished(int result,
+				struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+
+	/* |= rc in cb */
+	hook_cb->rc |= result;
+
+	/* NEEDSWORK: if halt_on_error is desired, do it here. */
+	return 0;
+}
+
 int run_hooks(const char *hookname, struct run_hooks_opt *options)
 {
 	struct strbuf hookname_str = STRBUF_INIT;
 	struct list_head *to_run, *pos = NULL, *tmp = NULL;
-	int rc = 0;
+	struct hook_cb_data cb_data = { 0, NULL, NULL, options };
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -260,41 +354,23 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	to_run = hook_list(&hookname_str);
 
 	list_for_each_safe(pos, tmp, to_run) {
-		struct child_process hook_proc = CHILD_PROCESS_INIT;
 		struct hook *hook = list_entry(pos, struct hook, list);
 
-		/* reopen the file for stdin; run_command closes it. */
-		if (options->path_to_stdin)
-			hook_proc.in = xopen(options->path_to_stdin, O_RDONLY);
-		else
-			hook_proc.no_stdin = 1;
-
-		hook_proc.env = options->env.v;
-		hook_proc.stdout_to_stderr = 1;
-		hook_proc.trace2_hook_name = hook->command.buf;
-		hook_proc.use_shell = 1;
-
-		if (hook->from_hookdir) {
-		    if (!should_include_hookdir(hook->command.buf, options->run_hookdir))
-			continue;
-		    /*
-		     * Commands from the config could be oneliners, but we know
-		     * for certain that hookdir commands are not.
-		     */
-		    hook_proc.use_shell = 0;
-		}
-
-		/* add command */
-		strvec_push(&hook_proc.args, hook->command.buf);
+		if (hook->from_hookdir &&
+		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
+			    list_del(pos);
+	}
 
-		/*
-		 * add passed-in argv, without expanding - let the user get back
-		 * exactly what they put in
-		 */
-		strvec_pushv(&hook_proc.args, options->args.v);
+	cb_data.head = to_run;
+	cb_data.run_me = to_run->next;
 
-		rc |= run_command(&hook_proc);
-	}
+	run_processes_parallel_tr2(options->jobs,
+				   pick_next_hook,
+				   notify_start_failure,
+				   notify_hook_finished,
+				   &cb_data,
+				   "hook",
+				   hookname);
 
-	return rc;
+	return cb_data.rc;
 }
diff --git a/hook.h b/hook.h
index 5184dcaa5a..f54568afe3 100644
--- a/hook.h
+++ b/hook.h
@@ -37,6 +37,9 @@ enum hookdir_opt
  */
 enum hookdir_opt configured_hookdir_opt(void);
 
+/* Provides the number of threads to use for parallel hook execution. */
+int configured_hook_jobs(void);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -54,15 +57,38 @@ struct run_hooks_opt
 
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
+
+	/* Number of threads to parallelize across */
+	int jobs;
 };
 
-#define RUN_HOOKS_OPT_INIT  {   		\
+/*
+ * Callback provided to feed_pipe_fn and consume_sideband_fn.
+ */
+struct hook_cb_data {
+	int rc;
+	struct list_head *head;
+	struct list_head *run_me;
+	struct run_hooks_opt *options;
+};
+
+#define RUN_HOOKS_OPT_INIT_SYNC  {   		\
 	.env = STRVEC_INIT, 			\
 	.args = STRVEC_INIT, 			\
 	.path_to_stdin = NULL,			\
+	.jobs = 1,				\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
+#define RUN_HOOKS_OPT_INIT_ASYNC {		\
+	.env = STRVEC_INIT, 			\
+	.args = STRVEC_INIT, 			\
+	.path_to_stdin = NULL,			\
+	.jobs = configured_hook_jobs(),		\
+	.run_hookdir = configured_hookdir_opt()	\
+}
+
+
 void run_hooks_opt_init(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

