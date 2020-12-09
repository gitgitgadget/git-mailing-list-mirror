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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB7C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC8822B51
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgLITnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbgLITm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F569C061282
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i9so3040150wrc.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=462xvpJKv8UgDJkU5159/TIxilz6ywPmSQkF4WNoaEU=;
        b=vazZ0RyJF2w3bCApIQOsQ6jBkEkyN80ABD2T/Z/OZ2ZLhhMcri4qzaKZQfyx4q49wz
         LpWykVqr5NNQzrK4tfGwZkjP/O7LiLYquiEC2EU7BGLcw0C5buDJALHaoD0fd/75T+SV
         Q/WRP9z/gxYx4D7W7mA0QXcxy8q93RsOgolmSA9raJMAQ4gmzyQ9TGpX0OtmGBTOi/x0
         7MVVx6f6fI1Xz5R7UdGh/49k4NfzlVAfQKCgo0Q9FstP36kQNeLVAExvVqeOA/B33IyH
         7DpBlmS1JbKNowTpsFhNArK1eixwb9u9Y97YJVy8e2ZFMprzH64LJFSRdiCdrSNnLwJs
         RfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=462xvpJKv8UgDJkU5159/TIxilz6ywPmSQkF4WNoaEU=;
        b=rv82IfpiwZZAyyr2FuFeDoVOrkWuChVaVeI3khlvydWbu9E3CljoTWEu70LLM3owJe
         fhHaWNlwVhkbaCe4nv2zvNo1/x91FlkciQPhBJBe+VhR1d93OTCKDvJtFYxGjkNX0p6V
         wME8VpOTvGTQMg6LFU0DsbbUPbDWsTGarO3+hsXS+64f/xvEt+MU3wyuwI+iWiM1iB7E
         FBIeRg4T0mrz5eubKC7G27wVOh3eep9GT4rPTwavlHCmfiSDug+NiAnmk7m/pHu9h/Rr
         MFysWEoGsuE0/etsZag4tR7WBaDXSbOmaT/AiQLo4BaM4iaHQ64Rq6wdoPtSLLxAbADC
         uRqA==
X-Gm-Message-State: AOAM532haizEa0OdET8d3CXnIbNpGkVQy6qylt7f6P8vLJXnmv7osnQh
        cqCx7AFY0J6xvSk3nmiKUI2cFOlK5sE=
X-Google-Smtp-Source: ABdhPJxOno4kPNz/zy1tzlQI2VVBO5dDFqHIJluLk7/Mh8XYk+665F+eQQf6h6p6aPmXhyFgZ33r/g==
X-Received: by 2002:a5d:6cad:: with SMTP id a13mr4310106wra.275.1607542897738;
        Wed, 09 Dec 2020 11:41:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm5210468wrr.85.2020.12.09.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:37 -0800 (PST)
Message-Id: <c069d34b15f8b28975898e089d64d166dd81b2aa.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:25 +0000
Subject: [PATCH 09/11] merge-ort: add implementation of rename/delete
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement rename/delete conflicts, i.e. one side renames a file and the
other deletes the file.  This code replaces the following from
merge-recurisve.c:

  * the code relevant to RENAME_DELETE in process_renames()
  * the RENAME_DELETE case of process_entry()
  * handle_rename_delete()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_change_delete()
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

To be fair, there is a _slight_ tweak to process_entry() here, because
rename/delete cases will also trigger the modify/delete codepath.
However, we only want a modify/delete message to be printed for a
rename/delete conflict if there is a content change in the renamed file
in addition to the rename.  So process_renames() and process_entry()
aren't quite fully orthogonal, but they are pretty close.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4ec6b0701f1..412a3b1da76 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -630,6 +630,7 @@ static int process_renames(struct merge_options *opt,
 		unsigned int old_sidemask;
 		int target_index, other_source_index;
 		int source_deleted, collision, type_changed;
+		const char *rename_branch = NULL, *delete_branch = NULL;
 
 		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
 		oldpath = old_ent->key;
@@ -752,6 +753,14 @@ static int process_renames(struct merge_options *opt,
 		if (type_changed && collision) {
 			/* special handling so later blocks can handle this */
 			die("Not yet implemented");
+		if (source_deleted) {
+			if (target_index == 1) {
+				rename_branch = opt->branch1;
+				delete_branch = opt->branch2;
+			} else {
+				rename_branch = opt->branch2;
+				delete_branch = opt->branch1;
+			}
 		}
 
 		assert(source_deleted || oldinfo->filemask & old_sidemask);
@@ -812,13 +821,26 @@ static int process_renames(struct merge_options *opt,
 				   "to %s in %s, but deleted in %s."),
 				 oldpath, newpath, rename_branch, delete_branch);
 		} else {
-			/* a few different cases... */
+			/*
+			 * a few different cases...start by copying the
+			 * existing stage(s) from oldinfo over the newinfo
+			 * and update the pathname(s).
+			 */
+			memcpy(&newinfo->stages[0], &oldinfo->stages[0],
+			       sizeof(newinfo->stages[0]));
+			newinfo->filemask |= (1 << 0);
+			newinfo->pathnames[0] = oldpath;
 			if (type_changed) {
 				/* rename vs. typechange */
 				die("Not yet implemented");
 			} else if (source_deleted) {
 				/* rename/delete */
-				die("Not yet implemented");
+				newinfo->path_conflict = 1;
+				path_msg(opt, newpath, 0,
+					 _("CONFLICT (rename/delete): %s renamed"
+					   " to %s in %s, but deleted in %s."),
+					 oldpath, newpath,
+					 rename_branch, delete_branch);
 			} else {
 				/* normal rename */
 				die("Not yet implemented");
@@ -1346,12 +1368,21 @@ static void process_entry(struct merge_options *opt,
 		modify_branch = (side == 1) ? opt->branch1 : opt->branch2;
 		delete_branch = (side == 1) ? opt->branch2 : opt->branch1;
 
-		path_msg(opt, path, 0,
-			 _("CONFLICT (modify/delete): %s deleted in %s "
-			   "and modified in %s.  Version %s of %s left "
-			   "in tree."),
-			 path, delete_branch, modify_branch,
-			 modify_branch, path);
+		if (ci->path_conflict &&
+		    oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
+			/*
+			 * This came from a rename/delete; no action to take,
+			 * but avoid printing "modify/delete" conflict notice
+			 * since the contents were not modified.
+			 */
+		} else {
+			path_msg(opt, path, 0,
+				 _("CONFLICT (modify/delete): %s deleted in %s "
+				   "and modified in %s.  Version %s of %s left "
+				   "in tree."),
+				 path, delete_branch, modify_branch,
+				 modify_branch, path);
+		}
 	} else if (ci->filemask == 2 || ci->filemask == 4) {
 		/* Added on one side */
 		int side = (ci->filemask == 4) ? 2 : 1;
-- 
gitgitgadget

