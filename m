Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE15C433FE
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352794AbiA2SH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiA2SHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB367C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so16918330wrg.12
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jiWw73ElfvDNzg9QG12H1L3cZ/9znWEQgBx121aVEwg=;
        b=MAofSWgOF+Omre6YE6okaq0olYX0Z3EtFPgqvIpB83R7Px4Ii8/c75l8WtaGB1PwCL
         GbaXGfSXAExVG5ur0Co97V6spSElgH8MIxiUFSjVRS697F5X2+sKOwFlAjn0GuvwcsS2
         2h5yBrG80NlRLpzc7CQMf049tGqIB0Xp1Pkj9EIJjBCG1bJ6i74E0JcoyhFQxQ2lPT2s
         gZxHTkbnZgrpxs4WkniZH+6r/RIyQ6nUSFRe+BBF4akIA9MkFylV9dE0e0iIafnWVm4a
         AckH26dC/8E2O0wlN/LKyDyyquWduNLVxr9S2f6GEyS6g/TJF+dyTL6c9uMHOvAKJG9O
         LN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jiWw73ElfvDNzg9QG12H1L3cZ/9znWEQgBx121aVEwg=;
        b=sXC2cCBLcKpFJZbCiBy5u646LArIMVM4XP2kjd9pWVc2HVO1763HkJwjbbTBy+p6RA
         mjMkE84SAmPeRTPl45QoD1Zro6qesKR2MOmSl5F494mJ5RGfdqU5JLG8tc9aqvjrtU8G
         XEA0Zuvi62iHOzniZ66hMJH/EPHVqLeVZpiA5N0Qu7nKo2Vqq1l9FqqT2+SkiOmqcAFk
         pPCyLnTftBKJKljHRpMgpujDSdBOA9+zRvkyBSVxctHzwlClvHnDF235COjwwh6AbD97
         v+NJvJgIcT3621sjlaf4EsJAgKUPmzlTyWH9RTqM4a6T/VhQJ/3iizr8xK3Hj8vbvNvD
         UGww==
X-Gm-Message-State: AOAM532nZuDmNCeXYCCVIH5iYdHAz/cilWVvIfjNaHDzXmcbrxnRE3aM
        CuiAjlqyMenmHt6UTQNficRvwdiG77M=
X-Google-Smtp-Source: ABdhPJwkY9IqIUClkFlmEwqj67G9lilZLhP1z2CmqchdWRev0J++s/ELUry9JlXvRdEF/Db8fq1bZw==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr11557187wri.176.1643479638268;
        Sat, 29 Jan 2022 10:07:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm1501189wrw.14.2022.01.29.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:17 -0800 (PST)
Message-Id: <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:04 +0000
Subject: [PATCH v2 04/13] merge-tree: implement real merges
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
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
ability.

This also marks the traditional trivial merge of merge-tree as
deprecated.  The trivial merge not only had limited applicability, the
output format was also difficult to work with (and its format
undocumented), and will generally be less performant than real merges.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 71 +++++++++++++++++++++-----
 builtin/merge-tree.c             | 44 +++++++++++++++-
 t/t4301-merge-tree-write-tree.sh | 88 ++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 13 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c19422..569485815a0 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -3,26 +3,73 @@ git-merge-tree(1)
 
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
+The second form is deprecated and supported only for backward
+compatibility.  It will likely be removed in the future, and will not
+be discussed further in this manual.
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
+After the merge completes, it will create a new toplevel tree object.
+See `OUTPUT` below for details.
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
+something other than 0 or 1.
+
+USAGE NOTES
+-----------
+
+git-merge-tree was written to be low-level plumbing, similar to
+hash-object, mktree, commit-tree, update-ref, and mktag.  Thus, it could
+be used as a part of a series of steps such as
+
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
+       test $? -eq 0 || die "There were conflicts..."
+       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       git update-ref $BRANCH1 $NEWCOMMIT
+
+However, it does not quite fit into the same category of low-level
+plumbing commands since the possibility of merge conflicts give it a
+much higher chance of the command not succeeding.
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e98ec8a9f1d..d14c9f6e44e 100644
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
@@ -392,7 +395,46 @@ struct merge_tree_options {
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
index 00000000000..66c3eaf2021
--- /dev/null
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -0,0 +1,88 @@
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
+	git commit -m other-modifications
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
+	test_expect_code 129 git merge-tree --write-tree side1 side2 side3 2>expect &&
+
+	grep "^usage: git merge-tree" expect
+'
+
+test_done
-- 
gitgitgadget

