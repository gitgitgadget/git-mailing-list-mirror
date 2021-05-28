Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01FDC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F60601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhE1MOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbhE1MNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC85C061344
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so2273820wmc.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a3CoEvFbxF7c8JD6MpEyFbe4NX8fRQq+CO16EgHBa4=;
        b=XQjY/YUTyGERBH5in3Y6Dcilgp1M4ijHRMoyYw4ON6OEbXRK5QB7Y3JVXeIZxUfd78
         FyZJy2czkZoeHdjrkskJaZ9Qyvf+RwTm6OvZc2TGocLtErLhSvSYI4LwmdOg7WD1AOH1
         27LNorsocPBaRI3/KvSJ+aTT9K9qOVNllGkCxsLEEP1par5UyJdE9AGkX2/y/gMIJaVx
         kzksADYIfbG5FakUDk5lr2RcFN8Abj1gRYAkIXAx/+Lu32u1YhBmEa8/S3woECEQaqqz
         hjWy6PY927aYdIEZMJXjiLJU95UVqYDyB1LSwT2bbF/oiT+2o7zfo24JCGEnPHwyWEeI
         RL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a3CoEvFbxF7c8JD6MpEyFbe4NX8fRQq+CO16EgHBa4=;
        b=UJ2EYJEW4E/SXQ1KXl5EG0Z5JiYkybWC27NfVed77mFw8xEDjfo4Yux67jZrsxPsHH
         nBa/T9wZZUPe+ykXWw64H6Ef7jMJ8aLxSEcLX+YBAFfgv9epQveeSXQeuxyWhCVsKxnY
         IIqJ1f++RJBkwpRx/Kt+Y/6c+OMRVWtfZvaYihhNbHBkTq1B6KLg6tw61Ym8apydpkFe
         WUqiw3Zr18AvL0y1Gs4+2K+6Yk9A+B13mTUtdPw2+iNZVJCSmCrvw2XSsyFDCjXtwySN
         WmCECyIlWz8yJqZ3+h7jChisY6F0k/PEbjONbCUiRQPx3vX3gpP0Tv2gvvy84O4xqQ20
         64GQ==
X-Gm-Message-State: AOAM533gzeCuX4NgcRAcKqsQhoWiTHrqG3Ux7T/II4n0G2Ep21AEV/mV
        nFLt7IberJeqUnDav+l664PRFCJneGsp9g==
X-Google-Smtp-Source: ABdhPJxz0mwxz5pYQYNKqjALxm96+f9K3DqtWHdedsB0P49wXPjOzoMCrRAOmttWge5HRSHMET+REg==
X-Received: by 2002:a05:600c:8a9:: with SMTP id l41mr13134734wmp.73.1622203915235;
        Fri, 28 May 2021 05:11:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/31] receive-pack: convert push-to-checkout hook to hook.h
Date:   Fri, 28 May 2021 14:11:18 +0200
Message-Id: <patch-16.31-a16163d4fb5-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

By using hook.h instead of run-command.h to invoke push-to-checkout,
hooks can now be specified in the config as well as in the hookdir.
push-to-checkout is not called anywhere but in builtin/receive-pack.c.

This is the last user of the run_hook_le() API, so let's remove it
while we're at it, since run_hook_le() itself is the last user of
run_hook_ve() we can remove that too. The last direct user of
run_hook_le() was removed in the commit preceding this one.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 14 ++++++++++----
 run-command.c          | 32 --------------------------------
 run-command.h          | 16 ----------------
 3 files changed, 10 insertions(+), 52 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1e0e04c62fc..5248228ebfe 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1436,12 +1436,18 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
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
@@ -1465,7 +1471,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
diff --git a/run-command.c b/run-command.c
index eecdef5a0c8..95c950a4a2b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1321,38 +1321,6 @@ int async_with_fork(void)
 #endif
 }
 
-static int run_hook_ve(const char *const *env, const char *name, va_list args)
-{
-	struct child_process hook = CHILD_PROCESS_INIT;
-	const char *p;
-
-	p = find_hook(name);
-	if (!p)
-		return 0;
-
-	strvec_push(&hook.args, p);
-	while ((p = va_arg(args, const char *)))
-		strvec_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
-
-	return run_command(&hook);
-}
-
-int run_hook_le(const char *const *env, const char *name, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
-	va_end(args);
-
-	return ret;
-}
-
 struct io_pump {
 	/* initialized by caller */
 	int fd;
diff --git a/run-command.h b/run-command.h
index 24ab5d63c4c..748d4fc2a72 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,22 +201,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/**
- * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
- * The further arguments correspond to the hook arguments.
- * The last argument has to be NULL to terminate the arguments list.
- * If the hook does not exist or is not executable, the return
- * value will be zero.
- * If it is executable, the hook will be executed and the exit
- * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
- */
-LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-
 /*
  * Trigger an auto-gc
  */
-- 
2.32.0.rc1.458.gd885d4f985c

