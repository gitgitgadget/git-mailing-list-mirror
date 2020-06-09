Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7673AC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522A92068D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv5H6rTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbgFITAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389101AbgFITAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:00:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27375C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:00:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d128so4232419wmc.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0x4OtFu9xWU+RmoiW5mdloOlld4Brwexr4XNl/WDBj4=;
        b=Sv5H6rTcNWaHK6S0IgFA+0ZzuUD1KB06Fi8OA3A7USO2PcuoT4C8sbIKP33D7KtWX6
         hPbMufsEx3+zc39otAzk9kDF3zmasl0WaY73aDOgSvyyGJwQLVutKnBze+CWwYAfFtzR
         Rz8443aEfZ1iV318GEf/itydk9fVLUk3BH/JDxllTj+OjfcqADMSFmD7jtRFl/kPWu6l
         2UZmOQpXC1xprAOLAoDkJLPv69sS13CXEfg2IH7y8KtEwhz/1YoZu7mofqp1njYab/JE
         wi0UIi3Lkea506YE6FhpEs1bSmVNw/FEAEToY+6kPIuX8KpEx2tL3XoxZA5WSKoyTcEj
         mgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0x4OtFu9xWU+RmoiW5mdloOlld4Brwexr4XNl/WDBj4=;
        b=fUdR0T3Hs3E8cokYO6wgKfvJBIj2Lr3lWFyLerP20ZQp4yb2VR8VhAvvh2VtYO5OmH
         o0HwaMFTcqUlack/cjALiIL6vXMouCV/iOqQwXfKYvpzFDwFltymqQGWEa3Czo37iLG/
         F1WWtusm+oPS6iQAJEOou7B2NmkfPAppJV6lRFAaIqT9kswxLepTB8QOlmzR/ZQ0MOxG
         AWlDbY/8d3Pb7BLiVUpd2dsRbj1at7gaRxoXNkZY/gGeT6cUdA/WAaCUxmwGB3qbAJTm
         CWXFP8M/k3BKo0mxoc9QsXELpFI3XaoBaEBliu6AP0MpKroIPPlc3TEbDTpc/bjqMV2m
         DWVg==
X-Gm-Message-State: AOAM5303ALhjPHmXmKFUXZYpW+vk+vHgTOuEqlnt6gKrA9ZmbyaXBiL6
        9JIX6IWbRAMeHLLkmy3TkGRAcFTc
X-Google-Smtp-Source: ABdhPJxWQ8icyloerhu+W7vh/9YXghzCcj47BRGJrL95JVZmTmlsrRnCvgDRrHgXrQ+ybplVyhFm+g==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr5712090wmf.133.1591729227284;
        Tue, 09 Jun 2020 12:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b185sm4408196wmd.3.2020.06.09.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:00:26 -0700 (PDT)
Message-Id: <100fa4034771e58b65cdac2f3dfb48531c07b735.1591729224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 19:00:22 +0000
Subject: [PATCH v2 2/3] git diff: improve A...B merge-base handling
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

To avoid all this, add a routine to catch the A...B case and verify that
there is at least one merge base, and that the arguments make sense.
As a side effect, produce a warning showing *which* merge base is being
used when there are multiple choices; die if there is no merge base.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 builtin/diff.c            | 129 +++++++++++++++++++++++++++++++++-----
 t/t4068-diff-symmetric.sh |  81 ++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 15 deletions(-)
 create mode 100755 t/t4068-diff-symmetric.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index 8537b17bd5e..0b6e63dbd02 100644
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
@@ -254,6 +255,103 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	return run_diff_files(revs, options);
 }
 
