Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428991F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeGABZ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:27 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32897 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeGABZU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:20 -0400
Received: by mail-ot0-f193.google.com with SMTP id h6-v6so13857725otj.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKJgZ6/TZivMgfA7M0b8QxunsvdewLvDcn8nYNDkyF8=;
        b=IB4du+bSkRX0Hnz2kbyahsUuDO9f4rH2cGK/OBo/oKE9bBYOczy27sLifnr6LA4AAi
         xEzRQH+zCl3fKiCA1XOVSZHRVgPuZHhWTcuyNUURyt7s8qbcjEXLxT5NJ9WRc9Qbvn8u
         lEoFl6zsdDgO/7dKltsHQC3JT2csadYkOi43+y4DCp75evRh8qCwOLpX/CWDEu4wGka9
         4eqTC/X95DtRfA0R0RbCbCl8vXW7fnW0mh8UCdH2h0FPrhmw4yLm18ndjeNQmewQqJ10
         G6PNB6NdfvVvnOIGgY6AU8FoR+J81J3ds0zgVETtYN1pNXlsX8MjLCr4TdhXJc4Tc9bR
         9OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKJgZ6/TZivMgfA7M0b8QxunsvdewLvDcn8nYNDkyF8=;
        b=ptRWjSHSib0IYo5UYhw5d8ZOtIFhaUjw8b2clRSjSxGpFfhAmYiBpHD0kQwHINUR1U
         hdKfF3ZR6nkYkOmBp1NLLEG8mVQShZfEwbkdH1YBIpp6/v/CpfBy5USsldFmbDwGgOYP
         AdF1OE6SA4JFiFfSHGjIXW6E2zh7tvfGFpb2eQOZKaxMolzDr9gBgPs23SMOl65FuJQh
         Txfgy2NNa9tTHE6Mc3oMs4hWJ1tNFbzX3u+xScr/Y6ln40nzZ71LN0q7oRXKk9DQgdqN
         NrbfKc4s7HYEqOEpNIXXrMyJHtiIyIEDswJyXLe0hZKhnMvL2lOrKbonzCZhCaONjf7q
         JYYA==
X-Gm-Message-State: APt69E2Hhw0A9ndrZ3O8TFNWx8FTnIxveduufx8un0BOu2RKmG02hYcv
        Wr67ZiZXiBoMgZn4Ki9+6+tweg==
X-Google-Smtp-Source: AAOMgpdebxkg9Nx2tfKWkx0xeBt/BL4Eoj6me3X6L9dyVcPDz41LTunglAxGeSgEcdmZjpZM+XClwg==
X-Received: by 2002:a9d:3835:: with SMTP id i50-v6mr12645760otc.382.1530408319740;
        Sat, 30 Jun 2018 18:25:19 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 8/9] merge-recursive: enforce rule that index matches head before merging
Date:   Sat, 30 Jun 2018 18:25:02 -0700
Message-Id: <20180701012503.14382-9-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/merge.c says that when we are about to perform a merge:

    ...the index must be in sync with the head commit.  The strategies are
    responsible to ensure this.

merge-recursive has always relied on unpack_trees() to enforce this
requirement, except in the case of an "Already up to date!" merge.
unpack-trees.c does not actually enforce this requirement, though.  It
allows for a pair of exceptions, in cases which it refers to as #14(ALT)
and #2ALT.  Documentation/technical/trivial-merge.txt can be consulted for
the precise meanings of the various case numbers and their meanings for
unpack-trees.c, but we have a high-level description of the intent behind
these two exceptions in a combined and summarized form in
Documentation/git-merge.txt:

    ...[merge will] abort if there are any changes registered in the index
    relative to the `HEAD` commit.  (One exception is when the changed index
    entries are in the state that would result from the merge already.)

