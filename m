Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F3BC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 05:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0F16140C
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 05:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFOFSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 01:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFOFST (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 01:18:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EACBC061767
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 22:16:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r9so16825925wrz.10
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pmvKoYWpif50u/MRRKxr0ZCtIqUUVRUcmAyk02ZqG8s=;
        b=J1P/vuMR8J5ciG3ct0zyFUB/hswmO7zXr3kLnrxv95bQN0zLEXK1mAtwX19eGR8Uyu
         zVjVUYXNgUnG+hixCxeQpRdNTvnGUUosmJ2zW0GDTq/9qgfz5qf0F0gU+gL4m3zDLqjk
         kanvKmRMNuctCIrCTKYiASdzCy2eYSPU3WXu7DcqxVXM1b2h4IyZ5m5SsdcsPNzc6DzZ
         v5VjsmgKTe28cbkzEtSpb+a+u1vBIGhD+CMzqqXLqOfAk7pP8Y6nS+yH8AU72CD+d/6F
         X5IpawDAY+ROCoU/RiZlmyIjYoswNOiFh1tXjtRoXPvzXxl88FY/l7TyzHafjknlUQ3C
         F+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pmvKoYWpif50u/MRRKxr0ZCtIqUUVRUcmAyk02ZqG8s=;
        b=XQmkn+AwYi1bvADdj2uYIZdae8pboGcpGm+79LinRtklQuYafPbMvxN9X1NPJ4Adjk
         YQleYCXunYMCGCZBUIaiWSyQ5gV7GjY776rdYUquVyVPHgdpkjA4i4whR68+VPfClghS
         8GjS4lrZbcQK5YvQLpcQtnLJ2bqDZAelIV/lxlrmTGWBPYBD67VARo96n+k6ZoYDh7Ra
         W6VPLISo9WFTMbhW1DrPDbDv3v+YEW8nrOy3OibZIKZk+TFH4xgGVSSV8Nz9yurXbG2S
         Ek8nB/Ld2ehgq6uSjj9jiX/MA7XkSsjxNrm8gtW+3T9cvBn0cV2FR858ob0ip1LCZFle
         XzLw==
X-Gm-Message-State: AOAM532JiGqAcXci1wBBi8//RG6z9vkbg/K5wwHxyUjDRu7QoPiNE5f6
        9SHNIlqQ8Xt2YKwltZTCipVa+vOfTxA=
X-Google-Smtp-Source: ABdhPJxNnL//3VJjGUTmToL1ITqz8tKwwNC3KEYvgYhhrhxNXPqAagXz8i1v1lB3WcPJEZHil75PGg==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr17141434wre.217.1623734173057;
        Mon, 14 Jun 2021 22:16:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm15388413wmb.26.2021.06.14.22.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 22:16:12 -0700 (PDT)
Message-Id: <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 05:16:09 +0000
Subject: [PATCH 1/2] xdiff: implement a zealous diff3, or "zdiff3"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

Initial-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  2 +-
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 52 ++++++++++++++++++++++++--
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 06a2f90c4875..e695867ee548 100644
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
index b50c5d0ea386..859455929814 100644
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
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 609615db2cd6..9977813a9d37 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -308,6 +308,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_DIFF3;
+		else if (!strcmp(value, "zdiff3"))
+			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
 		/*
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 7a046051468f..8629ae287c79 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -65,6 +65,7 @@ extern "C" {
 
 /* merge output styles */
 #define XDL_MERGE_DIFF3 1
+#define XDL_MERGE_ZEALOUS_DIFF3 2
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1659edb45393..b1dc9df7ea0a 100644
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
@@ -482,6 +518,16 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
+	/*
+	 * XDL_MERGE_DIFF3 does not attempt to refine conflicts by looking
+	 * at common areas of sides 1 & 2, because the base (side 0) does
+	 * not match and is being shown.
+	 *
+	 * XDL_MERGE_ZEALOUS_DIFF3 will attempt to refine conflicts
+	 * looking for common areas of sides 1 & 2, despite the base
+	 * not matching and being shown, but will only look for common
+	 * areas at the beginning or ending of the conflict block.
+	 */
 	if (style == XDL_MERGE_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
@@ -604,7 +650,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		changes = c;
 	/* refine conflicts */
 	if (XDL_MERGE_ZEALOUS <= level &&
-	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
+	    (xdl_refine_conflicts(xe1, xe2, changes, xpp, style) < 0 ||
 	     xdl_simplify_non_conflicts(xe1, changes,
 					XDL_MERGE_ZEALOUS < level) < 0)) {
 		xdl_cleanup_merge(changes);
-- 
gitgitgadget

