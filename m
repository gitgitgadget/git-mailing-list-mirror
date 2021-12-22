Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C4C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhLVEAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhLVD76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DDC061757
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso247000wmk.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYrrxyO7GpzNpIu9CAymevWAL9XN0Ai/pEcH2dxzW14=;
        b=Lg2i4GzIzGRvKkIISKqElpOvgJd0ZX5F/hECGg5AZYPlvQoDgdq5E+pa8mpsV95TQJ
         jT1wOzXtUUw6uim9igBYaKgtqYhv6dvh4Nw+EGMCxcAVfjo+mnI13x8y9Nx/B10yL9I/
         DZ3BbUplpszdVpfjad7LLklqAM0L4TkrmiecQVTYdbDIvzC+RCWqlWAb+WNlosK0Gy5f
         T9Z+LD+JZVj/1Mf9cHxIlX+EhxpkKWM+5aEpI0jSetTd+1PQ0U+2udjgQVk7nKWPA2LL
         rntp/mRtO01vf36M33/ZyXnwzyrSMm6dHWR0f/Pz4mhf0KjaOboqU0jvpRoYLe8azWHQ
         Pdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYrrxyO7GpzNpIu9CAymevWAL9XN0Ai/pEcH2dxzW14=;
        b=xIlxOM6YdDFb5trdmJFLsx21zPHVo7oJfd+5oaQ9gPPvZtNDfwC9FZ+2UIG4iPNQg1
         jPqBvh4f7Yb2hi7DmX7TES1Gik3hrx3Hl6jCV9Z9uL687rDRnADSyLGOFvvFSct+qGsN
         IlaqyAY+RVBST3AmFmIgD36FAhnsQFc+7RbY1duptBhsorUnHXGtsscFEaASv/OFwBz5
         watApaCzOL6Pb3PLt89uD2RIe/WN+NpohDR7f2sVQAL4P54PSZqMhvWmncBL3UDEjUck
         muWQD08plj56jwz2RqJw42/E1PgfRjQ+PvvmJIByXqHqe2SIAVBCQxCXQL1HL+Kkzr1w
         h+NA==
X-Gm-Message-State: AOAM532VCqodr8t6YeIP/MQv5cm7WJNwKfeOypvYOyRIhYBmJk3YLcXu
        TjQofgw5fX0jtItMxZqcrR8NR4anlHXZpg==
X-Google-Smtp-Source: ABdhPJxPSxP/CI5kAHwPOy2dte/5pP9IyuWaAjbaEM+9fAKbmYSwAa7owVn6X5Q7y7JLaqQmki8zig==
X-Received: by 2002:a05:600c:1d1c:: with SMTP id l28mr730642wms.69.1640145594631;
        Tue, 21 Dec 2021 19:59:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:54 -0800 (PST)
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
Subject: [PATCH v6 10/17] hooks: convert worktree 'post-checkout' hook to hook library
Date:   Wed, 22 Dec 2021 04:59:36 +0100
Message-Id: <patch-v6-10.17-bff7c1513ca-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
 builtin/worktree.c | 26 +++++++++++---------------
 hook.c             |  8 ++++++++
 hook.h             |  6 ++++++
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a396cfdc64e..6f03afad974 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,21 +382,17 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		const char *hook = find_hook("post-checkout");
-		if (hook) {
-			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
-			struct child_process cp = CHILD_PROCESS_INIT;
-			cp.no_stdin = 1;
-			cp.stdout_to_stderr = 1;
-			cp.dir = path;
-			strvec_pushv(&cp.env_array, env);
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
2.34.1.1146.gb52885e7c44

