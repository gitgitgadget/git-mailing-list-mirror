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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D0B1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHQSmH (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:07 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33242 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHQSmE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:04 -0400
Received: by mail-pg1-f172.google.com with SMTP id n190so4601556pgn.0
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8NEdZdHHPpWmcNTCZY6MyqU5TzeFA22NYSYoq9eKqM=;
        b=OpceAtHvzm10nYhPDxU7I5e79aEFiALdXhMK1p/Cr6hGEvotluFwRHrX0QHd1DkiLV
         CG8HQbga/rdfa+oyN/SKbIhBonF5keFepoXuxggujnBsw7yhGGREnNEhCAc8PVB1DXQJ
         DdY2b3HRODXwlYfsNSPV1tt2AI3BYHEH+1gPnizDHUpoueWhJBtwUg7F0h1Yh4BXMiDQ
         hl4DvqBqYXi+3L3hyWF6jhnjmwALzgFydCEx1Zo5jGJuamcM9ivyvH4GysMTCKkcxXyh
         l9CHdoaQ414InaS8xW3OYTPfChkGC/Vv6VbK/cAkvmz3HdcQaJMPoBIhsHLuN6muH5NA
         dIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8NEdZdHHPpWmcNTCZY6MyqU5TzeFA22NYSYoq9eKqM=;
        b=Z68ZCFkVE1jupWaw/5xdo5nixBrqwMojzTJV+rjD3jVSVzutZNCCSQm1C4VM/W/Sj7
         q2qBhaScy8zPPggelspjKA2MdXCFUfPG8IG28xz8B2gVVX3fMQfK3xVzrnw1kv+yNJYw
         rTukyC30G/GtNfJFW7OAcAQ+RaRbWtjuMRhOS6JoXBqbe5KQvPFCro/mZeRD8gV0qeNB
         UB2yrwXK3UermFxJ9foWEvvtLx8CxtEk4SwAYWNTWIUec2Jvqpj2JvO/ZKgZ+SbsgdRg
         a/9tDlxa7DZNAGMTGPqi4nHjPbNHDF+TkalO7EsPM5W/l3rRhb3cEUMMKxYFOgNd3o4H
         xhuw==
X-Gm-Message-State: APjAAAU2a6VhruCVE34oGq/K2hjzWH9KIfRtWWy+vtT3iOw1K3h2G5jY
        IrcQJQtW/i8mcVqv1wBhDqQeeHv7
X-Google-Smtp-Source: APXvYqyoN+rxpYk6j96xFiLfVGnRuVfrPt6poLwsGvRCGQtVx9Iy0b6v1icTMC/kV+MvkqlNkPZ8aw==
X-Received: by 2002:a63:4042:: with SMTP id n63mr2486156pga.75.1566067323291;
        Sat, 17 Aug 2019 11:42:03 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 04/24] merge-recursive: provide a better label for diff3 common ancestor
Date:   Sat, 17 Aug 2019 11:41:24 -0700
Message-Id: <20190817184144.32179-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
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
 merge-recursive.c                 |  16 ++-
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 189 ++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 4 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index a67ea4957a..e6b84db2ef 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3507,6 +3507,11 @@ int merge_recursive(struct merge_options *opt,
 	struct commit *merged_common_ancestors;
 	struct tree *mrtree;
 	int clean;
+	const char *ancestor_name;
+	struct strbuf merge_base_abbrev = STRBUF_INIT;
+
+	if (!opt->call_depth)
+		assert(opt->ancestor == NULL);
 
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
@@ -3535,6 +3540,14 @@ int merge_recursive(struct merge_options *opt,
 
 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
 		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
+		ancestor_name = "empty tree";
+	} else if (ca) {
+		ancestor_name = "merged common ancestors";
+	} else {
+		strbuf_add_unique_abbrev(&merge_base_abbrev,
+					 &merged_common_ancestors->object.oid,
+					 DEFAULT_ABBREV);
+		ancestor_name = merge_base_abbrev.buf;
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -3568,10 +3581,11 @@ int merge_recursive(struct merge_options *opt,
 	if (!opt->call_depth)
 		repo_read_index(opt->repo);
 
-	opt->ancestor = "merged common ancestors";
+	opt->ancestor = ancestor_name;
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
index 0000000000..3fb68e0aae
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
+		grep "|||||| empty tree" content
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
2.23.0.rc2.28.g5f89f15d7b.dirty

