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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F5C433E2
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEAE20836
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5Se4o8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgFKRmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKRmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:06 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D8C03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y1so5166700qtv.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igzrfi3WnJfvDZtO6KqpeiQtuUtzj80ciMuQ43kGxlw=;
        b=b5Se4o8ZqbV5DblrRFf7OILcsTKNneuwCrPaxPjv0tA1kwuY11NTqThCqYLykkDp61
         C1GFRj28KeSeD4sIgTCoRaXsHtBBNWr8MkH7TGGjqJrLfM/uaGaCDwwX2SphtBArqYW+
         FOEY6zMNnsDMgaRoAl8pNyVaMKytV9DT1QLf5ooN6KfP2pbp5ry6uOZ7xs7loYuYGNQV
         MVln5be1wkidIZi5C1rq+lAsvwteLD8ZDWJWnN/lYQ1ceZ6n1m8WwR0jpwKnozsXQizJ
         CwcO1Thoe02F58ceKsvsgZrafxJtGid+uM0OMKea7hmaO75HhsE+4jZFumiiQ4bavPdZ
         BFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igzrfi3WnJfvDZtO6KqpeiQtuUtzj80ciMuQ43kGxlw=;
        b=uE4y46IrvVYR2UX5+7G98hZmg1ygE0F9uav0Lg+4wT+PmM1/MYAK+bOU6cLhRpaaOu
         li9Pio5vKXjbBgUbhAQ2tjaTB18gHoyoosW9YuAbhzWPGZWHqLsek2/IHLBPv25j6joG
         uOhX+PNs8tq4qVO5yaii4nIU0Bc5lJykUksyeszBwGtYxIKbcxW8qtqtmyU9oZ//7WxD
         Mn1OD/VkypLWk454AkJtxUXcsNBZ4zQ5BPKUijxCLCYku9qLIQ+j83KP4Oo9ue8AbABX
         68uhWs+QKj9ax+CiXvqCyqe/KrqIEMiKNSv3skiSfk0hSJc7czoLev7oT/kEQZos5Dsd
         7Hgg==
X-Gm-Message-State: AOAM532D2CpraKqqmasMn1b1GZtZ0gM8az4AH52JtcBmNFv/MLcMS7uH
        n59GbAr49WBsa2xtYnHe6zFqS93TL10=
X-Google-Smtp-Source: ABdhPJxoCGY6obWjrgZWBIP0GKE7Wan4ytb2S36DIDNGNdV+S5Of+CsxWscOHFdx+FwXpfQD1+rYFQ==
X-Received: by 2002:aed:3123:: with SMTP id 32mr9995476qtg.366.1591897324776;
        Thu, 11 Jun 2020 10:42:04 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f9sm3050703qtk.68.2020.06.11.10.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:42:04 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] lib-submodule-update: prepend "git" to $command
Date:   Thu, 11 Jun 2020 13:41:49 -0400
Message-Id: <09446be5b9e9d6291dae3531a93b588e0b7a1c3f.1591897173.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1591897173.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1591897173.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since all invocations of test_submodule_forced_switch() are git
commands, automatically prepend "git" before invoking
test_submodule_switch_common().

Similarly, many invocations of test_submodule_switch() are also git
commands so automatically prepend "git" before invoking
test_submodule_switch_common() as well.

Finally, for invocations of test_submodule_switch() that invoke a custom
function, rename the old function to test_submodule_switch_func().

