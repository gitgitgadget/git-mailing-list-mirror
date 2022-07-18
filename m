Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B98C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiGRVoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiGRVoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 17:44:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C5D5F69
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:44:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w5-20020a170902e88500b0016ce31d1d79so3944249plg.4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ApVXr7sBH3Rha6cMV6zMo0pM3/UDyJJj7K6zXFWybVY=;
        b=hZj2WwWHDyArf1Da+L3BAowr4h///v4HmNROs8+pCoMriTtzoCdkkWkKuuURNNB2r5
         DH5K51Z/XrSh0j2FGXC3hEP2/+PapCeleoqb+uzM1PmNTld8rONr7Y+BZdQpw/Jc1orf
         XzDiUyIbTYw50zAWx8znI1OC5MzrgudJY6MMFvxMbeBIw0mFUa0OWcUeozHyxGJ76jwe
         LDOge4I8xGo4tQ14MxS6Hon7iVUTkrquPI59jgVh/Kfmi2WGdrR+Bl+7popVc29ceBGp
         OQU6et8SSoJ9vAVdv8WzIcwliMh2wSVxawoSUaWLeIyc0MOAL4toLmqIRjHFrzFjrN4p
         NjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ApVXr7sBH3Rha6cMV6zMo0pM3/UDyJJj7K6zXFWybVY=;
        b=oFKAznpuLQezFaJJaNz4lcqdXnXxT2MeJnkzz81XdoHJY+iO9Mq2jdaqclBWGprk99
         oZhjlKY49aXIc819L+GvrMZYm6V9sGtDyO66s8vlaYvZro33dO59xvk8yKI/srPjHuCo
         EYKL0+wsiTANC3Xovee3X7OQp8bC8Wsyxs1KK7x2Eq+B5hWMI/vFkxoE9gpFhGzmGMFa
         VKtxvEr9YwKnZ/7xfkvejkN2dDA3KtE/LBnJ121hkF02fqUXY1OUPy3AwqU/OG5gJOsi
         USjvnN6Pn0onJSAExBjz9Ofdf5jalEU5lrxa4oy6/N1xABd+iLvdtk/BE5BPi7ZjJlRC
         XZ4g==
X-Gm-Message-State: AJIora/GkpchHYONq/sF6gDk7s9pcoajJK9HmwuJ06cmr0FzvwmaCvBe
        9nzHygCLJ5E9trMtukb+2vXDy2xm41o3W5qQV8cQ7K+z/11BnLWrhve4UdiPVKHpYK798XKqiQp
        tj8xcJNjj6/6728zbUGDD7S2vWr2fwNMLRz+Gsu6x0zuHHjlOk46HY8MjBnaIIiYtgA==
X-Google-Smtp-Source: AGRyM1sV8g/1U2JRSIr3Hl6X6cA0Sb7tNetMVXUo5XNvSTCYVV91t0jpxmsV+tjsdMRGMi0KQYEvgizUbIj81Js=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:314a:0:b0:412:b42c:693d with SMTP id
 x71-20020a63314a000000b00412b42c693dmr25731782pgx.20.1658180642781; Mon, 18
 Jul 2022 14:44:02 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:43:49 +0000
In-Reply-To: <20220712231935.2979727-1-calvinwan@google.com>
Message-Id: <20220718214349.3379328-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220712231935.2979727-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, chooglen@google.com,
        gitster@pobox.com, newren@gmail.com, levraiphilippeblain@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4:
 - Rebased onto gitster/master
 - Fixed test cases to work with only merge-ort (and not merge-recursive)

== Description ==

When attempting to merge in a superproject with conflicting submodule
pointers that cannot be fast-forwarded or trivially resolved, the merge
fails and git prints the following error:

Failed to merge submodule <submodule>
CONFLICT (submodule): Merge conflict in <submodule>
Automatic merge failed; fix conflicts and then commit the result.

Git is left in a conflicted state, which requires the user to:
 1. merge submodules or update submodules to an already existing
	commit that reflects the merge
 2. add submodules changes to the superproject
 3. finish merging superproject
These steps are non-obvious for newer submodule users to figure out
based on the error message and neither `git submodule status` nor `git
status` provide any useful pointers. 

Update error message to match the steps above. If git does not detect a 
merge resolution, the following is printed:

====

Failed to merge submodule <submodule>
CONFLICT (submodule): Merge conflict in <submodule>
Recursive merging with submodules currently only supports trivial cases.
Please manually handle the merging of each conflicted submodule.
This can be accomplished with the following steps:
 - go to submodule (<submodule>), and either merge commit <commit>
or update to an existing commit which has merged those changes
 - come back to superproject, and `git add <submodule>` to record the above merge or update
 - resolve any other conflicts in the superproject
 - commit the resulting index in the superproject
