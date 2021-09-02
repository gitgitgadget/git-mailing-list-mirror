Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590BC4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC536108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbhIBNNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbhIBNNn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29297C0611C1
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so1358316wmq.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWG5vXKfLP8KTYdKLFxVfjCBoaVIl1IIARXbcD3D/Tc=;
        b=HDc8Cb7HqX913ki9N4Gnztk819FeeIoqmGLTy3cn1XtbxEiPNqms9Gzk4U74x504L8
         rhzqgstd6h1Y1lG/q1JacI46NBtwpFkmsN/CPxXlvfZkf2qeLrdQLuq0KuYdehOTFmiF
         yPzRu+dF3dGBxViORq6r8k08reLI6VKHeFv0bVj6aUpDQHWNVgXOHYKEfPk+749Ses7J
         zcv8z8N13UplhjnecLHl37Kp+jIzEfyxgx+zKUmmrOT0GZJL9cDvz8oNjyhY4r2pa39t
         RPl5zpvxXxfQK+Dlc/A26b618ysgcvcju6CH/ysQTc55p/5MvjlWrMZBzYi9qOf5+8ns
         VDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWG5vXKfLP8KTYdKLFxVfjCBoaVIl1IIARXbcD3D/Tc=;
        b=n62erbz9VFSBQz21dmUXLBYwXM0K6Zltabo9l+okbn4ef42CcULM8SF8ggWfUQ9zxM
         YJJKZt9zDt8V5i3GMvKacytiPZkAC5ozkV4hse/dLlxV7hWWqKE3LunqGvr1/ofk885d
         /Q1E3yLJ0JczD8h7ZbnPvEYy94P7ZrvJgkuTzdAW1syyn3d7hTow/4wzj1q1jXbBSEic
         bzd/NWk9WUjo30V0Ssj1OsGcIEQhofo0IFU7arSdve1RgYtacxRT/fVAyh379gUd1krP
         BqI6XHmoWtmKsKwcEac8F6C1r7Ugq45rvCL/SDbAuLsEb1iDmyX/PtE+z5kZy/bVQiq/
         mogQ==
X-Gm-Message-State: AOAM532u0FsccI5KEezmqVHyOVe0NNC3hJbQGoAfccn6W7N1BycThafm
        7HwAs8cAstwRmEhAF5O6BviMJ84/Wyaq+w==
X-Google-Smtp-Source: ABdhPJwDxYhlbF/G1elJPoyiiJPWICw1TR9PpSv9wpHRwPQVoQD+o72I59jmggAgk7sGaIJjD11x4A==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr3030540wmk.172.1630588330467;
        Thu, 02 Sep 2021 06:12:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:09 -0700 (PDT)
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
Subject: [PATCH v5 25/36] hook: provide stdin by string_list or callback
Date:   Thu,  2 Sep 2021 15:11:25 +0200
Message-Id: <patch-v5-25.36-2439f7752b8-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 hook.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 45983d08aed..7a6ef527443 100644
--- a/hook.c
+++ b/hook.c
@@ -48,6 +48,29 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
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
@@ -63,6 +86,10 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -146,7 +173,7 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
@@ -154,6 +181,7 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
 	if (options->absolute_path)
 		strbuf_release(&abs_path);
+	free(my_hook.feed_pipe_cb_data);
 
 	return cb_data.rc;
 }
@@ -167,6 +195,9 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 	if (!options)
 		options = &hook_opt_scratch;
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
 	hook_path = find_hook(hook_name);
 	if (!hook_path) {
 		ret = 0;
diff --git a/hook.h b/hook.h
index 253725e197b..4e26b8d658d 100644
--- a/hook.h
+++ b/hook.h
@@ -1,10 +1,18 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "strbuf.h"
 #include "strvec.h"
+#include "run-command.h"
 
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
@@ -26,6 +34,19 @@ struct run_hooks_opt
 
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
@@ -77,4 +98,12 @@ int run_hooks(const char *hookname, const char *hook_path,
  */
 int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
 
+/**
+ * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
+ * string_list and set 'run_hooks_opt.feed_pipe' to pipe_from_string_list().
+ * This will pipe each string in the list to stdin, separated by newlines.  (Do
+ * not inject your own newlines.)
+ */
+int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
+
 #endif
-- 
2.33.0.816.g1ba32acadee

