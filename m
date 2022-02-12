Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FFEC433FE
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiBLUfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBLUfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9692606E5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v12so20717990wrv.2
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BI2XPKuQkY8KatSiVlkfJXv4UIQhhGiLSSJo2kE67sQ=;
        b=bbm17XjIFCNZzJ7fhRvv0W7ciS2n8yfHZKVXyEl9pIJDnx1OE1OsAZKfR2e+h1LgYU
         7Tl2F6HZstRrj8S5ipOAbUzddoJBRC0aWwYH8ljgg3MwHtuXqnDvuXSp6+oPmhC6uIEr
         XqoRathGsDeUSNJqH/E3xoXF88eRkFWNhoGE7tis0dJLeQd/5AQv39ip1cT7Lmnud3ai
         kk9fKDdsOCziJG6NwBe4komu5qP4R2T73dxaITenUJQJLNl/c/R1xDm1I1Ht4iwW2xXb
         s0Bbqee9qwW8NXdDyP/ddMjgz7yS2dUBBM49vx+t/ao59b+13G4QVr5d7if5EMMZHbtt
         Nq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BI2XPKuQkY8KatSiVlkfJXv4UIQhhGiLSSJo2kE67sQ=;
        b=fX8bPHemtGU5BYrHZrbAypcn3tINOFKso6rap4in366ycRJi4rPOX7VmabiaNRWWhW
         j2rLbE0vuxtnSdUDW4dLm/B6URNDQkaL44542awQNnwbSywRZseOpJbXt0i4AfKlLrJE
         fVEppRxSTtieQ81cm1g04Tbn9l/9C050HY8neLaQc/OzInFMmLN47jaRIK4GEPzcLzGC
         kkIBfZGhaY3bxXKVKvLhMFvlt9k2ReIaq39bAt7eQkYAf+s97dXuo81X39LmAM3vMdGi
         MEPZyrod1koAgpYVOcnEakcCb6JY7pXP8b0njWe1K3CIEvlLI/vl6q344paJkKDF//hD
         /rjQ==
X-Gm-Message-State: AOAM531uyEUFWRFijkG0lNDM9+m4s/wr9HyUfL3NxFT4Lk/sUAUbAIpT
        t3BWB7Az0wN9iSdiePcYmAEvaawR3pM=
X-Google-Smtp-Source: ABdhPJxfcfIS7J7bWfI6OvnaUfab0Cu8RlBQHoPk3O6QDtGFrzbmf3qzfDQCOzLmnVRDTVHmAGNjzA==
X-Received: by 2002:adf:a4c8:: with SMTP id h8mr5828872wrb.169.1644698097979;
        Sat, 12 Feb 2022 12:34:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm25238365wrq.72.2022.02.12.12.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:34:57 -0800 (PST)
Message-Id: <d7b51da94e65db79aa59ca331e178741d3c50bc2.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:45 +0000
Subject: [PATCH v4 04/12] merge-tree: implement real merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds the ability to perform real merges rather than just trivial
merges (meaning handling three way content merges, recursive ancestor
consolidation, renames, proper directory/file conflict handling, and so
forth).  However, unlike `git merge`, the working tree and index are
left alone and no branch is updated.

The only output is:
  - the toplevel resulting tree printed on stdout
  - exit status of 0 (clean), 1 (conflicts present), anything else
    (merge could not be performed; unknown if clean or conflicted)

This output is meant to be used by some higher level script, perhaps in
a sequence of steps like this:

   NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT

Note that higher level scripts may also want to access the
conflict/warning messages normally output during a merge, or have quick
access to a list of files with conflicts.  That is not available in this
preliminary implementation, but subsequent commits will add that
ability (meaning that NEWTREE would be a lot more than a tree in the
case of conflicts).

This also marks the traditional trivial merge of merge-tree as
deprecated.  The trivial merge not only had limited applicability, the
output format was also difficult to work with (and its format
undocumented), and will generally be less performant than real merges.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  79 +++++++++++++++++++----
 builtin/merge-tree.c             |  44 ++++++++++++-
 t/t4301-merge-tree-write-tree.sh | 106 +++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 13 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c19422..586733ea564 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -3,26 +3,81 @@ git-merge-tree(1)
 
 NAME
 ----
