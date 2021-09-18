Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B71C433FE
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C9C610A5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbhIRXEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbhIRXEM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:04:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E39C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:02:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so14499289wri.1
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZpIKZs5yF8HBItHnRi7z9NjjBBjrUnrXD+Crgm6uABM=;
        b=SyCJ/oOAN5IMU4HrOgNrZ+cOtG9/0nRoQGuw2Wd2HBggLBZppz3ZNVnbeX8KRIGca6
         g4+xV1iTsfcz4rho1eEUlCAAXcF1KHlB5KyE+FsQHUWmVxQAmZ9iqkMc0fweOI3OlJhs
         Q5aegHIbBGe1XOZRiXCnYW0oJxGa6kxBP2G3GxCQ67Vby0VRZvfrBryC8/OvWarF8NNx
         aGiNKqTV3CuZrjF7WSAUvn3EPjZTaYXMF/0JkrV19YNHETWHHbc4qF5ipaRKJKPg+B87
         jLyjBU98uX1j5zZulOddKrjo4LG3E8g3TRYmmreUa3w9qBsppBn7dqgKOmySqVOWwiMZ
         EhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ZpIKZs5yF8HBItHnRi7z9NjjBBjrUnrXD+Crgm6uABM=;
        b=Nh3x1+1MQLlLTog6q4e/yX+QKSdITG5GHDpluoznmXXnmcbC1lfu6LOffQDF1sbHY4
         xr/C+YFbCmQh04T1GeF58Ym7cUrfOHW+f/k8PFD4FeByk/gHxM054VbX+b4phy1Z5F/s
         YwqzTlaqq5FNlDndfQfguRbXwQMqXJu1X1oUEdOCr8cokMDIe6KMOidStBxvxQsKvnQH
         m5Qm/B5UtVtLBg1KHCMu19yWgTV2C11P+FSKCAsE1/LTHEe84B/5HiIqcuKSmeoPnAP4
         MorPelCIzqeKYMnGS1v3KqbtV//FYA2B3uXciiFnMqDK6hz7yqVg2mzmwWcTaS5YhJSo
         dmjw==
X-Gm-Message-State: AOAM531ycIxSIYJIzKK4MXIkz4NV/UD1NAEI0RGptjRoStAh8f9HilBK
        9EYFcDqFnoDY+biEka4HDuBn6vP5ISs=
X-Google-Smtp-Source: ABdhPJx6KtmHwgzJMToAhoMnzAUn8PVG0v5H2wG1P8XPEC1MstjvYUAgUVwR9TaFxaENdDGPV1olZw==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr4926850wrz.439.1632006166647;
        Sat, 18 Sep 2021 16:02:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm11737921wrc.26.2021.09.18.16.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:02:46 -0700 (PDT)
Message-Id: <798aefbb40ae680f0f9533964425c4c5f1563860.1632006164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
        <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:02:43 +0000
Subject: [PATCH v3 1/2] xdiff: implement a zealous diff3, or "zdiff3"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

"zdiff3" is identical to ordinary diff3 except that it allows compaction
of common lines on the two sides of history at the beginning or end of
the conflict hunk.  For example, the following diff3 conflict:

    1
    2
    3
    4
    <<<<<<
    A
    B
    C
    D
    E
    ||||||
    5
    6
    ======
    A
    X
    C
    Y
    E
    >>>>>>
    7
    8
    9

has common lines 'A', 'C', and 'E' on the two sides.  With zdiff3, one
would instead get the following conflict:

    1
    2
    3
    4
    A
    <<<<<<
    B
    C
    D
    ||||||
    5
    6
    ======
    X
    C
    Y
    >>>>>>
    E
    7
    8
    9

Note that the common lines, 'A', and 'E' were moved outside the
conflict.  Unlike with the two-way conflicts from the 'merge'
conflictStyle, the zdiff3 conflict is NOT split into multiple conflict
regions to allow the common 'C' lines to be shown outside a conflict,
because zdiff3 shows the base version too and the base version cannot be
reasonably split.

Note also that the removing of lines common to the two sides might make
the remaining text inside the conflict region match the base text inside
the conflict region (for example, if the diff3 conflict had '5 6 E' on
the right side of the conflict, then the common line 'E' would be moved
outside and both the base and right side's remaining conflict text would
be the lines '5' and '6').  This has the potential to surprise users and
make them think there should not have been a conflict, but there
definitely was a conflict and it should remain.

