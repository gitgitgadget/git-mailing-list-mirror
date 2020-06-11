Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3FFC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0084206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf8NoWM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgFKPPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFKPPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:15:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145AC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so6571653wrt.5
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9k5sBc6fMjgdIntwVzzFTXuFBtPjdRYdDfJ56gNAmyY=;
        b=qf8NoWM63JdA7IQDpoWU6NF1zlBHjOjhdZGi4NEKi0PcSlj0MlA0X8XXLeJBro/O/e
         RjkD/6mVEoYsedQMPKwPURRh0tNgUIVc1fLeRwqwSDLuOCwlBQLjVlf/t6WwGuK19IQK
         ADC08AO3rWMKsnVWZu3ZEqwTefPWKA3wTy2GQ+wwGquH5x7A2SzQ+QfDlzIrOFpBDqP7
         5B2RlIwSZfRtc2aEsk7LMathD6VepK/nyZvTdppR/iPdWQdtcNlvnYy0I7mNVpFnfjTE
         1Vhnu9DmauWn0nQGzpN1fNnR32KnV/6OKj4EUo/UDD6qVFc3DW6yFeo7WXGnTuI7SIE3
         qy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9k5sBc6fMjgdIntwVzzFTXuFBtPjdRYdDfJ56gNAmyY=;
        b=ImtInhx+bkpUbFJ55ZrSk1uycPdXeACShEzYGIpnohMji27EQLwf9tdeNVmY+F+FPE
         b+lKbcjq5CKl6Fz6dCgdUhg114TL/DPOlfs3TKB0zh8aCMwcM6aTCqTCaWiqsjK7Q0rr
         GTAQUWQJdtBWu/QUD3/YFpKGUZl/MYvaOwIKRqGignmtFpddTXO9rOmBqdKyWlA03SuH
         ndrP/YE8X6gX/S0jJfoWI42zbwAKIFNNdai1yBRQi+wLH6y84HokroL1XLTU8PifAT32
         NwudMbki84uHvwOVpqGA2t4yi9002Otnd1v6jxp6vr0ub/fPlL93Bx/ELuNOMObFlKR/
         E+gA==
X-Gm-Message-State: AOAM533ljvw86gagqS4MJgEqOh1tghVoBwZuhUZ80TvklqwKjiuQTF/p
        f0h2lTG73cjrRX5Km1oUDwBxqXjr
X-Google-Smtp-Source: ABdhPJxkRuzL7qiU3N9X/IZF8c3LXtuob1+PqvjnHirfEM03Rt80gG32aOL5JoomXCkAJAAq/o+zaQ==
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr10203342wrj.415.1591888514422;
        Thu, 11 Jun 2020 08:15:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm5562264wrb.94.2020.06.11.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:15:14 -0700 (PDT)
Message-Id: <60aed3f9d6543a5f66ff75a50c86cf626ec04ed4.1591888511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
References: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
        <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 15:15:09 +0000
Subject: [PATCH v3 2/3] git diff: improve range handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

When git diff is given a symmetric difference A...B, it chooses
some merge base from the two specified commits (as documented).

This fails, however, if there is *no* merge base: instead, you
see the differences between A and B, which is certainly not what
is expected.

Moreover, if additional revisions are specified on the command
line ("git diff A...B C"), the results get a bit weird:

 * If there is a symmetric difference merge base, this is used
   as the left side of the diff.  The last final ref is used as
   the right side.
 * If there is no merge base, the symmetric status is completely
   lost.  We will produce a combined diff instead.

Similar weirdness occurs if you use, e.g., "git diff C A...B D".
Likewise, using multiple two-dot ranges, or tossing extra
revision specifiers into the command line with two-dot ranges,
or mixing two and three dot ranges, all produce nonsense.

To avoid all this, add a routine to catch the range cases and
verify that that the arguments make sense.  As a side effect,
produce a warning showing *which* merge base is being used when
there are multiple choices; die if there is no merge base.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 builtin/diff.c            | 124 ++++++++++++++++++++++++++++++++++----
 t/t4068-diff-symmetric.sh |  91 ++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+), 13 deletions(-)
 create mode 100755 t/t4068-diff-symmetric.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index 8537b17bd5e..3d33a9231ae 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -6,6 +6,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
+#include "ewah/ewok.h"
 #include "lockfile.h"
 #include "color.h"
 #include "commit.h"
