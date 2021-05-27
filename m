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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F1C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE45613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhE0ALr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhE0ALT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210BC06134A
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k34-20020a25b2a20000b02905149e86803eso3642062ybj.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=btlcOqWp2Hrr3jczh4cqmNxLjf86ggWODpJ2RlSu0+c=;
        b=HyDy3Xk5/RcHwzvBaXH+PXNmLKMnMMsFUncX1+K9rcGfTBF5yqHrR8A6yT4/1LlBF+
         dJObK102X1avKZLscULnvHl8J1h0kUyNMzurLbTh31wO89WBb9dZGGK4YLVU+ENdmmfJ
         nvOU9HXHXqu5MCL4rI6sbjPnr5BpysCecjlZ81mYHLTOpdWs9PTBwhIxFrUu4mfvxFN/
         bKgICq7XYhm/5Iz9pa55vhcmQBoqILbDrNyyhmCHI6cdKkIFZy+dAf7NNrWuM61TERRA
         b4HTxkJm6xLecBTexssohYYSL8ta92cG22h7zH5IBcYWCEXjqpZHGOecQdmL98c/xiHV
         BcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=btlcOqWp2Hrr3jczh4cqmNxLjf86ggWODpJ2RlSu0+c=;
        b=Ic5HSd7UW7WFtpTIa3DYUqtr2JvTOI19GbgvBMdwviD/fjPAt3nYtDJQUzLOZPaBE2
         hO5Cr+F57ZTK0cs6wyru7n9AOFjtfvgN5p8uvlE/GWyGTBwR7xiAODcT848+ZRyyILg2
         Gophhd9/0OdMeB+ycQv+32PWMWqoMhA9FRnF51L94qOOGXP5RgJVsMflJrq3TlNfXc1O
         VeE+IkY8KpZpTZQfoDN1YuJSn8N6vQ9tcfUrKEWDD0tp8NLtGCWnBB8gT2Xrz6Z7hFuU
         vIqtj2B6zjNX93bJMRdlxXJCjNQtHnGATX6cMokhFmFOnEGrEvX73GPP3LJ28IOARHF2
         kaeg==
X-Gm-Message-State: AOAM530Wvdv9Usky2k8L1oX4OppYne92wLu4gKTL52ud35W9Ck5JAQid
        P/EvaUNX3j0ZYnrfJ+pH7eGQugeGuXep5Q+3CPmlLGUKA4OxImypOxByjRlvSmByyM3KEPsSwrm
        9dku87ZfVabsTEbD6mLJEjzc79EP21IrNK7Pv1r2M9lkPaZPcBijwmzhkCkGslWHAWjyBytk4+A
        ==
X-Google-Smtp-Source: ABdhPJxWm3lCJZh0ACxr6PJy7NH5ko5sWrGymAKqZbM9x62mrMlnRh2fM/9sY2bRn/8SDkdzb4CBzq2+kObucYNplCM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:8b12:: with SMTP id
 i18mr858896ybl.162.1622074177910; Wed, 26 May 2021 17:09:37 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:38 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-20-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 19/37] merge: use config-based hooks for post-merge hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach post-merge to use the hook.h library instead of the run-command.h
library to run hooks. This means that post-merge hooks can come from the
config as well as from the hookdir. post-merge is invoked only from
builtin/merge.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 3 +++
 builtin/merge.c            | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ec5020bfb6..c904b160dc 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -242,6 +242,9 @@ save and restore any form of metadata associated with the working tree
 (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+Hooks executed during 'post-merge' will run in parallel, unless hook.jobs is
+configured to 1.
+
 pre-push
 ~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 182dea418a..7a524cb3e3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,6 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -489,7 +490,10 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hooks_opt_init_async(&opt);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks("post-merge", &opt);
+	run_hooks_opt_clear(&opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.31.1.818.g46aad6cb9e-goog

