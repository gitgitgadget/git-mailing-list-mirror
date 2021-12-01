Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415FDC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbhLAAIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhLAAIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:08:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D07C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:05:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so18870407wmq.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tn+Yup20qjD9E22IRE29YWxpahjLdja0sz4mTvoFh8o=;
        b=Ak2TpH8/ouTgR6SyDahqS1ewnvPg1qJQSL/rBOqjVfx7VDUh4GY9lxKPNa40qfvl79
         9Tbru7vQ/uPLEcfOPWH6P3MOCkdwOKARxOgO+TkfVSuEnrfiTQzV4XNdorGQKnweEIeA
         IHFPlUSyiVVJKIoa7DIJGOnwZYP70FdeeEwGEyW4xoZCcFqQY2z4uEe8n9aucaT6syFy
         k+OtddHoyqP3QCxRJfJt7o7XtzZUKrD/DQJcXz7D8hRWPVCsrSnGsHUHlONDOCex0yEC
         H/z7ngSaWKnkjRdWWcn9IMebZ5Kpv4SEOXBPPWzPnDgwKXeHDAxPf7xg+Ujj++/7aNBD
         /CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tn+Yup20qjD9E22IRE29YWxpahjLdja0sz4mTvoFh8o=;
        b=DTVfaUSkebo0XewB3Yw9Z0UJCIKuXE+25nzvAq2IYDdICboaoTWA0xbKS2F1gK5joF
         HJJmMwLaJW+HHdi8/b9zibC45EeS4kSAK1BRDJZ08vOHe7/bkgVsXnSNwDSlD/qx/O/S
         SzH4cB31K59va5QRaL6BlJPrZSorShoB9l1KP5Lnde0o2uAbidI4YL5azyd3C916L23h
         aGWl3bMhtZjKcJWEmJQUPiiVSdMlsrECFa9zGR8mewP3cFKo+DNe4KPx5yAjZvzwx6Mi
         sRsuIQXK0rkcADOxhZp34XdU7zc3f9mrrIl3ZbYPi08aAtTjz5mdxV/wqzYnFbu2Zm+m
         AVMg==
X-Gm-Message-State: AOAM533VK8JsRewZxxFZN/d+OFOH3J+yH944MW8SNToAd01j2QVLDz83
        raRBTDnT4qVAOCIn4fLUb5f8FC1NFaw=
X-Google-Smtp-Source: ABdhPJw3ddjRKC9igQoAvYHIgiKACSMrMfqwtw6QA5lwFi+ofQFOezjVKIzgZsrVlKjenAFubklERg==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr2532973wmb.51.1638317110091;
        Tue, 30 Nov 2021 16:05:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm21530143wri.74.2021.11.30.16.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 16:05:09 -0800 (PST)
Message-Id: <473fae82da160459189a6ef11b909ee074464184.1638317108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>
References: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
        <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 00:05:06 +0000
Subject: [PATCH v5 1/2] xdiff: implement a zealous diff3, or "zdiff3"
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
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

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
Co-authored-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +-
 t/t6427-diff3-conflict-markers.sh      | 90 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 63 ++++++++++++++++--
 6 files changed, 155 insertions(+), 9 deletions(-)

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
index 25c4b720e72..a9ee4cb207a 100755
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
+test_expect_success 'check zdiff3 markers' '
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
index 1659edb4539..fff0b594f9a 100644
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
@@ -322,6 +322,40 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 	return size;
 }
 
+static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
+{
+	return xdl_recmatch(rec1->ptr, rec1->size,
+			    rec2->ptr, rec2->size, flags);
+}
+
+/*
+ * Remove any common lines from the beginning and end of the conflicted region.
+ */
+static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
+		xpparam_t const *xpp)
+{
+	xrecord_t **rec1 = xe1->xdf2.recs, **rec2 = xe2->xdf2.recs;
+	for (; m; m = m->next) {
+		/* let's handle just the conflicts */
+		if (m->mode)
+			continue;
+
+		while(m->chg1 && m->chg2 &&
+		      recmatch(rec1[m->i1], rec2[m->i2], xpp->flags)) {
+			m->chg1--;
+			m->chg2--;
+			m->i1++;
+			m->i2++;
+		}
+		while (m->chg1 && m->chg2 &&
+		       recmatch(rec1[m->i1 + m->chg1 - 1],
+				rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
+			m->chg1--;
+			m->chg2--;
+		}
+	}
+}
+
 /*
  * Sometimes, changes are not quite identical, but differ in only a few
  * lines. Try hard to show only these few lines as conflicting.
@@ -482,7 +516,22 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
-	if (style == XDL_MERGE_DIFF3) {
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
+	 */
+	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
 		 * more aggressive than XDL_MERGE_EAGER.
@@ -603,10 +652,12 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (XDL_MERGE_ZEALOUS <= level &&
-	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
-	     xdl_simplify_non_conflicts(xe1, changes,
-					XDL_MERGE_ZEALOUS < level) < 0)) {
+	if (style == XDL_MERGE_ZEALOUS_DIFF3) {
+		xdl_refine_zdiff3_conflicts(xe1, xe2, changes, xpp);
+	} else if (XDL_MERGE_ZEALOUS <= level &&
+		   (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
+		    xdl_simplify_non_conflicts(xe1, changes,
+					       XDL_MERGE_ZEALOUS < level) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
-- 
gitgitgadget

