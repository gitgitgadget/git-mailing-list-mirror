Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383633095
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcJltsJA"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6B187
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4079ed65471so56372145e9.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058840; x=1700663640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXL7yXRIHo5odRBwXpC0m0+J+flilNCNgYaQrjDxz1Y=;
        b=DcJltsJAgnNdvw/lF8IQJVBGKnT2nG3ogs03+NP4RNyNsJ0Zf5UwjGyoyzAZOXacP1
         av7BowHbdXtIz5m7Qypp5fibSxFUoet9etuobEzjxqouIbAASYv68gmSgjeyYxiWfO8B
         TUTrls5b0N+pD97RzykIafTl7ebTLlM0j00XnMkyvAUISxxRyno4SQiKKqg7+z04PI+x
         5RVqo3p2BAKevYkb2Xq4g3SIyK+tAMSXqkKJ5dMsQZV7I0mgfw9D5IGuX08tqHDGFpCB
         KeZyvvIHN2dYcFuVlmMljikZB6R+p7aEnycWqWN1QNE1kJ6bBlbjnuxv1zzPbVolArm3
         2RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058840; x=1700663640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXL7yXRIHo5odRBwXpC0m0+J+flilNCNgYaQrjDxz1Y=;
        b=gkgql8fGeRZ7NScLxglqLeIdbH7h/yXEjjuSy1BLxdP1kk/P3uEE1oDxSK9tB/TObl
         eJG0WZljl1+5qk58VFNcukkhNEQ0mEM+aD3bniRgx0M2r0ayLq7ssiBSOxuCsQSZEIMN
         4LZL0f4miAmEaI91yw2uPrMv4ghnmqtuIi20CndycWPwh/X3SPmqf5rJnJAkAXtHxBdj
         nOSnXll4Wo0PiM19lsJl9zZSHfJ3XycFSrdT3NePBBvASsyibAjxKPSNKBfBL6FZnTPx
         LotHaFH9hX26i0kDXBkFbcRZWC5sQ17PAZFYk731au+ZxiiRjpFCc5SCpb/goT2EDOZC
         Alug==
X-Gm-Message-State: AOJu0YwjsaeW0iNviAbgy9z9Ng4xMV2xIWcarxRNSUN7d2ZYsj2mrl13
	owq4ExJ2Qutvf52wMVDqH9WLUkHabWc=
X-Google-Smtp-Source: AGHT+IFDgq9AI2dPK6kgrPJeJuyVJXkxCE7bGDKIqWLjY2AfgrdnzHDmK4DfjvwsGaX4hOQ927juEg==
X-Received: by 2002:a05:600c:3111:b0:405:36d7:4582 with SMTP id g17-20020a05600c311100b0040536d74582mr8535041wmo.15.1700058840288;
        Wed, 15 Nov 2023 06:34:00 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:58 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 10/14] replay: make it a minimal server side command
Date: Wed, 15 Nov 2023 15:33:23 +0100
Message-ID: <20231115143327.2441397-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 Documentation/git-replay.txt             |  5 +-
 builtin/replay.c                         | 78 ++++++++----------------
 t/t3650-replay-basics.sh                 | 19 +++++-
 t/t6429-merge-sequence-rename-caching.sh | 39 +++++++-----
 4 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 0349058b66..87a85a7f57 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -15,7 +15,10 @@ DESCRIPTION
 -----------
 
 Takes a range of commits, specified by <oldbase> and <branch>, and
-replays them onto a new location (see `--onto` option below).
+replays them onto a new location (see `--onto` option below). Leaves
+the working tree and the index untouched, and updates no references.
+The output of this command is meant to be used as input to
+`git update-ref --stdin`, which would update the relevant branches.
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
diff --git a/builtin/replay.c b/builtin/replay.c
index 30292d219d..73a25e9e85 100644
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
@@ -227,58 +215,44 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index b5b9f9ade2..3567c98362 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -47,12 +47,29 @@ test_expect_success 'setup' '
 	test_commit C.conflict C.t conflict
 '
 
+test_expect_success 'setup bare' '
+	git clone --bare . bare
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1 topic2 >result &&
 
+	test_line_count = 1 result &&
+
 	git log --format=%s $(cut -f 3 -d " " result) >actual &&
 	test_write_lines E D M L B A >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse topic2 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
+	git -C bare replay --onto main topic1 topic2 >result-bare &&
+	test_cmp expect result-bare
 '
 
 test_done
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
2.43.0.rc1.15.g29556bcc86

