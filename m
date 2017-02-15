Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63702013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdBOAfK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:10 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:36061 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdBOAfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:08 -0500
Received: by mail-it0-f44.google.com with SMTP id c7so56114573itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KdWo8VQLN9664knAo6Yduir4+SBo12B4hr9UJVk4L6A=;
        b=PVD+D3AVEGJfyP4Y7KgvheGeLUnxz23gC8Rsr1cfCK/PExF3kTt1vxDcpu81fwCrAG
         b+uTkrIC9FK/Rc3AP6M8VVMmsNhl71lnO3OaMOra0jVsCoFULtAacXEVfmqiQRHfXeJ9
         TNEjeKtAHEwWwvkW3qoS2Lx2cWj7NoPYFt5rzXhB/Y0mIiSKFU49W0FhXhTS6IjOQgeY
         OyfCeeTF8sf8i/3OAS3AyG54Q1mMVhuzMw9hJeGh+K9Rzd0p8/pZs2KTsnRrvmoiuxBX
         38Bef7mEUf9qbsFZMU+ghc7cw/JT+QuTj3wjmkMM2lybIxjPx0DgLPIw0F4QuMky22Oa
         8lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KdWo8VQLN9664knAo6Yduir4+SBo12B4hr9UJVk4L6A=;
        b=lJ7L0kboj/Cy6qiWRai47hFR/45j3+1BNkaEiXnzRNpDluV33N8mLstlkGkGMitJLU
         vgQUQFH1SDG8IwLHHlZfEoxHyHjeBOpLLyyGWFrYBVm3S0dFt4Jz6z3cD0leGavmiPM1
         x8pjjrWlXny7626R+X4sh5DMePFSWuL0KgwVdM17SO7fyIynSecrH0iJCrTqCwrvUZHp
         aEoAx0BuZEXYPtEEMPU7795fwjo1FYzoeScs8M1LOh1BqZfS8Vf66lsdcQns5pcBlzfl
         7dXRaZ6TW4vVmhBUwZHWczpfMpQbamWcys61pavmPRXGCNhhgwXJwlkIc5moQrRcykwx
         Mj7Q==
X-Gm-Message-State: AMke39koI599Jk1Gxqcwi2IrsLeZpsAYvvEL5m9EEkqMKcmu0VcGmobbut1PYXHrCwS7C4/h
X-Received: by 10.99.104.133 with SMTP id d127mr35880338pgc.52.1487118906593;
        Tue, 14 Feb 2017 16:35:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id a24sm3342385pfh.33.2017.02.14.16.35.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/14] lib-submodule-update.sh: define tests for recursing into submodules
Date:   Tue, 14 Feb 2017 16:34:11 -0800
Message-Id: <20170215003423.20245-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently lib-submodule-update.sh provides 2 functions
test_submodule_switch and test_submodule_forced_switch that are used by a
variety of tests to ensure that submodules behave as expected. The current
expected behavior is that submodules are not touched at all (see
42639d2317a for the exact setup).

In the future we want to teach all these commands to properly recurse
into submodules. To do that, we'll add two testing functions to
submodule-update-lib.sh test_submodule_switch_recursing and
test_submodule_forced_switch_recursing.

These two functions behave in analogy to the already existing functions
just with a different expectation on submodule behavior. The submodule
in the working tree is expected to be updated to the recorded submodule
version. The behavior is analogous to e.g. the behavior of files in a
nested directory in the working tree, where a change to the working tree
handles any arising directory/file conflicts just fine.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 474 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 472 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 61c54f2098..7c8c557572 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -4,6 +4,7 @@
 # - New submodule (no_submodule => add_sub1)
 # - Removed submodule (add_sub1 => remove_sub1)
 # - Updated submodule (add_sub1 => modify_sub1)
