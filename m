Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4369E2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbdKUWNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:13:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:40480 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdKUWNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:13:06 -0500
Received: by mail-io0-f195.google.com with SMTP id d123so5050808iog.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dNDoMOyn52UqyyFpt9hQwaZQ7lbTvssP9nQx8/B6Fbc=;
        b=awPOkwLEG7JgNtvF5l7fnTTR1UuGg6YwL4UkwoATGW1Ls7rvOA9EogrKhAU0i5p3nu
         9zQd9j3nuPkfwBqqvlkSxSiqRHuToXqb8Gy6poBsV7XvZfL1OzVeHKZ1lUJ21Te6WsU0
         gWihm13t3/6O2SReGNRXcWIkkFHV9U5/Uh2JrwiUJFSEvWhEbRJNtpvZyYT9BLssiWgh
         EhMOGk8bxP3CngDLellGsE+trMRsQkir50JNk1mtaTGjBZP3/uwSKwePpiN2cGRfvhhC
         W6FE0dKTHzhJhIPIDdb83TpmfRN/9DUT8OLTzbonmCGleaRTMbk9OwAD+SB3pWSXRzUE
         t7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dNDoMOyn52UqyyFpt9hQwaZQ7lbTvssP9nQx8/B6Fbc=;
        b=SbSfwNT7pz71hsqdYl4n7k7FeS5kdSsgDRj8KSvAQHRXCup0443Zjs4rcDXsnxrF5H
         oiP0JHmVVBo+LANwLwonOFqRP7foDtP5clOzpiTcqIsIxeGfcPjn994n6dQ6JBuSWdCe
         aal9tl29CR7KCq80YY+AQEUdtvR/oRh/aZcMJFzVxVQZ4kOOVOHR/c2MKy1Ej8kGWMup
         Q00DQdfBAVo5Bty0nRfPZ+dgSLwFL4ZrKojQdYuQe+S4B2zkH81xeMc6iH7bqUcHci3h
         V3nSMQqhb5mka9TC6IK+wxkk8KKD+ulvMNVF+k78CBsgRURPW/st9zzEi6MVsYnZ445P
         SZxw==
X-Gm-Message-State: AJaThX4XibP/1x73/Hdxnsug+l8hObb/kfXmJC/GMK8+WQZqXiAZwjRy
        6SIjhAWylWQbQZNafh5FZmBcDeUpopI=
X-Google-Smtp-Source: AGs4zMZEQYRSJQ76YnIZm1MqNFcsF/dujXEahsUOHm6Twx7Vvn8KRkUs4WnT9Qjht3Wpe2Ykuuy8BA==
X-Received: by 10.107.183.1 with SMTP id h1mr18696205iof.183.1511302385510;
        Tue, 21 Nov 2017 14:13:05 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id 126sm881051iov.21.2017.11.21.14.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Nov 2017 14:13:04 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] Tests: clean up submodule recursive helpers
