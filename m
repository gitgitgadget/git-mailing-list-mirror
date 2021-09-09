Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D211661059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhIIOUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346601AbhIIOTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901DC10DC45
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:42:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g74so1250034wmg.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQFAkh6iPGl4+gHDzwwaymLh9mq6wirma5ptMQKbIvY=;
        b=cvTi6lqadFffL7tAofQNqk/dhirGnppusXGbhFFx8UWJogM8OblBL7PaH57XunDc+Z
         fCtq7Fql9iuiiM+9uU1CUE32M4s3OQ23sHT06mE6gC2sB11Q8feicNn9sXFSkyd8JTrM
         7J5yFG+kOCHkZToLl/rYz9wbkfTi1UZO6B0IXftgnKXVBxpc1OshovHK/OU/h57m0YMx
         q9OEvbTnHwxBHTzMXg7ZNLslpY7bbKjLm+7zj/WDk1paqTAzsYOyIx9iVh9k8Ej8h3Kc
         MCTizMJG8Ow0A67Jq6OrUTSpam4ThL0DV+9QCDmbKq2WO+tj88zL08xHXYqPx/e+V5ns
         6Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQFAkh6iPGl4+gHDzwwaymLh9mq6wirma5ptMQKbIvY=;
        b=XOGT1fqxm5lF+mxeYWJGe4AoyDO8q2p4JfOeSIKXnupD+XZVSHcXO2qbTH4fK2qJDy
         wLj0136N4Gj3l8V3IM+heTmJ2UNz82wdM64c6zKcm1arV79hUanaAr4906moQ7Ls2r3a
         ftodZRPQWM0QHcbU1hje1qXN3+AbxXQsFQ7MRoPExJLkloKUPR+8IY8yXcpOEGlFCf92
         LOjLMnrbHBo9PIVz2PBF0VLCg8ANvhySUraCYZUmDgNqB7eB8LGmA3I2CxgGpTUuJcJd
         MFVEqLhdi49+LcOKUnYACj5hTVMSpPm/TuA2svTkmtxyLJbjVaWIHqGuMJGYXVrM8ndP
         PJUg==
X-Gm-Message-State: AOAM532EhG7bUj/atpJ6Pb9Lk+iq0Sod1XmsvZH4C6kEp4zWySWMWrSK
        VeO2vNAQK9jUvY3HuoApi0Yq/Bg77ftAaQ==
X-Google-Smtp-Source: ABdhPJytgvMzX7zz7vebkfphZ6qqtHH5xyI38q2ApVrZQI7xlQACF2QcJ2jBERpiTaCI81v+HHEKlA==
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr2716491wmi.77.1631191331288;
        Thu, 09 Sep 2021 05:42:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j25sm1742081wrc.12.2021.09.09.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:42:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/5] hook: allow parallel hook execution
Date:   Thu,  9 Sep 2021 14:42:00 +0200
Message-Id: <patch-v4-2.5-b03e70c805e-20210909T122802Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com> <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

In many cases, there's no reason not to allow hooks to execute in
parallel, if more than one was provided. hook.c already calls
run_processes_parallel(), so all we need to do is allow the job count we
hand to run_processes_parallel() to be greater than 1.

If users have specified no alternative, we can use the processor count
from online_cpus() to run an efficient number of tasks at once. However,
users can also override this number if they want by configuring
'hook.jobs'.

To avoid looking up 'hook.jobs' in cases where we don't end up with any
hooks to run anyways, teach the hook runner commands to notice if
.jobs==0 and do a config or online_cpus() lookup if so, when we already
know we have jobs to run.