-git-merge-tree - Show three-way merge without touching index
+git-merge-tree - Perform merge without touching index or working tree
 
 
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' <base-tree> <branch1> <branch2>
+'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
 
 DESCRIPTION
 -----------
-Reads three tree-ish, and output trivial merge results and
-conflicting stages to the standard output.  This is similar to
-what three-way 'git read-tree -m' does, but instead of storing the
-results in the index, the command outputs the entries to the
-standard output.
-
-This is meant to be used by higher level scripts to compute
-merge results outside of the index, and stuff the results back into the
-index.  For this reason, the output from the command omits
-entries that match the <branch1> tree.
+
+Performs a merge, but does not make any new commits and does not read
+from or write to either the working tree or index.
+
+The first form will merge the two branches, doing a real merge.  A real
+merge is distinguished from a trivial merge in that it includes:
+
+  * three way content merges of individual files
+  * rename detection
+  * proper directory/file conflict handling
+  * recursive ancestor consolidation (i.e. when there is more than one
+    merge base, creating a virtual merge base by merging the merge bases)
+  * etc.
+
+After the merge completes, the first form will create a new toplevel
+tree object.  See `OUTPUT` below for details.
+
+The second form is deprecated; it is kept for backward compatibility
+reasons but may be deleted in the future.  Other than the optional
+`--trivial-merge`, it accepts no options.  It can only do a trivial
+merge.  It reads three tree-ish, and outputs trivial merge results and
+conflicting stages to the standard output in a semi-diff format.
+Since this was designed for higher level scripts to consume and merge
+the results back into the index, it omits entries that match
+<branch1>.  The result of this second form is is similar to what
+three-way 'git read-tree -m' does, but instead of storing the results
+in the index, the command outputs the entries to the standard output.
+This form not only has limited applicability, the output format is
+also difficult to work with, and it will generally be less performant
+than the first form even on successful merges (especially if working
+in large repositories).  The remainder of this manual will only
+discuss the first form.
+
+OUTPUT
+------
+
+For either a successful or conflicted merge, the output from
+git-merge-tree is simply one line:
+
+	<OID of toplevel tree>
+
+The printed tree object corresponds to what would be checked out in
+the working tree at the end of `git merge`, and thus may have files
+with conflict markers in them.
+
+EXIT STATUS
+-----------
+
+For a successful, non-conflicted merge, the exit status is 0.  When the
+merge has conflicts, the exit status is 1.  If the merge is not able to
+complete (or start) due to some kind of error, the exit status is
+something other than 0 or 1 (and the output is unspecified).
+
+USAGE NOTES
+-----------
+
+git-merge-tree was written to be low-level plumbing, similar to
+hash-object, mktree, commit-tree, write-tree, update-ref, and mktag.
+Thus, it could be used as a part of a series of steps such as
+
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
+       test $? -eq 0 || die "There were conflicts..."
+       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       git update-ref $BRANCH1 $NEWCOMMIT
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0f9d928e862..af445cb1576 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,6 +2,9 @@
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
+#include "help.h"
+#include "commit-reach.h"
+#include "merge-ort.h"
 #include "object-store.h"
 #include "parse-options.h"
 #include "repository.h"