Date:   Tue, 21 Nov 2017 14:12:56 -0800
Message-Id: <20171121221256.154741-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.317.g14c63a9dc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the work in commit d3b5a49 ("Tests: clean up and document
submodule helpers", 2017-11-08).

Factor out the commonalities from
test_submodule_switch_recursing_with_args() and
test_submodule_forced_switch_recursing_with_args() in
lib-submodule-update.sh, and document their usage. Some tests differ
slightly in their test assertions; I have used the superset of those
assertions in that case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I checked my work by using a custom diff patch to "anchor" one line into
never appearing as a minus/plus in the diff, so that I could more
clearly see the deletions and additions, then opening 3 terminals: one
showing the common part, one showing the non-forced part, and one
showing the forced part. I'll send that diff patch to the mailing list
shortly [1].

[1] With my diff patch, you can run:
DIFF_ANCHOR=test_submodule_switch_recursing_with_args git show
--patience --color-moved
---
 t/lib-submodule-update.sh | 343 +++++++++++++++++-----------------------------
 1 file changed, 125 insertions(+), 218 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index bb94c2320..f39ec3095 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -554,6 +554,10 @@ test_submodule_switch_common() {
 #  - if succeeds, once "git submodule update" is invoked, the contents of
 #    submodule directories are updated
 #
+# If the command under test is known to not work with submodules in certain
+# conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
+# below to 1.
+#
 # Use as follows:
 #
 # my_func () {
@@ -622,19 +626,11 @@ test_submodule_forced_switch () {
 # - Removing a submodule with a git directory absorbs the submodules
 #   git directory first into the superproject.
 
-test_submodule_switch_recursing_with_args () {
-	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
-	RESULTDS=success
-	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
-	then
-		RESULTDS=failure
-	fi
-	RESULTOI=success
-	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
-	then
-		RESULTOI=failure
-	fi
+# Internal function; use test_submodule_switch_recursing_with_args() or
+# test_submodule_forced_switch_recursing_with_args() instead.
+test_submodule_recursing_with_args_common() {
+	command="$1"
+
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -648,7 +644,7 @@ test_submodule_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	# ... ignoring an empty existing directory ...
+	# ... ignoring an empty existing directory.
 	test_expect_success "$command: added submodule is checked out in empty dir" '
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
@@ -661,34 +657,6 @@ test_submodule_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	# ... unless there is an untracked file in its place.
-	test_expect_success "$command: added submodule doesn't remove untracked file with same name" '
-		prolog &&
-		reset_work_tree_to_interested no_submodule &&
-		(
-			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
-			: >sub1 &&
-			test_must_fail $command add_sub1 &&
-			test_superproject_content origin/no_submodule &&
-			test_must_be_empty sub1
-		)
-	'
-	# ... but an ignored file is fine.
-	test_expect_$RESULTOI "$command: added submodule removes an untracked ignored file" '
-		test_when_finished "rm submodule_update/.git/info/exclude" &&
-		prolog &&
-		reset_work_tree_to_interested no_submodule &&
-		(
-			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
-			: >sub1 &&
-			echo sub1 >.git/info/exclude
-			$command add_sub1 &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
 	# Replacing a tracked file with a submodule produces a checked out submodule
 	test_expect_success "$command: replace tracked file with submodule checks out submodule" '
 		prolog &&
@@ -742,33 +710,6 @@ test_submodule_switch_recursing_with_args () {
 			test_git_directory_exists sub1
 		)
 	'
-	# Replacing a submodule with files in a directory must succeeds
-	# when the submodule is clean
-	test_expect_$RESULTDS "$command: replace submodule with a directory" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			$command replace_sub1_with_directory &&
-			test_superproject_content origin/replace_sub1_with_directory &&
-			test_submodule_content sub1 origin/replace_sub1_with_directory
-		)
-	'
-	# ... absorbing a .git directory.
-	test_expect_$RESULTDS "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			replace_gitfile_with_git_dir sub1 &&
-			rm -rf .git/modules &&
-			$command replace_sub1_with_directory &&
-			test_superproject_content origin/replace_sub1_with_directory &&
-			test_git_directory_exists sub1
-		)
-	'
 
 	# Replacing it with a file ...
 	test_expect_success "$command: replace submodule with a file" '
@@ -782,7 +723,11 @@ test_submodule_switch_recursing_with_args () {
 			test -f sub1
 		)
 	'
-
+	RESULTDS=success
+	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
+	then
+		RESULTDS=failure
+	fi
 	# ... must check its local work tree for untracked files
 	test_expect_$RESULTDS "$command: replace submodule with a file must fail with untracked files" '
 		prolog &&
@@ -794,21 +739,7 @@ test_submodule_switch_recursing_with_args () {
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-
-	# ... and ignored files are ignored
-	test_expect_success "$command: replace submodule with a file works ignores ignored files in submodule" '
-		test_when_finished "rm submodule_update/.git/modules/sub1/info/exclude" &&
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			: >sub1/ignored &&
-			$command replace_sub1_with_file &&
-			test_superproject_content origin/replace_sub1_with_file &&
-			test -f sub1
+			test -f sub1/untracked_file
 		)
 	'
 
@@ -825,19 +756,6 @@ test_submodule_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
-
-	test_expect_success "git -c submodule.recurse=true $cmd_args: modified submodule updates submodule work tree" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
-			git -c submodule.recurse=true $cmd_args modify_sub1 &&
-			test_superproject_content origin/modify_sub1 &&
-			test_submodule_content sub1 origin/modify_sub1
-		)
-	'
-
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# superproject nor the submodule's work tree.
 	test_expect_success "$command: updating to a missing submodule commit fails" '
@@ -851,126 +769,166 @@ test_submodule_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-
-	# recursing deeper than one level doesn't work yet.
-	test_expect_success "$command: modified submodule updates submodule recursively" '
-		prolog &&
-		reset_work_tree_to_interested add_nested_sub &&
-		(
-			cd submodule_update &&
-			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
-			$command modify_sub1_recursively &&
-			test_superproject_content origin/modify_sub1_recursively &&
-			test_submodule_content sub1 origin/modify_sub1_recursively &&
-			test_submodule_content -C sub1 sub2 origin/modify_sub1_recursively
-		)
-	'
 }
 
-# Test that submodule contents are updated when switching between commits
-# that change a submodule, but throwing away local changes in
-# the superproject as well as the submodule is allowed.
-test_submodule_forced_switch_recursing_with_args () {
+# Declares and invokes several tests that, in various situations, checks that
+# the provided Git command, when invoked with --recurse-submodules:
+#  - succeeds in updating the worktree and index of a superproject to a target
+#    commit, or fails atomically (depending on the test situation)
+#  - if succeeds, the contents of submodule directories are updated
+#
+# Specify the Git command so that "git $GIT_COMMAND --recurse-submodules"
+# works.
+#
+# If the command under test is known to not work with submodules in certain
+# conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
+# below to 1.
+#
+# Use as follows:
+#
+# test_submodule_switch_recursing_with_args "$GIT_COMMAND"
+test_submodule_switch_recursing_with_args () {
 	cmd_args="$1"
 	command="git $cmd_args --recurse-submodules"
-	RESULT=success
+	test_submodule_recursing_with_args_common "$command"
+
+	RESULTDS=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
-		RESULT=failure
+		RESULTDS=failure
 	fi
-	######################### Appearing submodule #########################
-	# Switching to a commit letting a submodule appear creates empty dir ...
-	test_expect_success "$command: added submodule is checked out" '
+	RESULTOI=success
+	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
+	then
+		RESULTOI=failure
+	fi
+	# Switching to a commit letting a submodule appear cannot override an
+	# untracked file.
+	test_expect_success "$command: added submodule doesn't remove untracked file with same name" '
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
+			: >sub1 &&
+			test_must_fail $command add_sub1 &&
+			test_superproject_content origin/no_submodule &&
+			test_must_be_empty sub1
 		)
 	'
-	# ... and doesn't care if it already exists ...
-	test_expect_success "$command: added submodule ignores empty directory" '
+	# ... but an ignored file is fine.
+	test_expect_$RESULTOI "$command: added submodule removes an untracked ignored file" '
+		test_when_finished "rm submodule_update/.git/info/exclude" &&
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			mkdir sub1 &&
+			: >sub1 &&
+			echo sub1 >.git/info/exclude
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	# ... not caring about an untracked file either
-	test_expect_success "$command: added submodule does remove untracked unignored file with same name when forced" '
+
+	# Replacing a submodule with files in a directory must succeeds
+	# when the submodule is clean
+	test_expect_$RESULTDS "$command: replace submodule with a directory" '
 		prolog &&
-		reset_work_tree_to_interested no_submodule &&
+		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
-			>sub1 &&
-			$command add_sub1 &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			$command replace_sub1_with_directory &&
+			test_superproject_content origin/replace_sub1_with_directory &&
+			test_submodule_content sub1 origin/replace_sub1_with_directory
 		)
 	'
-	# Replacing a tracked file with a submodule checks out the submodule
-	test_expect_success "$command: replace tracked file with submodule populates the submodule" '
+	# ... absorbing a .git directory.
+	test_expect_$RESULTDS "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
 		prolog &&
-		reset_work_tree_to_interested replace_sub1_with_file &&
+		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
-			$command replace_file_with_sub1 &&
-			test_superproject_content origin/replace_file_with_sub1 &&
-			test_submodule_content sub1 origin/replace_file_with_sub1
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			rm -rf .git/modules &&
+			$command replace_sub1_with_directory &&
+			test_superproject_content origin/replace_sub1_with_directory &&
+			test_git_directory_exists sub1
 		)
 	'
-	# ... as does removing a directory with tracked files with a
-	# submodule.
-	test_expect_success "$command: replace directory with submodule" '
+
+	# ... and ignored files are ignored
+	test_expect_success "$command: replace submodule with a file works ignores ignored files in submodule" '
+		test_when_finished "rm submodule_update/.git/modules/sub1/info/exclude" &&
 		prolog &&
-		reset_work_tree_to_interested replace_sub1_with_directory &&
+		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
-			$command replace_directory_with_sub1 &&
-			test_superproject_content origin/replace_directory_with_sub1 &&
-			test_submodule_content sub1 origin/replace_directory_with_sub1
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			: >sub1/ignored &&
+			$command replace_sub1_with_file &&
+			test_superproject_content origin/replace_sub1_with_file &&
+			test -f sub1
 		)
 	'
 