+# - Updated submodule recursively (modify_sub1 => modify_sub1_recursively)
 # - Submodule updated to invalid commit (add_sub1 => invalid_sub1)
 # - Submodule updated from invalid commit (invalid_sub1 => valid_sub1)
 # - Submodule replaced by tracked files in directory (add_sub1 =>
@@ -19,8 +20,8 @@
 #                    /    ^
 #                   /     remove_sub1
 #                  /
-#       add_sub1  /-------O
-#             |  /        ^
+#       add_sub1  /-------O---------O
+#             |  /        ^         modify_sub1_recursive
 #             | /         modify_sub1
 #             v/
 #      O------O-----------O---------O
@@ -73,6 +74,14 @@ create_lib_submodule_repo () {
 		git add sub1 &&
 		git commit -m "Modify sub1" &&
 
+		git checkout -b modify_sub1_recursively modify_sub1 &&
+		git -C sub1 checkout -b "add_nested_sub" &&
+		git -C sub1 submodule add --branch no_submodule ./. sub2 &&
+		git -C sub1 commit -a -m "add a nested submodule" &&
+		git add sub1 &&
+		git commit -a -m "update submodule, that updates a nested submodule" &&
+		git -C sub1 submodule deinit -f --all &&
+
 		git checkout -b replace_sub1_with_directory add_sub1 &&
 		git submodule update &&
 		git -C sub1 checkout modifications &&
@@ -139,6 +148,15 @@ test_git_directory_is_unchanged () {
 	)
 }
 
+test_git_directory_exists() {
+	test -e ".git/modules/$1" &&
+	if test -f sub1/.git
+	then
+		# does core.worktree point at the right place?
+		test "$(git -C .git/modules/$1 config core.worktree)" = "../../../$1"
+	fi
+}
+
 # Helper function to be executed at the start of every test below, it sets up
 # the submodule repo if it doesn't exist and configures the most problematic
 # settings for diff.ignoreSubmodules.
@@ -169,6 +187,18 @@ reset_work_tree_to () {
 	)
 }
 
+reset_work_tree_to_interested () {
+	reset_work_tree_to $1 &&
+	# indicate we are interested in the submodule:
+	git -C submodule_update config submodule.sub1.url "bogus" &&
+	# also have it available:
+	if ! test -d submodule_update/.git/modules/sub1
+	then
+		mkdir submodule_update/.git/modules &&
+		cp -r submodule_update_repo/.git/modules/sub1 submodule_update/.git/modules/sub1
+	fi
+}
+
 # Test that the superproject contains the content according to commit "$1"
 # (the work tree must match the index for everything but submodules but the
 # index must exactly match the given commit including any submodule SHA-1s).
@@ -684,3 +714,443 @@ test_submodule_forced_switch () {
 		)
 	'
 }
