Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D74C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA2E20C09
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwBLnm6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbgFXIuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389605AbgFXIup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 04:50:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3213C061755
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 01:50:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so1077736qtr.7
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hx4voaR3FCIgTMPFb3s9iTlInERQfW6TvDzazfRQ0Zk=;
        b=WwBLnm6VUBcWN3BeIG8/VgKkFvqo0t4d/sCKphc2nfXs8UlDEAVXZhbTASd9TYkRj3
         yNm8+Rsdgl0lqCZgAN+EvSa1mJeg6wEt+K2LNloyOPU47Q9/K51fymXiNouL65PkBEwD
         ujvu8TghqDb4ZkXw2uHULPFud35K4ED5+I1U6FOabqGIFow6vwMZhhHKrDoEp3NN9kjc
         AObnGGbdAY9XvjJbixfmZVWx1ixsWZPzzbB1ODBD4gtZ9shx1atvN5MNZCcBemONTvfs
         ZrUfiV4+DOIjsaIDlfrq8fq6Ax735G6P5/Z2fWjfwXgNfGRUsDjpEfcVGVxXkyFRXlO8
         sjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hx4voaR3FCIgTMPFb3s9iTlInERQfW6TvDzazfRQ0Zk=;
        b=M56eBUywHMVAyhODLDK25AvL6+8oZHwUec+OJ35v/wLAe8ziS4ilv9iWlf+O3rmy0r
         nAFAfTlji2Uf6Mm/vKeeBJ1zM7FMeAfrzkusSwE59VXrp/L8MUMAG3/kObKBmgSDvU2N
         qbbwMT3SkePY0hfS08+uP6DwA92WxW6NJnec41HVz6wj57VEcZmM+x9K32N8HHjOJmCC
         3zD3elWkkyh21617F0yCVMCYMFnXzhq3YuMFqsjfWKOtwSxvmRa0o1QAQmfuf2GZkvAr
         YbWBxFKbNOxlo/IDKM2LqF1xTntFgZQFDx+Gl58z3hNMwVeXDk/AuNsXZhB0GuUAzgLJ
         ToIg==
X-Gm-Message-State: AOAM5306JN06ocTHN1+D5C+zY87tuGLG/6W92oPKTvFOmxbPn5dAtaDW
        9LRi3dG6TLjLyNQ2Piuf5i8iWJtO8Zo=
X-Google-Smtp-Source: ABdhPJwDSt/Dks5AYtLltMCmkKxREa0/hzGuU2BgIVbBv8W7p+F7WHxPbx99snVnANkvZ9fd6piKhA==
X-Received: by 2002:ac8:348f:: with SMTP id w15mr15461916qtb.79.1592988643598;
        Wed, 24 Jun 2020 01:50:43 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k14sm2824409qtm.38.2020.06.24.01.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:50:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5.2] lib-submodule-update: pass 'test_must_fail' as an argument
Date:   Wed, 24 Jun 2020 04:50:18 -0400
Message-Id: <9ea9d3ff08266e9f1062632c4b1ff1e5f23733bd.1592981264.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.307.g7979e895e7
In-Reply-To: <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
References: <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run a test helper function in test_submodule_switch_common(), we
sometimes specify a whole helper function as the $command. When we do
this, in some test cases, we just mark the whole function with
`test_must_fail`. However, it's possible that the helper function might
fail earlier or later than expected due to an introduced bug. If this
happens, then the test case will still report as passing but it should
really be marked as failing since it didn't actually display the
intended behaviour.

Instead of invoking `test_must_fail $command`, pass the string
"test_must_fail" as the second argument in case where the git command is
expected to fail.

When $command is a helper function, the parent function calling
test_submodule_switch_common() is test_submodule_switch_func(). For all
test_submodule_switch_func() invocations, increase the granularity of
the argument test helper function by prefixing the git invocation which is
meant to fail with the second argument like this:

	$2 git checkout "$1"

In the other cases, test_submodule_switch() and
test_submodule_forced_switch(), instead of passing in the git command
directly, wrap it using the git_test_func() and pass the git arguments
using the global variable $gitcmd. Unfortunately, since closures aren't
a thing in shell scripts, the global variable is necessary. Another
unfortunate result is that the "git_test_func" will used as the test
case name when $command is printed but it's worth it for the cleaner
code.

Finally, as an added bonus, `test_must_fail` will now only run on git
commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Changes since v5.1:

* Fix broken &&-chain

* Add may_only_be_test_must_fail() checks