@@ -398,7 +401,46 @@ struct merge_tree_options {
 static int real_merge(struct merge_tree_options *o,
 		      const char *branch1, const char *branch2)
 {
-	die(_("real merges are not yet implemented"));
+	struct commit *parent1, *parent2;
+	struct commit_list *common;
+	struct commit_list *merge_bases = NULL;
+	struct commit_list *j;
+	struct merge_options opt;
+	struct merge_result result = { 0 };
+
+	parent1 = get_merge_parent(branch1);
+	if (!parent1)
+		help_unknown_ref(branch1, "merge-tree",
+				 _("not something we can merge"));
+
+	parent2 = get_merge_parent(branch2);
+	if (!parent2)
+		help_unknown_ref(branch2, "merge-tree",
+				 _("not something we can merge"));
+
+	init_merge_options(&opt, the_repository);
+
+	opt.show_rename_progress = 0;
+
+	opt.branch1 = branch1;
+	opt.branch2 = branch2;
+
+	/*
+	 * Get the merge bases, in reverse order; see comment above
+	 * merge_incore_recursive in merge-ort.h
+	 */
+	common = get_merge_bases(parent1, parent2);
+	if (!common)
+		die(_("refusing to merge unrelated histories"));
+	for (j = common; j; j = j->next)
+		commit_list_insert(j->item, &merge_bases);
+
+	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	if (result.clean < 0)
+		die(_("failure to merge"));
+	puts(oid_to_hex(&result.tree->object.oid));
+	merge_finalize(&opt, &result);
+	return !result.clean; /* result.clean < 0 handled above */
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
new file mode 100755
index 00000000000..e4f9421c105
--- /dev/null
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='git merge-tree --write-tree'
+
+. ./test-lib.sh
+
+# This test is ort-specific
+if test "${GIT_TEST_MERGE_ALGORITHM}" != "ort"
+then
+	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
+	test_done
+fi
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >numbers &&
+	echo hello >greeting &&
+	echo foo >whatever &&
+	git add numbers greeting whatever &&
+	test_tick &&
+	git commit -m initial &&
+
+	git branch side1 &&
+	git branch side2 &&
+	git branch side3 &&
+
+	git checkout side1 &&
+	test_write_lines 1 2 3 4 5 6 >numbers &&
+	echo hi >greeting &&
+	echo bar >whatever &&
+	git add numbers greeting whatever &&
+	test_tick &&
+	git commit -m modify-stuff &&
+
+	git checkout side2 &&
+	test_write_lines 0 1 2 3 4 5 >numbers &&
+	echo yo >greeting &&
+	git rm whatever &&
+	mkdir whatever &&
+	>whatever/empty &&
+	git add numbers greeting whatever/empty &&
+	test_tick &&
+	git commit -m other-modifications &&
+
+	git checkout side3 &&
+	git mv numbers sequence &&
+	test_tick &&
+	git commit -m rename-numbers
+'
+
+test_expect_success 'Clean merge' '
+	git merge-tree --write-tree side1 side3 >RESULT &&
+	q_to_tab <<-EOF >expect &&
+	100644 blob $(git rev-parse side1:greeting)Qgreeting
+	100644 blob $(git rev-parse side1:numbers)Qsequence
+	100644 blob $(git rev-parse side1:whatever)Qwhatever
+	EOF
+
+	git ls-tree $(cat RESULT) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Content merge and a few conflicts' '
+	git checkout side1^0 &&
+	test_must_fail git merge side2 &&
+	expected_tree=$(cat .git/AUTO_MERGE) &&
+
+	# We will redo the merge, while we are still in a conflicted state!
+	test_when_finished "git reset --hard" &&
+
+	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
+	actual_tree=$(head -n 1 RESULT) &&
+
+	# Due to differences of e.g. "HEAD" vs "side1", the results will not
+	# exactly match.  Dig into individual files.
+
+	# Numbers should have three-way merged cleanly
+	test_write_lines 0 1 2 3 4 5 6 >expect &&
+	git show ${actual_tree}:numbers >actual &&
+	test_cmp expect actual &&
+
+	# whatever and whatever~<branch> should have same HASHES
+	git rev-parse ${expected_tree}:whatever ${expected_tree}:whatever~HEAD >expect &&
+	git rev-parse ${actual_tree}:whatever ${actual_tree}:whatever~side1 >actual &&
+	test_cmp expect actual &&
+
+	# greeting should have a merge conflict
+	git show ${expected_tree}:greeting >tmp &&
+	cat tmp | sed -e s/HEAD/side1/ >expect &&
+	git show ${actual_tree}:greeting >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
+	# Mis-spell with single "s" instead of double "s"
+	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&
+
+	grep "error: unknown option.*mesages" expect
+'
+
+test_expect_success 'Barf on too many arguments' '
+	test_expect_code 129 git merge-tree --write-tree side1 side2 invalid 2>expect &&
+
+	grep "^usage: git merge-tree" expect
+'
+
+test_done
-- 
gitgitgadget

