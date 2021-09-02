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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A9C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C7F6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbhIBNNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345082AbhIBNMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93891C0613C1
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1124024wme.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6lLU7KPI7myWBptiKDozkWIaYddu8OyRR5UIjYaeXY=;
        b=ToSqp71VnXiTJLk0CvFyBdH3piJT/O7PiHtXVX3h+D4BwrPhSH1FgUNxawUfkpZSJg
         ovTsJoKJf7uR7rynWM/EmZ4W24SYFku8l9KyUBC0BuMUsVgtjZ2xejGKjUAixKFVoFVd
         s4iydh1ZBKQ3gTP5kYA4F9QR3fPQSFb7VHIAN0Jx+9Jxe7mSeCXGkhJ3c3mUyf0rSYI9
         n5W0AJTFKYp4C+tf+s/i+FOs77yzkfUzIjyDWBZVgcP7vinZwYHPFoAzCLgC4o9iB/GN
         sjKx6WHQfxM+K/WPhNZvA88ntbPXL+UE+3RexTVkDRLr9PN7cA4zPMJIo3a5dAgD5v6J
         33pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6lLU7KPI7myWBptiKDozkWIaYddu8OyRR5UIjYaeXY=;
        b=ggYzKBkwUOxAmdWXdehR5aOsRGUV4FQWw7cMutn3g0DP+VrdUpSv+ts7F/4WkzD5TI
         ZwrQiAw9XWTINaJV213UaTN2LiWWbMLgqlvBkh0AzzyVVTXTl3DxKf10hL7Dbg9Y32X8
         CVgH+Yl7cD0YHerYRcN9oq9q5mQ60MIDt8oQfk06IumCKoRpoWoOkgnTS9I/B15Arv7D
         1ydc3QtJ9g0fhuip8BO09uJ7Hnb/Hq24RC5h/S0Z2rO8ObjC5KEWoXCLGiz33jJTSLxq
         qqcj0Ln93ZHLlYvNSIqlpPjFKCrRD11PQj1ImSY9PD3BIJqQfjXg5bgnMFnj9Jk/bEDd
         h71A==
X-Gm-Message-State: AOAM531mAadWdQTY3IvE6dWsPMxxzDjfByJ4H14unGIPwgB5IuT/5AY+
        eYPzXBwuFB2Ljn+yhRuyk8Cf71wW/FmlWw==
X-Google-Smtp-Source: ABdhPJw6XOgNZidNKefzyy8B7e4U30bP485iIUlvCCOYYMzairkMw7vIcs8N230xH4crycl7Vy/AwA==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr3076787wma.125.1630588314778;
        Thu, 02 Sep 2021 06:11:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:54 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/36] hooks: convert 'post-checkout' hook to hook library
Date:   Thu,  2 Sep 2021 15:11:12 +0200
Message-Id: <patch-v5-12.36-fed0b52f88f-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 builtin/clone.c    |  6 ++++--
 builtin/worktree.c | 28 ++++++++++++----------------
 hook.c             |  9 +++++++++
 hook.h             |  9 +++++++++
 read-cache.c       |  1 +
 reset.c            | 14 ++++++++++----
 7 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a7..863b02a7d7c 100644
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
index 66fe66679c8..27fc05ee511 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -775,6 +776,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	if (option_no_checkout)
 		return 0;
@@ -820,8 +822,8 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
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
index 1776895289e..8a923e52c1b 100644
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
index b7a106a6e2b..3edd937e198 100644
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
index 9048ef9e905..7a9ffea0885 100644
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
2.33.0.816.g1ba32acadee

