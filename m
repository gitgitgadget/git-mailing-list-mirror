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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D91C2BB3F
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E266122E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgLEBvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgLEBvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C3C08E9AA
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:20 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w135so1087977pff.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0NUjdothNmnFTQszroPBkq+yi75nXjc+7SeH/Ejj9Yw=;
        b=DMsB8/lzpShToxMIdM0aHK3xC4WPdIx1pgl8vy+auxjoVcc6OsF+JMsWEdbahm+ZZM
         yEqAtYDky07gHnAU8G3kTf0QzGySciYlQfEBeP2DvoLgvQGp1h6jMFJQBYQ+dSE1ZM1v
         h1vDnBezLMBjVXSb2XIla0pJbIH0C3Ctj+Sx7skZiqEtdYyZLse5WvUKA/Cl8E1UbMqn
         /rYelRKN7erwJRo4Wn8+2NRs416zRr5NJ4o+2vHjRZ4uNOTw7hiCE60SBpda4ntBEKJe
         +rb/MSZ9IQpgGboAKDcUL7DiZQ3pu1y3fiRhfsqLvWsf9GPvd65SfmAeg05XA5A4JjWR
         L6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0NUjdothNmnFTQszroPBkq+yi75nXjc+7SeH/Ejj9Yw=;
        b=NGbnzqtpFCs0Mii4JxySJOXy2vMKp/XvUroWOb53GafzEo1/fezXGhFwlllBCRpuFA
         wY43AGWq9tvUYq2XJh8deiofeuWacsJ8mVCpmue95JGrbo+mWXRaqVNqlOu4D9dRpFiS
         Uih1LwsBoOfo0ru/kI8sggZUztcbQ8+lw4aoHUK9HxlbACdOTcq/07sRivGeT8g0NmPQ
         rLS/XVjtE2aULznLtQt0U0QNUYXv8bJ24yEkOw+p554hFdb/dcGx/Eq3EMiGGHXj5Tek
         jP1jVlU1tHSiuYKv0xexARZM0pZWIuqPsj1hiI0zFSjJifxY/0QWVlIgCOT1WXKNIJcn
         1g3w==
X-Gm-Message-State: AOAM532l7Lv0nt6K+r+Nr0mbEEHrBoBByi7N6HtgPTziPxKs+8wwZ9Bp
        U7L2h4IhYH0cts5hY5ylpT6KxTulC55bOFgQv3AoW4vbn3FZVgofFD6Xcu1qARUpnSZfnSOCLId
        fGnZPySUCbwsiEKo833u3lX848byEI6GayoWCBXUgjR0z8e6lDJQ62SJsEtCr6Fl5G/YosLXMUQ
        ==
X-Google-Smtp-Source: ABdhPJyrU1/MSrPbO+WbBTf/Ve3/Ntw4AuWjI1c9qshWpVZYtazBaJkNGpLtSJMSAGwOLxOVIRnOF939TCPcP5UWijk=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:578a:: with SMTP id
 g10mr6626665pji.197.1607133020200; Fri, 04 Dec 2020 17:50:20 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:44 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-17-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 16/17] receive-pack: convert receive hooks to hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the hook.h library to run receive hooks, they can be specified
in the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |   4 +
 builtin/receive-pack.c     | 197 +++++++++++++++++--------------------
 2 files changed, 94 insertions(+), 107 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1412cd5846..c450f7a27e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -314,6 +314,8 @@ will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 See the section on "Quarantine Environment" in
 linkgit:git-receive-pack[1] for some caveats.
 
+Hooks executed during 'pre-receive' will not be parallelized.
+
 [[update]]
 update
 ~~~~~~
@@ -466,6 +468,8 @@ environment variables will not be set. If the client selects
 to use push options, but doesn't transmit any, the count variable
 will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 
