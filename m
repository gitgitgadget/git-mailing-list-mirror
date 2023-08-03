Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B62C001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 13:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjHCNMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjHCNMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 09:12:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4F4C0E
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 06:10:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so12982205e9.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691068178; x=1691672978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QiSSKCo2Ma4XUtKJpLrs5FAL0K8Asn6XhrPCif2roeo=;
        b=A/kmzp54vzWWQkBpWltf+kfdeyEv8NIKu6ml3PIvR5SqyAUGLG4T3bYBnQhtV+Tuc8
         UQjPSIHIlKZus8KvfU68PmsMh1f1P1edo6gT/lqbFzpdGWIMiO3ToPxwkwgngYKbPSfl
         d2xHnb6/nzh/tBM29W2el3+m429pquBlTfgFq5IQhHeZr+atn56aqBMKxo9QoMHpfI2g
         FXHpmgQy7GTMmSz/ey6gZxeQbRcJlDDWrmK+2HdW/KYkcsj5rJfwaElcylSF1XDk67Mf
         m86mLSHHJNGdAjU6TDwsuCAmbnwsEqlc3nG3Blu102hs+lGEbn9tSfhMoPRVVZtAdb1i
         0GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068178; x=1691672978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiSSKCo2Ma4XUtKJpLrs5FAL0K8Asn6XhrPCif2roeo=;
        b=Wft6NWuA1Llg9CKs0wt3wOaK6FdsoiByzrLRw71hr2Qq2rnpq8ww0r7+bftH1nXaqn
         BFyktq7rn7SQM55Po/Ro9OCiWSpggWTvbwF/pMd8livfT7lwnU2LPw5fUQgMsVLJS7eW
         ssQh9kOIDvNgudqCbtXvzm8FhZ5erHjmqO0L2NvfgqycesJQV+Ye3YchSOwYNXutIMZl
         xF8ZK5ZrNhUFnp1K72JAOwK1UN6MBmzWSvzKo/bzVLD8YM9Rx9ZtaEVR55Ui5TIc7HC1
         N9UW5ZuO05uD2AS+dqK+bfonxIuB0ic/6XNlU23rDosoEl9mojDZ5O0m8fbMQPxOmjcy
         cgwg==
X-Gm-Message-State: ABy/qLY72DnhlORfMUctGYLhOTCG5gi4g5VAH2ne5LpIf4u4v4QqXv8D
        2PXBCAvLmQm0MOhS6NsvzX3OOXwa6S4=
X-Google-Smtp-Source: APBJJlHvskCLQIpCY0Ug1tyxbXgv+gqRnIptp/vBTbYU67tCwcOP01Wi5GxTsMzevrJV/ap3UwnBGA==
X-Received: by 2002:a05:600c:3d85:b0:3f7:e78e:8a41 with SMTP id bi5-20020a05600c3d8500b003f7e78e8a41mr7437021wmb.18.1691068177397;
        Thu, 03 Aug 2023 06:09:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003fe1cac37d8sm4349681wmj.11.2023.08.03.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:09:37 -0700 (PDT)
Message-ID: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 13:09:35 +0000
Subject: [PATCH] rebase --skip: fix commit message clean up when skipping
 squash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

During a series of "fixup" and/or "squash" commands, the interactive
rebase accumulates a commit message from all the commits that are being
squashed together. If one of the commits has conflicts when it is picked
and the user chooses to skip that commit then we need to remove that
commit's message from accumulated messages.  To do this 15ef69314d5
(rebase --skip: clean up commit message after a failed fixup/squash,
2018-04-27) updated commit_staged_changes() to reset the accumulated
message to the commit message of HEAD (which does not contain the
message from the skipped commit) when the last command was "fixup" or
"squash" and there are no staged changes. Unfortunately the code to do
this contains two bugs.

(1) If parse_head() fails we pass an invalid pointer to
    unuse_commit_buffer().

(2) The reconstructed message uses the entire commit buffer from HEAD
    including the headers, rather than just the commit message.

The fist issue is fixed by splitting up the "if" condition into several
statements each with its own error handling. The second issue is fixed
by finding the start of the commit message within the commit buffer
using find_commit_subject().

