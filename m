Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E32C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83BA61037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhHCTkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbhHCTkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:40:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67696C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h14so26470173wrx.10
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AK5kx12g+auXj6+2QwqqEtxeKo9cA5xEdlPXGaf/TQw=;
        b=emtpXKcQcf3wLxTjtOqm+MDwpulLf032uIb24nrviGsMDYTqcDM9iyW5K62H0Twz/q
         8Cf79cz6OtaEj+F7n4iriGodCpCK1ppyk3Y/neeVbVNp0mpVHNRBuY/4qPKgjRKx3eE7
         NQe/FeGa71F9ZznOipyozd+jvfOjTeenaWGGtKvgyplL8aDS/bYeaVFszkCrU5RkCmVK
         GNsHr4NbA2xFJBQ3nwAjq2kJBhD9QKMnwF9feOVR1+nlhCPTqmMG91f49ar8wMfmQGXs
         9tcxitMq++GB3xlHeKHxm00pp2vGKC0O6rpKeHBt5IIhb9WRbBFwpX29HJaBl/DSj14V
         l4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AK5kx12g+auXj6+2QwqqEtxeKo9cA5xEdlPXGaf/TQw=;
        b=Rqdu5ZqCoWwyzXPC0CFn4jSkHjWOTsfp/JoDL4hyhV1Hr17d0BltQkN6wNYh9GfoyW
         XnSqEoX9XEo4YewF5n0fTs7ydYORbmHH0S8K3Ihkezd2d/iWKeS8ZSX8UgEb7VyB1S4f
         m+HGqFPCD75GRzB1huj2AppIMstXepVDK3IM0Ouvq8m7JHBOpAS1mZJ32wZIc/lHeBgv
         k1goxvgM4PTf9/kr4+xlMsEH0BnMFRnQxWadXK6Aes6s4K4cwteg+TVmYhFn4v6PCTfY
         KHL93ZIfviYmzT7AR9jrykQiOAnLwnXtuydDp3mr4ed9Td5tNFg1AWxvuhFsE11W4EyJ
         JlnQ==
X-Gm-Message-State: AOAM532K37YlghHd1bKoLbk65A1eFpSh4UihbMEto6AivuUW0smpIbFd
        fyiWH89L2M7jlvX1mLgCqK7ixRPuBrS6AQ==
X-Google-Smtp-Source: ABdhPJx6D4QyOYl0rK0gNb3jArNU3TnNNlLp2IIkVR6+oznAUhwIoNJf7gFcKihaIHgcSA3tlF1fFA==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr24693187wrr.224.1628019583715;
        Tue, 03 Aug 2021 12:39:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 35/36] receive-pack: convert receive hooks to hook.h
Date:   Tue,  3 Aug 2021 21:39:01 +0200
Message-Id: <patch-v4-35.36-ceef2f3e804-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 190 ++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 107 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 26e302aab85..c3984680d7f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -747,7 +747,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static void prepare_push_cert_sha1(struct run_hooks_opt *opt)
 {
 	static int already_done;
 
@@ -771,110 +771,42 @@ static void prepare_push_cert_sha1(struct child_process *proc)
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
@@ -883,9 +815,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
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
@@ -909,32 +839,36 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
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
@@ -970,6 +904,48 @@ static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
 	send_sideband(1, 2, output->buf, output->len, use_sideband);
 }
 
+static int run_receive_hook(struct command *commands,
+			    const char *hook_name,
+			    int skip_broken,
+			    const struct string_list *push_options)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct receive_hook_feed_context ctx;
+	struct command *iter = commands;
+
+	/* if there are no valid commands, don't invoke the hook at all. */
+	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
+		iter = iter->next;
+	if (!iter)
+		return 0;
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
+	return run_hooks_oneshot(hook_name, &opt);
+}
+
 static int run_update_hook(struct command *cmd)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-- 
2.33.0.rc0.595.ge31e012651d

