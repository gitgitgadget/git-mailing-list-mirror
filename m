Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C1BC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0646101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhJLNdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhJLNdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7CC06174E
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a25so65268208edx.8
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmOzkmvYJAHGeV9locM1gpM9LYZf5E8OArUGc1uLP68=;
        b=T4Wos4v767gXxILYAwkoMbgWqP6jvjXA8ShXb6Md3nDpKpG6Yvl0EXTSC2WrySjznw
         y2O59zwpjO0wOdkfjLYc6Kn3LgZl5OKIlO3ymF+Bv0HwyN/8lJbBaGSqZW5BW96E1dul
         u6qGJqVCD+IjQlixMPpH8RAPOJltUeYBesOjbSAdz1OSZayyo1hrtay2N2kCxrGZ91bH
         3sjuz27rPz6KPO9tXJNDujTdQg39Skol4mwjeW0CqHB+74siKGy9y0jOnTz1B+EdfNYn
         1Z9UDtJlKObyCjBrxCTtF/iBraEnh6Zqid0ydq9nrURZmAqItO4IKNBCYCAfLAj2lLRO
         9yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmOzkmvYJAHGeV9locM1gpM9LYZf5E8OArUGc1uLP68=;
        b=wN0AF41pqSMIgEBRu6Ri6XNeB44rBz9PQN3PLQ92jO8Tm5SOKjlW8wF2NSOLcv26e3
         e69dAdnNNYYtFbO3IvPQRwWBSkKCuUnIg2VNIS8TJa+4rJAmeXvIU9gyRYoTk+SFUxaN
         P86gPUKtPy7hDKtyWnCupjlmCURngIgsi4Zx9LpdCMbRuv5O1v/o1+0eD15SXWDzjyVW
         ccsXRupXE5j3GFSHZ8unkS/i248yy7+B+ryM4QffwMlthM2udmP5Zb1mt4KOcVINhYVJ
         h0cbmEp3rdUNxq8sm7XiPOXHar6S6xTrBBQAhFjmy98jbItIDgZNrIFvRP2aUUNpznAi
         JyPQ==
X-Gm-Message-State: AOAM531Cduxboj1gKLF+Hwy0I42OPm63s+pVtzaYUE9fWPzCjpql3VJ3
        xjLubEa/3VFhFGwk7F1Dqw6qZSfCqdSEmg==
X-Google-Smtp-Source: ABdhPJwArKTXjxId9BWRR163vnXUTe78/qhNN0OVHdArPKvkgkU1kV8PlxKyMWv1Ra4TOi5mtBOJEw==
X-Received: by 2002:aa7:c945:: with SMTP id h5mr51092643edt.350.1634045461621;
        Tue, 12 Oct 2021 06:31:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/13] hooks: convert 'post-checkout' hook to hook library
Date:   Tue, 12 Oct 2021 15:30:30 +0200
Message-Id: <patch-05.13-15d71fc210b-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the running of the 'post-checkout' hook away from run-command.h
to the new hook.h library. For "worktree" this requires a change to it
to run the hooks from a given directory.

We could strictly speaking skip the "absolute_path" flag and just
check if "dir" is specified, but let's split them up for clarity, as
well as for any future user who'd like to set "dir" but not implicitly
change the argument to an absolute path.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 14 +++++++++-----
 builtin/clone.c    |  7 +++++--
 builtin/worktree.c | 28 ++++++++++++----------------
 hook.c             |  9 +++++++++
 hook.h             |  9 +++++++++
 read-cache.c       |  1 +
 reset.c            | 14 ++++++++++----
 7 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72a..555119cc322 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
+#include "hook.h"
 #include "ll-merge.h"
 #include "lockfile.h"
 #include "merge-recursive.h"
@@ -106,13 +107,16 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
-
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
+		     changed ? "1" : "0",
+		     NULL);
+	return run_hooks_oneshot("post-checkout", &opt);
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index c9d4ca26640..4b356770739 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -659,6 +660,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	if (option_no_checkout)
 		return 0;
@@ -704,8 +706,9 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid),
+		     "1", NULL);
+	err |= run_hooks_oneshot("post-checkout", &hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct strvec args = STRVEC_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..330867c19bf 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,22 +382,18 @@ static int add_worktree(const char *path, const char *refname,
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
+		opt.absolute_path = 1;
+
+		ret = run_hooks_oneshot("post-checkout", &opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/hook.c b/hook.c
index bfdc79e2f1a..186c249bbec 100644
--- a/hook.c
+++ b/hook.c
@@ -63,6 +63,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
+	cp->dir = hook_cb->options->dir;
 
 	/* add command */
 	strvec_push(&cp->args, run_me->hook_path);
@@ -116,6 +117,7 @@ static int notify_hook_finished(int result,
 int run_hooks(const char *hook_name, const char *hook_path,
 	      struct run_hooks_opt *options)
 {
+	struct strbuf abs_path = STRBUF_INIT;
 	struct hook my_hook = {
 		.hook_path = hook_path,
 	};
@@ -129,6 +131,10 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->absolute_path) {
+		strbuf_add_absolute_path(&abs_path, hook_path);
+		my_hook.hook_path = abs_path.buf;
+	}
 	cb_data.run_me = &my_hook;
 
 	run_processes_parallel_tr2(jobs,
@@ -139,6 +145,9 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   "hook",
 				   hook_name);
 
+	if (options->absolute_path)
+		strbuf_release(&abs_path);
+
 	return cb_data.rc;
 }
 
diff --git a/hook.h b/hook.h
index a2b8d4fc6bd..7a858a6beed 100644
--- a/hook.h
+++ b/hook.h
@@ -14,6 +14,15 @@ struct run_hooks_opt
 
 	/* Args to be passed to each hook */
 	struct strvec args;
+
+	/*
+	 * Resolve and run the "absolute_path(hook)" instead of
+	 * "hook". Used for "git worktree" hooks
+	 */
+	int absolute_path;
+
+	/* Path to initial working directory for subprocess */
+	const char *dir;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/read-cache.c b/read-cache.c
index a78b88a41bf..9773118d078 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -28,6 +28,7 @@
 #include "sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
diff --git a/reset.c b/reset.c
index 79310ae071b..1237ced8a58 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -125,10 +126,15 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : null_oid()),
-			    oid_to_hex(oid), "1", NULL);
+	if (run_hook) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		strvec_pushl(&opt.args,
+			     oid_to_hex(orig ? orig : null_oid()),
+			     oid_to_hex(oid),
+			     "1",
+			     NULL);
+		run_hooks_oneshot("post-checkout", &opt);
+	}
 
 leave_reset_head:
 	strbuf_release(&msg);
-- 
2.33.0.1567.g7b23ce7ed9e

