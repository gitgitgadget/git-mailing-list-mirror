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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D6EC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B402B61057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFQK0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhFQKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2041C0611C0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l1so8998002ejb.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mN56wNKC0YYPqfoGbyBU2Gj4SFbIHRwVr17bU+eBLUo=;
        b=VFWGdYo47A5nsIqm2jo6tssbWVzlPioYSQAGEyFbmIrBUsaFdSZfGYIDoj03yQZFt4
         deQYMWMjnSTg9cFW5FGBMZ0qa6xqpdMcRLXXjAa+KTv1VVZr/4ztCSHI1Tv17hbqSeeg
         2y2Vf9v5Zl1hWIChKRlF5hbAYOmMBIjRICAoE0K0CVPkpqPd66pWpEv+F98NWQa7h8Pe
         XyOVLMKIpqPB4NW2dc2ZjxYRqmsOOna9+Rh8nc+6k+tFgWSZdm3k9irwen6bfxgnb0V4
         klGljloJTS2w5QqVp14gneqAVGDkEJ0AAmFfiCShNnl3Fk+XTnPLG69uOGepbWLxpq6B
         SMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN56wNKC0YYPqfoGbyBU2Gj4SFbIHRwVr17bU+eBLUo=;
        b=RV3fjLrPloZTHp3OKF82P0nNHD9JDaRqB6kaRmYTE5VvIah67kZ6G5XVAqtzdZqaJZ
         A5NUqyjVSdTF/NiVuXWZ2b88pTaWFgaQ+4FZeWGynpJ4E7pdRAleLKl/if2QxuZCottn
         Db96Zha0Jl466zgCgtPROPDA1JajKWqMJzyEpIWrlJTX0O3VZWU5is9kjnv0KfApMM5i
         ctPV6tqSkQ1IjzSismyXwrS+nElbnHUJuOrWPzdxwg1YzgtStUD/9YnmIE3d2zCt5TiX
         NAsslRiUpLZ9iYDPL/mSIHXHQiJJK2U1dCNVJ3vncsVufhFM7ihIrd6FrCh+P5F5U6oj
         CZtQ==
X-Gm-Message-State: AOAM531m3ha5XuwAVwQFtbBLg47ratBtwoOsgn1b/EqV2lo90c9HnkSu
        sh35an1RT/Ef9TVtlLrfLT4+7qN/+yhk/g==
X-Google-Smtp-Source: ABdhPJxd/9YhES6sTuAvW4AzS2maroZvfwVkAbkUJk/PoRtS4vpsODyKK2iMS79Q8EoE6msuIXjCXQ==
X-Received: by 2002:a17:906:9713:: with SMTP id k19mr4508970ejx.516.1623925404046;
        Thu, 17 Jun 2021 03:23:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:23 -0700 (PDT)
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
Subject: [PATCH 18/27] hook: provide stdin by string_list or callback
Date:   Thu, 17 Jun 2021 12:22:52 +0200
Message-Id: <patch-18.27-da46c859c1-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
 hook.c | 32 +++++++++++++++++++++++++++++++-
 hook.h | 27 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index a012c3d458..c4df787f13 100644
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
@@ -90,6 +113,10 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -164,7 +191,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
@@ -182,6 +209,9 @@ int run_hooks(const char *hook_name, struct run_hooks_opt *options)
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
 	hook_path = find_hook(hook_name);
 
 	/*
diff --git a/hook.h b/hook.h
index c4ac054ee3..b78a8e4805 100644
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
@@ -47,6 +53,19 @@ struct run_hooks_opt
 
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
@@ -55,6 +74,14 @@ struct run_hooks_opt
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
 struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
-- 
2.32.0.576.g59759b6ca7d

