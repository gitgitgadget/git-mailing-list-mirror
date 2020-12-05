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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF1C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430CA22E01
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgLEBum (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLEBul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:50:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2948C061A52
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:49:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i184so9282165ybg.7
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QuFgqQ38kuuOuGbPFEj0v9gRTsM5mCpbZ9OoGbpfPIY=;
        b=By7cpzpN5phVazgX1DmtCFhNqO90vPLNCuWeve2UdG4arQN8MNboRGdW+jW2BRTucj
         6aTrjavoNq8iHf7SzncAJ6VGQg3do2yaDPnYCZzoV9Ktfs4LkMWzCsgy7lJ0Qw/rq1nJ
         wIz9kIl3dOxrd6XRAmZrQTHrNNH9cDOLj8fem1zzEzqWNrZn/evhkiKqOlDJ59P8bc/1
         sZyZy1sKlEdD0iX6yh+d/7z/Zj5SFgFjtl0OCPjlDa0O2y8WyRT8RRRWIQamiev8CiMM
         HYaMZ5UyTsrtWxCiwtJCYQmObnZRRJXjunkn3CupJTtBloNzzqa6GrfbxEJup+hqGRDZ
         kOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QuFgqQ38kuuOuGbPFEj0v9gRTsM5mCpbZ9OoGbpfPIY=;
        b=m2cWEzl0fpsvWoHHmZGrwRhsvzVPZvNMLUzArwTsgpRUw8uFpmAVWr/4iHnspxCqfZ
         +xlLXIq8f4Rff28npsxaLWsOINo8MF9M7jZYTg+quC/9/0QIFjMGVpikEAqBnrFWgepU
         0H6+BtwkbHZZDL1feIwgopleN8SNHJzicuRt4GbLNQE19jTRCD9hk8cQnI8UpXt1uG3x
         k+QcjJfMCJmwAy3FwwMGYs21BiZBpTcF/37r0Ej8keWbQpiRgd/IHMQ/9ouvfws6BV2Z
         431Si3owoSc5hImBdHVlPfsK+b+rvaX/c6KVn1nw2GZ3lJ3x660r+4BMT5HOdfFnHiUz
         0rxg==
X-Gm-Message-State: AOAM5338HI25h3ySGl2Ue59YuCUwIgwzgUsssbXKT4/sWbqZjyfSKFl8
        LoshwM+5YWun2mtJZGhV/MasImBfxgt+R2g7zAWMPLVPc52slDLFiCS9uc4JsN5T0sDNzzAXMhp
        H36+H1kDroWxDtcJwG7ScWzOTvHsPWET9p36BBkRlL2dLwbMQiXx/zxZoAwuvnB2m8mDQaQyGkQ
        ==
X-Google-Smtp-Source: ABdhPJx2BM4GWBsY6EON3/sye02bareB/bjNe5dY8ipmCGwWuKvLBGcm3qqzJ2qCcyu72MHmy9C8gdxjvvfnIta7nIQ=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ce8e:: with SMTP id
 x136mr9717455ybe.488.1607132994187; Fri, 04 Dec 2020 17:49:54 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:30 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 02/17] am: convert applypatch hooks to use config
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

