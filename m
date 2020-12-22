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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B28C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1A322AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgLVADz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgLVADw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:52 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F5EC0611CF
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:50 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id w3so9128895qti.17
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eOkRt3sHO+DZ9MfMNfj2MOvU3rJSy7G5czli6umbxR4=;
        b=AkzPb5X3A6kpRMK+irevjvYUy9huT3VUjClyE1b/B3G6DUNKVgRY7wtmdFGxqBddJt
         mys6yvKKRQ+iK8HXp7bcgZ+KvlEEtQoZ8OSLOmZDZjMTviXgWolqpE/TzUEPvm0ADsl9
         f4aoKv9L+VGvGizNBw15xLaANZb4u2K3/seD4O/fOBRpikxODd6tbnTdBhBZS/qVOccK
         oDARVZr3xUU538wHogGOOmje1N/mIf+FzGoWx7SiolLb+3byIMdTiHx/NFMTxG5NeHT9
         +tqf/0QM6RoiRjveetuSOPAPRH9poynPNAJiAo2ra6AlWQzqBvRTJcP22vWqr8bcxKov
         Z9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eOkRt3sHO+DZ9MfMNfj2MOvU3rJSy7G5czli6umbxR4=;
        b=tKoYRBAtjc1K3IThsqNkc2FTGcqYDJP8ONzbfPWDmer7As1smvhEadIDgrPYJkqBvr
         wta4okXrwRKAJCsHw8WnhyFj7kfMOhyta+bpPmDZ3f8r+reFPkyxmdjTT4LlfGpeiY8h
         R2IYD2vgFjE7nkyLs+WLf4jTyGLZ0dqNFK11xh14km0/Urs8KaFX9BcOfgdrgtImBjMc
         GK2BzZyi6fz47fm0QCDEOGnWnamglnBrtl69DFrehS8RweDAqe1P6DwFatGFTkdXKC3a
         GiKybU2KJsstfyuf6sA7cLCDCjjsHZlbD5RGY1ep62J9HeqYI022mIhjZNHZQQ2lBOQl
         z+6w==
X-Gm-Message-State: AOAM5300W/h8jCUcSjHkxJw4t8XenGoGRc8a9H0rwgnFrlx1BXz0Gn4X
        aYyOOQJqzDDeO5kPgkimf4nucrV3lKdRzz6uYjnLbOpK/2B8TAeLFFB75oZIolOVWDezF6DWVzg
        DnwZpmCP0xLusN4Bf/rRYPqa8qcO2V4ZmCUeRmzrpnGoSxfljF3a7aguWxIjOq/C3MsKTlMMJRg
        ==
X-Google-Smtp-Source: ABdhPJx3dY6P7iKxcP9In3280iYF5LpyVc8J74PR/RpHzfpUlV7N/bacsW9OXhWaoufMlUKZp+TpWLKR65oCwwV3Sz8=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:da87:: with SMTP id
 z7mr19381539qvj.41.1608595369674; Mon, 21 Dec 2020 16:02:49 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:16 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 13/17] hook: allow specifying working directory for hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hooks like "post-checkout" require that hooks have a different working
directory than the initial process. Pipe that directly through to struct
child_process.

Because we can just run 'git -C <some-dir> hook run ...' it shouldn't be
necessary to pipe this option through the frontend. In fact, this
reduces the possibility of users running hooks which affect some part of
the filesystem outside of the repo in question.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Needed later for "post-checkout" conversion.

 hook.c | 1 +
 hook.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/hook.c b/hook.c
index b190afa33b..eea90ec1d0 100644
--- a/hook.c
+++ b/hook.c
@@ -271,6 +271,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook->command.buf;
+	cp->dir = hook_cb->options->dir;
 
 	/* reopen the file for stdin; run_command closes it. */
 	if (hook_cb->options->path_to_stdin) {
diff --git a/hook.h b/hook.h
index 0d973d090f..8a7542610c 100644
--- a/hook.h
+++ b/hook.h
@@ -60,6 +60,9 @@ struct run_hooks_opt
 
 	/* Number of threads to parallelize across */
 	int jobs;
+
+	/* Path to initial working directory for subprocess */
+	const char *dir;
 };
 
 /*
@@ -77,6 +80,7 @@ struct hook_cb_data {
 	.args = STRVEC_INIT, 			\
 	.path_to_stdin = NULL,			\
 	.jobs = 1,				\
+	.dir = NULL,				\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
@@ -85,6 +89,7 @@ struct hook_cb_data {
 	.args = STRVEC_INIT, 			\
 	.path_to_stdin = NULL,			\
 	.jobs = configured_hook_jobs(),		\
+	.dir = NULL,				\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

