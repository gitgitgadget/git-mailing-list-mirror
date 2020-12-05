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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C4C4167B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9A422DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgLEBru (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgLEBrt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:49 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2075C08E862
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:39 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id f11so6253634qth.23
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=b0JOpPGS4lpoiIbzKa9QKHaCbedLFF1bN+1kpGq8ChY=;
        b=pAsJajn7szGg7afDKH4kUEkcN4AlbyobgOH/w4P5fhBCPEvnvEG16UQ4l12bItYT1U
         OPd1Ukx/y2A6PzDYhtz0gJqICt9yDiNcb17hH98Yrf8Y2UpAA7avz/vHecWUirwhQ/Te
         o7ECjnCfxVd3au++nga4U/NgZN6ghB5k5Z5aiFrsJE2i0DTfJBGnxtwFqvVLAk/E6PS5
         RcAfoA1JkwICmR4Og830DOK8AheTQEjp+2XH65052PkU/a5vKa2XtzKe9rAUAJH2HKDy
         DkkhXsN/uVYUR8pigpe0/ahG5lM6DI8AKG8TYWSh/0fG3hWgk7U7xhIfGgcBl5lRQWK/
         zM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b0JOpPGS4lpoiIbzKa9QKHaCbedLFF1bN+1kpGq8ChY=;
        b=YQHZB2v0S0NnzxvRGzNr9QRITxheffUyyEayaekkYOu1IvfHLg38kj/fcy+OFk7m9F
         RvhvA6I5/230qJ2wNx3oMcvqSlTeIgg2MdReEmaIuB1yoZa6PgzBrIaGvXConLPhA5B/
         bKSgn2JglM8rurJkzYI7vXyoZ7JC0zETF8ml11ly5Ow3qrI2JG1N3VOowXnaWUBPKYQh
         X/gmUqNlt1tzKHXOvqIaXOA3TbaWcgr58iRlWA7D4v2xRi56XMBJS6s02o4vujzhOAze
         Ui9q92A30V2KCP5WMvriSyKCjBy70n6fWfm/jj6yY4lUSr0TZw6hpRhJjkk3DDUy5+pl
         3W3w==
X-Gm-Message-State: AOAM530/qihooIPwlvvWGL0wc7Y3pFPmOmVccW3LIv+6acy7JJ1g8qzI
        nrI9XANZUsUQtfhoGeNIqFi0Bx/IyEPm7/cfFxp09t9vk2Rm+PKmmSbgIzDV0Ijc2foFEC8rAtP
        zpEstBZFDWdSuvPSTmdNNyH891aTAFN+88rcBwqQd2Z9GcRDTE7cBFPEyIw80ui0fUzxpnPB+nA
        ==
X-Google-Smtp-Source: ABdhPJzbeSZ2VqYJRoA4HeucIFDYoYaNoRzLgjUMnmdGMpfZK/qd1h/5Nz3KMT9QtgaVVe0FrEbxc6nazfs27gcWDq4=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4e30:: with SMTP id
 dm16mr9062164qvb.47.1607132798813; Fri, 04 Dec 2020 17:46:38 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:03 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 13/17] hook: allow specifying working directory for hooks
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
index edea54f95c..f0c052d847 100644
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
index f54568afe3..4aae8e2dbb 100644
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

