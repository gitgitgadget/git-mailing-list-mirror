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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F3C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989A7225AC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440030AbgLNQZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440258AbgLNQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7DCC061248
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so4048163wmz.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=grralITenGTZVsTOMW4aRwob8S5Jq4wbK6k0GPuEJpc=;
        b=QR+P9/AGj+VWg9iMs0xC4gMAU9RGa+gorb2XHxhwzVyLII9RemVfhig3ui9txNe34s
         Kek7Jw4GS8PlRtXLoslflNARKiTPFu/YQrWuMRSl0LI+N0u6VftMuXDA++tSGIdlUTzt
         HAhnsUOPalJEqYC64t8jSiWv4u7XpE4DyuKh1erphqWJNkSt1/YsaQZUt/glXpanlRul
         ElPD1GpV6VfSifPmhMOQmYdVK8vf1o11n3IQ6CrrbjskNnjUhkvHvQncNIXBxgjufmMe
         0K7kLj4Y30nTfG94wW+Z5jJdkHVU1D9ANR5Hlh+oJVWNm4qkeBxztkKD/ZrwnWzejVwK
         PFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=grralITenGTZVsTOMW4aRwob8S5Jq4wbK6k0GPuEJpc=;
        b=kaoaujvxxJy4NB803piuHH8yIODQ9f+KL4GFWv3ocVOoyDaOisz/7xd1lgsusdP8V5
         bRxhWCEe0feXYEPQXx0WZ6olmwTp6I5hKa/KqRYnfBFaV1Ds2PQc3aHdxrxKH76qINs3
         OrTzmIivZ59mnoUgEd+T0XMSve15djsPOdw9VNiqsjDn+9tHUx6Ih8A6s9Wi1L9QoceH
         S8t00gvDiRhQpOwBvPVkbsiF5rnQQcOx+C+lc28G9SYTpI1qsa6e2Q7BCIz+Xict4LO5
         YagTCF71nbH+h2s5hSMUGnSTIdHL49eqKqodoZXTwu74pgxoDJFj8X1svH4IqFEI8Iuh
         ZIdw==
X-Gm-Message-State: AOAM532vJrn2D9RxvEXZOnG7MKPm3K3TfbeAzTFvLR0mzbjqJv9L5C76
        Jl5N0B+TJ+g+zZ5/QGZC7/kgju1zT4E=
X-Google-Smtp-Source: ABdhPJw402uArOhk+2e0cHwtOIRPrJXkiVietwiMJlKIVUGkXswxLMUFMZ/9JjCmVClBXhAevrJYoA==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr28628303wmi.90.1607962910905;
        Mon, 14 Dec 2020 08:21:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm31368897wmb.40.2020.12.14.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:50 -0800 (PST)
Message-Id: <f017534243c967caa0137e6899f4e1c69ff02c2e.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:38 +0000
Subject: [PATCH v2 09/11] merge-ort: add implementation of rename/delete
 conflicts
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
index 04a16837849..4150ccc35e1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -657,6 +657,7 @@ static int process_renames(struct merge_options *opt,
 		unsigned int old_sidemask;
 		int target_index, other_source_index;
 		int source_deleted, collision, type_changed;
+		const char *rename_branch = NULL, *delete_branch = NULL;
 
 		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
 		oldpath = old_ent->key;
@@ -778,6 +779,14 @@ static int process_renames(struct merge_options *opt,
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
@@ -838,13 +847,26 @@ static int process_renames(struct merge_options *opt,
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
+			newinfo->filemask |= (1 << MERGE_BASE);
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
@@ -1380,12 +1402,21 @@ static void process_entry(struct merge_options *opt,
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

