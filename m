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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D6C4708A
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50F0613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhE0AMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhE0ALa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B152C061353
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:52 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x2-20020a0cda020000b02901edb4c412fdso2546737qvj.11
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZdDKsphkbuAGRRhJWNf6o04Yx3VUr1hbdG6NAatJSo8=;
        b=Tlk2mc/RKy0rt6XVGonwGOdredqV4+ZjskuicSzivE0SD2R6hIdSmO+txoXC5W9W7h
         o1Qle341sg2oYRVtjn92MaclYQ4cAKRF3e57VlzZHZ85e0yUDgqBhIDUD/MI77hfCqDA
         DRvEV27vHZovLT74bsXRF/i4ue5kyr+Mm0gQ6k8wz1OlQbz810S9f2S+zKbt86W5ECHJ
         AAzubp2QVNN83IlwxTwRnSo9+DKwJMCB+bt5EI4TmBp49K5b/0e5h0cjEmRgxiKnd+Bi
         voeDmMy2iWpI7mG1r3Reu312hQuhHOQx34G7sLb+R5phY99Hj7gupAVSHDPX9gBzrOos
         iwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZdDKsphkbuAGRRhJWNf6o04Yx3VUr1hbdG6NAatJSo8=;
        b=Sow/9srLrDG2YoUZi35YtUtUgQ7OZza5Wy6MB3hTb34EF+5z2Nc0hDhqreK45xa3Ie
         BXaHCFuTFne2fKwqahuLV5F5Qeuv/vwasbrwzKjiSD85J3fo0NzbYl1RZtPskhA8oVBC
         8p9CgkFDz1830O64G9IMFU88raouazthdqf++vXWtDhmlz+p1K2hCY7q0IjIMDDCK7YE
         LborZ4tgN12KXdRhkWadok5wJIro4k3/aB96fioRqWrUYNMVnQSCev4Qpqy/uNHMoaXF
         s1a5uFPgIXlO7hIbzk9eO00tGl83jZJhbWhI4ZnV0NfOV8OUjMnYUlEBgQ/o16Vus5Fn
         ieXA==
X-Gm-Message-State: AOAM5339Eo8NN1BqXl+yuhvr6AmYKzhqTmGOw6gfYQeFtRJP2ndWFP47
        tn8Ky1RW/2NjJ8S82bMubuxBpWpa9hP73T59DplMscPWtsFhj17XLFVkJFlBmDkfVuqwOGmT5jX
        ILhw8FlI45ySJRoX+dkW+RsK3EjEt/Aj+I5aX7IxpXc2Qkw10YXaeBUHNBaGyyCpgaDj7Nk9iNg
        ==
X-Google-Smtp-Source: ABdhPJw86f1W0g3hc1hkNrOwDUdFtY9ihUIg5ekBz2W0zKmWqGIh0UJIv5HWOQ6XDHZNRhCS1jy1hBRYaE6Hq57hxMY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:450f:: with SMTP id
 k15mr553700qvu.1.1622074191330; Wed, 26 May 2021 17:09:51 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:45 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-27-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 26/37] hook: convert 'post-rewrite' hook to config
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
 Documentation/githooks.txt |  3 ++
 builtin/am.c               | 18 +++-----
 sequencer.c                | 85 +++++++++++++++++---------------------
 3 files changed, 47 insertions(+), 59 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 6a5ff036ff..156e4809f6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -603,6 +603,9 @@ The hook always runs after the automatic note copying (see
 "notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
 thus has access to these notes.
 
+Hooks run during 'post-rewrite' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 The following command-specific comments apply:
 
 rebase::
diff --git a/builtin/am.c b/builtin/am.c
index d84791859c..d2534f9a1f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -469,23 +469,17 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
+	struct run_hooks_opt opt;
 	int ret;
 
-	if (!hook)
-		return 0;
+	run_hooks_opt_init_async(&opt);
 
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
index 72234af8ed..3fa7668763 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "hook.h"
+#include "string-list.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1147,33 +1148,30 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
+	struct run_hooks_opt opt;
+	struct strbuf tmp = STRBUF_INIT;
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int code;
-	struct strbuf sb = STRBUF_INIT;
 
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
+	run_hooks_opt_init_async(&opt);
 
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
+	strvec_push(&opt.args, "amend");
+
+	strbuf_addf(&tmp,
+		    "%s %s",
+		    oid_to_hex(oldoid),
+		    oid_to_hex(newoid));
+	string_list_append(&to_stdin, tmp.buf);
+
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	code = run_hooks("post-rewrite", &opt);
+
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	string_list_clear(&to_stdin, 0);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -4527,30 +4525,23 @@ static int pick_commits(struct repository *r,
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
+			struct run_hooks_opt hook_opt;
+
+			run_hooks_opt_init_async(&hook_opt);
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
2.31.1.818.g46aad6cb9e-goog

