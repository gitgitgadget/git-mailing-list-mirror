Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662AECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIUWIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIUWIH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:08:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48196A74F4
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:08:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so6414641wrm.7
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=zesGvu4F9DDyoB7RiGyXWgyuO4EUpdSis1+iWIo38Uk=;
        b=nS0ylZzlE+dwYC8vDYTvXD6gpI70JWe56AqawsO+vUFtPGXJFmVQ+IJT/vW9qSFxqw
         nKbVixbi+q9W5K4Pa1wmPoR5bneGgR8IszmxW1WMfAf4paYJiH5OHRquh90D4fgR/WCy
         nviexXB0ws23/YE0jLa+fxVrUGDLsEPaoai0a5u7RndbTtb9RLPx2mD47wqmhL07+Zih
         we5FVtoqjgUXb/CtMgEtC5BwogZomqSA8Fp/HsvlJ7DyruMl5o2Rkl65/BEwHDLt/ixF
         u223STGOe4VSB3ggFUhkeXfrk3nCjBtMRZDDr8ENeTLaLqJ2QPOqArkcE22YWTfsbiRg
         6now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zesGvu4F9DDyoB7RiGyXWgyuO4EUpdSis1+iWIo38Uk=;
        b=L1Z9aiKebez4oAhnAgktnhaSmE8tvrF92lMiwa+Q1A4OmpsjlaxpJQcLZrpXtF71Xi
         1yxx3HTZFk991uRIDKYbPMHbU+4olYh9ipdy6hO7jVnyq8HJgQlsx20Sr2pbJC4yXR0d
         f4e9H+3psoOL2qDERHNyQUmRJUjAhgNbkkrxmnfzGoEx7kT7PBWgno3lHoAGSBpb88bR
         bfZTm2ZsUja5r2r9efSN2s3uoW3bEN7ptCPvow8HqCUTEog5D/3fY9PfAJoXojr3emfU
         yIs+VUWapjdTXP8fciPYwxsBwlfLGiiVFdG/tiSRp8hcztb8eElGPP1kzV+6hV6WiXNN
         BPyw==
X-Gm-Message-State: ACrzQf20pAfFraXW3hTb/5wiGaR0MNxa8RnVfKzyM4FZVWWMyfMi5RYx
        o3/ptOU2AI6W7S899PdhIta0Z+oOqlQ=
X-Google-Smtp-Source: AMsMyM6V32YDC3sMoUNrwfG/HTP6GtfUyKE/S4XeU8nYpGbjhP1q9L5W5+pAzCyf4VFvheC+N4WG8A==
X-Received: by 2002:adf:eb89:0:b0:22a:c7fc:27c8 with SMTP id t9-20020adfeb89000000b0022ac7fc27c8mr136340wrn.397.1663798084384;
        Wed, 21 Sep 2022 15:08:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a5f4fccd4asm4071699wmb.35.2022.09.21.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:08:03 -0700 (PDT)
Message-Id: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 22:08:03 +0000
Subject: [PATCH v2] merge-tree: fix segmentation fault in read-only
 repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Independent of the question whether we want `git merge-tree` to report
the tree name even when it failed to write the tree objects in a
read-only repository, there is no question that we should avoid a
segmentation fault.

And when we report an invalid tree name (because the tree could not be
written), we need the exit status to be non-zero.