Automatic merge failed; fix conflicts and then commit the result.

====

If git detects a possible merge resolution, the following is printed:

====

Failed to merge submodule sub, but a possible merge resolution exists:
    <commit> Merge branch '<branch1>' into <branch2>

CONFLICT (submodule): Merge conflict in <submodule>
Recursive merging with submodules currently only supports trivial cases.
Please manually handle the merging of each conflicted submodule.
This can be accomplished with the following steps:
To manually complete the merge:
 - go to submodule (<submodule>), and either merge commit <commit>
or update to an existing commit which has merged those changes
such as one listed above
 - come back to superproject, and `git add <submodule>` to record the above merge or update
 - resolve any other conflicts in the superproject
 - commit the resulting index in the superproject
Automatic merge failed; fix conflicts and then commit the result.

====

If git detects multiple possible merge resolutions, the following is printed:

====

Failed to merge submodule sub, but multiple possible merges exist:
    <commit> Merge branch '<branch1>' into <branch2>
    <commit> Merge branch '<branch1>' into <branch3>

CONFLICT (submodule): Merge conflict in <submodule>
Recursive merging with submodules currently only supports trivial cases.
Please manually handle the merging of each conflicted submodule.
This can be accomplished with the following steps:
To manually complete the merge:
 - go to submodule (<submodule>), and either merge commit <commit>
or update to an existing commit which has merged those changes
such as one listed above
 - come back to superproject, and `git add <submodule>` to record the above merge or update
 - resolve any other conflicts in the superproject
 - commit the resulting index in the superproject
Automatic merge failed; fix conflicts and then commit the result.

== Previous Changes ==

Changes since v3:
Thank you again Elijah for the helpful feedback! I have removed any code
touching merge-recursive.c, and refactored the rest into merge-ort.c.
The error message has been updated as well as any relevant test cases. I
had added a jump in v3 to "ret:" in merge_submodule() to accomodate
early returns, but this has been proven to not be necessary since an
early return means the submodule was either renamed or deleted, and this
case is already taken care of with the message "CONFLICT (modify/delete):"

Changes since v2:
There are three major changes in this patch thanks to all the helpful
feedback! I have moved the print function from builtin/merge.c to
merge-ort.c and added it to merge_finalize() in merge-recursive.c and
merge_switch_to_result() in merge-ort.c. This allows other merge
machinery commands besides merge to print submodule conflict advice.

I have moved the check for submodule conflicts from process_entry() to 
merge_submodule(). This also required removing the early returns and
instead going to my submodule conflict check allowing us to pass back
information on whether git detected a possible merge resolution or not.

I have also updated the error message to better reflect the merge
status. Specifically, if git detects a possible merge resolution, the
error message now also suggest updating to one of those resolutions.

Other small changes: 
 - Moved fields that hold submodule conflict information to new object
 - Shortened printed commit id to DEFAULT_ABBREV
 - Added a test to t6437-submodule-merge.sh for merges with no
   resolution existence
 - Modified a test in t7402-submodule-rebase to show error message
   prints in other parts of the merge machinery

Changes since v1:
 - Removed advice to abort merge
 - Error message updated to contain more commit/submodule information

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 merge-ort.c                 | 56 +++++++++++++++++++++++++++++++++++++
 t/t6437-submodule-merge.sh  | 38 +++++++++++++++++++++----
 t/t7402-submodule-rebase.sh |  9 ++++--
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 01f150ef3b..125ee3c0d1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -292,6 +292,18 @@ struct rename_info {
 	int needed_limit;
 };
 
+struct conflicted_submodule_item {
+	char *oid;
+	char *path;
+	int resolution_exists;
+};
+
+struct conflicted_submodule_list {
+	struct conflicted_submodule_item *items;
+	size_t nr;
+	size_t alloc;
+};
+
 struct merge_options_internal {
 	/*
 	 * paths: primary data structure in all of merge ort.
@@ -387,6 +399,9 @@ struct merge_options_internal {
 
 	/* call_depth: recursion level counter for merging merge bases */
 	int call_depth;
+
+	/* field that holds submodule conflict information */
+	struct conflicted_submodule_list conflicted_submodules;
 };
 
 struct version_info {
@@ -1741,6 +1756,9 @@ static int merge_submodule(struct merge_options *opt,
 	struct commit *commit_o, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
+	struct conflicted_submodule_list *csub = &opt->priv->conflicted_submodules;
+	struct conflicted_submodule_item csub_item;
+	int resolution_exists = 0;
 
 	int i;
 	int search = !opt->priv->call_depth;
@@ -1835,6 +1853,7 @@ static int merge_submodule(struct merge_options *opt,
 			   "resolution exists: %s"),
 			 path, sb.buf);
 		strbuf_release(&sb);
+		resolution_exists = 1;
 		break;
 	default:
 		for (i = 0; i < merges.nr; i++)
@@ -1845,10 +1864,22 @@ static int merge_submodule(struct merge_options *opt,
 			 _("Failed to merge submodule %s, but multiple "
 			   "possible merges exist:\n%s"), path, sb.buf);
 		strbuf_release(&sb);
+		resolution_exists = 1;
 	}
 
 	object_array_clear(&merges);
 cleanup:
