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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70151C433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADBC22512
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLVAF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgLVAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416F8C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:47 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n16so7482825pgk.12
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QuFgqQ38kuuOuGbPFEj0v9gRTsM5mCpbZ9OoGbpfPIY=;
        b=tB4Av8cYa+WUcZAiZcD3neiJiMs59Wm1e4Ya5qfyJ7Pqzvk70szflo/7l3YJg6ljm1
         mpWbSM7XZwLoAfeU+aOrKDfL8TbIDl5OlPkkO5CJrXUWYUxNnNzwdfuZaP8Ek7DreBpU
         iz429QJsgRyBNCixgxtTTto/DxBgxRLSrkoeGtHtSZl0fLSUcK5KyAyOmWxXKaSNCOpv
         +uViw52zoAiknjOcengRiJHzAJa5ZoHVSKPxbLmBVp5I244ieRJ1NYiRDNOo8urVFaMz
         Nei6IVQDAVJE1LYIXoIMhNgsIQSdd5WkXcsMGUxK7HJFZFN5wFA2PHFOPgqE2QGhgic9
         WgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QuFgqQ38kuuOuGbPFEj0v9gRTsM5mCpbZ9OoGbpfPIY=;
        b=B1QNA9DH/MxPHl2PXrUgRrocWx43qQ7mK5VomxGT3MFm5Znyt+R//sXcwmly3C/B9g
         SpHAqtjo6ydTcGBMhX4rogVPnPSsEo/pdkZenzO0CKih/PZXrxcvb3jO80MbTE80lZMU
         9QB7+fH7uyjeWfDBLIwVdKIVS6iEWZ/W3zKoUsClqsMGB0QQu7cm/h0Zaf5FjpGBQYc1
         Fz11depR0tDLb66wLae+QgGTqNqXm5Ogfe/zQchFq9jLnEhx5TV+wVgrgxYKcaihpn6G
         JEjhV8QgVnuRfcVQkya37+wKUd9ASnbno9OcIUtmkKutq5bgpFqZ89MYq+pjRh9BsLqb
         YhxA==
X-Gm-Message-State: AOAM531cNNTJUCQL0m9E+tlucwnme84b9iG5RgEGPvX6BvMKcm8bVDrT
        fQvbsZLB/4XY4azoSdqohfq3ZbOhu3FlFGW87F180ClPRSzke0OgRj2lLt6DsgTRyRM2wUwnhA0
        HRmehfVB9MWqbl6hL/Dfl88zIgGs65SJfz3LsctAaC08zkQDUJeFYlJMDUNYurwWSXb1dr4qk8g
        ==
X-Google-Smtp-Source: ABdhPJzKQB9v1gloZ5PikvFhRhlJo8f6fNzn4NT/Ss5fkN0zTURdEXmB7Vps5GQu7oAS9MCtbMzu+f2NVz5JZjp6Haw=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:6b0a:b029:dc:31af:8dc3 with
 SMTP id o10-20020a1709026b0ab02900dc31af8dc3mr15219646plk.41.1608595486721;
 Mon, 21 Dec 2020 16:04:46 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:20 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 02/17] am: convert applypatch hooks to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library. This enables use of
hooks specified in the config, in addition to those in the hookdir.
These three hooks are called only by builtin/am.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  6 ++++++
 builtin/am.c               | 12 +++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8b352be43f..0842cd812c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -58,6 +58,8 @@ the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
 
+Hooks run during 'applypatch-msg' will not be parallelized.
+
 pre-applypatch
 ~~~~~~~~~~~~~~
 
@@ -73,6 +75,8 @@ make a commit if it does not pass certain test.
 The default 'pre-applypatch' hook, when enabled, runs the
 'pre-commit' hook, if the latter is enabled.
 
+Hooks run during 'pre-applypatch' will be run in parallel by default.
+
 post-applypatch
 ~~~~~~~~~~~~~~~
 
@@ -82,6 +86,8 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+Hooks run during 'post-applypatch' will be run in parallel by default.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/am.c b/builtin/am.c
index f22c73a05b..22d147bc19 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -33,6 +33,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "hook.h"
 
 /**
  * Returns the length of the first line of msg.
@@ -426,9 +427,12 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	strvec_push(&opt.args, am_path(state, "final-commit"));
+	ret = run_hooks("applypatch-msg", &opt);
+	run_hooks_opt_clear(&opt);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1558,8 +1562,9 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch", &hook_opt))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1611,8 +1616,9 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks("post-applypatch", &hook_opt);
 
+	run_hooks_opt_clear(&hook_opt);
 	strbuf_release(&sb);
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

