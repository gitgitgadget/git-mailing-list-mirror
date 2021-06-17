Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AAAC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BA861245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhFQKZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhFQKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB2C061767
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb6so8906655ejc.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMzAH59OIj9FTzeiEnLJdGcEqzfCjHVnSrjGAjZbwB8=;
        b=McwNcQ7hY90XmfFWK4SavgJ0jgTjp7qNL9BeZOUFW6pHfww2wsH6cIICFkI8KkDwfL
         C20+L3Hw1ymeYykkpuMprngelamHLTL6h3GeEdyw9p2lkixbYQx73oFXzBkkZrvANaFG
         ZW2diHRNnMGPwWeXr2eG7j5fs3Qh8KRcIdjec7YrCw1rl+XTn5IIQn6J8fWmnHBdceNB
         fkEhrSxf/qZ/3va/i2hGfvxhvnLfRWLdqmxv+NN/5w6n0JSoGfFrbAWABAkK+j0bbVSR
         8k1D6TwPJGUBmlEYpLB4nI/dmBU2b2JLfjYZgW5s9YqIjttw3Fd2Fr49SE4+Qz8mM2OS
         sB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMzAH59OIj9FTzeiEnLJdGcEqzfCjHVnSrjGAjZbwB8=;
        b=Yjp9Sut8Ro8z7MdeWPoh1/ZBgjI8ILRz7foHBT2slzgqzOgn4/tyYzxH3S6HWAkKS6
         xVXGWZJFiL1BlUwLfMiMXaFJXj0SYJx51WxMYTg6CxQ/ZvShv2WTA9ab+n2ZYMlXctJp
         u1+lmzIcVLhcHlSgA8IaoRiRG4cUUnQIz+oPaR5zt9c7UcWy3ztaCYjgVne/LgLzJnkC
         jKFfF4GvwctgEQ0HNQYwJVppD+pLGEJPOh2unLGdVfuUhH6POnA4M/nR5aQWGIkjqYLO
         s2kUGQvzzoOgfDFqpHZ4sDzV+PEKtjvF3BJO0mhfRwt83WeV7hmw3HgmXwPcm0JRbqKu
         bmgA==
X-Gm-Message-State: AOAM531Xwqsh9VIqQl2uhRmefbzJQv4pcmbr2CeCtTCfcR+KDtmOeoYh
        NokiSbY+5SFJWK5rbfdLpiZbEyktLOIpqw==
X-Google-Smtp-Source: ABdhPJwCNAL/HhWibIa31cBEBi8Mpp8Rnv5fHomOOjMDOV2A+L0ls4wI7k79aj///njTeMvbs8q0tA==
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr4331305eje.549.1623925392902;
        Thu, 17 Jun 2021 03:23:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:12 -0700 (PDT)
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
Subject: [PATCH 05/27] hooks: convert 'post-checkout' hook to hook library
Date:   Thu, 17 Jun 2021 12:22:39 +0200
Message-Id: <patch-05.27-32eec5dc2f-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
 builtin/checkout.c | 17 ++++++++++++-----
 builtin/clone.c    |  7 +++++--
 builtin/worktree.c | 30 ++++++++++++++----------------
 hook.c             |  8 ++++++++
 hook.h             |  9 +++++++++
 read-cache.c       |  1 +
 reset.c            | 15 +++++++++++----
 7 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d3..6205ace09f 100644
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
@@ -106,13 +107,19 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	int rc;
+
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
-
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
+		     changed ? "1" : "0",
+		     NULL);
+	rc = run_hooks("post-checkout", &opt);
+	run_hooks_opt_clear(&opt);
+	return rc;
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..de57a3119b 100644
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
@@ -820,8 +822,9 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
+	err |= run_hooks("post-checkout", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct strvec args = STRVEC_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b1350640fe..2ad26a76f4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,22 +382,20 @@ static int add_worktree(const char *path, const char *refname,
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
+		ret = run_hooks("post-checkout", &opt);
+
+		run_hooks_opt_clear(&opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/hook.c b/hook.c
index 4d87e98255..cb39404ac8 100644
--- a/hook.c
+++ b/hook.c
@@ -89,6 +89,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
+	cp->dir = hook_cb->options->dir;
 
 	/* add command */
 	strvec_push(&cp->args, run_me->hook_path);
@@ -135,6 +136,7 @@ static int notify_hook_finished(int result,
 int run_found_hooks(const char *hook_name, const char *hook_path,
 		    struct run_hooks_opt *options)
 {
+	struct strbuf abs_path = STRBUF_INIT;
 	struct hook my_hook = {
 		.hook_path = hook_path,
 	};
@@ -143,6 +145,10 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 		.hook_name = hook_name,
 		.options = options,
 	};
+	if (options->absolute_path) {
+		strbuf_add_absolute_path(&abs_path, hook_path);
+		my_hook.hook_path = abs_path.buf;
+	}
 	cb_data.run_me = &my_hook;
 
 	if (options->jobs != 1)
@@ -155,6 +161,8 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 				   &cb_data,
 				   "hook",
 				   hook_name);
+	if (options->absolute_path)
+		strbuf_release(&abs_path);
 
 	return cb_data.rc;
 }
diff --git a/hook.h b/hook.h
index dcc2cc2112..8bd0fc8d1f 100644
--- a/hook.h
+++ b/hook.h
@@ -36,6 +36,15 @@ struct run_hooks_opt
 	 * implicit 1 for now.
 	 */
 	int jobs;
+
+	/* Resolve and run the "absolute_path(hook)" instead of
+	 * "hook". Used for "git worktree" hooks
+	 */
+	int absolute_path;
+
+	/* Path to initial working directory for subprocess */
+	const char *dir;
+
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/read-cache.c b/read-cache.c
index 77961a3885..af5b97104c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,7 @@
 #include "progress.h"
 #include "sparse-index.h"
 #include "csum-file.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
diff --git a/reset.c b/reset.c
index 4bea758053..e6af33b901 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -126,10 +127,16 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
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
+		run_hooks("post-checkout", &opt);
+		run_hooks_opt_clear(&opt);
+	}
 
 leave_reset_head:
 	strbuf_release(&msg);
-- 
2.32.0.576.g59759b6ca7d