* Remove $OVERWRITING_FAIL from the commit message

 t/lib-submodule-update.sh   | 55 ++++++++++++++++++++++++++++---------
 t/t3426-rebase-submodule.sh |  6 ++--
 t/t3513-revert-submodule.sh |  7 ++++-
 t/t3906-stash-submodule.sh  |  7 ++++-
 t/t4137-apply-submodule.sh  |  8 ++++--
 t/t4255-am-submodule.sh     |  8 ++++--
 t/t5572-pull-submodule.sh   | 12 +++++---
 t/t6041-bisect-submodule.sh |  7 ++++-
 8 files changed, 84 insertions(+), 26 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 7c3ba1be00..8e9f310bcb 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -303,8 +303,12 @@ test_submodule_content () {
 # update" is run. And even then that command doesn't delete the work tree of
 # a removed submodule.
 #
+# The first argument of the callback function will be the name of the submodule.
+#
 # Removing a submodule containing a .git directory must fail even when forced
-# to protect the history!
+# to protect the history! If we are testing this case, the second argument of
+# the callback function will be 'test_must_fail', else it will be the empty
+# string.
 #
 
 # Internal function; use test_submodule_switch_func(), test_submodule_switch(),
@@ -443,7 +447,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -456,7 +460,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -470,7 +474,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
+			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -484,7 +488,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
+			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -559,12 +563,25 @@ test_submodule_switch_common () {
 # conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
 # below to 1.
 #
-# Use as follows:
+# The first argument of the callback function will be the name of the submodule.
+#
+# Removing a submodule containing a .git directory must fail even when forced
+# to protect the history! If we are testing this case, the second argument of
+# the callback function will be 'test_must_fail', else it will be the empty
+# string.
+#
+# The following example uses `git some-command` as an example command to be
+# tested. It updates the worktree and index to match a target, but not any
+# submodule directories.
 #
 # my_func () {
-#   target=$1
-#   # Do something here that updates the worktree and index to match target,
-#   # but not any submodule directories.
+#   ...prepare for `git some-command` to be run...
+#   $2 git some-command "$1" &&
+#   if test -n "$2"
+#   then
+#     return
+#   fi &&
+#   ...check the state after git some-command is run...
 # }
 # test_submodule_switch_func "my_func"
 test_submodule_switch_func () {
@@ -580,23 +597,35 @@ test_submodule_switch_func () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			test_must_fail $command add_sub1 &&
+			$command add_sub1 test_must_fail &&
 			test_superproject_content origin/no_submodule &&
 			test_must_be_empty sub1
 		)
 	'
 }
 
+# Ensures that the that the arg either contains "test_must_fail" or is empty.
+may_only_be_test_must_fail () {
+	test -z "$1" || test "$1" = test_must_fail || die
+}
+
+git_test_func () {
+	may_only_be_test_must_fail "$2" &&
+	$2 git $gitcmd "$1"
+}
+
 test_submodule_switch () {
-	test_submodule_switch_func "git $1"
+	gitcmd="$1"
+	test_submodule_switch_func "git_test_func"
 }
 
 # Same as test_submodule_switch(), except that throwing away local changes in
 # the superproject is allowed.
 test_submodule_forced_switch () {
-	command="$1"
+	gitcmd="$1"
+	command="git_test_func"
 	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
-	test_submodule_switch_common "git $command"
+	test_submodule_switch_common "$command"
 
 	# When forced, a file in the superproject does not prevent creating a
 	# submodule of the same name.
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 788605ccc0..0ad3a07bf4 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -17,7 +17,8 @@ git_rebase () {
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-	git rebase "$1"
+	may_only_be_test_must_fail "$2" &&
+	$2 git rebase "$1"
 }
 
 test_submodule_switch_func "git_rebase"
@@ -35,7 +36,8 @@ git_rebase_interactive () {
 	test_cmp expect actual &&
 	set_fake_editor &&
 	echo "fake-editor.sh" >.git/info/exclude &&
-	git rebase -i "$1"
+	may_only_be_test_must_fail "$2" &&
+	$2 git rebase -i "$1"
 }
 
 test_submodule_switch_func "git_rebase_interactive"
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 95a7f64471..a759f12cbb 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -15,7 +15,12 @@ git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
-	git checkout "$1" &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git checkout "$1" &&
+	if test -n "$2"
+	then
+		return
+	fi &&
 	git revert HEAD &&
 	rm -rf * &&
 	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 6a7e801ca0..a52e53dd2d 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -8,7 +8,12 @@ test_description='stash can handle submodules'
 git_stash () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	git read-tree -u -m "$1" &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git read-tree -u -m "$1" &&
+	if test -n "$2"
+	then
+		return
+	fi &&
 	git stash &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index b645e303a0..07d5262537 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -6,13 +6,17 @@ test_description='git apply handling submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 apply_index () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --index -
+	git diff --ignore-submodules=dirty "..$1" >diff &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git apply --index diff
 }
 
 test_submodule_switch_func "apply_index"
 
 apply_3way () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
+	git diff --ignore-submodules=dirty "..$1" >diff &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git apply --3way diff
 }
 
 test_submodule_switch_func "apply_3way"
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 1b179d5f45..a7ba08f728 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -6,13 +6,17 @@ test_description='git am handling submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 am () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git am patch
 }
 
 test_submodule_switch_func "am"
 
 am_3way () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git am --3way patch
 }
 
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f911bf631e..1d75e3b12b 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -13,7 +13,8 @@ reset_branch_to_HEAD () {
 
 git_pull () {
 	reset_branch_to_HEAD "$1" &&
-	git pull
+	may_only_be_test_must_fail "$2" &&
+	$2 git pull
 }
 
 # pulls without conflicts
@@ -21,21 +22,24 @@ test_submodule_switch_func "git_pull"
 
 git_pull_ff () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --ff
+	may_only_be_test_must_fail "$2" &&
+	$2 git pull --ff
 }
 
 test_submodule_switch_func "git_pull_ff"
 
 git_pull_ff_only () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --ff-only
+	may_only_be_test_must_fail "$2" &&
+	$2 git pull --ff-only
 }
 
 test_submodule_switch_func "git_pull_ff_only"
 
 git_pull_noff () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --no-ff
+	may_only_be_test_must_fail "$2" &&
+	$2 git pull --no-ff
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 0e0cdf638d..df1eff0fb8 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -10,7 +10,12 @@ git_bisect () {
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
-	git checkout "$1" &&
+	may_only_be_test_must_fail "$2" &&
+	$2 git checkout "$1" &&
+	if test -n "$2"
+	then
+		return
+	fi &&
 	echo "foo" >bar &&
 	git add bar &&
 	git commit -m "bisect bad" &&
-- 
2.27.0.307.g7979e895e7

