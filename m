Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90518C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiGLXTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiGLXTp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:19:45 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61811AD84D
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:19:44 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d83-20020a621d56000000b00528ce187233so2859953pfd.23
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x1kRuIq1W3Fzpa6EUo35EgmB66vn0IDRgw26a3WVSSA=;
        b=L3kQhvQgXQc883iNz63nn4tAmH8E6XJm6YBcacpvmSCXAJn6/kHCMYeAyddvWBSK5k
         4P0cKawI8ATbpoi/t9/jESInheQ5JJDIE6j0zYeQv6JDQH1a78VTt/N8k/i9uM/sSRHk
         V8pQOxkmxe5hcD9ldjLzvY0SqF1/MgVQFOMKcE647hf8XPeJUap2qsEAvU+JFm+pGtEX
         pF2G1DZqC3GyqlSCcckWjlQPTYudLkbmEsWFZM3hCGTsEnGDSlf4vhp/xbcTKWPUhwnN
         y0x9astWG+ERdrridXK6mJuJ0DPr6dno83SwsF14QyRNmAutUKzNgHX/M24Vuerk3Gfo
         GDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x1kRuIq1W3Fzpa6EUo35EgmB66vn0IDRgw26a3WVSSA=;
        b=Mmzgk6fRWcjGxeKBSm+15PHWvcbKHsUGU0qr0SJGuq/iDFgLguAvkyScRjAuTioXo0
         1fIV2Mi461qwlHIyjupCPwj3qdUFY/plPjpNRw7ycGJmWKqglKMwIWO++ET+ZM8stygE
         huFUVPXhLBZcsJrDfBDh9/4NtbAGAi/7cuIc/MG1lDzo+7S+G6aJg1wEvncchvlWdOFO
         TJ7eKsdUhAUTjH1/jWwCI0KwxXIuxc70xtJpJ6ZJWL4Gxq+CJcgA7ZSGr1lVuOdA3qvT
         pcwVpyyZM3Lg3dIrL2tgrU6uBo5ecHxxxKxwSxU3F4pkXh83i8c8emVEFRpLtUYcNQd9
         iTCw==
X-Gm-Message-State: AJIora+4tKcFFOzwqhxyrWrXw5hdbXy9ymLo2EFykcSEjww74SxBEuBu
        clUnqbtqHfA8/QPafzIXEEf0RYAgIKnxESvliIUWt1IoIu4zl/ZvavyG3BXn20qg77823bHTQ01
        OOtuorLml4CH3YI0mM+gNmC/oJsUI8qEPih05mCuA75b1U5kMJE5XDHfgcYKA6pQ0cg==
X-Google-Smtp-Source: AGRyM1vJ1JUFl6+bhk1y2AKr0uW0V6K1B0nRRy9t1H2LL8h0XNvhSiNgjVYBibIXtyrtggIEJ8y84dChHTwItI0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1a49:b0:528:6ea0:14e2 with SMTP
 id h9-20020a056a001a4900b005286ea014e2mr459610pfv.22.1657667983795; Tue, 12
 Jul 2022 16:19:43 -0700 (PDT)
Date:   Tue, 12 Jul 2022 23:19:35 +0000
In-Reply-To: <20220629224059.1016645-1-calvinwan@google.com>
Message-Id: <20220712231935.2979727-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v4] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, chooglen@google.com,
        gitster@pobox.com, newren@gmail.com, levraiphilippeblain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies to any reviewers for the late v4 -- was OOO

