Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E932BC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA16D60F24
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKATBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhKATAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C63C061220
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso143639wmc.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN0ZqfTQ5G7hfuaGyLYkRNvqVPSOuvNDbesgnKwcfqg=;
        b=CYGBPwSCnqFD52MZFY4zk+EfMmrdPWPo2PMzA1L6M/xzFv/9t7DgyGkMbOz10luHH2
         C5vMhFfG4YnImJmMCifEYPUCrQp4r4JYcv8of25LbviGYjshPZd4UU10s3eOMp0I0lW2
         W9YeFIjmPMm2H7Qb8lVaSAUfgqFt82mNTu7FyzDtezDm1GHRxb1IXFwGTgYla/uNNw9R
         o1PfmLK7HRIxWKxz67p7/lL2PV6Yq/XpC4Jknab3un1zv1SkBbRAuARZ3Wquk83fCS19
         NlSHIEFFaTxc03bGc5rOZ5O9JIetApwAw+1g68ZSfI47eaOCntDrXxlE8iKUxFJZa387
         ePBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN0ZqfTQ5G7hfuaGyLYkRNvqVPSOuvNDbesgnKwcfqg=;
        b=Fn9IKzyQH2wICY1fFnK2eg7Mr0fkIDxVveXIwPZ197QCJNzi0puER41BpZddgox5pF
         JLwB/QWUtZsLzLs9BlfVN3UZ7vVibpE7g1dL9URI5ssLhHVQmRvGhic/PrjjlaHisxY+
         FhT78oPnyCUmN9ePNWaovKY7G0GPuGRkdemjY5gHt+NERVLBLfKMIxFOUF6OiYlrRb/H
         NU8cOR/DM7VvrVwttCGdQe57hSluQ+Ng06BUJ8ZHz109rowjGGcNvd94npWUwMRqMfn/
         FXe71HG8I959a0U+/loFBhFI6dhqJcGq9iSSkXEy0b01sURjcGh27QKPmHZlqU+TwbKM
         Mu9A==
X-Gm-Message-State: AOAM5323/4E0VLe0diGUhguhFIFNMshJfJfuMUhmnt6A0rp66r536Aee
        wXbdNVhYgbtis4SpMbNTAQ1zMbMZIy0uCbmr
X-Google-Smtp-Source: ABdhPJy0mk4EN4YPi7zHhLrzx61Tr4N7x/Wo1oGF5nPIuGgtgS0sn0QoIF3cqDVwW6QSBCha5hTrXA==
X-Received: by 2002:a05:600c:3508:: with SMTP id h8mr880377wmq.122.1635792992707;
        Mon, 01 Nov 2021 11:56:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/17] hooks: convert worktree 'post-checkout' hook to hook library
Date:   Mon,  1 Nov 2021 19:56:15 +0100
Message-Id: <patch-v4-10.17-f330600fec8-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
index cf6d099f83a..95f5b926354 100644
--- a/hook.c
+++ b/hook.c
@@ -57,6 +57,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
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
2.33.1.1570.g069344fdd45