-	######################## Disappearing submodule #######################
-	# Removing a submodule doesn't remove its work tree ...
-	test_expect_success "$command: removed submodule leaves submodule directory and its contents in place" '
+	test_expect_success "git -c submodule.recurse=true $cmd_args: modified submodule updates submodule work tree" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
-			$command remove_sub1 &&
-			test_superproject_content origin/remove_sub1 &&
-			! test -e sub1
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -c submodule.recurse=true $cmd_args modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
-	# ... especially when it contains a .git directory.
-	test_expect_success "$command: removed submodule leaves submodule containing a .git directory alone" '
+
+	# recursing deeper than one level doesn't work yet.
+	test_expect_success "$command: modified submodule updates submodule recursively" '
 		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
+		reset_work_tree_to_interested add_nested_sub &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
-			replace_gitfile_with_git_dir sub1 &&
-			rm -rf .git/modules/sub1 &&
-			$command remove_sub1 &&
-			test_superproject_content origin/remove_sub1 &&
-			test_git_directory_exists sub1 &&
-			! test -e sub1
+			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			$command modify_sub1_recursively &&
+			test_superproject_content origin/modify_sub1_recursively &&
+			test_submodule_content sub1 origin/modify_sub1_recursively &&
+			test_submodule_content -C sub1 sub2 origin/modify_sub1_recursively
+		)
+	'
+}
+
+# Same as test_submodule_switch_recursing_with_args(), except that throwing
+# away local changes in the superproject is allowed.
+test_submodule_forced_switch_recursing_with_args () {
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
+	test_submodule_recursing_with_args_common "$command"
+
+	RESULT=success
+	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
+	then
+		RESULT=failure
+	fi
+	# Switching to a commit letting a submodule appear does not care about
+	# an untracked file.
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
 		)
 	'
