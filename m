Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B6EC77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjEIRyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjEIRyj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5633B46B5
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso4207645e9.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654862; x=1686246862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgsghEp6lwnkUbT3ybqUKM82cTbgMINyG9YEebhMH40=;
        b=YFNNllz/ks7HyykXG4stV7L+y3jQ1vm5L8XSCnG33AQ6XbS8ZqtuVy+k6Pc2Y+mMhJ
         YTOwaMZwU/5kGJHIcz3xH4pJF1nT+favLzbczaxsnafr52u1+ILOUjotiWSId4CMNh5t
         Ro/moI16B/quwTr0o5s2Ok/KFDbGL7m0KWRX8wxZ4KfgqkzXUU6zzPbVa40JWTKHpqs8
         xSvrm9FWiu0Ag25xjG1pDjZ0gFz4ZBB/EAyfPqzWdmNDe54eYLNy1fefop6D5oOAJNbq
         jEZHzbBvgk7tHtb2IXw5QeJ8aI5KbdhwhiTlAWzDPEEeYvXIaCeaOMBm97Pe4i8RzreC
         YSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654862; x=1686246862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgsghEp6lwnkUbT3ybqUKM82cTbgMINyG9YEebhMH40=;
        b=lDOx6B5Ly/0K+sNwuWiqFnaL9y/d24SRLOXjlHlAoH98FFWVl3hYrxbYP8Qt0//gob
         KhdeTf/tP0pzMmhA8WlazRB/bZPZEGRK4hPw/xb6MYsTCHeXwr7ldEYH3p6cj+oahbg+
         s+gVwPsylMLtFUYE84gjP/gduyxa5RiUcrjoNqLA51bOdpNNfWGnUFaVlZDV0YTjIkuO
         YCce0DJafeETBia2Q0JufeAOV07et+X6vLDjEq3QWyq7Q/aLxhuqs4pzFfMWU/hU41Ah
         Jltg45ENbVjZZp7tPXO7aelvxMsBH/RyYMm8WHy8hps0r2BBty7UARIKnWWxrsBD/Xjv
         4A5Q==
X-Gm-Message-State: AC+VfDzFSpjaCtDcTew7YTdNrn2/n/87bjlcBtZf0/amrVTecoCO2T1s
        78fayxjWJqtTzusQl4O6S00Wks7WA2c=
X-Google-Smtp-Source: ACHHUZ7cGuINxXWS9pIRq7gZ8x0g4F9wN/APp0BkxRyTq/DpjcOVXztwF7pXtA0IMjHjeuVKCy0q0Q==
X-Received: by 2002:a7b:cb57:0:b0:3f1:7a4a:7f9 with SMTP id v23-20020a7bcb57000000b003f17a4a07f9mr10258889wmj.7.1683654862335;
        Tue, 09 May 2023 10:54:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/15] replay: make it a minimal server side command
Date:   Tue,  9 May 2023 19:53:42 +0200
Message-ID: <20230509175347.1714141-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want this command to be a minimal command that just does server side
picking of commits, displaying the results on stdout for higher level
scripts to consume.

So let's simplify it:
  * remove the worktree and index reading/writing,
  * remove the ref (and reflog) updating,
  * remove the assumptions tying us to HEAD, since (a) this is not a
    rebase and (b) we want to be able to pick commits in a bare repo,
    i.e. to/from branches that are not checked out and not the main
    branch,
  * remove unneeded includes,
  * handle rebasing multiple branches by printing on stdout the update
    ref commands that should be performed.

The output can be piped into `git update-ref --stdin` for the ref
updates to happen.

In the future to make it easier for users to use this command
directly maybe an option can be added to automatically pipe its output
into `git update-ref`.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c                         | 79 ++++++++----------------
 t/t6429-merge-sequence-rename-caching.sh | 39 +++++++-----
 2 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6437633724..46f00a2d71 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -6,10 +6,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
-#include "cache-tree.h"
-#include "commit.h"
 #include "environment.h"
-#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
@@ -17,10 +14,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
-#include "sequencer.h"
-#include "setup.h"
 #include "strvec.h"
-#include "tree.h"
 
 static const char *short_commit_name(struct commit *commit)
 {
@@ -100,6 +94,7 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	pickme_tree = repo_get_commit_tree(the_repository, pickme);
 	base_tree = repo_get_commit_tree(the_repository, base);
 
+	merge_opt->branch1 = short_commit_name(last_commit);
 	merge_opt->branch2 = short_commit_name(pickme);
 	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
@@ -120,15 +115,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
 	const char *onto_name = NULL;
-	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct lock_file lock = LOCK_INIT;
+	struct commit *last_commit = NULL;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *head_tree;
 	struct merge_result result;
-	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
@@ -159,10 +151,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-	if (repo_read_index(the_repository) < 0)
-		BUG("Could not read index");
-
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
@@ -188,58 +176,45 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
-	merge_opt.branch1 = "HEAD";
-	head_tree = repo_get_commit_tree(the_repository, onto);
-	result.tree = head_tree;
+	result.tree = repo_get_commit_tree(the_repository, onto);
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *pick;
+		const struct name_decoration *decoration;
 
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		pick = pick_regular_commit(commit, last_commit, &merge_opt, &result);
-		if (!pick)
+		last_commit = pick_regular_commit(commit, last_commit, &merge_opt, &result);
+		if (!last_commit)
 			break;
-		last_commit = pick;
-		last_picked_commit = commit;
+
+		decoration = get_name_decoration(&commit->object);
+		if (!decoration)
+			continue;
+
+		while (decoration) {
+			if (decoration->type == DECORATION_REF_LOCAL) {
+				printf("update %s %s %s\n",
+				       decoration->name,
+				       oid_to_hex(&last_commit->object.oid),
+				       oid_to_hex(&commit->object.oid));
+			}
+			decoration = decoration->next;
+		}
 	}
 
+	/* Cleanup */
 	merge_finalize(&merge_opt, &result);
+	ret = result.clean;
 
-	if (result.clean < 0)
-		exit(128);
-
-	if (result.clean) {
-		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
-			    oid_to_hex(&last_picked_commit->object.oid),
-			    oid_to_hex(&last_commit->object.oid));
-		if (update_ref(reflog_msg.buf, branch_name.buf,
-			       &last_commit->object.oid,
-			       &last_picked_commit->object.oid,
-			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[2]);
-			die("Failed to update %s", argv[2]);
-		}
-		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
-			die(_("unable to update HEAD"));
-	} else {
-		strbuf_addf(&reflog_msg, "rebase progress up to %s",
-			    oid_to_hex(&last_picked_commit->object.oid));
-		if (update_ref(reflog_msg.buf, "HEAD",
-			       &last_commit->object.oid,
-			       &onto->object.oid,
-			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[2]);
-			die("Failed to update %s", argv[2]);
-		}
-	}
-	ret = (result.clean == 0);
 cleanup:
-	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_name);
 	release_revisions(&revs);
-	return ret;
+
+	/* Return */
+	if (ret < 0)
+		exit(128);
+	return ret ? 0 : 1;
 }
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 7670b72008..099aefeffc 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,8 +71,9 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		git ls-files >tracked-files &&
 		test_line_count = 2 tracked-files &&
@@ -140,7 +141,9 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls
@@ -198,8 +201,9 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 2 tracked &&
@@ -275,8 +279,9 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 4 tracked &&
@@ -451,8 +456,9 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
@@ -517,8 +523,9 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 3 calls &&
@@ -619,8 +626,9 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls &&
@@ -677,8 +685,9 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
-- 
2.40.1.491.gdff9a222ea