+struct symdiff {
+	struct bitmap *skip;	/* bitmap of commit indices to skip, or NULL */
+	int warn;		/* true if there were multiple merge bases */
+	int base, left, right;	/* index of chosen merge base and left&right */
+};
+
+/*
+ * Check for symmetric-difference arguments, and if present, arrange
+ * everything we need to know to handle them correctly.
+ *
+ * For an actual symmetric diff, *symdiff is set this way:
+ *
+ *  - its skip is non-NULL and marks *all* rev->pending.objects[i]
+ *    indices that the caller should ignore (extra merge bases, of
+ *    which there might be many, and A in A...B).  Note that the
+ *    chosen merge base and right side are NOT marked.
+ *  - warn is set if there are multiple merge bases.
+ *  - base, left, and right hold the merge base and left and
+ *    right side indices, for warnings or errors.
+ *
+ * If there is no symmetric diff argument, sym->skip is NULL and
+ * sym->warn is cleared.  The remaining fields are not set.
+ *
+ * If the user provides a symmetric diff with no merge base, or
+ * more than one range, we do a usage-exit.
+ */
+static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
+{
+	int i, lcount = 0, rcount = 0, basecount = 0;
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
+			if (obj->flags & SYMMETRIC_LEFT) {
+				lpos = i;
+				lcount++;
+				break;	/* do mark A */
+			}
+			continue;
+		case REV_CMD_RIGHT:
+			rpos = i;
+			rcount++;
+			continue;	/* don't mark B */
+		default:
+			continue;
+		}
+		if (map == NULL)
+			map = bitmap_new();
+		bitmap_set(map, i);
+	}
+
+	if (lcount == 0) {	/* not a symmetric difference */
+		bitmap_free(map);
+		sym->warn = 0;
+		sym->skip = NULL;
+		return;
+	}
+
+	if (lcount != 1)
+		die(_("cannot use more than one symmetric difference"));
+
+	if (basecount == 0) {
+		const char *lname = rev->pending.objects[lpos].name;
+		const char *rname = rev->pending.objects[rpos].name;
+		die(_("%s...%s: no merge base"), lname, rname);
+	}
+	bitmap_unset(map, basepos);	/* unmark the base we want */
+	sym->base = basepos;
+	sym->left = lpos;
+	sym->right = rpos;
+	sym->warn = basecount > 1;
+	sym->skip = map;
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -263,6 +361,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	struct object_array_entry *blob[2];
 	int nongit = 0, no_index = 0;
 	int result = 0;
+	struct symdiff sdiff;
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -382,6 +481,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	symdiff_prepare(&rev, &sdiff);
 	for (i = 0; i < rev.pending.nr; i++) {
 		struct object_array_entry *entry = &rev.pending.objects[i];
 		struct object *obj = entry->item;
@@ -394,8 +494,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type == OBJ_COMMIT)
 			obj = &get_commit_tree(((struct commit *)obj))->object;
-
 		if (obj->type == OBJ_TREE) {
+			if (sdiff.skip && bitmap_get(sdiff.skip, i))
+				continue;
 			obj->flags |= flags;
 			add_object_array(obj, name, &ent);
 		} else if (obj->type == OBJ_BLOB) {
@@ -437,24 +538,22 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		usage(builtin_diff_usage);
 	else if (ent.nr == 1)
 		result = builtin_diff_index(&rev, argc, argv);
-	else if (ent.nr == 2)
+	else if (ent.nr == 2) {
+		if (sdiff.warn) {
+			const char *lname = rev.pending.objects[sdiff.left].name;
+			const char *rname = rev.pending.objects[sdiff.right].name;
+			const char *basename = rev.pending.objects[sdiff.base].name;
+			warning(_("%s...%s: multiple merge bases, using %s"),
+				lname, rname, basename);
+		}
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
-	} else
+	} else {
+		if (sdiff.skip)
+			usage(builtin_diff_usage);
 		result = builtin_diff_combined(&rev, argc, argv,
 					       ent.objects, ent.nr);
+	}
 	result = diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
new file mode 100755
index 00000000000..7b5988933da
--- /dev/null
+++ b/t/t4068-diff-symmetric.sh
@@ -0,0 +1,81 @@
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
+	tail -1 tmp >actual &&
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
+	test_i18ngrep "fatal: cannot use more than one symmetric difference" err
+'
+
+test_expect_success 'diff with symmetric difference and extraneous arg' '
+	test_must_fail git diff master br1...master >tmp 2>err &&
+	test_i18ngrep "usage" err
+'
+
+test_done
-- 
gitgitgadget

