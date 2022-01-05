Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85308C433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiAER1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbiAER1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59FC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so3707325wme.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7GoB9E//7sqZ3qsTLDJp/wclKZXAI4SgsQ5Qaeegepk=;
        b=QPppUko9E1HRHDI0weHL1Y+YIMXaFEL3kH/Uuc9DOpo5PiXih3mcvp9USNoI0zsstE
         a9OcLw4gortFE2xrKaqYriVO8pt/BipWYbCyeEQ6vb9zsx+/UjNdyCyYOY/c/Iib4U07
         DyIJG6yFSIsuqoTB+2lI/ITWQVevyFCs2M23Xf7eHjc07QWHRVklmFRKUCr62OArZTHF
         BKECspYPzM9RckfE647y635rbVH5DKy6nukOSIzF33T4CjR4C//Br56gUnKnmbEh0vlU
         HGCPrJLd3SAq1vKb4o7fya8LwbP19xHDLI5o/8lbyb28hLS4y2gkC1hwwKGgPNKrY3mc
         l8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7GoB9E//7sqZ3qsTLDJp/wclKZXAI4SgsQ5Qaeegepk=;
        b=14bIo+ERvcsbFFLMvXA3Xd0OG7Kp8v1I+5325IJ0lKcYA1dCGk/kWdsLFz89MwloP2
         WfFtocy9a6MYCmWk50aeHuTKPCIQ+oATpPqELJ70HtK2q6I9xVgIvHV5TeVLUAsinaoV
         aFGeXm7ifBIC7dM/EQ+bMmrFCVo5z1FHhL01JzFs6aLsh37Aw9ltErvhzfQ3F5dUy3VJ
         OyX/Z7S1UfZERtu937qkX0gGm/tiRXPAfUmjGW6QnCa288ci7Y7ZniXhDH8iW0GiGnbN
         cJ7E3EcbdQu6Q7VOljOApef8EpsOGBpHfVUj5iMpCj5jBtC+KWBNncRfCHaxtF6M6783
         S8lA==
X-Gm-Message-State: AOAM531Kl2ZIR6hX1MRuwPRtjXHEOFobY5Bi7QNg0Xf+YWKOQWd4UMYS
        F+MDlyRR4HoReRzop854duUP+N+ZpXU=
X-Google-Smtp-Source: ABdhPJwpf7gQzMHE2ZWa5TXAp/szNihC/P561a+Mm8vSRn2gR45cUwVGoVFz3F9Sg2qDihd+HOm4xQ==
X-Received: by 2002:a7b:c058:: with SMTP id u24mr3716075wmc.90.1641403659362;
        Wed, 05 Jan 2022 09:27:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm2921905wmj.44.2022.01.05.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:39 -0800 (PST)
Message-Id: <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:31 +0000
Subject: [PATCH v2 4/8] merge-tree: implement real merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
  - exit status of 0 (clean) or 1 (conflicts present)

This output is mean to be used by some higher level script, perhaps in a
sequence of steps like this:

   NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT

Note that higher level scripts may also want to access the
conflict/warning messages normally output during a merge, or have quick
access to a list of files with conflicts.  That is not available in this
preliminary implementation, but subsequent commits will add that
ability.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 28 +++++++----
 builtin/merge-tree.c             | 55 +++++++++++++++++++++-
 t/t4301-merge-tree-real.sh       | 81 ++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 11 deletions(-)
 create mode 100755 t/t4301-merge-tree-real.sh

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c19422..5823938937f 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -3,26 +3,34 @@ git-merge-tree(1)
 
 NAME
 ----
-git-merge-tree - Show three-way merge without touching index
+git-merge-tree - Perform merge without touching index or working tree
 
 
 SYNOPSIS
 --------
 [verse]
+'git merge-tree' --real <branch1> <branch2>
 'git merge-tree' <base-tree> <branch1> <branch2>
 
 DESCRIPTION
 -----------
-Reads three tree-ish, and output trivial merge results and
-conflicting stages to the standard output.  This is similar to
-what three-way 'git read-tree -m' does, but instead of storing the
-results in the index, the command outputs the entries to the
-standard output.
+Performs a merge, but does not make any new commits and does not read
+from or write to either the working tree or index.
 