While this high-level description does describe conditions under which it
would be safe to allow the index to diverge from HEAD, it does not match
what is actually implemented.  In particular, unpack-trees.c has no
knowledge of renames, and these two exceptions were written assuming that
no renames take place.  Once renames get into the mix, it is no longer
safe to allow the index to not match for #2ALT.  We could modify
unpack-trees to only allow #14(ALT) as an exception, but that would be
more strict than required for the resolve strategy (since the resolve
strategy doesn't handle renames at all).  Therefore, unpack_trees.c seems
like the wrong place to fix this.

Further, if someone fixes the combination of break and rename detection
and modifies merge-recursive to take advantage of the combination, then it
will also no longer be safe to allow the index to not match for #14(ALT)
when the recursive strategy is in use.  Therefore, leaving one of the
exceptions in place with the recursive merge strategy feels like we are
just leaving a latent bug in the code for folks in the future to stumble
across.

It may be possible to fix both unpack-trees and merge-recursive in a way
that implements the exception as stated in Documentation/git-merge.txt,
but it would be somewhat complex, possibly also buggy at first, and
ultimately, not all that valuable.  Instead, just enforce the requirement
stated in builtin/merge.c; error out if the index does not match the HEAD
commit, just like the 'ours' and 'octopus' strategies do.

Some testcase fixups were in order:
  t7611: had many tests designed to show that `git merge --abort` could
	 not always restore the index and working tree to the state they
	 were in before the merge started.  The tests that were associated
	 with having changes in the index before the merge started are no
         longer applicable, so they have been removed.
  t7504: had a few tests that had stray staged changes that were not
         actually part of the test under consideration
  t6044: We no longer expect stray staged changes to sometimes result
         in the merge continuing.  Also, fix a case where a merge
         didn't abort but should have.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                        |  14 +--
 t/t6044-merge-unrelated-index-changes.sh |  19 ++--
 t/t7504-commit-msg-hook.sh               |   4 +-
 t/t7611-merge-abort.sh                   | 118 -----------------------
 4 files changed, 18 insertions(+), 137 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 855ca39ca..8f7a8e828 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3257,6 +3257,13 @@ int merge_trees(struct merge_options *o,
 		struct tree **result)
 {
 	int code, clean;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
+		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+		    sb.buf);
+		return -1;
+	}
 
 	if (o->subtree_shift) {
 		merge = shift_tree_object(head, merge, o->subtree_shift);
@@ -3264,13 +3271,6 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
-		struct strbuf sb = STRBUF_INIT;
-
-		if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
-			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
-			    sb.buf);
-			return -1;
-		}
 		output(o, 0, _("Already up to date!"));
 		*result = head;
 		return 1;
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index e609f14f8..6e0ecab9c 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -137,7 +137,7 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	test_i18ngrep "Already up to date" out
 '
 
-test_expect_failure 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
+test_expect_success 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -145,14 +145,12 @@ test_expect_failure 'recursive, when file has staged changes not matching HEAD n
 	test_seq 1 10 >subdir/a &&
 	git add subdir/a &&
 
-	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
-	# Since subdir/a matches neither HEAD nor what the merge would write
-	# to that file, the merge should fail to avoid overwriting what is
-	# currently found in subdir/a
-	test_must_fail git merge -s recursive E^0
+	# We have staged changes; merge should error out
+	test_must_fail git merge -s recursive E^0 2>err &&
+	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
-test_expect_failure 'recursive, when file has staged changes matching what a merge would give' '
+test_expect_success 'recursive, when file has staged changes matching what a merge would give' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -160,10 +158,9 @@ test_expect_failure 'recursive, when file has staged changes matching what a mer
 	test_seq 1 11 >subdir/a &&
 	git add subdir/a &&
 
-	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
-	# Since subdir/a matches what the merge would write to that file,
-	# the merge should be safe to proceed
-	git merge -s recursive E^0
+	# We have staged changes; merge should error out
+	test_must_fail git merge -s recursive E^0 2>err &&
+	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
 test_expect_success 'octopus, unrelated file touched' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 302a3a208..31b9c6a2c 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -157,6 +157,7 @@ test_expect_success 'merge bypasses failing hook with --no-verify' '
 	test_when_finished "git branch -D newbranch" &&
 	test_when_finished "git checkout -f master" &&
 	git checkout --orphan newbranch &&
+	git rm -f file &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
@@ -168,7 +169,7 @@ test_expect_success 'merge bypasses failing hook with --no-verify' '
 chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
-	echo "content" >> file &&
+	echo "content" >file &&
 	git add file &&
 	git commit -m "content"
 