+
 	# Replacing a submodule with files in a directory ...
 	test_expect_success "$command: replace submodule with a directory" '
 		prolog &&
@@ -997,17 +955,6 @@ test_submodule_forced_switch_recursing_with_args () {
 			test_git_directory_exists sub1
 		)
 	'
-	# Replacing it with a file
-	test_expect_success "$command: replace submodule with a file" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			$command replace_sub1_with_file &&
-			test_superproject_content origin/replace_sub1_with_file
-		)
-	'
 
 	# ... even if the submodule contains ignored files
 	test_expect_success "$command: replace submodule with a file ignoring ignored files" '
@@ -1022,46 +969,6 @@ test_submodule_forced_switch_recursing_with_args () {
 		)
 	'
 
-	# ... but stops for untracked files that would be lost
-	test_expect_$RESULT "$command: replace submodule with a file stops for untracked files" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			: >sub1/untracked_file &&
-			test_must_fail $command replace_sub1_with_file &&
-			test_superproject_content origin/add_sub1 &&
-			test -f sub1/untracked_file
-		)
-	'
-
-	########################## Modified submodule #########################
-	# Updating a submodule sha1 updates the submodule's work tree
-	test_expect_success "$command: modified submodule updates submodule work tree" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
-			$command modify_sub1 &&
-			test_superproject_content origin/modify_sub1 &&
-			test_submodule_content sub1 origin/modify_sub1
-		)
-	'
-	# Updating a submodule to an invalid sha1 doesn't update the
-	# submodule's work tree, subsequent update will fail
-	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t invalid_sub1 origin/invalid_sub1 &&
-			test_must_fail $command invalid_sub1 &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
 	# Updating a submodule from an invalid sha1 updates
 	test_expect_success "$command: modified submodule does update submodule work tree from invalid commit" '
 		prolog &&
-- 
2.15.0.317.g14c63a9dc.dirty

