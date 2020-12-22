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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFDC4332B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8848022512
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgLVAGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgLVAF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:59 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD00C0611C5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:56 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i20so9230986qvk.18
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yNSL21HxP5RNNCKYE8EwhTeFGbdFXT4FMmuUI4tLRiA=;
        b=GqhR9TqrIl7wkSYs5g75h/LFJ031s7xBXP+W353m48JkXZ+1KKKTa9A7ASCfKVj9AY
         6n4gjpO5UseVCV9q/Ve3+rggxM8ZcYYPBAfeiqLA0h2wsSXG5E/YC2gb0ZGv14oxsHyM
         a6xcVel5C0ltEChwTHQbBQm7C0QS+1/wj1JLkz+s3cPv3vfsYAOwPjtRc7/cC8l5wzB6
         sJJBScxMIL6PbNDLw3SDuzkiFxNQfzl72iW97t/ySjNjfS+TK5Spc8oPe/P7BEdzqYaE
         NRy3Tc8x2mJofjB63eveI4mfu8b0u3+Je1YJLB+UQ36humKvGiq/OAREuwykH9bL6AFC
         0kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yNSL21HxP5RNNCKYE8EwhTeFGbdFXT4FMmuUI4tLRiA=;
        b=tU5nD3WTMRGc7m4wImSRaGEYUpfwQzlmdyohBfGbzfEPl7M0zo66RRmKqX0LBu5jUF
         /v5XT2McAtpZaW/2pe66ebFjlVmgi9iZgzNU3n3MY8QZ3eCt5JbKYv1TYKt2LTUhzTAw
         lbpAF4DIlyv9D4YlBv8b9d+tdj8ssxtY2xlt/pSMqOxE3LmTniEL2Oe9QgoEvZAVfomB
         16QXIRKwgtchRzPhtpBgaKvY1VObIAmm4MtKXdGZibrGnuJkamZsb3fr6oYmQC7gIBdu
         Z4a3slT2czB1W0LSGPBF8WMBQqoYw00OzOYFH11hoOzTMpy8SOC3BfUUFj9VkaF9954Z
         +OnA==
X-Gm-Message-State: AOAM533SFZXdFXB2Q5yL9CSyX7IemzVkTomZD+U8GiwuYQZFuuz6DebD
        jfl/ql7bEx8/ceHsvnLJo8MI3QLbNE/deOFAmt4kobdL+hYWWcrAnzHa07Hn4ORUlfmyXgC1Pvn
        +UVGsIp/JRivfPxTm1da/tcNWOXVPDV8hBzJ+wZGz3xn/UDB653XCYI8hJwOzeZA7gSl0pPOm0g
        ==
X-Google-Smtp-Source: ABdhPJyEky+977ZKH5ZrNZD3n4BA6B+0Wrfg6Uhk3LQos43h3YH2dvVNxmwqf8RRTZ4aw2s1GkSryhFJo0HBNLDqWh0=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:302:: with SMTP id
 i2mr19908079qvu.14.1608595495624; Mon, 21 Dec 2020 16:04:55 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:25 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 07/17] receive-pack: convert push-to-checkout hook to hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to invoke push-to-checkout,
hooks can now be specified in the config as well as in the hookdir.
push-to-checkout is not called anywhere but in builtin/receive-pack.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  1 +
 builtin/receive-pack.c     | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8249ecec5f..8de512ee5d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -547,6 +547,7 @@ that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
 
+Hooks executed during 'push-to-checkout' will not be parallelized.
 
 pre-auto-gc
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d49d050e6e..1c0bad0448 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "hook.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1435,12 +1436,18 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks(push_to_checkout_hook, &opt)) {
+		run_hooks_opt_clear(&opt);
 		return "push-to-checkout hook declined";
-	else
+	} else {
+		run_hooks_opt_clear(&opt);
 		return NULL;
+	}
 }
 
 static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
@@ -1464,7 +1471,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook, configured_hookdir_opt()))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
-- 
2.28.0.rc0.142.g3c755180ce-goog