@@ -254,6 +255,108 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	return run_diff_files(revs, options);
 }
 
+struct symdiff {
+	struct bitmap *skip;
+	int warn;
+	const char *base, *left, *right;
+};
+
+/*
+ * Check for symmetric-difference arguments, and if present, arrange
+ * everything we need to know to handle them correctly.  As a bonus,
+ * weed out all bogus range-based revision specifications, e.g.,
+ * "git diff A..B C..D" or "git diff A..B C" get rejected.
+ *
+ * For an actual symmetric diff, *symdiff is set this way:
+ *
+ *  - its skip is non-NULL and marks *all* rev->pending.objects[i]
+ *    indices that the caller should ignore (extra merge bases, of
+ *    which there might be many, and A in A...B).  Note that the
+ *    chosen merge base and right side are NOT marked.
+ *  - warn is set if there are multiple merge bases.
+ *  - base, left, and right point to the names to use in a
+ *    warning about multiple merge bases.
+ *
+ * If there is no symmetric diff argument, sym->skip is NULL and
+ * sym->warn is cleared.  The remaining fields are not set.
+ */
+static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
+{
+	int i, is_symdiff = 0, basecount = 0, othercount = 0;
+	int lpos = -1, rpos = -1, basepos = -1;
+	struct bitmap *map = NULL;
+
+	/*
+	 * Use the whence fields to find merge bases and left and
+	 * right parts of symmetric difference, so that we do not
+	 * depend on the order that revisions are parsed.  If there
+	 * are any revs that aren't from these sources, we have a
+	 * "git diff C A...B" or "git diff A...B C" case.  Or we
+	 * could even get "git diff A...B C...E", for instance.
+	 *
+	 * If we don't have just one merge base, we pick one
+	 * at random.
+	 *
+	 * NB: REV_CMD_LEFT, REV_CMD_RIGHT are also used for A..B,
+	 * so we must check for SYMMETRIC_LEFT too.  The two arrays
+	 * rev->pending.objects and rev->cmdline.rev are parallel.
+	 */
+	for (i = 0; i < rev->cmdline.nr; i++) {
+		struct object *obj = rev->pending.objects[i].item;
+		switch (rev->cmdline.rev[i].whence) {
+		case REV_CMD_MERGE_BASE:
+			if (basepos < 0)
+				basepos = i;
+			basecount++;
+			break;		/* do mark all bases */
+		case REV_CMD_LEFT:
+			if (lpos > 0)
+				usage(builtin_diff_usage);
+			lpos = i;
+			if (obj->flags & SYMMETRIC_LEFT) {
+				is_symdiff = 1;
+				break;	/* do mark A */
+			}
+			continue;
+		case REV_CMD_RIGHT:
+			if (rpos > 0)
+				usage(builtin_diff_usage);
+			rpos = i;
+			continue;	/* don't mark B */
+		case REV_CMD_PARENTS_ONLY:
+		case REV_CMD_REF:
+		case REV_CMD_REV:
+			othercount++;
+			continue;
+		}
+		if (map == NULL)
+			map = bitmap_new();
+		bitmap_set(map, i);
+	}
+
+	/*
+	 * Forbid any additional revs for both A...B and A..B.
+	 */
+	if (lpos >= 0 && othercount > 0)
+		usage(builtin_diff_usage);
+
+	if (!is_symdiff) {
+		bitmap_free(map);
+		sym->warn = 0;
+		sym->skip = NULL;
+		return;
+	}
+
+	sym->left = rev->pending.objects[lpos].name;
+	sym->right = rev->pending.objects[rpos].name;
+	sym->base = rev->pending.objects[basepos].name;
+	if (basecount == 0)
+		die(_("%s...%s: no merge base"), sym->left, sym->right);
+	bitmap_unset(map, basepos);	/* unmark the base we want */
+	sym->warn = basecount > 1;
+	sym->skip = map;
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -263,6 +366,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	struct object_array_entry *blob[2];
 	int nongit = 0, no_index = 0;
 	int result = 0;
+	struct symdiff sdiff;
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -382,6 +486,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	symdiff_prepare(&rev, &sdiff);
 	for (i = 0; i < rev.pending.nr; i++) {
 		struct object_array_entry *entry = &rev.pending.objects[i];
 		struct object *obj = entry->item;
@@ -396,6 +501,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			obj = &get_commit_tree(((struct commit *)obj))->object;
 
 		if (obj->type == OBJ_TREE) {
+			if (sdiff.skip && bitmap_get(sdiff.skip, i))
+				continue;
 			obj->flags |= flags;
 			add_object_array(obj, name, &ent);
 		} else if (obj->type == OBJ_BLOB) {
@@ -437,21 +544,12 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		usage(builtin_diff_usage);
 	else if (ent.nr == 1)
 		result = builtin_diff_index(&rev, argc, argv);
-	else if (ent.nr == 2)
+	else if (ent.nr == 2) {
+		if (sdiff.warn)
+			warning(_("%s...%s: multiple merge bases, using %s"),
+				sdiff.left, sdiff.right, sdiff.base);
 		result = builtin_diff_tree(&rev, argc, argv,
 					   &ent.objects[0], &ent.objects[1]);
-	else if (ent.objects[0].item->flags & UNINTERESTING) {
-		/*
-		 * diff A...B where there is at least one merge base
-		 * between A and B.  We have ent.objects[0] ==
-		 * merge-base, ent.objects[ents-2] == A, and
-		 * ent.objects[ents-1] == B.  Show diff between the
-		 * base and B.  Note that we pick one merge base at
-		 * random if there are more than one.
-		 */
-		result = builtin_diff_tree(&rev, argc, argv,
-					   &ent.objects[0],
-					   &ent.objects[ent.nr-1]);
 	} else
 		result = builtin_diff_combined(&rev, argc, argv,
 					       ent.objects, ent.nr);
diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
new file mode 100755
index 00000000000..dd60da0294e
--- /dev/null
+++ b/t/t4068-diff-symmetric.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='behavior of diff with symmetric-diff setups'
+
+. ./test-lib.sh
+
+# build these situations:
+#  - normal merge with one merge base (b1...b2);
+#  - criss-cross merge ie 2 merge bases (b1...master);
+#  - disjoint subgraph (orphan branch, b3...master).
+#
+#     B---E   <-- master
+#    / \ /
+#   A   X
+#    \ / \
+#     C---D--G   <-- br1
+#      \    /
+#       ---F   <-- br2
+#
+#  H  <-- br3
+#
+# We put files into a few commits so that we can verify the
+# output as well.
+
+test_expect_success setup '
+	git commit --allow-empty -m A &&
+	echo b >b &&
+	git add b &&
+	git commit -m B &&
+	git checkout -b br1 HEAD^ &&
+	echo c >c &&
+	git add c &&
+	git commit -m C &&
+	git tag commit-C &&
+	git merge -m D master &&
+	git tag commit-D &&
+	git checkout master &&
+	git merge -m E commit-C &&
+	git checkout -b br2 commit-C &&
+	echo f >f &&
+	git add f &&
+	git commit -m F &&
+	git checkout br1 &&
+	git merge -m G br2 &&
+	git checkout --orphan br3 &&
+	git commit -m H
+'
+
+test_expect_success 'diff with one merge base' '
+	git diff commit-D...br1 >tmp &&
+	tail -n 1 tmp >actual &&
+	echo +f >expect &&
+	test_cmp expect actual
+'
+
+# The output (in tmp) can have +b or +c depending
+# on which merge base (commit B or C) is picked.
+# It should have one of those two, which comes out
+# to seven lines.
+test_expect_success 'diff with two merge bases' '
+	git diff br1...master >tmp 2>err &&
+	test_line_count = 7 tmp &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'diff with no merge bases' '
+	test_must_fail git diff br2...br3 >tmp 2>err &&
+	test_i18ngrep "fatal: br2...br3: no merge base" err
+'
+
+test_expect_success 'diff with too many symmetric differences' '
+	test_must_fail git diff br1...master br2...br3 >tmp 2>err &&
+	test_i18ngrep "usage" err
+'
+
+test_expect_success 'diff with symmetric difference and extraneous arg' '
+	test_must_fail git diff master br1...master >tmp 2>err &&
+	test_i18ngrep "usage" err
+'
+
+test_expect_success 'diff with two ranges' '
+	test_must_fail git diff master br1..master br2..br3 >tmp 2>err &&
+	test_i18ngrep "usage" err
+'
+
+test_expect_success 'diff with ranges and extra arg' '
+	test_must_fail git diff master br1..master commit-D >tmp 2>err &&
+	test_i18ngrep "usage" err
+'
+
+test_done
-- 
gitgitgadget

