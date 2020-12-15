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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C40C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8B2227C3
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgLOScl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgLOS3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34048C0611C5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c5so17197952wrp.6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jqrshys1PBZBm3tZpHK86UWzCXBVH+6N8C7lohnC76k=;
        b=Isk7qSbm+47mHJsEF6XGNrmSS+VTQVjFxcEjXIkah6P7iPDpcCnDjCrdWDoVYAiiHX
         azCUtY531GIUp+nfEvWOFxDKg0RuP6jAtKbPYU8fyUCnswSbFrzI8x+cUCCSK73RjvhF
         yrQKdqFJSGbvG6gfkPSKU3B2q32PcPCrj3coZvvvWFh0u7w4TnGu2L5GBy/O+bp98wds
         hw+F9uxxSKQoG7BO68KLJc2QkctlUeiD6dZrOiyp8GzF62KS0iXbh5pSzFk3Avdz587z
         4eLjed9nakcL09m000M9H7VZpZgoS2har3GaRtfon6ex2CAeP8h9lW/HNyPLTJS+fYFg
         Rzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jqrshys1PBZBm3tZpHK86UWzCXBVH+6N8C7lohnC76k=;
        b=DoATyscG6gvNvoGRGqejin8WOdBRyECCh3+CBtCZSYc1ZqmpruP9Dj87w3Tyspl2dn
         HT2+nA02DVOoMSzcfpBGXTU9pi/i61vAnbvPXQRvhfLNiZpQs89Q7v7aedJhsHQRvjAa
         jq4pO6zbveYlAXZl3V4XSFn4JoThzBupxwEaEoERfEtQ9U8ZHMqGbTs8E8wBq1exNxdD
         XM8UmGLjMk/1QNKiHHN9EFqLgzhOyNQm4biW605mfPfqEm9n/YX36YyWiW9rbuPIFiEe
         JJ421jMORUC3XUpQVcoOydtXi5w7tDVvKakjjZTCrWhXP344L0EeSlWbY2MDakG9vOKj
         6jAw==
X-Gm-Message-State: AOAM530+XExe6UAaFAa6PaOGmv6MhNMWrhdoLGPk0H95kq7sz4CoxFX0
        O5PhEk4YKx9UxGi+kAuytY3PLFflFP8=
X-Google-Smtp-Source: ABdhPJxi2CCCwmDOSjxlt3kg75LxraT3Uk54eij/z5IPmKYF/a8W+oB6vlSlyoEpLx/KN7SJClGt7g==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr6058121wrr.69.1608056894473;
        Tue, 15 Dec 2020 10:28:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q73sm39341506wme.44.2020.12.15.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:14 -0800 (PST)
Message-Id: <d37e2626c30b03ecd5d091e0e1860144a1c0283b.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:28:02 +0000
Subject: [PATCH v3 07/11] merge-ort: add implementation of both sides renaming
 differently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement rename/rename(1to2) handling, i.e. both sides of history
renaming a file and rename it differently.  This code replaces the
following from merge-recurisve.c:

  * all the 1to2 code in process_renames()
  * the RENAME_ONE_FILE_TO_TWO case of process_entry()
  * handle_rename_rename_1to2()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_file_collision()
  * setup_rename_conflict_info()

The consolidation of five separate codepaths into one is made possible
by a change in design: process_renames() tweaks the conflict_info
entries within opt->priv->paths such that process_entry() can then
handle all the non-rename conflict types (directory/file, modify/delete,
etc.) orthogonally.  This means we're much less likely to miss special
implementation of some kind of combination of conflict types (see
commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
2020-11-18), especially commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26) for more details).
That, together with letting worktree/index updating be handled
orthogonally in the merge_switch_to_result() function, dramatically
simplifies the code for various special rename cases.

To be fair, there is a _slight_ tweak to process_entry() here to make
sure that the two different paths aren't marked as clean but are left in
a conflicted state.  So process_renames() and process_entry() aren't
quite entirely orthogonal, but they are pretty close.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index da3715baa63..19477cfae60 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -676,6 +676,7 @@ static int process_renames(struct merge_options *opt,
 			const char *pathnames[3];
 			struct version_info merged;
 			struct conflict_info *base, *side1, *side2;
+			unsigned was_binary_blob = 0;
 
 			pathnames[0] = oldpath;
 			pathnames[1] = newpath;
@@ -706,7 +707,58 @@ static int process_renames(struct merge_options *opt,
 			}
 
 			/* This is a rename/rename(1to2) */
-			die("Not yet implemented");
+			clean_merge = handle_content_merge(opt,
+							   pair->one->path,
+							   &base->stages[0],
+							   &side1->stages[1],
+							   &side2->stages[2],
+							   pathnames,
+							   1 + 2 * opt->priv->call_depth,
+							   &merged);
+			if (!clean_merge &&
+			    merged.mode == side1->stages[1].mode &&
+			    oideq(&merged.oid, &side1->stages[1].oid))
+				was_binary_blob = 1;
+			memcpy(&side1->stages[1], &merged, sizeof(merged));
+			if (was_binary_blob) {
+				/*
+				 * Getting here means we were attempting to
+				 * merge a binary blob.
+				 *
+				 * Since we can't merge binaries,
+				 * handle_content_merge() just takes one
+				 * side.  But we don't want to copy the
+				 * contents of one side to both paths.  We
+				 * used the contents of side1 above for
+				 * side1->stages, let's use the contents of
+				 * side2 for side2->stages below.
+				 */
+				oidcpy(&merged.oid, &side2->stages[2].oid);
+				merged.mode = side2->stages[2].mode;
+			}
+			memcpy(&side2->stages[2], &merged, sizeof(merged));
+
+			side1->path_conflict = 1;
+			side2->path_conflict = 1;
+			/*
+			 * TODO: For renames we normally remove the path at the
+			 * old name.  It would thus seem consistent to do the
+			 * same for rename/rename(1to2) cases, but we haven't
+			 * done so traditionally and a number of the regression
+			 * tests now encode an expectation that the file is
+			 * left there at stage 1.  If we ever decide to change
+			 * this, add the following two lines here:
+			 *    base->merged.is_null = 1;
+			 *    base->merged.clean = 1;
+			 * and remove the setting of base->path_conflict to 1.
+			 */
+			base->path_conflict = 1;
+			path_msg(opt, oldpath, 0,
+				 _("CONFLICT (rename/rename): %s renamed to "
+				   "%s in %s and to %s in %s."),
+				 pathnames[0],
+				 pathnames[1], opt->branch1,
+				 pathnames[2], opt->branch2);
 
 			i++; /* We handled both renames, i.e. i+1 handled */
 			continue;
@@ -1291,13 +1343,13 @@ static void process_entry(struct merge_options *opt,
 		int side = (ci->filemask == 4) ? 2 : 1;
 		ci->merged.result.mode = ci->stages[side].mode;
 		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
-		ci->merged.clean = !ci->df_conflict;
+		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
 	} else if (ci->filemask == 1) {
 		/* Deleted on both sides */
 		ci->merged.is_null = 1;
 		ci->merged.result.mode = 0;
 		oidcpy(&ci->merged.result.oid, &null_oid);
-		ci->merged.clean = 1;
+		ci->merged.clean = !ci->path_conflict;
 	}
 
 	/*
-- 
gitgitgadget