Serial execution can still be performed by setting .jobs == 1.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt      |  2 ++
 Documentation/config/hook.txt |  4 ++++
 Documentation/git-hook.txt    | 17 ++++++++++++++++-
 builtin/am.c                  |  4 ++--
 builtin/checkout.c            |  2 +-
 builtin/clone.c               |  2 +-
 builtin/hook.c                |  4 +++-
 builtin/merge.c               |  2 +-
 builtin/rebase.c              |  2 +-
 builtin/receive-pack.c        |  9 +++++----
 builtin/worktree.c            |  2 +-
 commit.c                      |  2 +-
 hook.c                        | 35 ++++++++++++++++++++++++++++++++---
 hook.h                        | 16 +++++++++++++++-
 read-cache.c                  |  2 +-
 refs.c                        |  2 +-
 reset.c                       |  3 ++-
 sequencer.c                   |  4 ++--
 transport.c                   |  2 +-
 19 files changed, 92 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/config/hook.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c0e6b859f1..6fb218f649d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -391,6 +391,8 @@ include::config/guitool.txt[]
 
 include::config/help.txt[]
 
+include::config/hook.txt[]
+
 include::config/http.txt[]
 
 include::config/i18n.txt[]
diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
new file mode 100644
index 00000000000..96d3d6572c1
--- /dev/null
+++ b/Documentation/config/hook.txt
@@ -0,0 +1,4 @@
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to the number of processors on
+	the current system.
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index fa68c1f3912..79e82479ec6 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,8 @@ git-hook - run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
+'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
 
 DESCRIPTION
 -----------
@@ -42,6 +43,20 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
 
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specified,
+uses the value of the `hook.jobs` config, see linkgit:git-config[1]. If the
+config is not specified, uses the number of CPUs on the current system. Some
+hooks may be ineligible for parallelization: for example, 'commit-msg' intends
+hooks modify the commit message body and cannot be parallelized.
+
+CONFIGURATION
+-------------
+include::config/hook.txt[]
+
 SEE ALSO
 --------
 linkgit:githooks[5]
diff --git a/builtin/am.c b/builtin/am.c
index 9e3d4d9ab44..c7ffc7eafc5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -446,7 +446,7 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 
 	assert(state->msg);
 	strvec_push(&opt.args, am_path(state, "final-commit"));
@@ -467,7 +467,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin = am_path(state, "rewritten");
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 863b02a7d7c..6b99d31c6ba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -107,7 +107,7 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
diff --git a/builtin/clone.c b/builtin/clone.c
index 27fc05ee511..986c3b1932a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -776,7 +776,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_SERIAL;
 
 	if (option_no_checkout)
 		return 0;
