Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7196C47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75C7613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhE0AMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbhE0AL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BBC06138F
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so3713836ybp.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aoqljucL2LDctk2U9RJTSfIh18IB7ZyjcWgZzUGaKAE=;
        b=Ec4vFSUxq2uVWPJqx45e/PagaaJ/Dj92+gOLWRmuPBg9zYqYjMDVuOFvU0BICLuaSj
         splQeFpKDnGavjkctJ8zObmuh6vVVnqXiwLVjrgvXagkcbdmBZyWp/y2XLhLlWavGodu
         lJGPOtcPD/7dNG0rlwuhr4v21wM/jhOpKo0nRw+S4/nYXVlQFQe4GnZdMQ2BxSkMd1gS
         AqG5z5iNlriaj8X3kKB9X0X08y7VEP6kGybxWTEfjFKQXYEb5M4+dsYdwpuwn6cWU6zB
         TeDvZSOpqwv5LMHoYvTC3enStjw3Ie2l4xGaL+Zq/lZpe1J+GHWZaXT7s/nKoRqqk12Q
         vtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aoqljucL2LDctk2U9RJTSfIh18IB7ZyjcWgZzUGaKAE=;
        b=QbYFnaqNDxbjdeYaaKXtQcjFP0k6xtQI35ZdMfqGngpmo1I8r4WAVdgB75m2HoWFjc
         Oes8N56ijTKPRnnYVuhA2Zm6z/LXzbZip99nYjJ1fLJ7Ezwx6BgduQrY2Zq2xyfA8cxc
         HyceR+x76YCWAe/mXL6heFszRT60IV4YNH1MUpMWSk5/bo3FVCI0wK84av61T1yZgOHg
         Z6FVMUQhqC12IyTW2mvnllfmgrio4DpqRIA3JY/2afloUMBXG5JsFtJvQMsgbjmcFlMG
         rNvTypbwCqsC0edEklfrQFS0W8yoeVKKmXNOwbZXsNNxBqUr+fQvUDuADO9TG+k0Gs2b
         OmXg==
X-Gm-Message-State: AOAM530x9kV2kNROaM44c+NGYYlOE3JPEXX005Or9+dz44UrH3pu1i1N
        HRloVMJXYrTlVbbU8bD5Wgwk0js77DUJY/03ID89hiImnxiI7VlugepdHb0HsSUIG5atKHNWRYp
        tnbVbcPLV/D+jf8YrE+lPWr6L8jfOp3WjmuVlSVU9Azl7ir/mCb4VuMp2hQrTAqSpNCBzRE1XDQ
        ==
X-Google-Smtp-Source: ABdhPJykUXdjgjNWiaYC+zQipOvgILHrAXCGxDP5XVQfeAw2kHOAa6eEi5Q7xGVF6aTaROVk7yc7IRSuXCkhZ6dxyf8=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:b701:: with SMTP id
 t1mr871501ybj.348.1622074189337; Wed, 26 May 2021 17:09:49 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:44 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-26-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 25/37] hooks: convert 'post-checkout' hook to hook library
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the 'hook.h' library, 'post-checkout' hooks can now be
specified in the config as well as in the hook directory.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 ++
 builtin/checkout.c         | 19 ++++++++++++++-----
 builtin/clone.c            |  8 ++++++--
 builtin/worktree.c         | 32 ++++++++++++++++----------------
 read-cache.c               |  1 -
 reset.c                    | 17 +++++++++++++----
 6 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 17ffeebf07..6a5ff036ff 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -231,6 +231,8 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+Hooks executed during 'post-checkout' will not be parallelized.
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d3..1797f05a50 100644
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
@@ -106,13 +107,21 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt;
+	int rc;
+
+	run_hooks_opt_init_sync(&opt);
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
index eeb74c0217..2a2a03bf76 100644
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
+	struct run_hooks_opt hook_opt;
 
 	if (option_no_checkout)
 		return 0;
@@ -820,8 +822,10 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
-			   oid_to_hex(&oid), "1", NULL);
+	run_hooks_opt_init_sync(&hook_opt);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
+	err |= run_hooks("post-checkout", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct strvec args = STRVEC_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 976bf8ed06..017b2cfcb5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "hook.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -381,22 +382,21 @@ static int add_worktree(const char *path, const char *refname,
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
+		struct run_hooks_opt opt;
+
+		run_hooks_opt_init_sync(&opt);
+
+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+		strvec_pushl(&opt.args,
+			     oid_to_hex(null_oid()),
+			     oid_to_hex(&commit->object.oid),
+			     "1",
+			     NULL);
+		opt.dir = path;
+
+		ret = run_hooks("post-checkout", &opt);
+
+		run_hooks_opt_clear(&opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/read-cache.c b/read-cache.c
index 6a5c9403f4..ebb9c19056 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,7 +27,6 @@
 #include "progress.h"
 #include "sparse-index.h"
 #include "hook.h"
->>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use config)
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
diff --git a/reset.c b/reset.c
index 4bea758053..48d45f5b79 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -126,10 +127,18 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : null_oid()),
-			    oid_to_hex(oid), "1", NULL);
+	if (run_hook) {
+		struct run_hooks_opt opt;
+
+		run_hooks_opt_init_sync(&opt);
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
2.31.1.818.g46aad6cb9e-goog