Based-on-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Co-authored-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +-
 t/t6427-diff3-conflict-markers.sh      | 90 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 68 +++++++++++++++++--
 6 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 06a2f90c487..e695867ee54 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -34,6 +34,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
+		OPT_SET_INT(0, "zdiff3", &xmp.style, N_("use a zealous diff3 based merge"),
+				XDL_MERGE_ZEALOUS_DIFF3),
 		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our version"),
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their version"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8108eda1e86..a7fb14e9a40 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1566,7 +1566,7 @@ _git_checkout ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--*)
 		__gitcomp_builtin checkout
@@ -2446,7 +2446,7 @@ _git_switch ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--*)
 		__gitcomp_builtin switch
@@ -2887,7 +2887,7 @@ _git_restore ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--source=*)
 		__git_complete_refs --cur="${cur##--source=}"
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index 25c4b720e72..dc740757187 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -211,4 +211,94 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 	)
 '
 
+test_setup_zdiff3 () {
+	test_create_repo zdiff3 &&
+	(
+		cd zdiff3 &&
+
+		test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
+		test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 >evil &&
+
+		git add basic middle-common interesting evil &&
+		git commit -m base &&
+
+		git branch left &&
+		git branch right &&
+
+		git checkout left &&
+		test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
+		test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
+		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
+		test_write_lines 1 2 3 4 X A B C 7 8 9 >evil &&
+		git add -u &&
+		git commit -m letters &&
+
+		git checkout right &&
+		test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
+		test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
+		test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
+		test_write_lines 1 2 3 4 Y A B C B C 7 8 9 >evil &&
+		git add -u &&
+		git commit -m permuted
+	)
+}
+
+test_expect_failure 'check zdiff3 markers' '
+	test_setup_zdiff3 &&
+	(
+		cd zdiff3 &&
+
+		git checkout left^0 &&
+
+		base=$(git rev-parse --short HEAD^1) &&
+		test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
+
+		test_write_lines 1 2 3 4 A \
+				 "<<<<<<< HEAD" B C D \
+				 "||||||| $base" 5 6 \
+				 ======= X C Y \
+				 ">>>>>>> right^0" \
+				 E 7 8 9 \
+				 >expect &&
+		test_cmp expect basic &&
+
+		test_write_lines 1 2 3 \
+				 "<<<<<<< HEAD" CC \
+				 "||||||| $base" AA \
+				 ======= EE \
+				 ">>>>>>> right^0" \
+				 4 5 \
+				 "<<<<<<< HEAD" DD \
+				 "||||||| $base" BB \
+				 ======= FF \
+				 ">>>>>>> right^0" \
+				 6 7 8 \
+				 >expect &&
+		test_cmp expect middle-common &&
+
+		test_write_lines 1 2 3 4 A B C \
+				 "<<<<<<< HEAD" D E F \
+				 "||||||| $base" 5 6 \
+				 ======= 5 6 \
+				 ">>>>>>> right^0" \
+				 G H I J 7 8 9 \
+				 >expect &&
+		test_cmp expect interesting &&
+
+		# Not passing this one yet; the common "B C" lines is still
+		# being left in the conflict blocks on the left and right
+		# sides.
+		test_write_lines 1 2 3 4 \
+				 "<<<<<<< HEAD" X A \
+				 "||||||| $base" 5 6 \
+				 ======= Y A B C \
+				 ">>>>>>> right^0" \
+				 B C 7 8 9 \
+				 >expect &&
+		test_cmp expect evil
+	)
+'
+
 test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 75b32aef51d..2e3a5a2943e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -313,6 +313,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_DIFF3;
+		else if (!strcmp(value, "zdiff3"))
+			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
 		/*
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b29deca5de8..72e25a9ffa5 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -66,6 +66,7 @@ extern "C" {
 
 /* merge output styles */
 #define XDL_MERGE_DIFF3 1
+#define XDL_MERGE_ZEALOUS_DIFF3 2
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1659edb4539..df0c6041778 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -230,7 +230,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
 			      dest ? dest + size : NULL);
 