Let's make it so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    merge-tree: fix segmentation fault in read-only repositories
    
    Turns out that the segmentation fault reported by Taylor
    [https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened
    while testing merge-ort in a read-only repository, and that the upstream
    version of git merge-tree is as affected as GitHub's internal version.
    
    Note: I briefly considered using the OID of the_hash_algo->empty_tree
    instead of null_oid() when no tree object could be constructed. However,
    I have come to the conclusion that this could potentially cause its own
    set of problems because it would relate to a valid tree object even if
    we do not have any valid tree object to play with.
    
    Also note: The question I hinted at in the commit message, namely
    whether or not to try harder to construct a tree object even if we
    cannot write it out, maybe merits a longer discussion, one that I think
    we should have after v2.38.0 is released, so as not to distract from
    focusing on v2.38.0.
    
    Changes since v1:
    
     * Using the SANITY prereq now
     * If the merge was aborted due to a write error, exit with a non-zero
       code even if the (potentially partial) merge is clean
     * The test case now also verifies that the git merge-tree command fails
       in a read-only repository even if the merge would have succeeded

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1362%2Fdscho%2Fmerge-tree-in-read-only-repos-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1362/dscho/merge-tree-in-read-only-repos-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1362

Range-diff vs v1:

 1:  beba3fd9a95 ! 1:  1de4df3f471 merge-tree: fix segmentation fault in read-only repositories
     @@ Metadata
       ## Commit message ##
          merge-tree: fix segmentation fault in read-only repositories
      
     -    Independent of the question whether we want `git merge-tree` to report a
     -    tree name even when it failed to write the tree objects in a read-only
     -    repository, there is no question that we should avoid a segmentation
     -    fault.
     +    Independent of the question whether we want `git merge-tree` to report
     +    the tree name even when it failed to write the tree objects in a
     +    read-only repository, there is no question that we should avoid a
     +    segmentation fault.
     +
     +    And when we report an invalid tree name (because the tree could not be
     +    written), we need the exit status to be non-zero.
     +
     +    Let's make it so.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	if (!result.clean) {
       		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
       		const char *last = NULL;
     +@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     + 					      &result);
     + 	}
     + 	merge_finalize(&opt, &result);
     +-	return !result.clean; /* result.clean < 0 handled above */
     ++	return !result.tree || !result.clean; /* result.clean < 0 handled above */
     + }
     + 
     + int cmd_merge_tree(int argc, const char **argv, const char *prefix)
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'can override merge of unrelated histories' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'merge-ort fails gracefully in a read-only repository' '
     ++test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository' '
      +	git init --bare read-only &&
     -+	git push read-only side1 side2 &&
     ++	git push read-only side1 side2 side3 &&
      +	test_when_finished "chmod -R u+w read-only" &&
      +	chmod -R a-w read-only &&
     ++	test_must_fail git -C read-only merge-tree side1 side3 &&
      +	test_must_fail git -C read-only merge-tree side1 side2
      +'
      +


 builtin/merge-tree.c             | 6 ++++--
 t/t4301-merge-tree-write-tree.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ae5782917b9..0df24eb82d4 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -412,6 +412,7 @@ static int real_merge(struct merge_tree_options *o,
 	struct commit_list *merge_bases = NULL;
 	struct merge_options opt;
 	struct merge_result result = { 0 };
+	const struct object_id *tree_oid;
 
 	parent1 = get_merge_parent(branch1);
 	if (!parent1)
@@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o,
 	if (o->show_messages == -1)
 		o->show_messages = !result.clean;
 
-	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
+	tree_oid = result.tree ? &result.tree->object.oid : null_oid();
+	printf("%s%c", oid_to_hex(tree_oid), line_termination);
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
@@ -473,7 +475,7 @@ static int real_merge(struct merge_tree_options *o,
 					      &result);
 	}
 	merge_finalize(&opt, &result);
-	return !result.clean; /* result.clean < 0 handled above */
+	return !result.tree || !result.clean; /* result.clean < 0 handled above */
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 28ca5c38bb5..013b77144bd 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -810,4 +810,13 @@ test_expect_success 'can override merge of unrelated histories' '
 	test_cmp expect actual
 '
 
+test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository' '
+	git init --bare read-only &&
+	git push read-only side1 side2 side3 &&
+	test_when_finished "chmod -R u+w read-only" &&
+	chmod -R a-w read-only &&
+	test_must_fail git -C read-only merge-tree side1 side3 &&
+	test_must_fail git -C read-only merge-tree side1 side2
+'
+
 test_done

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
gitgitgadget
