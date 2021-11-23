Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E3C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhKWLtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbhKWLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE42C0613F4
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2325393wmc.2
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAsytXaxXjOs1TERHWkOTicdxYVnof0YOd+nc8NYEG4=;
        b=Pt9O/EN3vI5H3F5gKFfqwe6/gTxYyBBuxDJ8MqONkER+1o7494Nf31LMpfU/BwgX7Z
         9avpr6pbijpta3BvbMXZfEkX+DMGewMcCSI9hQSV0kli2BxRjO8Eo8YTDxUWoTX9HYuP
         yXfIhOsXwhe6Wj6V8cT6oUOH0GhU13X9g98lhYmhomvRnPefVAKatznN3wS8kbu9q/1s
         fOADzx5Ko1VbgqLm+fIpRyuAsMSPy9WI/nar7MHv+rpvM9/Qq5lRa0yA9+VILBcnmoLN
         SdGZn27dLgg2Qb7B6A64/0fkmb3GIjkINL32snFKye8dNyTcA/0FNbLEXedRrWX6gSsH
         TUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAsytXaxXjOs1TERHWkOTicdxYVnof0YOd+nc8NYEG4=;
        b=z/pc3zteXwe1Xn8ju2Qd67HVm/sWLc5xESbFYU1AtJurJga+ZeH6YWp4qeHVHBbh4o
         xcBxZjNxSCYyTW6PwrECDTEx64hG2duAA+fFDA8NAo4odhcM0WKCyU3yUD31SB9ks3tJ
         wIGYNGlM87+8t6tKKe6crnPFEDmrG8UZxSBagZSMYKAODdga0qCRf2nPT9QiKnAUURAd
         fA8dKBglslAsxD6vWJEmwXb/5g7CUz452p/czGC/0TMi+9HBpjpI6cLyYB/c7Qaf0BWj
         EwXEydX3PYx+Ss8zeISpoR2yBHiul45SyJYuey275elsR550eqNlABUf9Fe8NFg/W6mV
         LdZA==
X-Gm-Message-State: AOAM531BwnPWzswYdC0C+lA0ZHZqxCX7fk8vuphNxQW/c9enais9KadQ
        +bFG+Auzd66cV5z96FBw98ykdjB6PrtWOQ==
X-Google-Smtp-Source: ABdhPJxYcrPB6uMogrroImrLk5x1JRDotnai2YdVGu0Qm6y+ozZ4Zi1shvQ5CuJYEl/qF4mMm44dxw==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr2367701wmq.122.1637667989322;
        Tue, 23 Nov 2021 03:46:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/17] hooks: convert worktree 'post-checkout' hook to hook library
Date:   Tue, 23 Nov 2021 12:46:09 +0100
Message-Id: <patch-v5-10.17-b7599be95a7-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the running of the 'post-checkout' hook away from run-command.h
to the new hook.h library in builtin/worktree.c. For this special case
we need a change to the hook API to teach it to run the hook from a
given directory.

We cannot skip the "absolute_path" flag and just check if "dir" is
specified as we'd then fail to find our hook in the new dir we'd
chdir() to. We currently don't have a use-case for running a hook not
in our "base" repository at a given absolute path, so let's have "dir"
imply absolute_path(find_hook(hook_name)).

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 27 +++++++++++----------------
 hook.c             |  8 ++++++++
 hook.h             |  6 ++++++
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..4d9df5ecc4c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,22 +382,17 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		const char *hook = find_hook("post-checkout");
-		if (hook) {
-			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
-			cp.git_cmd = 0;
-			cp.no_stdin = 1;
-			cp.stdout_to_stderr = 1;
-			cp.dir = path;
-			cp.env = env;
-			cp.argv = NULL;
-			cp.trace2_hook_name = "post-checkout";
-			strvec_pushl(&cp.args, absolute_path(hook),
-				     oid_to_hex(null_oid()),
-				     oid_to_hex(&commit->object.oid),
-				     "1", NULL);
-			ret = run_command(&cp);
-		}
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+		strvec_pushl(&opt.args,
+			     oid_to_hex(null_oid()),
+			     oid_to_hex(&commit->object.oid),
+			     "1",
+			     NULL);
+		opt.dir = path;
+
+		ret = run_hooks_opt("post-checkout", &opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/hook.c b/hook.c
index 1ad123422b2..69a215b2c3c 100644
--- a/hook.c
+++ b/hook.c
@@ -57,6 +57,7 @@ static int pick_next_hook(struct child_process *cp,
 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
+	cp->dir = hook_cb->options->dir;
 
 	strvec_push(&cp->args, hook_path);
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
@@ -109,6 +110,7 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 
 int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 {
+	struct strbuf abs_path = STRBUF_INIT;
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
@@ -130,6 +132,11 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	}
 
 	cb_data.hook_path = hook_path;
+	if (options->dir) {
+		strbuf_add_absolute_path(&abs_path, hook_path);
+		cb_data.hook_path = abs_path.buf;
+	}
+
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
@@ -139,6 +146,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 				   hook_name);
 	ret = cb_data.rc;
 cleanup:
+	strbuf_release(&abs_path);
 	run_hooks_opt_clear(options);
 	return ret;
 }
diff --git a/hook.h b/hook.h
index 54528395953..18d90aedf14 100644
--- a/hook.h
+++ b/hook.h
@@ -12,6 +12,12 @@ struct run_hooks_opt
 
 	/* Emit an error if the hook is missing */
 	unsigned int error_if_missing:1;
+
+	/**
+	 * An optional initial working directory for the hook,
+	 * translates to "struct child_process"'s "dir" member.
+	 */
+	const char *dir;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.34.0.831.gd33babec0d1

