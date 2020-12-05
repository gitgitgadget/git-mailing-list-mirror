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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36E1C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E2122DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgLEBrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgLEBrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:53 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876BC08ED7E
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:47 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i1so1817521qtw.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FyZvN3it5ExyrC1BDLo/CrnbYgEG+KU+/ghE/g+v6so=;
        b=HSk5L23JSSFAk6lLLRtzDMca34Nt+BpyDbghs8IQYRtKV+PVl3dYwQQY8orX3CRoRM
         fTcFnD2h4GE9AMa8zhMC3oLmQo646tjY+p9erqoIun6/cij7sSoWrV6xHLC5/ax6B/SU
         COb070UFR1Jx9mRkXdvjAq5dvWuYbvpwtljrUyj3jNUIIvBfPSwUt+zqX5DCZKcaTSfH
         RaQh/rftgoBjy1/cbCVrxsUI0z1MYWQJ1rOynK8yGBZ5NlqO0CMqRcUAgMXtr8e40OVQ
         PPadZ0WE6ox6uS96/6lBN0KjHewUI45i5+zSN7L/osO1Vmz14gcO61g2A57klQMekCgg
         gTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FyZvN3it5ExyrC1BDLo/CrnbYgEG+KU+/ghE/g+v6so=;
        b=pgc3rTQa7Aiq4YD67CiQvO1tG7xlVkHepb85zCjPA8rcIhyPJsHpxRJktuoe+U7lcM
         AYOz1rXKw6hWa0MLvMFlfA3sGj/94GndK9LLZwpgkNS7P8gTBbW5OvaPxaQceT7KlFpv
         XSATgZzhAgHXWeHz/dNS2LmZnksZqCMlDeL8SgtQH2NcDFNX5dLbxk9tnuNmG8vnMiN7
         Jg+9B5qYIloWtumB30bptUuCXB2emWDnWQveXmzMgBeRq9r9ost5pUSVD9tVBeRe+9KF
         URux1+ct2/B0dLXS+PoV3HrLX7nTaHzdvxch95iQacmDUY18SulPJk8WleFHaKYGrPll
         Qwgg==
X-Gm-Message-State: AOAM5308abpoK1kX5VQ1Xwj8M3uSRaezf0GyD7mhZjQmNUBP+RAR/PrS
        dsq3Uh965y5OBS8ikPPE+89yz12B/9+M7dsYAxejiSqgHi0qS2NPu9Xq0e2TrFAGV7ZFQoicU0Y
        VnJSjtB73uJZGY3ZuOPHm3zNW7UW6gnZ2+hJMdHmTw5A8QnZICzwGJxAEWIfFj3lJM8ilPndjKw
        ==
X-Google-Smtp-Source: ABdhPJztdOwweCLCtFXjKYb1PqeLUBzZJkqgLPQ5p4JqKz1/klY6fZr+6Z/6kxkn9cY+h/4gSuQknbdbmqg/0ZJVn/I=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:fad1:: with SMTP id
 p17mr3000419qvo.47.1607132806150; Fri, 04 Dec 2020 17:46:46 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:07 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-18-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 17/17] hooks: allow callers to capture output
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    You can see this in practice in the conversions for some of the push hooks,
    like 'receive-pack'.

 hook.c |  2 +-
 hook.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 1186ee41b3..78d7721b74 100644
--- a/hook.c
+++ b/hook.c
@@ -407,7 +407,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index ace26c637e..7059e0db77 100644
--- a/hook.h
+++ b/hook.h
@@ -76,6 +76,14 @@ struct run_hooks_opt
 	feed_pipe_fn feed_pipe;
 	void *feed_pipe_ctx;
 
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_sideband_fn consume_sideband;
+
 	/* Number of threads to parallelize across */
 	int jobs;
 
@@ -103,6 +111,7 @@ struct hook_cb_data {
 	.str_stdin = STRING_LIST_INIT_DUP,	\
 	.feed_pipe = NULL,			\
 	.feed_pipe_ctx = NULL,			\
+	.consume_sideband = NULL,		\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
@@ -115,6 +124,7 @@ struct hook_cb_data {
 	.str_stdin = STRING_LIST_INIT_DUP,	\
 	.feed_pipe = NULL,			\
 	.feed_pipe_ctx = NULL,			\
+	.consume_sideband = NULL,		\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