-	if (style == XDL_MERGE_DIFF3) {
+	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
 			size += marker_size + 1 + needs_cr + marker3_size;
@@ -327,7 +327,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
  * lines. Try hard to show only these few lines as conflicting.
  */
 static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
-		xpparam_t const *xpp)
+				xpparam_t const *xpp, int style)
 {
 	for (; m; m = m->next) {
 		mmfile_t t1, t2;
@@ -368,6 +368,42 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 			continue;
 		}
 		x = xscr;
+		if (style == XDL_MERGE_ZEALOUS_DIFF3) {
+			int advance1 = xscr->i1, advance2 = xscr->i2;
+
+			/*
+			 * Advance m->i1 and m->i2 so that conflict for sides
+			 * 1 and 2 start after common region.  Decrement
+			 * m->chg[12] since there are now fewer conflict lines
+			 * for those sides.
+			 */
+			m->i1 += advance1;
+			m->i2 += advance2;
+			m->chg1 -= advance1;
+			m->chg2 -= advance2;
+
+			/*
+			 * Splitting conflicts due to internal common regions
+			 * on the two sides would be inappropriate since we
+			 * are also showing the merge base and have no
+			 * reasonable way to split the merge base text.
+			 */
+			while (xscr->next)
+				xscr = xscr->next;
+
+			/*
+			 * Lower the number of conflict lines to not include
+			 * the final common lines, if any.  Do this by setting
+			 * number of conflict lines to
+			 *   (line offset for start of conflict in xscr) +
+			 *   (number of lines in the conflict in xscr)
+			 */
+			m->chg1 = (xscr->i1 - advance1) + (xscr->chg1);
+			m->chg2 = (xscr->i2 - advance2) + (xscr->chg2);
+			xdl_free_env(&xe);
+			xdl_free_script(x);
+			continue;
+		}
 		m->i1 = xscr->i1 + i1;
 		m->chg1 = xscr->chg1;
 		m->i2 = xscr->i2 + i2;
@@ -419,6 +455,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 static void xdl_merge_two_conflicts(xdmerge_t *m)
 {
 	xdmerge_t *next_m = m->next;
+	m->chg0 = next_m->i0 + next_m->chg0 - m->i0;
 	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
 	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
 	m->next = next_m->next;
@@ -430,12 +467,12 @@ static void xdl_merge_two_conflicts(xdmerge_t *m)
  * it appears simpler -- because it takes up less (or as many) lines --
  * if the lines are moved into the conflicts.
  */
-static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
+static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m, int style,
 				      int simplify_if_no_alnum)
 {
 	int result = 0;
 
-	if (!m)
+	if (!m || style == XDL_MERGE_ZEALOUS_DIFF3)
 		return result;
 	for (;;) {
 		xdmerge_t *next_m = m->next;
@@ -482,6 +519,25 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
+	/*
+	 * XDL_MERGE_DIFF3 does not attempt to refine conflicts by looking
+	 * at common areas of sides 1 & 2, because the base (side 0) does
+	 * not match and is being shown.  Similarly, simplification of
+	 * non-conflicts is also skipped due to the skipping of conflict
+	 * refinement.
+	 *
+	 * XDL_MERGE_ZEALOUS_DIFF3, on the other hand, will attempt to
+	 * refine conflicts looking for common areas of sides 1 & 2.
+	 * However, since the base is being shown and does not match,
+	 * it will only look for common areas at the beginning or end
+	 * of the conflict block.  Since XDL_MERGE_ZEALOUS_DIFF3's
+	 * conflict refinement is much more limited in this fashion, the
+	 * conflict simplification will be skipped.
+	 *
+	 * See xdl_refine_conflicts() and xdl_simplify_non_conflicts()
+	 * for more details, particularly looking for
+	 * XDL_MERGE_ZEALOUS_DIFF3.
+	 */
 	if (style == XDL_MERGE_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
@@ -604,8 +660,8 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		changes = c;
 	/* refine conflicts */
 	if (XDL_MERGE_ZEALOUS <= level &&
-	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
-	     xdl_simplify_non_conflicts(xe1, changes,
+	    (xdl_refine_conflicts(xe1, xe2, changes, xpp, style) < 0 ||
+	     xdl_simplify_non_conflicts(xe1, changes, style,
 					XDL_MERGE_ZEALOUS < level) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
-- 
gitgitgadget

