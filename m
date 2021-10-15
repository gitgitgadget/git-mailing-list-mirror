Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47783C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29015610D2
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhJOJqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbhJOJp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542CC061765
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y3so25584159wrl.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grqogRcxdukXT1xsEqyVnqrlN/YZMLx1apYNqw0nb7w=;
        b=DANoj6aORGPUMwihXLtFMCU0/asSYm0rie/VG/yOcS/2RtNCef4Bm7yyXlXI8KcGqu
         ms4KAbPVhATKtUMvAy62oq3WhZvKfz8dui+c6IFuEKKUOBrRytTYQ/ZjmTJ1YVH4XCa7
         WvTlIYLiVTrANRZvj4ZBPlcYVkupBdo++9/xssf1UjTMUnQZDDiNp6uc6Yn8kOatSuJT
         On1sE+HWhLhSnnnxeUSdF5foUiqii4oKAozq2Ql/BuC+1Ynz1QZmQIz5YZ9PPF8tZp9v
         JSES0W0x6yLEZyEAoTAyH+tAxZGGwOrh6cpFUiHUu1wMa9P7YtxahTrFWpChKatNMm+p
         ecgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grqogRcxdukXT1xsEqyVnqrlN/YZMLx1apYNqw0nb7w=;
        b=hPKvL/jHhhu+5o97jtwIQSUQvRZixkEcj9BAdgjSj41HlP3ZbHac+C04/Km+uJ02DL
         A9KRcARtP5F04v0h6pxhWeyiYaHcGDkDuyuqbB5dgirO7ComE8ltKgPB+56bWg0/cRJq
         9cNC1s2dWdwLI0QLnNQmOz2abG+y7NNh/1dfwsu1SkSLgaq6c9ea0kevvmYzNgcqdx3X
         ymEe+pGSEhtBnr+hYEuSKS7I6cCy0/RGO6B4SjZf+NbfCHmq0oOP2ys05YjehiT/Zbrv
         fayuJW58YBWkp5bMxiADLjodr8MPQcn91ba5ksRm0st0jj8RfatMeZqiYNdLPitd7Mbz
         QSTA==
X-Gm-Message-State: AOAM530XkGEiWVF6id4gnbj+KDsvfNLak5ewO0p9EEbAt5GOvfJcm8qd
        gav45PTFpRW6DWOkYUty/v3y5Zr8kFGZdw==
X-Google-Smtp-Source: ABdhPJwch96ntHlh/SoIlbBRz/YNxzjV8PKm1mIBOyWSCCtzcqTWEYJtnIgsRrgxjd8NMoWxEpmcZA==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr12941110wrr.409.1634291029777;
        Fri, 15 Oct 2021 02:43:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:49 -0700 (PDT)
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
Subject: [PATCH v2 05/13] hooks: convert 'post-checkout' hook to hook library
Date:   Fri, 15 Oct 2021 11:43:33 +0200
Message-Id: <patch-v2-05.13-a4df96c1719-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
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
 hook.c             | 10 ++++++++++
 hook.h             |  9 +++++++++
 read-cache.c       |  1 +
 reset.c            | 14 ++++++++++----
 7 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..54cbba821a8 100644
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
index 559acf9e036..53ca5ca0eb2 100644
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
@@ -705,8 +707,9 @@ static int checkout(int submodule_progress)
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
index 9951015dc66..756f549e5b2 100644
--- a/hook.c
+++ b/hook.c
@@ -63,6 +63,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
+	cp->dir = hook_cb->options->dir;
 
 	strvec_push(&cp->args, hook_path);
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
@@ -110,6 +111,7 @@ static int notify_hook_finished(int result,
 int run_hooks(const char *hook_name, const char *hook_path,
 	      struct run_hooks_opt *options)
 {
+	struct strbuf abs_path = STRBUF_INIT;
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
@@ -121,6 +123,11 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->absolute_path) {
+		strbuf_add_absolute_path(&abs_path, hook_path);
+		hook_path = abs_path.buf;
+	}
+
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
@@ -129,6 +136,9 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   "hook",
 				   hook_name);
 
+	if (options->absolute_path)
+		strbuf_release(&abs_path);
+
 	return cb_data.rc;
 }
 
diff --git a/hook.h b/hook.h
index 9e4d10df63e..252a605b125 100644
--- a/hook.h
+++ b/hook.h
@@ -9,6 +9,15 @@ struct run_hooks_opt
 
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
index f214df3d96c..4234dd345db 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -126,10 +127,15 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
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
2.33.1.1338.g20da966911a