+
+# Test that submodule contents are correctly updated when switching
+# between commits that change a submodule.
+# Test that the following transitions are correctly handled:
+# (These tests are also above in the case where we expect no change
+#  in the submodule)
+# - Updated submodule
+# - New submodule
+# - Removed submodule
+# - Directory containing tracked files replaced by submodule
+# - Submodule replaced by tracked files in directory
+# - Submodule replaced by tracked file with the same name
+# - tracked file replaced by submodule
+#
+# New test cases
+# - Removing a submodule with a git directory absorbs the submodules
+#   git directory first into the superproject.
+
+test_submodule_switch_recursing () {
+	command="$1"
+	######################### Appearing submodule #########################
+	# Switching to a commit letting a submodule appear checks it out ...
+	test_expect_success "$command: added submodule is checked out" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... ignoring an empty existing directory ...
+	test_expect_success "$command: added submodule is checked out in empty dir" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			mkdir sub1 &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... unless there is an untracked file in its place.
+	test_expect_success "$command: added submodule doesn't remove untracked file with same name" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			: >sub1 &&
+			test_must_fail $command add_sub1 &&
+			test_superproject_content origin/no_submodule &&
+			test_must_be_empty sub1
+		)
+	'
+	# ... but an ignored file is fine.
+	test_expect_success "$command: added submodule removes an untracked ignored file" '
+		test_when_finished "rm submodule_update/.git/info/exclude" &&
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			: >sub1 &&
+			echo sub1 > .git/info/exclude
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Replacing a tracked file with a submodule produces a checked out submodule
+	test_expect_success "$command: replace tracked file with submodule checks out submodule" '
+		prolog &&
+		reset_work_tree_to_interested replace_sub1_with_file &&
+		(
+			cd submodule_update &&
+			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			$command replace_file_with_sub1 &&
+			test_superproject_content origin/replace_file_with_sub1 &&
+			test_submodule_content sub1 origin/replace_file_with_sub1
+		)
+	'
+	# ... as does removing a directory with tracked files with a submodule.
+	test_expect_success "$command: replace directory with submodule" '
+		prolog &&
+		reset_work_tree_to_interested replace_sub1_with_directory &&
+		(
+			cd submodule_update &&
+			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			$command replace_directory_with_sub1 &&
+			test_superproject_content origin/replace_directory_with_sub1 &&
+			test_submodule_content sub1 origin/replace_directory_with_sub1
+		)
+	'
+
+	######################## Disappearing submodule #######################
+	# Removing a submodule removes its work tree ...
+	test_expect_success "$command: removed submodule removes submodules working tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			! test -e sub1
+		)
+	'
+	# ... absorbing a .git directory along the way.
+	test_expect_success "$command: removed submodule absorbs submodules .git directory" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			replace_gitfile_with_git_dir sub1 &&
+			rm -rf .git/modules &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			! test -e sub1 &&
+			test_git_directory_exists sub1
+		)
+	'
+	# Replacing a submodule with files in a directory must succeeds
+	# when the submodule is clean
+	test_expect_success "$command: replace submodule with a directory" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			$command replace_sub1_with_directory &&
+			test_superproject_content origin/replace_sub1_with_directory &&
+			test_submodule_content sub1 origin/replace_sub1_with_directory
+		)
+	'
+	# ... absorbing a .git directory.
+	test_expect_success "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			rm -rf .git/modules &&
+			$command replace_sub1_with_directory &&
+			test_superproject_content origin/replace_sub1_with_directory &&
+			test_git_directory_exists sub1
+		)
+	'
+
+	# Replacing it with a file ...
+	test_expect_success "$command: replace submodule with a file" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			$command replace_sub1_with_file &&
+			test_superproject_content origin/replace_sub1_with_file &&
+			test -f sub1
+		)
+	'
+
+	# ... must check its local work tree for untracked files
+	test_expect_success "$command: replace submodule with a file must fail with untracked files" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			: >sub1/untrackedfile &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+
+	# ... and ignored files are ignroed
+	test_expect_success "$command: replace submodule with a file works ignores ignored files in submodule" '
+		test_when_finished "rm submodule_update/.git/modules/sub1/info/exclude" &&
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			: >sub1/ignored &&
+			$command replace_sub1_with_file &&
+			test_superproject_content origin/replace_sub1_with_file &&
+			test -f sub1
+		)
+	'
+
+	########################## Modified submodule #########################
+	# Updating a submodule sha1 updates the submodule's work tree
+	test_expect_success "$command: modified submodule updates submodule work tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+
+	# Updating a submodule to an invalid sha1 doesn't update the
+	# superproject nor the submodule's work tree.
+	test_expect_success "$command: updating to a missing submodule commit fails" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			test_must_fail $command invalid_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+
+	test_expect_success "$command: modified submodule updates submodule recursively" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			$command modify_sub1_recursively &&
+			test_superproject_content origin/modify_sub1_recursively &&
+			test_submodule_content sub1 origin/modify_sub1_recursively
+			test_submodule_content sub1/sub2
+		)
+	'
+}
+
+# Test that submodule contents are updated when switching between commits
+# that change a submodule, but throwing away local changes in
+# the superproject as well as the submodule is allowed.
+test_submodule_forced_switch_recursing () {
+	command="$1"
+	######################### Appearing submodule #########################
+	# Switching to a commit letting a submodule appear creates empty dir ...
+	test_expect_success "$command: added submodule is checked out" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... and doesn't care if it already exists ...
+	test_expect_success "$command: added submodule ignores empty directory" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			mkdir sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... not caring about an untracked file either
+	test_expect_success "$command: added submodule does remove untracked unignored file with same name when forced" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			>sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Replacing a tracked file with a submodule checks out the submodule
+	test_expect_success "$command: replace tracked file with submodule populates the submodule" '
+		prolog &&
+		reset_work_tree_to_interested replace_sub1_with_file &&
+		(
+			cd submodule_update &&
+			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			$command replace_file_with_sub1 &&
+			test_superproject_content origin/replace_file_with_sub1 &&
+			test_submodule_content sub1 origin/replace_file_with_sub1
+		)
+	'
+	# ... as does removing a directory with tracked files with a
+	# submodule.
+	test_expect_success "$command: replace directory with submodule" '
+		prolog &&
+		reset_work_tree_to_interested replace_sub1_with_directory &&
+		(
+			cd submodule_update &&
+			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			$command replace_directory_with_sub1 &&
+			test_superproject_content origin/replace_directory_with_sub1 &&
+			test_submodule_content sub1 origin/replace_directory_with_sub1
+		)
+	'
+
+	######################## Disappearing submodule #######################
+	# Removing a submodule doesn't remove its work tree ...
+	test_expect_success "$command: removed submodule leaves submodule directory and its contents in place" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			! test -e sub1
+		)
+	'
+	# ... especially when it contains a .git directory.
+	test_expect_success "$command: removed submodule leaves submodule containing a .git directory alone" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			replace_gitfile_with_git_dir sub1 &&
+			rm -rf .git/modules/sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			test_git_directory_exists sub1 &&
+			! test -e sub1
+		)
+	'
+	# Replacing a submodule with files in a directory ...
+	test_expect_success "$command: replace submodule with a directory" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/replace_sub1_with_directory
+		)
+	'
+	# ... absorbing a .git directory.
+	test_expect_success "$command: replace submodule containing a .git directory with a directory must fail" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			rm -rf .git/modules/sub1 &&
+			$command replace_sub1_with_directory &&
+			test_superproject_content origin/replace_sub1_with_directory &&
+			test_submodule_content sub1 origin/modify_sub1
+			test_git_directory_exists sub1
+		)
+	'
+	# Replacing it with a file
+	test_expect_success "$command: replace submodule with a file" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			$command replace_sub1_with_file &&
+			test_superproject_content origin/replace_sub1_with_file
+		)
+	'
+
+	# ... even if the submodule contains ignored files
+	test_expect_success "$command: replace submodule with a file ignoring ignored files" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			: > sub1/expect &&
+			$command replace_sub1_with_file &&
+			test_superproject_content origin/replace_sub1_with_file
+		)
+	'
+
+	# ... but stops for untracked files that would be lost
+	test_expect_success "$command: replace submodule with a file" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			: > sub1/untracked_file &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test -f sub1/untracked_file
+		)
+	'
+
+	########################## Modified submodule #########################
+	# Updating a submodule sha1 updates the submodule's work tree
+	test_expect_success "$command: modified submodule updates submodule work tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+	# Updating a submodule to an invalid sha1 doesn't update the
+	# submodule's work tree, subsequent update will fail
+	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			test_must_fail $command invalid_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Updating a submodule from an invalid sha1 updates
+	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
+		prolog &&
+		reset_work_tree_to_interested invalid_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t valid_sub1 origin/valid_sub1 &&
+			test_must_fail $command valid_sub1 &&
+			test_superproject_content origin/invalid_sub1
+		)
+	'
+}
-- 
2.12.0.rc0.16.gd1691994b4.dirty

