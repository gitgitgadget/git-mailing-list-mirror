Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABAE1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfGZPxc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44926 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfGZPx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so24888631plr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLTpY1gU5zWwk9q3BLg+ZtJwcdTQniKTPSSxYgicyOk=;
        b=ljyh1Fg0F8UcPfmq4LkgGGqutQK9cQJAyNDx7+ZLRPGQ9a4DMTFltvaVNdPvUb73dR
         XtEMXTuTA+KSVk1Q74ffPokJFrWd6B9HEEVtZEd+bt15BLyueKheCkK6LvfIbUIHFG/S
         yRjUpj6nNxaQHn3MO3r0up7Gj1IbN2YwEp3lqxcIzhevKfxa2E4JzdaX5dQN+qrgMRMe
         n3bzBo4Ocih2FEtKIiojl4pdHq/mUsOsUC2F5yOGJMvqMFgK1tm+hYeGefgD6Vk5/97r
         tSeI/aWXwM1ob9kpKQ8dfueY6h+VHOHGhMZ/Zv5mkEW4ranc5NfmhWvSNSU94nlbDoKF
         JFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLTpY1gU5zWwk9q3BLg+ZtJwcdTQniKTPSSxYgicyOk=;
        b=ANAyyx7DMTrVjKn+7hbEwfOWozTYF+cORrFgSxIltKZKB6Vl5hXonkMX0kcl8/ljBx
         gvPXrwGRZq7FcWJE4yvraZeksAw9wzBcuZnb2GOaFtXYi0AFNSYYwVUrveU93GZ4Sa+G
         JTPt/MWcEkDlOCRkHqLte0mN0J7cxXqah6KyINCnm0K7SUjEPVz8UJO+D9ThQlDc8DGi
         DIhR/Jy8eZAKln8UMJOcCc+mjMMX/XVcnG+ltfjVg6KW7WULiboRbvik4Y49wsDrxzE6
         IzNtrPQfBXEIsStQjH3SFEsM+OGr4cR5edn/bsBR0ethc9emxoGUasnCERoyB2Lwd6Qp
         /XRg==
X-Gm-Message-State: APjAAAW8yf5xwkRXZmfJhKxN1Lf+xBuGypmBREXjhS6Efz6WWzQoUwOA
        rC7iOz6o3SAsHNIJoJ5d3um1FnRX
X-Google-Smtp-Source: APXvYqwdMGkuaFbjJfxwnRVnVGmSJr3W9BGFAeq+v4RBi5Blnp4nMkgqoYhMbHefr0I1PiTtq1CrjQ==
X-Received: by 2002:a17:902:42d:: with SMTP id 42mr92551892ple.228.1564156407027;
        Fri, 26 Jul 2019 08:53:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 20/20] merge-recursive: provide a better label for diff3 common ancestor
Date:   Fri, 26 Jul 2019 08:52:58 -0700
Message-Id: <20190726155258.28561-21-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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

Also, the code in merge_3way making use of opt->ancestor was overly
complex because it tried to handle the case of opt->ancestor being NULL.
We always set it first, though, so just add an assert that opt->ancestor
is not NULL and simplify the surrounding code.

Tests have also been added to check that we get the right ancestor name
for each of the three cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |  39 ++++--
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 189 ++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+), 14 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index f1e2658457..6d5dce17fc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1034,7 +1034,7 @@ static int merge_3way(struct merge_options *opt,
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
-	char *base_name, *name1, *name2;
+	char *base, *name1, *name2;
 	int merge_status;
 
 	ll_opts.renormalize = opt->renormalize;
@@ -1058,16 +1058,13 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path && o->path);
-	if (strcmp(a->path, b->path) ||
-	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s:%s", opt->ancestor, o->path);
+	assert(a->path && b->path && o->path && opt->ancestor);
+	if (strcmp(a->path, b->path) || strcmp(a->path, o->path) != 0) {
+		base  = mkpathdup("%s:%s", opt->ancestor, o->path);
 		name1 = mkpathdup("%s:%s", branch1, a->path);
 		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s", opt->ancestor);
+		base  = mkpathdup("%s", opt->ancestor);
 		name1 = mkpathdup("%s", branch1);
 		name2 = mkpathdup("%s", branch2);
 	}
@@ -1076,11 +1073,11 @@ static int merge_3way(struct merge_options *opt,
 	read_mmblob(&src1, &a->oid);
 	read_mmblob(&src2, &b->oid);
 
-	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
+	merge_status = ll_merge(result_buf, a->path, &orig, base,
 				&src1, name1, &src2, name2,
 				opt->repo->index, &ll_opts);
 
-	free(base_name);
+	free(base);
 	free(name1);
 	free(name2);
 	free(orig.ptr);
@@ -3523,6 +3520,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 	struct commit *merged_merge_bases;
 	struct tree *result_tree;
 	int clean;
+	int num_merge_bases;
+	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
@@ -3544,6 +3543,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 			output_commit_title(opt, iter->item);
 	}
 
+	num_merge_bases = commit_list_count(merge_bases);
 	merged_merge_bases = pop_commit(&merge_bases);
 	if (merged_merge_bases == NULL) {
 		/* if there is no common ancestor, use an empty tree */
@@ -3585,13 +3585,26 @@ static int merge_recursive_internal(struct merge_options *opt,
 	if (!opt->priv->call_depth)
 		repo_read_index(opt->repo);
 
-	opt->ancestor = "merged common ancestors";
+	switch (num_merge_bases) {
+	case 0:
+		opt->ancestor = "<empty tree>";
+		break;
+	case 1:
+		strbuf_add_unique_abbrev(&merge_base_abbrev,
+					 &merged_merge_bases->object.oid,
+					 DEFAULT_ABBREV);
+		opt->ancestor = merge_base_abbrev.buf;
+		break;
+	default:
+		opt->ancestor = "merged common ancestors";
+	}
 	clean = merge_trees_internal(opt,
 				     repo_get_commit_tree(opt->repo, h1),
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
 				     &result_tree);
+	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
@@ -3644,6 +3657,8 @@ int merge_trees(struct merge_options *opt,
 	int clean;
 	struct tree *ignored;
 
+	assert(opt->ancestor != NULL);
+
 	if (merge_start(opt, head))
 		return -1;
 	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
@@ -3660,6 +3675,8 @@ int merge_recursive(struct merge_options *opt,
 {
 	int clean;
 
+	assert(opt->ancestor == NULL);
+
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
 	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
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
2.22.0.550.g71c37a0928.dirty

