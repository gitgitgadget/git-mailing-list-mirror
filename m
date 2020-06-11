Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45366C433E4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B516207ED
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2QWuHU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFKRmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFKRmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:08 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B100C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cv17so2984438qvb.13
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Rx4fbE1WJbONSTNGOLpLssvATQ97wiKhEbnVywPxfc=;
        b=G2QWuHU/ngSlMlZg3xYb1AfWwTP5MuPbE1LXaqm8XNWhFlYTJdgJ0isuOL2Jc27l/s
         LgZYqx9KOWc/8H/mUy/N9gA/GNKaJ8egGa73mKIE0KT8PDVOj2bMNHGiMB76uGmhhuZj
         pq7hB5+s6SFx8Y3r6LPgvAnokLJ42Pk3BVCadRRP/pKpNR0NpkZl1zI0PImpKf5Ub2pc
         bHkfv+bA5Jc7bTAEQ3GuiQQqNWwZq+2cUvSZsRj/Cl88LvcEH3Tlsh3QofAXHK9zw/Mf
         BzjuH+MqZFa4Jr6XZNl4/Z/QY0GnRWUOqU7OeWST48d4mqi4N/5hMDjw+miuInXWTn+0
         OXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Rx4fbE1WJbONSTNGOLpLssvATQ97wiKhEbnVywPxfc=;
        b=syzTWXHqOPZvNX6mIR2L3OxurTcir/vbEAlaG98s+VLsYr7alYgi5EbuzRIb8oALbz
         EONcJgjruZCX0buAkIyzSKKvsz9YVNHshcFHqJhjnqJaKh1sGcul6T5jgVk7KqfLV6n3
         9RjNdyuxr4B2cBvBMx/OfC+Q0JMTixwQfbg6IPgMcujKqfu1RQDhFKALqRoY1XwRxXTD
         mX2l3ZJKkeWhI7wTkEVOYi2Ny2uPZ7AfZBvrhSgH+UzguYfW+8Apf+BL6Q3vEZ205CSM
         omNSA5De9xq2E0dr2U6gkwcSsmXHMa/B45eYuCxznDujj/dRF6NT4Uime0No4pSYxCTH
         7LDg==
X-Gm-Message-State: AOAM533QiizNt456gERn3tfVfWv1xOncm+aQtgOmf14Cmv3aLA8kLqUE
        4/1znqsK1Yg4d9i/IH5iOQl8DrTYPkM=
X-Google-Smtp-Source: ABdhPJwFuDmUnckqrrtQWXkYydhDgQAywEa74KXWVDvjWGoAQKjU6GKFmjoFp+ambK98b/lh0TV8lQ==
X-Received: by 2002:ad4:5485:: with SMTP id q5mr8968329qvy.62.1591897326193;
        Thu, 11 Jun 2020 10:42:06 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f9sm3050703qtk.68.2020.06.11.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:42:05 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] lib-submodule-update: use callbacks in test_submodule_switch_common()
Date:   Thu, 11 Jun 2020 13:41:50 -0400
Message-Id: <74e6086da451a4ce2ac52b04a2399ef332d61047.1591897173.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1591897173.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1591897173.git.liu.denton@gmail.com>
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

Instead of invoking $command as one monolithic helper function, break it
up into three parts:

	1. $command which is always a git command.
	2. $before which is a callback function that runs just prior to
	   $command.
	3. $after which is a callback function that runs just after
	   $command.

If the command requires a filename argument, specify it as `\$arg` since
that variable will be set and the whole $command string will be eval'd.
Unfortunately, there is no way to get rid of the eval as some of the
commands are passed (such as the `git pull` tests) require that no
additional arguments are passed so we must have some mechanism for the
caller to specify whether or not it wants the filename argument.

The $before and $after callback functions will be passed the filename as
the first arg. These callback functions are optional and, if missing,
will be replaced with `true`. Also, in the case where we have a
`test_must_fail` test, $after will not be executed, similar to how the
helper functions currently behave when the git command fails and exits
the &&-chain.

Finally, as an added bonus, `test_must_fail` will only run on $command
which is guaranteed to be a git command.