diff --git a/builtin/hook.c b/builtin/hook.c
index 398980523aa..9b6272cfd3b 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -22,7 +22,7 @@ static const char * const builtin_hook_run_usage[] = {
 static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 	int ignore_missing = 0;
 	const char *hook_name;
 	struct list_head *hooks;
@@ -31,6 +31,8 @@ static int run(int argc, const char **argv, const char *prefix)
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_INTEGER('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index f215f264cc8..c01eb535d6b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,7 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ee68a1df492..a4bbb9abb35 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1314,7 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ebec6f3bb10..7460124b743 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -909,7 +909,7 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct receive_hook_feed_context ctx;
 	struct command *iter = commands;
 
@@ -948,7 +948,7 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
@@ -1432,7 +1432,8 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
+
 	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
@@ -1628,7 +1629,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 330867c19bf..30905067906 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,7 +382,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
diff --git a/commit.c b/commit.c
index 842e47beae2..a38bd047524 100644
--- a/commit.c
+++ b/commit.c
@@ -1700,7 +1700,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook,
 		    const char *name, ...)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 	va_list args;
 	const char *arg;
 
diff --git a/hook.c b/hook.c
index 2b2c16a9095..600030c59ec 100644
--- a/hook.c
+++ b/hook.c
@@ -208,6 +208,28 @@ static int notify_hook_finished(int result,
 	return 0;
 }
 
+/*
+ * Determines how many jobs to use after we know we want to parallelize. First
+ * priority is the config 'hook.jobs' and second priority is the number of CPUs.
+ */
+static int configured_hook_jobs(void)
+{
+	/*
+	 * The config and the CPU count probably won't change during the process
+	 * lifetime, so cache the result in case we invoke multiple hooks during
+	 * one process.
+	 */
+	static int jobs = 0;
+	if (jobs)
+		return jobs;
+
+	if (git_config_get_int("hook.jobs", &jobs))
+		/* if the config isn't set, fall back to CPU count. */
+		jobs = online_cpus();
+
+	return jobs;
+}
+
 int run_hooks(const char *hook_name, struct list_head *hooks,
 	      struct run_hooks_opt *options)
 {
@@ -217,7 +239,6 @@ int run_hooks(const char *hook_name, struct list_head *hooks,
 		.options = options,
 		.invoked_hook = options->invoked_hook,
 	};
-	int jobs = 1;
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -225,7 +246,11 @@ int run_hooks(const char *hook_name, struct list_head *hooks,
 	cb_data.head = hooks;
 	cb_data.run_me = list_first_entry(hooks, struct hook, list);
 
-	run_processes_parallel_tr2(jobs,
+	/* INIT_PARALLEL sets jobs to 0, so go look up how many to use. */
+	if (!options->jobs)
+		options->jobs = configured_hook_jobs();
+
+	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
@@ -244,7 +269,11 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 {
 	struct list_head *hooks;
 	int ret = 0;
-	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
+	/*
+	 * Turn on parallelism by default. Hooks which don't want it should
+	 * specify their options accordingly.
+	 */
+	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	if (!options)
 		options = &hook_opt_scratch;
diff --git a/hook.h b/hook.h
index 49b4c335f86..fe16ab35028 100644
--- a/hook.h
+++ b/hook.h
@@ -25,6 +25,13 @@ struct run_hooks_opt
 	/* Args to be passed to each hook */
 	struct strvec args;
 
+	/*
+	 * Number of threads to parallelize across. Set to 0 to use the
+	 * 'hook.jobs' config or, if that config is unset, the number of cores
+	 * on the system.
+	 */
+	int jobs;
+
 	/*
 	 * Resolve and run the "absolute_path(hook)" instead of
 	 * "hook". Used for "git worktree" hooks
@@ -68,7 +75,14 @@ struct run_hooks_opt
 	int *invoked_hook;
 };
 
-#define RUN_HOOKS_OPT_INIT { \
+#define RUN_HOOKS_OPT_INIT_SERIAL { \
+	.jobs = 1, \
+	.env = STRVEC_INIT, \
+	.args = STRVEC_INIT, \
+}
+
+#define RUN_HOOKS_OPT_INIT_PARALLEL { \
+	.jobs = 0, \
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
 }
diff --git a/read-cache.c b/read-cache.c
index 875f6c1dea5..98e9fb8b04e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3069,7 +3069,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	ret = convert_to_sparse(istate);
 
diff --git a/refs.c b/refs.c
index 73d4a939267..5543b8cdaba 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,7 +2062,7 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
 	int ret = 0, i;
 
diff --git a/reset.c b/reset.c
index 1237ced8a58..63a9c513409 100644
--- a/reset.c
+++ b/reset.c
@@ -127,7 +127,8 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
+
 		strvec_pushl(&opt.args,
 			     oid_to_hex(orig ? orig : null_oid()),
 			     oid_to_hex(oid),
diff --git a/sequencer.c b/sequencer.c
index db8044ab47d..979cd01c303 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1148,7 +1148,7 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct strbuf tmp = STRBUF_INIT;
 	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int code;
@@ -4522,7 +4522,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process notes_cp = CHILD_PROCESS_INIT;
-			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			notes_cp.git_cmd = 1;
diff --git a/transport.c b/transport.c
index 4ca8fc0391d..33da71a108b 100644
--- a/transport.c
+++ b/transport.c
@@ -1204,7 +1204,7 @@ static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
 	int ret = 0;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct ref *r;
 	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
 
-- 
2.33.0.867.g88ec4638586