+Hooks executed during 'post-receive' are run in parallel by default.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 66af00fd8c..c30c8e3a55 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -740,7 +740,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static void prepare_push_cert_sha1(struct run_hooks_opt *opt)
 {
 	static int already_done;
 
@@ -764,110 +764,42 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT=%s",
 			     oid_to_hex(&push_cert_oid));
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_SIGNER=%s",
 			     sigcheck.signer ? sigcheck.signer : "");
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_KEY=%s",
 			     sigcheck.key ? sigcheck.key : "");
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_STATUS=%c",
 			     sigcheck.result);
 		if (push_cert_nonce) {
-			strvec_pushf(&proc->env_array,
+			strvec_pushf(&opt->env,
 				     "GIT_PUSH_CERT_NONCE=%s",
 				     push_cert_nonce);
-			strvec_pushf(&proc->env_array,
+			strvec_pushf(&opt->env,
 				     "GIT_PUSH_CERT_NONCE_STATUS=%s",
 				     nonce_status);
 			if (nonce_status == NONCE_SLOP)
-				strvec_pushf(&proc->env_array,
+				strvec_pushf(&opt->env,
 					     "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 					     nonce_stamp_slop);
 		}
 	}
 }
 
+struct receive_hook_feed_context {
+	struct command *cmd;
+	int skip_broken;
+};
+
 struct receive_hook_feed_state {
 	struct command *cmd;
 	struct ref_push_report *report;
 	int skip_broken;
 	struct strbuf buf;
-	const struct string_list *push_options;
 };
 
-typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed,
-			     struct receive_hook_feed_state *feed_state)
-{
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct async muxer;
-	const char *argv[2];
-	int code;
-
-	argv[0] = find_hook(hook_name);
-	if (!argv[0])
-		return 0;
-
-	argv[1] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = hook_name;
-
-	if (feed_state->push_options) {
-		int i;
-		for (i = 0; i < feed_state->push_options->nr; i++)
-			strvec_pushf(&proc.env_array,
-				     "GIT_PUSH_OPTION_%d=%s", i,
-				     feed_state->push_options->items[i].string);
-		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
-			     feed_state->push_options->nr);
-	} else
-		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
-
-	if (tmp_objdir)
-		strvec_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
-
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc = copy_to_sideband;
-		muxer.in = -1;
-		code = start_async(&muxer);
-		if (code)
-			return code;
-		proc.err = muxer.in;
-	}
-
-	prepare_push_cert_sha1(&proc);
-
-	code = start_command(&proc);
-	if (code) {
-		if (use_sideband)
-			finish_async(&muxer);
-		return code;
-	}
-
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	while (1) {
-		const char *buf;
-		size_t n;
-		if (feed(feed_state, &buf, &n))
-			break;
-		if (write_in_full(proc.in, buf, n) < 0)
-			break;
-	}
-	close(proc.in);
-	if (use_sideband)
-		finish_async(&muxer);
-
-	sigchain_pop(SIGPIPE);
-
-	return finish_command(&proc);
-}
-
-static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
+static int feed_receive_hook(void *state_)
 {
 	struct receive_hook_feed_state *state = state_;
 	struct command *cmd = state->cmd;
@@ -876,9 +808,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
 		cmd = cmd->next;
 	if (!cmd)
-		return -1; /* EOF */
-	if (!bufp)
-		return 0; /* OK, can feed something. */
+		return 1; /* EOF - close the pipe*/
 	strbuf_reset(&state->buf);
 	if (!state->report)
 		state->report = cmd->report;
@@ -902,32 +832,36 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 			    cmd->ref_name);
 		state->cmd = cmd->next;
 	}
-	if (bufp) {
-		*bufp = state->buf.buf;
-		*sizep = state->buf.len;
-	}
 	return 0;
 }
 
-static int run_receive_hook(struct command *commands,
-			    const char *hook_name,
-			    int skip_broken,
-			    const struct string_list *push_options)
+static int feed_receive_hook_cb(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
 {
-	struct receive_hook_feed_state state;
-	int status;
-
-	strbuf_init(&state.buf, 0);
-	state.cmd = commands;
-	state.skip_broken = skip_broken;
-	state.report = NULL;
-	if (feed_receive_hook(&state, NULL, NULL))
-		return 0;
-	state.cmd = commands;
-	state.push_options = push_options;
-	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
-	strbuf_release(&state.buf);
-	return status;
+	struct hook *hook = pp_task_cb;
+	struct receive_hook_feed_state *feed_state = hook->feed_pipe_cb_data;
+	int rc;
+
+	/* first-time setup */
+	if (!feed_state) {
+		struct hook_cb_data *hook_cb = pp_cb;
+		struct run_hooks_opt *opt = hook_cb->options;
+		struct receive_hook_feed_context *ctx = opt->feed_pipe_ctx;
+		if (!ctx)
+			BUG("run_hooks_opt.feed_pipe_ctx required for receive hook");
+
+		feed_state = xmalloc(sizeof(struct receive_hook_feed_state));
+		strbuf_init(&feed_state->buf, 0);
+		feed_state->cmd = ctx->cmd;
+		feed_state->skip_broken = ctx->skip_broken;
+		feed_state->report = NULL;
+
+		hook->feed_pipe_cb_data = feed_state;
+	}
+
+	rc = feed_receive_hook(feed_state);
+	if (!rc)
+		strbuf_addbuf(pipe, &feed_state->buf);
+	return rc;
 }
 
 static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
@@ -963,6 +897,55 @@ static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
 	send_sideband(1, 2, output->buf, output->len, use_sideband);
 }
 
+static int run_receive_hook(struct command *commands,
+			    const char *hook_name,
+			    int skip_broken,
+			    const struct string_list *push_options)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	struct receive_hook_feed_context ctx;
+	int rc;
+	struct command *iter = commands;
+
+	/* if there are no valid commands, don't invoke the hook at all. */
+	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
+		iter = iter->next;
+	if (!iter)
+		return 0;
+
+	/* pre-receive hooks should run in series as the hook updates refs */
+	if (!strcmp(hook_name, "pre-receive"))
+		opt.jobs = 1;
+
+	if (push_options) {
+		int i;
+		for (i = 0; i < push_options->nr; i++)
+			strvec_pushf(&opt.env, "GIT_PUSH_OPTION_%d=%s", i,
+				     push_options->items[i].string);
+		strvec_pushf(&opt.env, "GIT_PUSH_OPTION_COUNT=%d", push_options->nr);
+	} else
+		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
+
+	if (tmp_objdir)
+		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
+
+	prepare_push_cert_sha1(&opt);
+
+	/* set up sideband printer */
+	if (use_sideband)
+		opt.consume_sideband = hook_output_to_sideband;
+
+	/* set up stdin callback */
+	ctx.cmd = commands;
+	ctx.skip_broken = skip_broken;
+	opt.feed_pipe = feed_receive_hook_cb;
+	opt.feed_pipe_ctx = &ctx;
+
+	rc = run_hooks(hook_name, &opt);
+	run_hooks_opt_clear(&opt);
+	return rc;
+}
+
 static int run_update_hook(struct command *cmd)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
-- 
2.28.0.rc0.142.g3c755180ce-goog

