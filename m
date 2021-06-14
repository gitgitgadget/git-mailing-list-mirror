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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC9C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A271B6147E
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhFNKlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:41:18 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:43583 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhFNKhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:12 -0400
Received: by mail-wm1-f47.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso12483453wmj.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Ro5rHts4hw/ry0Xv8bJ+87ugrvD9L7WktYG6axhJ2w=;
        b=ESKy6OD7iimKgq7cG0pvu6Kz/asIldXcPXt8WUhvnGGr6ZCmPfmU1xn78vQl9xQtaS
         XW0977h+burrd2ZYytg+HcDcbeCYaoVTPfm892weTKiocy9lYLuV4MpQx9Ip17oxgLWL
         eba/5yLeWKLkKkGSxrci5gl9tME9ZhSGnVx8yiHeto5g/ndCYJJVEBjxPMe4z375X8VC
         AXfZjTFo6Uftnn0Uit7t739T6+7DldPN0oxYYWBApCimUHeqIH7klM4MObe2p0pjDbAY
         ZVQDEP5ZtyykovV3HhFTNEkuFbtavl3LNws9RG76leARMwjMfk5W+z1h7xSPwsT01QAO
         I/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Ro5rHts4hw/ry0Xv8bJ+87ugrvD9L7WktYG6axhJ2w=;
        b=Nv6bsbTJQXhzHTC5FuOIuY81dZAWxure1Tyqau0K/E6GSXZvqRPBsq5cJQlJ4ZWU/Z
         BgM0EQNDTVGmfuJ7EybvA3/QUEAkvif2J+0JrKTyrIWgNX/InWn2bl94DhvecfYrTeji
         jPDE6L/L6T7cLUyZRVW0DIgIolcI04rajbiroS8RM5UIx5kZBl6UMCqpXRrq6gDFa24W
         7Ui4WYjHPW+JgNCR5fTmxN5cYcTEWx9TCg8a0Hnrq7veQvdX3Tn6HlEnkZTjdFGBwKjq
         mW7PUjWBB/O90+VyVGRSU4bdUF1WiVAzUxxK8oOdR1ITR7mkBKPZIMsESb4Mzdvz6t9v
         KZpA==
X-Gm-Message-State: AOAM533v3UEi8nMc0xy7Y3z4j8fdB1+eeeMRk0PmPwxshD1cZ5XJbcBT
        PEwlocQNG9vxSj9xiUwVxGIO8Rf7UtFoWg==
X-Google-Smtp-Source: ABdhPJz/SxTRdAznFSSYmtmiGA5ADv4DAVkhlsP0z1zhGvc7s+Mxhx/OeHZn2kjBo2uKTJ6cOUKADw==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr15839744wmb.113.1623666848689;
        Mon, 14 Jun 2021 03:34:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:08 -0700 (PDT)
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
Subject: [PATCH v2 28/30] receive-pack: convert receive hooks to hook.h
Date:   Mon, 14 Jun 2021 12:33:17 +0200
Message-Id: <patch-28.30-bb9d57f809a-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
 builtin/receive-pack.c | 197 +++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 107 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b2ccdb66daa..ec90e10477a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -748,7 +748,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static void prepare_push_cert_sha1(struct run_hooks_opt *opt)
 {
 	static int already_done;
 
@@ -772,110 +772,42 @@ static void prepare_push_cert_sha1(struct child_process *proc)
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
@@ -884,9 +816,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
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
@@ -910,32 +840,36 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
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
@@ -971,6 +905,55 @@ static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
 	send_sideband(1, 2, output->buf, output->len, use_sideband);
 }
 
+static int run_receive_hook(struct command *commands,
+			    const char *hook_name,
+			    int skip_broken,
+			    const struct string_list *push_options)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
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
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-- 
2.32.0.rc3.434.gd8aed1f08a7

