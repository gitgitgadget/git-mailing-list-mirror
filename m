Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384CFC43331
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DD022B3B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgLVAGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgLVAGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:04 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9DC0611CC
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:01 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id kb15so298597pjb.4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cffkahU1lSzSwVG5AbrWY7gx1XvLJa7VTE+r84Lr7GM=;
        b=RJY18XhodH+l3Gn6k/48vqJIt8c/xhQdogZKJh0NiK6IEsHmGrsLwVgddVPoYdBkhh
         6HFEZ0eBo9pgwrVZfzdeH8TT4npbZFam/l+unXR36IzDDyZ7tVwVRNMlhpA8k69ahh7m
         1HyvQ+L4KKykCDscmE7RmyXohB9Pu++tE6tmHmfbCNcANeHkPdcZV0CqFV+jM+Kvuuvp
         M1HSBblQQXgm7FxYdEakd6fLp1HPmp4m4YwM7fIpl/lxbqWJ7P0kZzZD0nwIB0SDJrk2
         U01a5OTnOMOOQ76zzDvKwthjFcvGrPYLCLFefkCG0D3pcCV08zGl/Y+s3Xhy5f1nGPUX
         X04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cffkahU1lSzSwVG5AbrWY7gx1XvLJa7VTE+r84Lr7GM=;
        b=K4FE2y01YsGnAiShZy+nBrzziiQj6k6y5bphteYR9siQSAGBzYM9KyZasU4HrW0gCu
         bM5MD+rawlcrHHPfnQVpfnxSF3bpSbVW1WlIs9C1XzBDtmQS2cNxOSM7l9fyXPcTrKxn
         Eed6fiM6DTb8K2xSI0ggCGhavT/UYZ8zkymp21RAOTdaJ5wY0pmIej4zPcTo1bIYABYS
         THfomHOu/09UNFVC99mrjxQUxBM/gIWgusNAiLRc2XebS68pCxVQGRMfSDb8D7yuyktE
         0Az2RFC6ouv3G0b/V8VwGBpnWLVPpiAtNSyWXekkc3a2+kI1kbak9NVWRVoG6pLSoXtC
         1Oew==
X-Gm-Message-State: AOAM531bwfuPdKiWTljVuRa6iLyLXeLt/lAP4BG8dNUyEbDQzv4Skt5U
        PbJ8JJloBytYHgSmRA02RmORvpQpYKrAEsnOTctnadbjwoomnPuNktFeiYjdVDQc2aTsdo9rndS
        uDIE2J/nTvejQrMyAtCFH1UFM6Rrt13HMBY3rzQWYbTqOwIGmC0PKnPCuLk34WFXv8QexnnwnVg
        ==
X-Google-Smtp-Source: ABdhPJzdGUcDpbG67AcAKSKPU5B6dzMfj7Cdp8gdpxjCejcAtOIKZZ0N4zhlosg6WGw+E45D/qcZ055OqqbV6qVrwjQ=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:a9cb:b029:d8:fae5:9e9a with
 SMTP id b11-20020a170902a9cbb02900d8fae59e9amr18523416plr.32.1608595501146;
 Mon, 21 Dec 2020 16:05:01 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:28 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 10/17] hook: convert 'post-rewrite' hook to config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using 'hook.h' for 'post-rewrite', we simplify hook invocations by
not needing to put together our own 'struct child_process' and we also
learn to run hooks specified in the config as well as the hook dir.

The signal handling that's being removed by this commit now takes place
in run-command.h:run_processes_parallel(), so it is OK to remove them
here.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 +
 builtin/am.c               | 18 +++------
 sequencer.c                | 76 +++++++++++++++-----------------------
 3 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 14035ef725..db290984f6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -585,6 +585,8 @@ The hook always runs after the automatic note copying (see
 "notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
 thus has access to these notes.
 
+Hooks run during 'post-rewrite' will be run in parallel by default.
+
 The following command-specific comments apply:
 
 rebase::
diff --git a/builtin/am.c b/builtin/am.c
index 22d147bc19..c7cad2cb32 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -449,23 +449,15 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	int ret;
 
-	if (!hook)
-		return 0;
-
-	strvec_push(&cp.args, hook);
-	strvec_push(&cp.args, "rebase");
+	strvec_push(&opt.args, "rebase");
+	opt.path_to_stdin = am_path(state, "rewritten");
 
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
+	ret = run_hooks("post-rewrite", &opt);
 
-	ret = run_command(&cp);
-
-	close(cp.in);
+	run_hooks_opt_clear(&opt);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 5a98fd2fbc..4befd862ff 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "hook.h"
+#include "string-list.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1143,33 +1144,23 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	struct strbuf tmp = STRBUF_INIT;
 	int code;
-	struct strbuf sb = STRBUF_INIT;
 
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
+	strvec_push(&opt.args, "amend");
 
-	argv[1] = "amend";
-	argv[2] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "post-rewrite";
-
-	code = start_command(&proc);
-	if (code)
-		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, sb.buf, sb.len);
-	close(proc.in);
-	strbuf_release(&sb);
-	sigchain_pop(SIGPIPE);
-	return finish_command(&proc);
+	strbuf_addf(&tmp,
+		    "%s %s",
+		    oid_to_hex(oldoid),
+		    oid_to_hex(newoid));
+	string_list_append(&opt.str_stdin, tmp.buf);
+
+	code = run_hooks("post-rewrite", &opt);
+
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -4317,30 +4308,21 @@ static int pick_commits(struct repository *r,
 		flush_rewritten_pending();
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
-			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
-
-			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
-			child.git_cmd = 1;
-			strvec_push(&child.args, "notes");
-			strvec_push(&child.args, "copy");
-			strvec_push(&child.args, "--for-rewrite=rebase");
+			struct child_process notes_cp = CHILD_PROCESS_INIT;
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
+
+			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			notes_cp.git_cmd = 1;
+			strvec_push(&notes_cp.args, "notes");
+			strvec_push(&notes_cp.args, "copy");
+			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
-			run_command(&child);
-
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				strvec_push(&hook.args, post_rewrite_hook);
-				strvec_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			run_command(&notes_cp);
+
+			hook_opt.path_to_stdin = rebase_path_rewritten_list();
+			strvec_push(&hook_opt.args, "rebase");
+			run_hooks("post-rewrite", &hook_opt);
+			run_hooks_opt_clear(&hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