@@ -249,6 +250,7 @@ test_expect_success 'hook called in git-merge picks up commit message' '
 	test_when_finished "git branch -D newbranch" &&
 	test_when_finished "git checkout -f master" &&
 	git checkout --orphan newbranch &&
+	git rm -f file &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 7b4798e8e..7c84a518a 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -187,31 +187,6 @@ test_expect_success 'Fail clean merge with matching dirty worktree' '
 	test_cmp expect actual
 '
 
-test_expect_success 'Abort clean merge with matching dirty index' '
-	git add bar &&
-	git diff --staged > expect &&
-	git merge --no-commit clean_branch &&
-	test -f .git/MERGE_HEAD &&
-	### When aborting the merge, git will discard all staged changes,
-	### including those that were staged pre-merge. In other words,
-	### --abort will LOSE any staged changes (the staged changes that
-	### are lost must match the merge result, or the merge would not
-	### have been allowed to start). Change expectations accordingly:
-	rm expect &&
-	touch expect &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff --staged > actual &&
-	test_cmp expect actual &&
-	test -z "$(git diff)"
-'
-
-test_expect_success 'Reset worktree changes' '
-	git reset --hard "$pre_merge_head"
-'
-
 test_expect_success 'Fail conflicting merge with matching dirty worktree' '
 	echo barf > bar &&
 	git diff > expect &&
@@ -223,97 +198,4 @@ test_expect_success 'Fail conflicting merge with matching dirty worktree' '
 	test_cmp expect actual
 '
 
-test_expect_success 'Abort conflicting merge with matching dirty index' '
-	git add bar &&
-	git diff --staged > expect &&
-	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
-	### When aborting the merge, git will discard all staged changes,
-	### including those that were staged pre-merge. In other words,
-	### --abort will LOSE any staged changes (the staged changes that
-	### are lost must match the merge result, or the merge would not
-	### have been allowed to start). Change expectations accordingly:
-	rm expect &&
-	touch expect &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff --staged > actual &&
-	test_cmp expect actual &&
-	test -z "$(git diff)"
-'
-
-test_expect_success 'Reset worktree changes' '
-	git reset --hard "$pre_merge_head"
-'
-
-test_expect_success 'Abort merge with pre- and post-merge worktree changes' '
-	# Pre-merge worktree changes
-	echo xyzzy > foo &&
-	echo barf > bar &&
-	git add bar &&
-	git diff > expect &&
-	git diff --staged > expect-staged &&
-	# Perform merge
-	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
-	# Post-merge worktree changes
-	echo yzxxz > foo &&
-	echo blech > baz &&
-	### When aborting the merge, git will discard staged changes (bar)
-	### and unmerged changes (baz). Other changes that are neither
-	### staged nor marked as unmerged (foo), will be preserved. For
-	### these changed, git cannot tell pre-merge changes apart from
-	### post-merge changes, so the post-merge changes will be
-	### preserved. Change expectations accordingly:
-	git diff -- foo > expect &&
-	rm expect-staged &&
-	touch expect-staged &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff > actual &&
-	test_cmp expect actual &&
-	git diff --staged > actual-staged &&
-	test_cmp expect-staged actual-staged
-'
-
-test_expect_success 'Reset worktree changes' '
-	git reset --hard "$pre_merge_head"
-'
-
-test_expect_success 'Abort merge with pre- and post-merge index changes' '
-	# Pre-merge worktree changes
-	echo xyzzy > foo &&
-	echo barf > bar &&
-	git add bar &&
-	git diff > expect &&
-	git diff --staged > expect-staged &&
-	# Perform merge
-	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
-	# Post-merge worktree changes
-	echo yzxxz > foo &&
-	echo blech > baz &&
-	git add foo bar &&
-	### When aborting the merge, git will discard all staged changes
-	### (foo, bar and baz), and no changes will be preserved. Whether
-	### the changes were staged pre- or post-merge does not matter
-	### (except for not preventing starting the merge).
-	### Change expectations accordingly:
-	rm expect expect-staged &&
-	touch expect &&
-	touch expect-staged &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff > actual &&
-	test_cmp expect actual &&
-	git diff --staged > actual-staged &&
-	test_cmp expect-staged actual-staged
-'
-
 test_done
-- 
2.18.0.137.g2a11d05a6.dirty

