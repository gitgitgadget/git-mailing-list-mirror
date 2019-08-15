Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C05C1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfHOVlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33092 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbfHOVlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so2003057pfq.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K06rYwqzBCWXDk09acrdPoKG1Y0V0H4z8sTFUswvgzE=;
        b=sjGY6k88hInqeAT0j1VEGhzfp0Tequc+xunNyySPGC8AiLxwz8LYCsKZjor0Qb228a
         7j87Vfl/WxITpqLk8z8n+3gCHm5J6fueSqpt/CT4EgLH84pMqbOP7XRmOVFBBtv8w1KR
         zxugyCAcIhl4M4eU2snk/PLRcca9sDTLMNVqalHP5FK4Svo2hs1GSF3fOGELc2d0XEv9
         vo+3SO2EJcMiseNom89Q+OyUoDTagu1do1lmQSi0lUscVaVEvwzBc8kcmL7P896XSYR3
         +wMovga9tFefuup4+lOU+RKzHxTCutziQhDKCU1rAXHC5o5q7DyGT16dHkmyKufyBAMF
         nPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K06rYwqzBCWXDk09acrdPoKG1Y0V0H4z8sTFUswvgzE=;
        b=h8pTMCUMaWyRFIeaXRQNiY3ihBCsBRwMqBTaAe6OXT3ahWvHpq5n6zBfo5vJknWnYY
         mO5kkDVuduuBnfm2gwwnNOcBGJ5YFGEfabkam9k3WydpS3kC0flIrD6ncqO0DJu9LXhc
         i46XSzI8875j7yrfiJ5HXc5iPWSuhxdP2bIDJ2c6K0aVs9ku0pyJzYYXfqr3NCv9I7Dm
         cfZaRbfxdZGGY5DwBMzdHbJtxxLqBk6S/sTKH+ADiEPf3DaeAGSY41k9xmUdCRxUe4uu
         Lc8FzQVTbVGh8lGnxevzGfgY7C6iJZeGw0v3/LSah3oEviiy1VYlUSrbH1BOXiTF82va
         lAfg==
X-Gm-Message-State: APjAAAWKQ4BFl8g/x2BjRt18KYR2Dg7VJix6uI73bvBqsIHLAz8hkTYC
        uAdSO+/NUtrYreRFUbEmETnlblF/
X-Google-Smtp-Source: APXvYqzL9BNkWijjCswRoBWj5mFxvJO9OOilFv8Vs9TmNn6/dqK9QfUb/hywv2EIBJ2Je7znIBm+rg==
X-Received: by 2002:a17:90a:1916:: with SMTP id 22mr4131127pjg.62.1565905277180;
        Thu, 15 Aug 2019 14:41:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 04/24] merge-recursive: provide a better label for diff3 common ancestor
Date:   Thu, 15 Aug 2019 14:40:33 -0700
Message-Id: <20190815214053.16594-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 7ca56aa07619 ("merge-recursive: add a label for ancestor",
2010-03-20), a label was added for the '||||||' line to make it have
the more informative heading '|||||| merged common ancestors', with
the statement:

    It would be nicer to use a more informative label.  Perhaps someone
    will provide one some day.

This chosen label was perfectly reasonable when recursiveness kicks in,
i.e. when there are multiple merge bases.  (I can't think of a better
label in such cases.)  But it is actually somewhat misleading when there
is a unique merge base or no merge base.  Change this based on the
number of merge bases:
    >=2: "merged common ancestors"
    1:   <abbreviated commit hash>
    0:   "<empty tree>"

Tests have also been added to check that we get the right ancestor name
for each of the three cases.