This is necessary because in a future commit, we will be adding some
logic that needs to distinguish between an invocation of a plain git
comamnd and an invocation of a test helper function.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh        | 14 +++++++++-----
 t/t1013-read-tree-submodule.sh   |  4 ++--
 t/t2013-checkout-submodule.sh    |  4 ++--
 t/t3426-rebase-submodule.sh      |  4 ++--
 t/t3512-cherry-pick-submodule.sh |  2 +-
 t/t3513-revert-submodule.sh      |  2 +-
 t/t3906-stash-submodule.sh       |  2 +-
 t/t4137-apply-submodule.sh       |  4 ++--
 t/t4255-am-submodule.sh          |  4 ++--
 t/t5572-pull-submodule.sh        |  8 ++++----
 t/t6041-bisect-submodule.sh      |  2 +-
 t/t7112-reset-submodule.sh       |  6 +++---
 t/t7613-merge-submodule.sh       |  8 ++++----
 13 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index bb36287803..7c3ba1be00 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -307,8 +307,8 @@ test_submodule_content () {
 # to protect the history!
 #
 
-# Internal function; use test_submodule_switch() or
-# test_submodule_forced_switch() instead.
+# Internal function; use test_submodule_switch_func(), test_submodule_switch(),
+# or test_submodule_forced_switch() instead.
 test_submodule_switch_common () {
 	command="$1"
 	######################### Appearing submodule #########################
@@ -566,8 +566,8 @@ test_submodule_switch_common () {
 #   # Do something here that updates the worktree and index to match target,
 #   # but not any submodule directories.
 # }
-# test_submodule_switch "my_func"
-test_submodule_switch () {
+# test_submodule_switch_func "my_func"
+test_submodule_switch_func () {
 	command="$1"
 	test_submodule_switch_common "$command"
 
@@ -587,12 +587,16 @@ test_submodule_switch () {
 	'
 }
 
+test_submodule_switch () {
+	test_submodule_switch_func "git $1"
+}
+
 # Same as test_submodule_switch(), except that throwing away local changes in
 # the superproject is allowed.
 test_submodule_forced_switch () {
 	command="$1"
 	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
-	test_submodule_switch_common "$command"
+	test_submodule_switch_common "git $command"
 
 	# When forced, a file in the superproject does not prevent creating a
 	# submodule of the same name.
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 91a6fafcb4..b6df7444c0 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -12,8 +12,8 @@ test_submodule_switch_recursing_with_args "read-tree -u -m"
 
 test_submodule_forced_switch_recursing_with_args "read-tree -u --reset"
 
-test_submodule_switch "git read-tree -u -m"
+test_submodule_switch "read-tree -u -m"
 
-test_submodule_forced_switch "git read-tree -u --reset"
+test_submodule_forced_switch "read-tree -u --reset"
 
 test_done
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 8f86b5f4b2..b2bdd1fcb4 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -68,8 +68,8 @@ test_submodule_switch_recursing_with_args "checkout"
 
 test_submodule_forced_switch_recursing_with_args "checkout -f"
 
-test_submodule_switch "git checkout"
+test_submodule_switch "checkout"
 
-test_submodule_forced_switch "git checkout -f"
+test_submodule_forced_switch "checkout -f"
 
 test_done
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index a2bba04ba9..788605ccc0 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -20,7 +20,7 @@ git_rebase () {
 	git rebase "$1"
 }
 
-test_submodule_switch "git_rebase"
+test_submodule_switch_func "git_rebase"
 
 git_rebase_interactive () {
 	git status -su >expect &&
@@ -38,7 +38,7 @@ git_rebase_interactive () {
 	git rebase -i "$1"
 }
 
-test_submodule_switch "git_rebase_interactive"
+test_submodule_switch_func "git_rebase_interactive"
 
 test_expect_success 'rebase interactive ignores modified submodules' '
 	test_when_finished "rm -rf super sub" &&
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index bd78287841..6ece1d8573 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -7,7 +7,7 @@ test_description='cherry-pick can handle submodules'
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git cherry-pick"
+test_submodule_switch "cherry-pick"
 
 test_expect_success 'unrelated submodule/file conflict is ignored' '
 	test_create_repo sub &&
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 5e39fcdb66..95a7f64471 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -26,6 +26,6 @@ git_revert () {
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch "git_revert"
+test_submodule_switch_func "git_revert"
 
 test_done
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index b93d1d74da..6a7e801ca0 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -19,7 +19,7 @@ git_stash () {
 KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
 KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch "git_stash"
+test_submodule_switch_func "git_stash"
 
 setup_basic () {
 	test_when_finished "rm -rf main sub" &&
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index a9bd40a6d0..b645e303a0 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -9,12 +9,12 @@ apply_index () {
 	git diff --ignore-submodules=dirty "..$1" | git apply --index -
 }
 
-test_submodule_switch "apply_index"
+test_submodule_switch_func "apply_index"
 
 apply_3way () {
 	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
 }
 
-test_submodule_switch "apply_3way"
+test_submodule_switch_func "apply_3way"
 
 test_done
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 0ba8194403..1b179d5f45 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -9,14 +9,14 @@ am () {
 	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
 }
 
-test_submodule_switch "am"
+test_submodule_switch_func "am"
 
 am_3way () {
 	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
 }
 
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "am_3way"
+test_submodule_switch_func "am_3way"
 
 test_expect_success 'setup diff.submodule' '
 	test_commit one &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f916729a12..f911bf631e 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -17,21 +17,21 @@ git_pull () {
 }
 
 # pulls without conflicts
-test_submodule_switch "git_pull"
+test_submodule_switch_func "git_pull"
 
 git_pull_ff () {
 	reset_branch_to_HEAD "$1" &&
 	git pull --ff
 }
 
-test_submodule_switch "git_pull_ff"
+test_submodule_switch_func "git_pull_ff"
 
 git_pull_ff_only () {
 	reset_branch_to_HEAD "$1" &&
 	git pull --ff-only
 }
 
-test_submodule_switch "git_pull_ff_only"
+test_submodule_switch_func "git_pull_ff_only"
 
 git_pull_noff () {
 	reset_branch_to_HEAD "$1" &&
@@ -40,7 +40,7 @@ git_pull_noff () {
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git_pull_noff"
+test_submodule_switch_func "git_pull_noff"
 
 test_expect_success 'pull --recurse-submodule setup' '
 	test_create_repo child &&
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 62b8a2e7bb..0e0cdf638d 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -27,6 +27,6 @@ git_bisect () {
 	git bisect bad $BAD
 }
 
-test_submodule_switch "git_bisect"
+test_submodule_switch_func "git_bisect"
 
 test_done
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index a1cb9ff858..8741b665c9 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -13,10 +13,10 @@ test_submodule_switch_recursing_with_args "reset --keep"
 
 test_submodule_forced_switch_recursing_with_args "reset --hard"
 
-test_submodule_switch "git reset --keep"
+test_submodule_switch "reset --keep"
 
-test_submodule_switch "git reset --merge"
+test_submodule_switch "reset --merge"
 
-test_submodule_forced_switch "git reset --hard"
+test_submodule_forced_switch "reset --hard"
 
 test_done
diff --git a/t/t7613-merge-submodule.sh b/t/t7613-merge-submodule.sh
index d1e9fcc781..04bf4be7d7 100755
--- a/t/t7613-merge-submodule.sh
+++ b/t/t7613-merge-submodule.sh
@@ -6,14 +6,14 @@ test_description='merge can handle submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 # merges without conflicts
-test_submodule_switch "git merge"
+test_submodule_switch "merge"
 
-test_submodule_switch "git merge --ff"
+test_submodule_switch "merge --ff"
 
-test_submodule_switch "git merge --ff-only"
+test_submodule_switch "merge --ff-only"
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git merge --no-ff"
+test_submodule_switch "merge --no-ff"
 
 test_done
-- 
2.27.0.132.g321788e831

