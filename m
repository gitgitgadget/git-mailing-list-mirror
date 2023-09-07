Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2AEEC8743
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjIGQfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjIGQfI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:35:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5C3C04
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:34:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5029740cfd2so775720e87.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104417; x=1694709217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi9+HyN1lKSgcEhyhb3bm3DWDRvpTUHb9RSykj4q6IE=;
        b=V2ThirvGaTZBRuIUG8p2jZaycsn081k3KsfeQXI1Kp0jp7jFXpepIvHSv7YT7QQqoO
         yMfIipANi2Znm0hnAg2pS3VtMWu+tsl3siZOgGcvNwbKYOCcu8lWzB9v+/6yL8wSK/gb
         fbq8KMhlPmMLfv6zjW8QSAYrW7owcshuBdvZN+KGXw/oWMvzRFhgNApSs6aUXKbJJV0i
         rGBE+IC45Bmpb3bRNnK6FVYpKB+PqCtDfC+eve7KufMKOn1iTVemvIKWRXrVjhBue8WK
         TAakiok8iV0s+Nre1J9DNKTo35RAfYQs+VzTYKTU5KRWJLz0KzeJ+IZjKa93dm0eWoMu
         nCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104417; x=1694709217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi9+HyN1lKSgcEhyhb3bm3DWDRvpTUHb9RSykj4q6IE=;
        b=lWjwszKnOcsniJxuzl3WUjlVF4q7e0beFxo171VNoSqZNl6PowmqlWeMPcZP5YC8jr
         kjEn7o2/XC4RQ4MovLXBSgr7yzemBJgKBHjOkpG7rhLcwZW64Ul/ubhM8aiM5np7g3w9
         Etc4BxVprY2eEhPWl73ZzEqz35ehLsUTYKfmvT2IdrWNa2yuA467p2O1Fp/wdV2DV5yt
         14sSdW/ksVxV3aypcm/fG/STqFRQw+VnPud8ZrM0YhKlqjqnF5QwyefaL0HmTR5UaBoC
         8rmpZY2D9z7Vsj3WU8Klhc8xa+PyXa7pBenhLGpVtx76fdOyuqks2Oc1rpHhUJHaJ378
         H41A==
X-Gm-Message-State: AOJu0Yw+WmzdPaWIwR87md3BvvVAEtanCMyTZnykbTnaQziD5WNlFewe
        UC7Wjul6l+gGS8J4cb/gPsPrzp1hZXw=
X-Google-Smtp-Source: AGHT+IFndZwPh6yJLdjY1R7nnZzRbyD1MptcLc78pnpJmOPxOv3oRVqEv7fm5+mWrXyHR3m3t1o4fQ==
X-Received: by 2002:a5d:6d4d:0:b0:313:e953:65d0 with SMTP id k13-20020a5d6d4d000000b00313e95365d0mr4481640wri.28.1694078904497;
        Thu, 07 Sep 2023 02:28:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:28:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 10/15] replay: make it a minimal server side command
Date:   Thu,  7 Sep 2023 11:25:16 +0200
Message-ID: <20230907092521.733746-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
 builtin/replay.c                         | 78 ++++++++----------------
 t/t6429-merge-sequence-rename-caching.sh | 39 +++++++-----
 2 files changed, 50 insertions(+), 67 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index a2636fbdcc..e45cd59da1 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -6,11 +6,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
-#include "cache-tree.h"
-#include "commit.h"
 #include "environment.h"
-#include "gettext.h"
-#include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
@@ -18,8 +14,6 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
-#include "sequencer.h"
-#include "setup.h"
 #include "strvec.h"
 #include <oidset.h>
 #include <tree.h>
@@ -102,6 +96,7 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	pickme_tree = repo_get_commit_tree(the_repository, pickme);
 	base_tree = repo_get_commit_tree(the_repository, base);
 
+	merge_opt->branch1 = short_commit_name(last_commit);
 	merge_opt->branch2 = short_commit_name(pickme);
 	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
@@ -122,15 +117,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
 
@@ -161,10 +153,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-	if (repo_read_index(the_repository) < 0)
-		BUG("Could not read index");
-
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
@@ -190,58 +178,44 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.42.0.126.gcf8c984877