Also, since merge_recursive() and merge_trees() have polar opposite
pre-conditions for opt->ancestor, document merge_recursive()'s
pre-condition with an assertion.  (An assertion was added to
merge_trees() already a few commits ago.)  The differences in
pre-conditions stem from two factors: (1) merge_trees() does not recurse
and thus does not have multiple sub-merges to worry about -- each of
which would require a different value for opt->ancestor, (2)
merge_trees() is only passed trees rather than commits and thus cannot
internally guess as good of a label.  Thus, while external callers of
merge_trees() are required to provide a non-NULL opt->ancestor,
merge_recursive() expects to set this value itself.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |  21 +++-
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 189 ++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 4 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index a67ea4957a..3a7a9514b9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3507,6 +3507,11 @@ int merge_recursive(struct merge_options *opt,
 	struct commit *merged_common_ancestors;
 	struct tree *mrtree;
 	int clean;
+	int num_merge_bases;
+	struct strbuf merge_base_abbrev = STRBUF_INIT;
+
+	if (!opt->call_depth)
+		assert(opt->ancestor == NULL);
 
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
@@ -3528,6 +3533,7 @@ int merge_recursive(struct merge_options *opt,
 			output_commit_title(opt, iter->item);
 	}
 
+	num_merge_bases = commit_list_count(ca);
 	merged_common_ancestors = pop_commit(&ca);
 	if (merged_common_ancestors == NULL) {
 		/* if there is no common ancestor, use an empty tree */
@@ -3568,10 +3574,23 @@ int merge_recursive(struct merge_options *opt,
 	if (!opt->call_depth)
 		repo_read_index(opt->repo);
 
-	opt->ancestor = "merged common ancestors";
+	switch (num_merge_bases) {
+	case 0:
+		opt->ancestor = "<empty tree>";
+		break;
+	case 1:
+		strbuf_add_unique_abbrev(&merge_base_abbrev,
+					 &merged_common_ancestors->object.oid,
+					 DEFAULT_ABBREV);
+		opt->ancestor = merge_base_abbrev.buf;
+		break;
+	default:
+		opt->ancestor = "merged common ancestors";
+	}
 	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
 			    get_commit_tree(merged_common_ancestors),
 			    &mrtree);
+	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index d23b948f27..7fddcc8c73 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1562,6 +1562,7 @@ test_expect_success 'check nested conflicts' '
 		cd nested_conflicts &&
 
 		git clean -f &&
+		MASTER=$(git rev-parse --short master) &&
 		git checkout L2^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1582,7 +1583,7 @@ test_expect_success 'check nested conflicts' '
 		git cat-file -p R1:a >theirs &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "merged common ancestors"  \
+			-L "$MASTER"  \
 			-L "Temporary merge branch 2" \
 			ours  \
 			base  \
@@ -1594,7 +1595,7 @@ test_expect_success 'check nested conflicts' '
 		git cat-file -p R1:b >theirs &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "merged common ancestors"  \
+			-L "$MASTER"  \
 			-L "Temporary merge branch 2" \
 			ours  \
 			base  \
@@ -1732,6 +1733,7 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 	(
 		cd virtual_merge_base_has_nested_conflicts &&
 
+		MASTER=$(git rev-parse --short master) &&
 		git checkout L3^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1760,7 +1762,7 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 		cp left merged-once &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "merged common ancestors"  \
+			-L "$MASTER"  \
 			-L "Temporary merge branch 2" \
 			merged-once \
 			base        \
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
new file mode 100755
index 0000000000..f69c8256bc
--- /dev/null
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -0,0 +1,189 @@
+#!/bin/sh
+
+test_description='recursive merge diff3 style conflict markers'
+
+. ./test-lib.sh
+
+# Setup:
+#          L1
+#            \
+#             ?
+#            /
+#          R1
+#
+# Where:
+#   L1 and R1 both have a file named 'content' but have no common history
+#
+
+test_expect_success 'setup no merge base' '
+	test_create_repo no_merge_base &&
+	(
+		cd no_merge_base &&
+
+		git checkout -b L &&
+		test_commit A content A &&
+
+		git checkout --orphan R &&
+		test_commit B content B
+	)
+'
+
+test_expect_success 'check no merge base' '
+	(
+		cd no_merge_base &&
+
+		git checkout L^0 &&
+
+		test_must_fail git -c merge.conflictstyle=diff3 merge --allow-unrelated-histories -s recursive R^0 &&
+
+		grep "|||||| <empty tree>" content
+	)
+'
+
+# Setup:
+#          L1
+#         /  \
+#   master    ?
+#         \  /
+#          R1
+#
+# Where:
+#   L1 and R1 have modified the same file ('content') in conflicting ways
+#
+
+test_expect_success 'setup unique merge base' '
+	test_create_repo unique_merge_base &&
+	(
+		cd unique_merge_base &&
+
+		test_commit base content "1
+2
+3
+4
+5
+" &&
+
+		git branch L &&
+		git branch R &&
+
+		git checkout L &&
+		test_commit L content "1
+2
+3
+4
+5
+7" &&
+
+		git checkout R &&
+		git rm content &&
+		test_commit R renamed "1
+2
+3
+4
+5
+six"
+	)
+'
+
+test_expect_success 'check unique merge base' '
+	(
+		cd unique_merge_base &&
+
+		git checkout L^0 &&
+		MASTER=$(git rev-parse --short master) &&
+
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
+
+		grep "|||||| $MASTER:content" renamed
+	)
+'
+
+# Setup:
+#          L1---L2--L3
+#         /  \ /      \
+#   master    X1       ?
+#         \  / \      /
+#          R1---R2--R3
+#
+# Where:
+#   commits L1 and R1 have modified the same file in non-conflicting ways
+#   X1 is an auto-generated merge-base used when merging L1 and R1
+#   commits L2 and R2 are merges of R1 and L1 into L1 and R1, respectively
+#   commits L3 and R3 both modify 'content' in conflicting ways
+#
+
+test_expect_success 'setup multiple merge bases' '
+	test_create_repo multiple_merge_bases &&
+	(
+		cd multiple_merge_bases &&
+
+		test_commit initial content "1
+2
+3
+4
+5" &&
+
+		git branch L &&
+		git branch R &&
+
+		# Create L1
+		git checkout L &&
+		test_commit L1 content "0
+1
+2
+3
+4
+5" &&
+
+		# Create R1
+		git checkout R &&
+		test_commit R1 content "1
+2
+3
+4
+5
+6" &&
+
+		# Create L2
+		git checkout L &&
+		git merge R1 &&
+
+		# Create R2
+		git checkout R &&
+		git merge L1 &&
+
+		# Create L3
+		git checkout L &&
+		test_commit L3 content "0
+1
+2
+3
+4
+5
+A" &&
+
+		# Create R3
+		git checkout R &&
+		git rm content &&
+		test_commit R3 renamed "0
+2
+3
+4
+5
+six"
+	)
+'
+
+test_expect_success 'check multiple merge bases' '
+	(
+		cd multiple_merge_bases &&
+
+		git checkout L^0 &&
+
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
+
+		grep "|||||| merged common ancestors:content" renamed
+	)
+'
+
+test_done
-- 
2.23.0.rc2.32.g2123e9e4e4

