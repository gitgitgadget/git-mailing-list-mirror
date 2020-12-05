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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EBAC19437
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8C622E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgLEBvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgLEBvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229CC08E85F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o13so4362343pjp.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LUxw/hFdF9lowPah09S7Zj467fY7yAG7wcNTSHnpxaE=;
        b=GBJRC2rWJpp3T02x873IbFrZOToRiJa8/0fgQ523BIUxfk2CopYp2rDrnr71e5HzYk
         /ctyudQJ15jEZ1QdFbKxGB13/LoqUSN63uMQpWd2JDKCWTuO9qeE8UaC56DEIwsFt7q4
         gpFL1HVygvPkvP68CAB0NRu9s7rbvD0UdbO7lxaHa08YN5IYTCTw4u/TvzF6P3JHKkQU
         I0Li8XRqck/5t6YnA+DEFUBCmGeOWfvTuBjP1eAclCIIyjYTJJVerW9X8gSe/XTkOF0e
         tMIApfEgd37Jck8wyOX/WdHos5fZKeL853uhTaG9mnnOuwqvmESaizHODoHAudcSAWDV
         PCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LUxw/hFdF9lowPah09S7Zj467fY7yAG7wcNTSHnpxaE=;
        b=grtVCiZ65/dpdnFjLSU5utDwhHE+did70/llChREmuDXW2j3ovEbmdav1YnbhAzRmk
         KkUImugD1svOnEoZPVzHhaf/WsUSM/HznhBg2sYMpnvMVPaYBGOMfTCdg1hck94F9hUk
         glAeW/BntbFTu5lpu2lAmuc6hzq9EMmNon3N+V2iKj5d4m8hbQCAacuwAiOryWgIuprf
         zgz9TKKjd94QuRGjQyFJJ87pAfMKWWBHVAzOT9+UlzJiI6z+HtVFy4UKnB/+FQeVYki5
         6AxxUIiELvsXH8p3/MAgj7SY/OzGGtGyoQ9Ph9LdgwbBLfV8l+0yfnHK3Qt/DNdLFbKq
         XwAQ==
X-Gm-Message-State: AOAM532qN5OaHgOlZEM4PzM1FYlPZNpndJ0xP+EVaDkxxIDl9aKVvCNb
        qwKtf4idg+WqXYTnrpgs9K6m4CDcEe8qEogbqxMG72lR7e0BzQGmT4Va8IDUpK4TUOB0XHjBQUf
        UtT8j71GOnwjOqkZW4DZgjFjTyyCfJS517ehgTzz5CnPGwg2gJPAsGaDPc7C+ROG+S11uxlRxEw
        ==
X-Google-Smtp-Source: ABdhPJwEHrzlzimhxLjPmnJQKcWPSDqpL1ko/fqTzUV7M6/bZP6nZd238D3QkoWpi96AtPnQkTMQok3BE8g1D4mVb7o=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a62:8388:0:b029:19b:816e:9cca with
 SMTP id h130-20020a6283880000b029019b816e9ccamr6624373pfe.31.1607133007311;
 Fri, 04 Dec 2020 17:50:07 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:37 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 09/17] hooks: convert 'post-checkout' hook to hook library
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
 builtin/checkout.c         | 16 +++++++++++-----
 builtin/clone.c            |  7 +++++--
 builtin/worktree.c         | 30 ++++++++++++++----------------
 reset.c                    | 15 +++++++++++----
 5 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8de512ee5d..14035ef725 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -224,6 +224,8 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+Hooks executed during 'post-checkout' will not be parallelized.
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b82119129..20966452b8 100644
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
@@ -104,13 +105,18 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
+	int rc;
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
-
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
+		     changed ? "1" : "0",
+		     NULL);
+	rc = run_hooks("post-checkout", &opt);
+	run_hooks_opt_clear(&opt);
+	return rc;
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..307336e576 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -771,6 +772,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_SYNC;
 
 	if (option_no_checkout)
 		return 0;
@@ -816,8 +818,9 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(&null_oid), oid_to_hex(&oid), "1", NULL);
+	err |= run_hooks("post-checkout", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct strvec args = STRVEC_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 197fd24a55..9a87c4c120 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "hook.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -455,22 +456,19 @@ static int add_worktree(const char *path, const char *refname,
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
-				     oid_to_hex(&null_oid),
-				     oid_to_hex(&commit->object.oid),
-				     "1", NULL);
-			ret = run_command(&cp);
-		}
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
+
+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+		strvec_pushl(&opt.args,
+			     oid_to_hex(&null_oid),
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
diff --git a/reset.c b/reset.c
index 2f4fbd07c5..e6bfaf67e1 100644
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
-			    oid_to_hex(orig ? orig : &null_oid),
-			    oid_to_hex(oid), "1", NULL);
+	if (run_hook) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
+		strvec_pushl(&opt.args,
+			     oid_to_hex(orig ? orig : &null_oid),
+			     oid_to_hex(oid),
+			     "1",
+			     NULL);
+		run_hooks("post-checkout", &opt);
+		run_hooks_opt_clear(&opt);
+	}
 
 leave_reset_head:
 	strbuf_release(&msg);
-- 
2.28.0.rc0.142.g3c755180ce-goog