Changes since v3:
Thank you again Elijah for the helpful feedback! I have removed any code
touching merge-recursive.c, and refactored the rest into merge-ort.c.
The error message has been updated as well as any relevant test cases. I
had added a jump in v3 to "ret:" in merge_submodule() to accomodate
early returns, but this has been proven to not be necessary since an
early return means the submodule was either renamed or deleted, and this
case is already taken care of with the message "CONFLICT (modify/delete):"

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
 t/t6437-submodule-merge.sh  | 31 +++++++++++++++++---
 t/t7402-submodule-rebase.sh |  6 ++--
 3 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0d3f42592f..872d924f58 100644
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
@@ -385,6 +397,9 @@ struct merge_options_internal {
 
 	/* call_depth: recursion level counter for merging merge bases */
 	int call_depth;
+
+	/* field that holds submodule conflict information */
+	struct conflicted_submodule_list conflicted_submodules;
 };
 
 struct version_info {
@@ -1610,6 +1625,9 @@ static int merge_submodule(struct merge_options *opt,
 	struct commit *commit_o, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
+	struct conflicted_submodule_list *csub = &opt->priv->conflicted_submodules;
+	struct conflicted_submodule_item csub_item;
+	int resolution_exists = 0;
 
 	int i;
 	int search = !opt->priv->call_depth;
@@ -1703,6 +1721,7 @@ static int merge_submodule(struct merge_options *opt,
 			   "which will accept this suggestion.\n"),
 			 oid_to_hex(&merges.objects[0].item->oid), path);
 		strbuf_release(&sb);
+		resolution_exists = 1;
 		break;
 	default:
 		for (i = 0; i < merges.nr; i++)
@@ -1712,10 +1731,22 @@ static int merge_submodule(struct merge_options *opt,
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
@@ -4256,6 +4287,29 @@ static int record_conflicted_index_entries(struct merge_options *opt)
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
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
@@ -4324,6 +4378,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		}
 		string_list_clear(&olist, 0);
 
+		print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+
 		/* Also include needed rename limit adjustment now */
 		diff_warn_rename_limit("merge.renamelimit",
 				       opti->renames.needed_limit, 0);
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 178413c22f..cc1a312661 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
 	 echo "file-c" > file-c &&
 	 git add file-c &&
 	 git commit -m "sub-c") &&
-	git commit -a -m "c" &&
+	git commit -a -m "c")
+'
+
+test_expect_success 'merging should conflict for non fast-forward' '
+	(cd merge-search &&
+	 git checkout -b test-nonforward-a b &&
+	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	  then
+		test_must_fail git merge c >actual
+	  else
+		test_must_fail git merge c 2> actual
+	  fi &&
+	 sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 grep "$sub_expect" actual &&
+	 git reset --hard)
+'
 
+test_expect_success 'finish setup for merge-search' '
+	(cd merge-search &&
 	git checkout -b d a &&
 	(cd sub &&
 	 git checkout -b sub-d sub-b &&
@@ -129,9 +146,9 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
 	 test_cmp expect actual)
 '
 
-test_expect_success 'merging should conflict for non fast-forward' '
+test_expect_success 'merging should conflict for non fast-forward (resolution exists)' '
 	(cd merge-search &&
-	 git checkout -b test-nonforward b &&
+	 git checkout -b test-nonforward-b b &&
 	 (cd sub &&
 	  git rev-parse sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
@@ -141,6 +158,8 @@ test_expect_success 'merging should conflict for non fast-forward' '
 		test_must_fail git merge c 2> actual
 	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
+	 sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 grep "$sub_expect" actual &&
 	 git reset --hard)
 '
 
@@ -167,6 +186,8 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
+	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	grep "$sub_expect" actual &&
 	git reset --hard)
 '
 
@@ -205,7 +226,9 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f)
+	test_must_fail git merge f >actual &&
+	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
+	grep "$sub_expect" actual)
 '
 
 
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..f1bb29681f 100755
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
@@ -112,7 +112,9 @@ test_expect_success 'rebasing submodule that should conflict' '
 		echo "160000 $(git rev-parse HEAD^^) 2	submodule" &&
 		echo "160000 $(git rev-parse HEAD) 3	submodule"
 	) >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
+	grep "$sub_expect" actual_output
 '
 
 test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
2.37.0.144.g8ac04bfd2-goog