An alternate design was considered where the $OVERWRITING_FAIL is set
from the test_submodule_switch_common() function and passed to the
helper function. This approach was considered too difficult to
understand due to the fact that using a signalling magic environment
variable might be too indirect.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh   | 95 +++++++++++++++++++++++++++++--------
 t/t3426-rebase-submodule.sh | 10 ++--
 t/t3513-revert-submodule.sh | 10 ++--
 t/t3906-stash-submodule.sh  | 10 ++--
 t/t4137-apply-submodule.sh  | 12 ++---
 t/t4255-am-submodule.sh     | 12 ++---
 t/t5572-pull-submodule.sh   | 28 ++---------
 t/t6041-bisect-submodule.sh | 10 ++--
 8 files changed, 108 insertions(+), 79 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 7c3ba1be00..988d85bd7d 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -310,7 +310,20 @@ test_submodule_content () {
 # Internal function; use test_submodule_switch_func(), test_submodule_switch(),
 # or test_submodule_forced_switch() instead.
 test_submodule_switch_common () {
-	command="$1"
+	command="$1" # should be a git command
+	before="$2"
+	after="$3"
+
+	if test -z "$before"
+	then
+		before=true
+	fi
+
+	if test -z "$after"
+	then
+		after=true
+	fi
+
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
 	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
@@ -326,7 +339,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
+			arg=add_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -341,7 +357,10 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			mkdir sub1 &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
+			arg=add_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -356,7 +375,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
-			$command replace_file_with_sub1 &&
+			arg=replace_file_with_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -380,7 +402,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
-			$command replace_directory_with_sub1 &&
+			arg=replace_directory_with_sub1  &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -402,7 +427,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t remove_sub1 origin/remove_sub1 &&
-			$command remove_sub1 &&
+			arg=remove_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/remove_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -415,7 +443,10 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
-			$command remove_sub1 &&
+			arg=remove_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/remove_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -443,7 +474,9 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			arg=replace_sub1_with_directory &&
+			$before "$arg" &&
+			eval test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -456,7 +489,9 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			arg=replace_sub1_with_directory &&
+			$before "$arg" &&
+			eval test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -470,7 +505,9 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
+			arg=replace_sub1_with_file &&
+			$before "$arg" &&
+			eval test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -484,7 +521,9 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
+			arg=replace_sub1_with_file &&
+			$before "$arg" &&
+			eval test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -508,7 +547,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t modify_sub1 origin/modify_sub1 &&
-			$command modify_sub1 &&
+			arg=modify_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
 			git submodule update &&
@@ -523,7 +565,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t invalid_sub1 origin/invalid_sub1 &&
-			$command invalid_sub1 &&
+			arg=invalid_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/invalid_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
 			test_must_fail git submodule update &&
@@ -538,7 +583,10 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t valid_sub1 origin/valid_sub1 &&
-			$command valid_sub1 &&
+			arg=valid_sub1 &&
+			$before "$arg" &&
+			eval $command &&
+			$after "$arg" &&
 			test_superproject_content origin/valid_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -568,8 +616,10 @@ test_submodule_switch_common () {
 # }
 # test_submodule_switch_func "my_func"
 test_submodule_switch_func () {
-	command="$1"
-	test_submodule_switch_common "$command"
+	command="git $1"
+	before="$2"
+	after="$3"
+	test_submodule_switch_common "$command" "$before" "$after"
 
 	# An empty directory does not prevent the creation of a submodule of
 	# the same name, but a file does.
@@ -580,7 +630,9 @@ test_submodule_switch_func () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			test_must_fail $command add_sub1 &&
+			arg=add_sub1 &&
+			$before "$arg" &&
+			eval test_must_fail $command &&
 			test_superproject_content origin/no_submodule &&
 			test_must_be_empty sub1
 		)
@@ -588,15 +640,15 @@ test_submodule_switch_func () {
 }
 
 test_submodule_switch () {
-	test_submodule_switch_func "git $1"
+	test_submodule_switch_func "$1 \$arg"
 }
 
 # Same as test_submodule_switch(), except that throwing away local changes in
 # the superproject is allowed.
 test_submodule_forced_switch () {
-	command="$1"
+	command="git $1 \$arg"
 	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
-	test_submodule_switch_common "git $command"
+	test_submodule_switch_common "$command"
 
 	# When forced, a file in the superproject does not prevent creating a
 	# submodule of the same name.
@@ -607,7 +659,8 @@ test_submodule_forced_switch () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			$command add_sub1 &&
+			arg=add_sub1 &&
+			eval $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1
 		)
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 788605ccc0..d31e6487bd 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -16,11 +16,10 @@ git_rebase () {
 	git revert HEAD &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
-	test_cmp expect actual &&
-	git rebase "$1"
+	test_cmp expect actual
 }
 
-test_submodule_switch_func "git_rebase"
+test_submodule_switch_func "rebase \$arg" "git_rebase"
 
 git_rebase_interactive () {
 	git status -su >expect &&
@@ -34,11 +33,10 @@ git_rebase_interactive () {
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
 	set_fake_editor &&
-	echo "fake-editor.sh" >.git/info/exclude &&
-	git rebase -i "$1"
+	echo "fake-editor.sh" >.git/info/exclude
 }
 
-test_submodule_switch_func "git_rebase_interactive"
+test_submodule_switch_func "rebase -i \$arg" "git_rebase_interactive"
 
 test_expect_success 'rebase interactive ignores modified submodules' '
 	test_when_finished "rm -rf super sub" &&
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 95a7f64471..994cdc40f0 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -11,11 +11,13 @@ test_description='revert can handle submodules'
 # first so we can restore the work tree test setup after doing the checkout
 # and revert.  We test here that the restored work tree content is identical
 # to that at the beginning. The last revert is then tested by the framework.
-git_revert () {
+git_revert_before () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
-	git checkout "$1" &&
+	tar cf "$TRASH_DIRECTORY/tmp.tar" *
+}
+
+git_revert_after () {
 	git revert HEAD &&
 	rm -rf * &&
 	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
@@ -26,6 +28,6 @@ git_revert () {
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch_func "git_revert"
+test_submodule_switch_func "checkout \$arg" "git_revert_before" "git_revert_after"
 
 test_done
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 6a7e801ca0..358a625124 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -5,10 +5,12 @@ test_description='stash can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-git_stash () {
+git_stash_before () {
 	git status -su >expect &&
-	ls -1pR * >>expect &&
-	git read-tree -u -m "$1" &&
+	ls -1pR * >>expect
+}
+
+git_stash_after () {
 	git stash &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
@@ -19,7 +21,7 @@ git_stash () {
 KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
 KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch_func "git_stash"
+test_submodule_switch_func "read-tree -u -m \$arg" "git_stash_before" "git_stash_after"
 
 setup_basic () {
 	test_when_finished "rm -rf main sub" &&
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index b645e303a0..fe5ebeaa41 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -5,16 +5,12 @@ test_description='git apply handling submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-apply_index () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --index -
+create_diff () {
+	git diff --ignore-submodules=dirty "..$1" >diff
 }
 
-test_submodule_switch_func "apply_index"
+test_submodule_switch_func "apply --index diff" "create_diff"
 
-apply_3way () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
-}
-
-test_submodule_switch_func "apply_3way"
+test_submodule_switch_func "apply --3way diff" "create_diff"
 
 test_done
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 1b179d5f45..5305280dfd 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -5,18 +5,14 @@ test_description='git am handling submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-am () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
+create_patch () {
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch
 }
 
-test_submodule_switch_func "am"
-
-am_3way () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
-}
+test_submodule_switch_func "am patch" "create_patch"
 
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch_func "am_3way"
+test_submodule_switch_func "am --3way patch" "create_patch"
 
 test_expect_success 'setup diff.submodule' '
 	test_commit one &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f911bf631e..3b37853537 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -11,36 +11,16 @@ reset_branch_to_HEAD () {
 	git branch --set-upstream-to="origin/$1" "$1"
 }
 
-git_pull () {
-	reset_branch_to_HEAD "$1" &&
-	git pull
-}
-
 # pulls without conflicts
-test_submodule_switch_func "git_pull"
+test_submodule_switch_func "pull" "reset_branch_to_HEAD"
 
-git_pull_ff () {
-	reset_branch_to_HEAD "$1" &&
-	git pull --ff
-}
+test_submodule_switch_func "pull --ff" "reset_branch_to_HEAD"
 
-test_submodule_switch_func "git_pull_ff"
-
-git_pull_ff_only () {
-	reset_branch_to_HEAD "$1" &&
-	git pull --ff-only
-}
-
-test_submodule_switch_func "git_pull_ff_only"
-
-git_pull_noff () {
-	reset_branch_to_HEAD "$1" &&
-	git pull --no-ff
-}
+test_submodule_switch_func "pull --ff-only" "reset_branch_to_HEAD"
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch_func "git_pull_noff"
+test_submodule_switch_func "pull --no-ff" "reset_branch_to_HEAD"
 
 test_expect_success 'pull --recurse-submodule setup' '
 	test_create_repo child &&
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 0e0cdf638d..b99e81d55d 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -5,12 +5,14 @@ test_description='bisect can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-git_bisect () {
+git_bisect_before () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
-	GOOD=$(git rev-parse --verify HEAD) &&
-	git checkout "$1" &&
+	GOOD=$(git rev-parse --verify HEAD)
+}
+
+git_bisect_after () {
 	echo "foo" >bar &&
 	git add bar &&
 	git commit -m "bisect bad" &&
@@ -27,6 +29,6 @@ git_bisect () {
 	git bisect bad $BAD
 }
 
-test_submodule_switch_func "git_bisect"
+test_submodule_switch_func "checkout \$arg" "git_bisect_before" "git_bisect_after"
 
 test_done
-- 
2.27.0.132.g321788e831

