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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B7C4167B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11439229C4
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgLEBvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbgLEBvL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43074C061A56
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so9259436ybs.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Dfa0Az4U4Jg19K2ZkjvnVLjkTUIAgpE93RN//ozv9BM=;
        b=dWikadKDJMgBKavg/7MJclZOlG35SIXdWIe1nVnCddiWDnR+0PA+S731LPrctZP9yR
         rZMV/7jIrWKQuJImp8z42SnEKgi9JCtWQSK4pR6U1CN9gy8aKR4rRHG8fm6dltyAnPL5
         sXNAtT7iBYhpVkK2GeyUpsw4/TG42AkHjEFi9kRS/yhBC7Sd5OJOUeX8YEe0koj4SNz4
         RJ7eg9nrYz+9SbGGt5LD4U2NHFw6tvNO+HlXlKwak4i6h56ID8XSZNvi6knDcdujvC+Q
         ri3PECWpQhmPbZI+SqNdDjcJmyUQ4DWlK3GcTE5WiSgq0BCQ9ICo3VMCgPtu6nkotTgw
         wu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dfa0Az4U4Jg19K2ZkjvnVLjkTUIAgpE93RN//ozv9BM=;
        b=aawTLTywEBTG5FbKCIV2juf+NINRMGPbbJant9eBhyCKVW+e56cEbc8GXKJtDj7ftG
         WWUgV/qvq/A4VtKbYnPn6RNHJTt8YfvcniHzaRjMP4duK1OFAQtUWvINM+upcxY1IBt2
         DF+13sWy6wO2s5ca550tFb1/OUA/3gVIC/jytg8ZnXwuJEnMp8KcY9mWWWQItFiJ3RBy
         Cu1yXUOOxMOfQYTg+p5UgUVlenkzZTBsVb1LJKvd63oeMrl4nouek2Z/id7ja5nmU4jH
         a6LgFojqk/wYeSXyj3zsex87nCSXHfHGMM2afzLWM+ZhEWEzhP+9iTvjE2nNeqPhfyns
         ZT3Q==
X-Gm-Message-State: AOAM530VNZ7AlyosDffpdOJjxuDExCNBDrcFloS9J/7eURPq+f2KqLHt
        BRHf3bv9KmHIyzel6OyVQIPGVAn95xvyCueE+aXIFFeTTZ+wvI/0u/Ca7jOqPkQpfgFm3l6kcEt
        sKOQTPJiur1bIHQBdZ5PR3Gn1FScjXFO+TsYMRk4lvturKXBELtESQ1rkaiV96IMCletY5kUJrA
        ==
X-Google-Smtp-Source: ABdhPJxpED5G0N8azYEQ9obhcYUiwycUPvkUP19p39NYCqCZB0KmeLl7E9B+JJ+RVKS6JUPrXp0mWyQSIoBvc5qOFU8=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:6951:: with SMTP id
 e78mr10202953ybc.42.1607133001500; Fri, 04 Dec 2020 17:50:01 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:34 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 06/17] read-cache: convert post-index-change hook to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to run, post-index-change hooks
can now be specified in the config in addition to the hookdir.
post-index-change is not run anywhere besides in read-cache.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 ++
 read-cache.c               | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 5dc0690607..8249ecec5f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -711,6 +711,8 @@ and "0" meaning they were not.
 Only one parameter should be set to "1" when the hook runs.  The hook
 running passing "1", "1" should not be possible.
 
+Hooks run during 'post-index-change' will be run in parallel by default.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/read-cache.c b/read-cache.c
index ecf6f68994..dcfc080aaa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3052,6 +3053,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 				 unsigned flags)
 {
 	int ret;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
 
 	/*
 	 * TODO trace2: replace "the_repository" with the actual repo instance
@@ -3070,9 +3072,13 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks("post-index-change", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

