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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF42C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C684260BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhHCTkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbhHCTj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C1C061386
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso2429106wms.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZJAedodHOCyKHn5EqcPNmDKaEqty1UOdjR3RcX4RA8=;
        b=aXSRiyCyBLjouLGUXLkePWXQxlarD4LQDqj4BWcCXiXg5ImYcoJr1a6n1F2cV4Zxmx
         D8qS/sBRSZ8+uCj5H+xScbgMNumbdk6SX/EXodRaW57cshCJOoLQapoxFKFQstTaVIzt
         Kd0GLwO28DsYd/BsRdX9KQ+wv6Pu+BuKpSkC5RWIWHvvgF4+X0gn/IKTBLtP3PtaX2YH
         lpFHM9RsMgHCOsj7iSQJM/7sY4heKVBZOEhmD2RMnEIGqPPoAOs+rioLtWkB35PaVpu9
         K9d6dfrn5d08T6Bo6O9m6lGyecDOQnKQrQ7irAmUd6VtBoTD7VlZy79BuA2tvUVgHQuF
         EElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZJAedodHOCyKHn5EqcPNmDKaEqty1UOdjR3RcX4RA8=;
        b=VRimNfVYoQQkXii5GRxtfKCzpe5BjmBZTXmgj3vUO+VeTOs+uskPwVIkBR5XFKn1Po
         SCdMrxmO6SYN5VJR3NHRW3si4zhl4dS9h53wHbty6rVifr116OrzpohQeThs1aHLumhT
         1oNFc81POnOBJRIVw9X0a3+FR09RjuhaK2uolVA2FbU0hu0PX3u72AqHPogU/HLBZ/wy
         0HwYQ5nyYA0Jqi7RL1NGDFk9C2cYcvNVT+M8y0P7zb1wIRZO/IT+3wp5lNcgSHS+iUat
         mxmQw3LdG5Mqo04364Fu3dnUyRS8JR1kRNpnK5V8ch9jfHq42gQUBuIFq1tkwKEZR3Lg
         j9rQ==
X-Gm-Message-State: AOAM531tifuLbmwCpN39B8BzIgylGsM1IXKoLWPZgsolj2l1szES40K2
        VazHwggKgqGclIBIqffgaW/TSA86yjZ3Hg==
X-Google-Smtp-Source: ABdhPJwEWSqQ+feGUm+bj2zyro2qphmuULLCXcgHeb+m6vEKReAZl9I6bWD8GS2wHFuydHvuUVhyfw==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr6189209wmb.12.1628019574763;
        Tue, 03 Aug 2021 12:39:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:34 -0700 (PDT)
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
Subject: [PATCH v4 25/36] hook: provide stdin by string_list or callback
Date:   Tue,  3 Aug 2021 21:38:51 +0200
Message-Id: <patch-v4-25.36-05d1085f7eb-20210803T191505Z-avarab@gmail.com>
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

In cases where a hook requires only a small amount of information via
stdin, it should be simple for users to provide a string_list alone. But
in more complicated cases where the stdin is too large to hold in
memory, let's instead provide a callback the users can populate line
after line.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 33 ++++++++++++++++++++++++++++++++-
 hook.h | 27 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index a7462639d97..44e73827800 100644
--- a/hook.c
+++ b/hook.c
@@ -77,6 +77,29 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
 	strvec_clear(&o->args);
 }
 
+int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
+{
+	int *item_idx;
+	struct hook *ctx = pp_task_cb;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct string_list *to_pipe = hook_cb->options->feed_pipe_ctx;
+
+	/* Bootstrap the state manager if necessary. */
+	if (!ctx->feed_pipe_cb_data) {
+		ctx->feed_pipe_cb_data = xmalloc(sizeof(unsigned int));
+		*(int*)ctx->feed_pipe_cb_data = 0;
+	}
+
+	item_idx = ctx->feed_pipe_cb_data;
+
+	if (*item_idx < to_pipe->nr) {
+		strbuf_addf(pipe, "%s\n", to_pipe->items[*item_idx].string);
+		(*item_idx)++;
+		return 0;
+	}
+	return 1;
+}
+
 static int pick_next_hook(struct child_process *cp,
 			  struct strbuf *out,
 			  void *pp_cb,
@@ -92,6 +115,10 @@ static int pick_next_hook(struct child_process *cp,
 	if (hook_cb->options->path_to_stdin) {
 		cp->no_stdin = 0;
 		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else if (hook_cb->options->feed_pipe) {
+		/* ask for start_command() to make a pipe for us */
+		cp->in = -1;
+		cp->no_stdin = 0;
 	} else {
 		cp->no_stdin = 1;
 	}
@@ -175,7 +202,7 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
@@ -183,6 +210,7 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
 	if (options->absolute_path)
 		strbuf_release(&abs_path);
+	free(my_hook.feed_pipe_cb_data);
 
 	return cb_data.rc;
 }
@@ -196,6 +224,9 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 	if (!options)
 		options = &hook_opt_scratch;
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
 	hook_path = find_hook(hook_name);
 	if (!hook_path) {
 		ret = 0;
diff --git a/hook.h b/hook.h
index cd6a68a3b50..b55f283f90b 100644
--- a/hook.h
+++ b/hook.h
@@ -19,6 +19,12 @@ int hook_exists(const char *hookname);
 struct hook {
 	/* The path to the hook */
 	const char *hook_path;
+
+	/*
+	 * Use this to keep state for your feed_pipe_fn if you are using
+	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 struct run_hooks_opt
@@ -39,6 +45,19 @@ struct run_hooks_opt
 
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
+
+	/*
+	 * Callback and state pointer to ask for more content to pipe to stdin.
+	 * Will be called repeatedly, for each hook. See
+	 * hook.c:pipe_from_stdin() for an example. Keep per-hook state in
+	 * hook.feed_pipe_cb_data (per process). Keep initialization context in
+	 * feed_pipe_ctx (shared by all processes).
+	 *
+	 * See 'pipe_from_string_list()' for info about how to specify a
+	 * string_list as the stdin input instead of writing your own handler.
+	 */
+	feed_pipe_fn feed_pipe;
+	void *feed_pipe_ctx;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
@@ -46,6 +65,14 @@ struct run_hooks_opt
 	.args = STRVEC_INIT, \
 }
 
+/*
+ * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
+ * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
+ * This will pipe each string in the list to stdin, separated by newlines.  (Do
+ * not inject your own newlines.)
+ */
+int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
+
 /*
  * Callback provided to feed_pipe_fn and consume_sideband_fn.
  */
-- 
2.33.0.rc0.595.ge31e012651d

