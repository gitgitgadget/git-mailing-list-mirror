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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96726C43381
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729FB22AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgLVAGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLVAF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:59 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB09C061257
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:54 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v5so4582101pgq.15
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Dfa0Az4U4Jg19K2ZkjvnVLjkTUIAgpE93RN//ozv9BM=;
        b=MrXcfLfqYpOOKB9k69605ChvptZyOTdnJx0MkZA7a1r6aZQw5wtZXIZSQn3jmIv32O
         SktBYEj/5V/N6IoIJ9f0uFp59YDKYZpKhIwqyjGFzlmZiy66itOQU726EKIg7bs188dL
         /q9jCPFzrONSgvDDg7A115HxWzLYLyVd6uxjJgzJp4gynQPcg2Gvxdio4UtYgjTWwy40
         jfVCS3GU8e+B5Pj4nIPUfLu7JmkD/+VpCSNGywur8IrCdpUJmIyiD8J3Imya/00jxs/t
         Y4OZJbCi7D/aYNTOtizlH+Ly+a8WaHyo6wjlfpoLNnGH7xwDTBhmNcl2DOyB1X/CSqOI
         iIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dfa0Az4U4Jg19K2ZkjvnVLjkTUIAgpE93RN//ozv9BM=;
        b=rMV68izSsmwZg41Sg06DDbON6CJjqnqzaslatTFB+iWsmRg9NjqXWSoum8yXCJtb2p
         qjwa3H/DPn2p0eUNmWjef5LFvYVtJZGeSuDyJz3kcKXaoaHgjBn3r0F84Njjy+1Z8C0j
         0vRaPPx/8P8GCqnTIMCBw/jqWrBboA3HuAwCnzEK12VSDvomtHZmXqxx0n4bR/8mKJGz
         Vc6EpkJmeKtTGPyEFnE2KW/77cTjBeolJJDgktrU9BBXIwrK1lz95QZPpu/fqdwVoQYt
         HdHL9mpsN+P2MjHdFCIccoqrhBMja+MS24YAQ0WvtrPy/ja/NUHXtcO8TImBnvW+dsQh
         GgGQ==
X-Gm-Message-State: AOAM531YkSkm4R7RQ2q1DucyCkBxByC8mS31wymFlrEHoMCEmfvwoZnx
        vR4CJD37V+hr2ec6REr9D2FPBqMmMA4luVa0o3Bp4yrV5sihnqLeqYwWIB9adSQoYr3V1G+/P08
        ypeVpvIhsm05mhqYNrGXGBO9hDDHn0hhmOK8GrohLRrdMZAXmcIYTOAni3rIN55gRetaysbrD6Q
        ==
X-Google-Smtp-Source: ABdhPJwHrBIxuYKjbbzATOJ485znTuxBJ8/r8ah3XnOgRPj5MdRcQ7k6KDhDPSnmqxTq8FqBamGeHKyN1ALie0b31Lk=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:7144:b029:da:7268:d730 with
 SMTP id u4-20020a1709027144b02900da7268d730mr18262946plm.20.1608595493796;
 Mon, 21 Dec 2020 16:04:53 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:24 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 06/17] read-cache: convert post-index-change hook to use config
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