-This is meant to be used by higher level scripts to compute
-merge results outside of the index, and stuff the results back into the
-index.  For this reason, the output from the command omits
-entries that match the <branch1> tree.
+The first form will merge the two branches, doing a full recursive
+merge with rename detection.  If the merge is clean, the exit status
+will be `0`, and if the merge has conflicts, the exit status will be
+`1`.  The output will consist solely of the resulting toplevel tree
+(which may have files including conflict markers).
+
+The second form is meant for backward compatibility and will only do a
+trival merge.  It reads three tree-ish, and outputs trivial merge
+results and conflicting stages to the standard output in a semi-diff
+format.  Since this was designed for higher level scripts to consume
+and merge the results back into the index, it omits entries that match
+<branch1>.  The result of this second form is is similar to what
+three-way 'git read-tree -m' does, but instead of storing the results
+in the index, the command outputs the entries to the standard output.
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e1d2832c809..ac50f3d108b 100644
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
@@ -392,7 +395,57 @@ struct merge_tree_options {
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
+		help_unknown_ref(branch1, "merge",
+				 _("not something we can merge"));
+
+	parent2 = get_merge_parent(branch2);
+	if (!parent2)
+		help_unknown_ref(branch2, "merge",
+				 _("not something we can merge"));
+
+	init_merge_options(&opt, the_repository);
+	/*
+	 * TODO: Support subtree and other -X options?
+	if (use_strategies_nr == 1 &&
+	    !strcmp(use_strategies[0]->name, "subtree"))
+		opt.subtree_shift = "";
+	for (x = 0; x < xopts_nr; x++)
+		if (parse_merge_opt(&opt, xopts[x]))
+			die(_("Unknown strategy option: -X%s"), xopts[x]);
+	*/
+
+	opt.show_rename_progress = 0;
+
+	opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
+	opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */
+
+	/*
+	 * Get the merge bases, in reverse order; see comment above
+	 * merge_incore_recursive in merge-ort.h
+	 */
+	common = get_merge_bases(parent1, parent2);
+	for (j = common; j; j = j->next)
+		commit_list_insert(j->item, &merge_bases);
+
+	/*
+	 * TODO: notify if merging unrelated histories?
+	if (!common)
+		fprintf(stderr, _("merging unrelated histories"));
+	 */
+
+	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	printf("%s\n", oid_to_hex(&result.tree->object.oid));
+	merge_switch_to_result(&opt, NULL, &result, 0, 0);
+	return result.clean ? 0 : 1;
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
new file mode 100755
index 00000000000..f7aa310f8c1
--- /dev/null
+++ b/t/t4301-merge-tree-real.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='git merge-tree --real'
+
+. ./test-lib.sh
+
+# This test is ort-specific
+GIT_TEST_MERGE_ALGORITHM=ort
+export GIT_TEST_MERGE_ALGORITHM
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >numbers &&
+	echo hello >greeting &&
+	echo foo >whatever &&
+	git add numbers greeting whatever &&
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
+	git commit -m modify-stuff &&
+
+	git checkout side2 &&
+	test_write_lines 0 1 2 3 4 5 >numbers &&
+	echo yo >greeting &&
+	git rm whatever &&
+	mkdir whatever &&
+	>whatever/empty &&
+	git add numbers greeting whatever/empty &&
+	git commit -m other-modifications
+'
+
+test_expect_success 'Content merge and a few conflicts' '
+	git checkout side1^0 &&
+	test_must_fail git merge side2 &&
+	cp .git/AUTO_MERGE EXPECT &&
+	E_TREE=$(cat EXPECT) &&
+
+	git reset --hard &&
+	test_must_fail git merge-tree --real side1 side2 >RESULT &&
+	R_TREE=$(cat RESULT) &&
+
+	# Due to differences of e.g. "HEAD" vs "side1", the results will not
+	# exactly match.  Dig into individual files.
+
+	# Numbers should have three-way merged cleanly
+	test_write_lines 0 1 2 3 4 5 6 >expect &&
+	git show ${R_TREE}:numbers >actual &&
+	test_cmp expect actual &&
+
+	# whatever and whatever~<branch> should have same HASHES
+	git rev-parse ${E_TREE}:whatever ${E_TREE}:whatever~HEAD >expect &&
+	git rev-parse ${R_TREE}:whatever ${R_TREE}:whatever~side1 >actual &&
+	test_cmp expect actual &&
+
+	# greeting should have a merge conflict
+	git show ${E_TREE}:greeting >tmp &&
+	cat tmp | sed -e s/HEAD/side1/ >expect &&
+	git show ${R_TREE}:greeting >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Barf on misspelled option' '
+	# Mis-spell with single "s" instead of double "s"
+	test_expect_code 129 git merge-tree --real --mesages FOOBAR side1 side2 2>expect &&
+
+	grep "error: unknown option.*mesages" expect
+'
+
+test_expect_success 'Barf on too many arguments' '
+	test_expect_code 129 git merge-tree --real side1 side2 side3 2>expect &&
+
+	grep "^usage: git merge-tree" expect
+'
+
+test_done
-- 
gitgitgadget