+	if (!ret) {
+		if (!csub) {
+			CALLOC_ARRAY(csub, 1);
+		}
+		csub_item.oid = xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV));
+		csub_item.path = xstrdup(path);
+		csub_item.resolution_exists = resolution_exists;
+		ALLOC_GROW(csub->items, csub->nr + 1, csub->alloc);
+		csub->items[csub->nr++] = csub_item;
+		opt->priv->conflicted_submodules = *csub;
+	}
 	repo_clear(&subrepo);
 	return ret;
 }
@@ -4412,6 +4443,29 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	return errs;
 }
 
+static void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub) {
+	if (csub && csub->nr > 0) {
+		int i;
+		printf(_("Recursive merging with submodules currently only supports trivial cases.\n"
+			"Please manually handle the merging of each conflicted submodule.\n"
+			"This can be accomplished with the following steps:\n"));
+		for (i = 0; i < csub->nr; i++) {
+			printf(_(" - go to submodule (%s), and either merge commit %s\n"
+				    "or update to an existing commit which has merged those changes\n"),
+					csub->items[i].path,
+					csub->items[i].oid);
+			if (csub->items[i].resolution_exists)
+				printf(_("such as one listed above\n"));
+		}
+		printf(_(" - come back to superproject, and `git add"));
+		for (i = 0; i < csub->nr; i++)
+			printf(_(" %s"), csub->items[i].path);
+		printf(_("` to record the above merge or update \n"
+			" - resolve any other conflicts in the superproject\n"
+			" - commit the resulting index in the superproject\n"));
+	}
+}
+
 void merge_display_update_messages(struct merge_options *opt,
 				   int detailed,
 				   struct merge_result *result)
@@ -4461,6 +4515,8 @@ void merge_display_update_messages(struct merge_options *opt,
 	}
 	string_list_clear(&olist, 0);
 
+	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
 			       opti->renames.needed_limit, 0);
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c253bf759a..84913525cf 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
 	 echo "file-c" > file-c &&
 	 git add file-c &&
 	 git commit -m "sub-c") &&
-	git commit -a -m "c" &&
+	git commit -a -m "c")
+'
 
+test_expect_success 'merging should conflict for non fast-forward' '
+	test_when_finished "git -C merge-search reset --hard" &&
+	(cd merge-search &&
+	 git checkout -b test-nonforward-a b &&
+	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	  then
+		test_must_fail git merge c >actual &&
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 	grep "$sub_expect" actual
+	  else
+		test_must_fail git merge c 2> actual
+	  fi)
+'
+
+test_expect_success 'finish setup for merge-search' '
+	(cd merge-search &&
 	git checkout -b d a &&
 	(cd sub &&
 	 git checkout -b sub-d sub-b &&
@@ -129,14 +146,16 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
 	 test_cmp expect actual)
 '
 
-test_expect_success 'merging should conflict for non fast-forward' '
+test_expect_success 'merging should conflict for non fast-forward (resolution exists)' '
 	(cd merge-search &&
-	 git checkout -b test-nonforward b &&
+	 git checkout -b test-nonforward-b b &&
 	 (cd sub &&
 	  git rev-parse --short sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 	grep "$sub_expect" actual
 	  else
 		test_must_fail git merge c 2> actual
 	  fi &&
@@ -161,7 +180,9 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 ) &&
 	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	 then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+		grep "$sub_expect" actual
 	 else
 		test_must_fail git merge c 2> actual
 	 fi &&
@@ -205,7 +226,12 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f)
+	test_must_fail git merge f >actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+    then
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
+		grep "$sub_expect" actual
+	fi)
 '
 
 
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..ebeca12a71 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should conflict' '
 	test_tick &&
 	git commit -m fourth &&
 
-	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
+	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
 	git ls-files -s submodule >actual &&
 	(
 		cd submodule &&
@@ -112,7 +112,12 @@ test_expect_success 'rebasing submodule that should conflict' '
 		echo "160000 $(git rev-parse HEAD^^) 2	submodule" &&
 		echo "160000 $(git rev-parse HEAD) 3	submodule"
 	) >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+    then
+		sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
+		grep "$sub_expect" actual_output
+	fi
 '
 
 test_done

base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
-- 
2.37.0.170.g444d1eabd0-goog

