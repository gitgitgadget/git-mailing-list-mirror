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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84DC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB3A22DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgLEBun (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbgLEBum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:50:42 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5AC061A53
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:49:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c1so4350285pjo.6
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JBKVjRnbzqESSv9JqchxvmDRnDuoKg97DbxCNoBxVeU=;
        b=LRIh3JDz6eZE+Dw8WOsopSpg2X4xGSphGm4fp4IHg8OxsF5gmbGFMIfEVuUJNcdikX
         fkQWDuvm/07pYLG1eGb4mohMW7H2wwNytMnrF0wVbJ5NIPlWAQOmdVR5ubGpIpgUUjZ9
         sI4A/JMMdmEP96uV3pQsdagXqHUD1RzlZfcFNn883xr1GP2kgwP6xeRo+HJ4W3DOFhgd
         S2yHySIlpNncasweUrBc0EBlEH88vY5amDQfuo5OSc4y642St1RtRemqG+ULHMaUU0XU
         dKEE3znxC4X94SLMKhxSx9P9/M0f9RawRcHOya3TvhYoIPGxxpLUUsOEtkybjrS+KOGV
         Gtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JBKVjRnbzqESSv9JqchxvmDRnDuoKg97DbxCNoBxVeU=;
        b=duVMjQVIxz22CX/jV95McmiT2iXnx8m5xijkVURE6h/biSM4ZlYM6s4DVY4c3AX01G
         wY2SZ/CHIAxh/kzfdkeSD5ldQqA6ElUKokfBPqKQQjs08iKqxQHZOfimfrjA8vxv7cGD
         oOHizi5QskBnZwP3eNaYBMhm/Wix+wwGOXSbLP3DDKUY75WTpvIoNuf2dlourLM/9SCN
         ivOEtbHG6WKAFsSNRADfPRILIbJ/Dz5TSpx/5w1U3widhRbrD37c9xiqM2oecqq0FoJf
         ECq1/QdEBUFjSz6tbNb7hyt727lfKYnlymcgDZrgVKDvx19yK2f8Vbkh1azrX+bHbCln
         W24g==
X-Gm-Message-State: AOAM531IUOytDDFPctSpwtedTMVN1ufJMN608tvc/t6mYcjRs/B8JTuB
        euUzXNENpHydz/DEOVSeWLbJFr862CWbKk6bEz686QdQOA5Vgoq8iLX88F2Hq8YdwgBzWZ+BszT
        SB9pL2WEKXWw5YIvOQyj62trIJLa3qI+9CYD+/FihmuRH8+K4a9HZeA/WDRh01eII2Ml/vpd4YQ
        ==
X-Google-Smtp-Source: ABdhPJwxZdMVAw24+jSqamdDPtEz/vPNwX0A1/6pCEYUBMP+fu4z2cTVRcfJ5yGOZL6/A6cd+kDNR3K+0oZxG4FnMu0=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:fa0c:: with SMTP id
 cm12mr6683903pjb.87.1607132996090; Fri, 04 Dec 2020 17:49:56 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:31 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 03/17] merge: use config-based hooks for post-merge hook
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
 Documentation/githooks.txt | 2 ++
 builtin/merge.c            | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 0842cd812c..f6ddf1aa22 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -236,6 +236,8 @@ save and restore any form of metadata associated with the working tree
 (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+Hooks executed during 'post-merge' will run in parallel by default.
+
 pre-push
 ~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index d654b6923c..717fbaa019 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -443,6 +443,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -484,7 +485,9 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks("post-merge", &opt);
+	run_hooks_opt_clear(&opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.28.0.rc0.142.g3c755180ce-goog