The existing test added by 15ef69314d5 is modified to show the effect of
this bug.  The bug is triggered when skipping the first command in the
chain (as the test does before this commit) but the effect is hidden
because opts->current_fixup_count is set to zero which leads
update_squash_messages() to recreate the squash message file from
scratch overwriting the bad message created by
commit_staged_changes(). The test is also updated to explicitly check
the commit messages rather than relying on grep to ensure they do not
contain any stay commit headers.

To check the commit message the function test_commit_message() is moved
from t3437-rebase-fixup-options.sh to test-lib.sh. As the function is
now publicly available it is updated to provide better error detection
and avoid overwriting the commonly used files "actual" and "expect".
Support for reading the expected commit message from stdin is also
added.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase --skip: fix commit message clean up when skipping squash
    
    This patch is based on maint.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1558%2Fphillipwood%2Fwip%2Frebase-skip-fix-message-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1558/phillipwood/wip/rebase-skip-fix-message-cleanup-v1
Pull-Request: https://github.com/git/git/pull/1558

 sequencer.c                     | 26 +++++++++++----
 t/t3418-rebase-continue.sh      | 58 +++++++++++++++++++++++----------
 t/t3437-rebase-fixup-options.sh | 15 ---------
 t/test-lib-functions.sh         | 33 +++++++++++++++++++
 4 files changed, 93 insertions(+), 39 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bceb6abcb6c..af271ab6fbd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5038,19 +5038,31 @@ static int commit_staged_changes(struct repository *r,
 				 * We need to update the squash message to skip
 				 * the latest commit message.
 				 */
+				int res = 0;
 				struct commit *commit;
+				const char *msg;
 				const char *path = rebase_path_squash_msg();
 				const char *encoding = get_commit_output_encoding();
 
-				if (parse_head(r, &commit) ||
-				    !(p = repo_logmsg_reencode(r, commit, NULL, encoding)) ||
-				    write_message(p, strlen(p), path, 0)) {
-					repo_unuse_commit_buffer(r, commit, p);
-					return error(_("could not write file: "
+				if (parse_head(r, &commit))
+					return error(_("could not parse HEAD"));
+
+				p = repo_logmsg_reencode(r, commit, NULL, encoding);
+				if (!p)  {
+					res = error(_("could not parse commit %s"),
+						    oid_to_hex(&commit->object.oid));
+					goto unuse_commit_buffer;
+				}
+				find_commit_subject(p, &msg);
+				if (write_message(msg, strlen(msg), path, 0)) {
+					res = error(_("could not write file: "
 						       "'%s'"), path);
+					goto unuse_commit_buffer;
 				}
-				repo_unuse_commit_buffer(r,
-							 commit, p);
+			unuse_commit_buffer:
+				repo_unuse_commit_buffer(r, commit, p);
+				if (res)
+					return res;
 			}
 		}
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2d0789e554b..fb7b68990cc 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -115,15 +115,23 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b with-conflicting-fixup &&
 	test_commit wants-fixup &&
-	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
-	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
-	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
+	test_commit "fixup 1" wants-fixup.t 1 wants-fixup-1 &&
+	test_commit "fixup 2" wants-fixup.t 2 wants-fixup-2 &&
+	test_commit "fixup 3" wants-fixup.t 3 wants-fixup-3 &&
 	test_must_fail env FAKE_LINES="1 fixup 2 squash 4" \
 		git rebase -i HEAD~4 &&
 
 	: now there is a conflict, and comments in the commit message &&
-	git show HEAD >out &&
-	grep "fixup! wants-fixup" out &&
+	test_commit_message HEAD <<-\EOF &&
+	# This is a combination of 2 commits.
+	# This is the 1st commit message:
+
+	wants-fixup
+
+	# The commit message #2 will be skipped:
+
+	# fixup 1
+	EOF
 
 	: skip and continue &&
 	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
@@ -133,33 +141,49 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	test_path_is_missing .git/copy.txt &&
 
 	: now the comments in the commit message should have been cleaned up &&
-	git show HEAD >out &&
-	! grep "fixup! wants-fixup" out &&
+	test_commit_message HEAD -m wants-fixup &&
 
 	: now, let us ensure that "squash" is handled correctly &&
 	git reset --hard wants-fixup-3 &&
-	test_must_fail env FAKE_LINES="1 squash 4 squash 2 squash 4" \
+	test_must_fail env FAKE_LINES="1 squash 2 squash 1 squash 3 squash 1" \
 		git rebase -i HEAD~4 &&
 
-	: the first squash failed, but there are two more in the chain &&
+	: the second squash failed, but there are two more in the chain &&
 	(test_set_editor "$PWD/copy-editor.sh" &&
 	 test_must_fail git rebase --skip) &&
 
 	: not the final squash, no need to edit the commit message &&
 	test_path_is_missing .git/copy.txt &&
 
-	: The first squash was skipped, therefore: &&
-	git show HEAD >out &&
-	test_i18ngrep "# This is a combination of 2 commits" out &&
-	test_i18ngrep "# This is the commit message #2:" out &&
+	: The first and third squashes succeeded, therefore: &&
+	test_commit_message HEAD <<-\EOF &&
+	# This is a combination of 3 commits.
+	# This is the 1st commit message:
+
+	wants-fixup
+
+	# This is the commit message #2:
+
+	fixup 1
+
+	# This is the commit message #3:
+
+	fixup 2
+	EOF
 
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
-	git show HEAD >out &&
-	test_i18ngrep ! "# This is a combination" out &&
+	test_commit_message HEAD <<-\EOF &&
+	wants-fixup
+
+	fixup 1
+
+	fixup 2
+	EOF
 
 	: Final squash failed, but there was still a squash &&
-	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt &&
-	test_i18ngrep "# This is the commit message #2:" .git/copy.txt
+	head -n1 .git/copy.txt >first-line &&
+	test_i18ngrep "# This is a combination of 3 commits" first-line &&
+	test_i18ngrep "# This is the commit message #3:" .git/copy.txt
 '
 
 test_expect_success 'setup rerere database' '
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index dd3b301fa7a..7929e2e2e3a 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -21,21 +21,6 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 EMPTY=""
 
-# test_commit_message <rev> -m <msg>
-# test_commit_message <rev> <path>
-# Verify that the commit message of <rev> matches
-# <msg> or the content of <path>.
-test_commit_message () {
-	git show --no-patch --pretty=format:%B "$1" >actual &&
-	case "$2" in
-	-m)
-		echo "$3" >expect &&
-		test_cmp expect actual ;;
-	*)
-		test_cmp "$2" actual ;;
-	esac
-}
-
 get_author () {
 	rev="$1" &&
 	git log -1 --pretty=format:"%an %ae %at" "$rev"
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6e19ebc922a..d8a52334eeb 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1273,6 +1273,39 @@ test_cmp_rev () {
 	fi
 }
 
+# Tests that a commit message matches the expected text
+#
+# Usage: test_commit_message <rev> [-m <msg> | <file>]
+#
+# When using "-m" <msg> will have a line feed appended. If the second
+# argument is omitted then the expected message is read from stdin.
+
+test_commit_message () {
+	local msg_file=expect.msg
+
+	case $# in
+	3)
+		if test "$2" = "-m"
+		then
+			printf "%s\n" "$3" >"$msg_file"
+		else
+			BUG "Usage: test_commit_message <rev> [-m <message> | <file>]"
+		fi
+		;;
+	2)
+		msg_file="$2"
+		;;
+	1)
+		cat >"$msg_file"
+		;;
+	*)
+		BUG "Usage: test_commit_message <rev> [-m <message> | <file>]"
+		;;
+	esac
+	git show --no-patch --pretty=format:%B "$1" -- >actual.msg &&
+	test_cmp "$msg_file" actual.msg
+}
+
 # Compare paths respecting core.ignoreCase
 test_cmp_fspath () {
 	if test "x$1" = "x$2"

base-commit: fb7d80edcae482f4fa5d4be0227dc3054734e5f3
-- 
gitgitgadget
