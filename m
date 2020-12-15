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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A3EC2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668A622B47
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgLOSct (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbgLOS3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F1C0611CA
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m5so20823301wrx.9
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9dXUSfk4gXDbJgWZJ+YVJrGIa/oWkxkwmFfnDNWUNoI=;
        b=obA2UbWBb0kAy6qMpGHy4xFTh+SV9F+L+b0whgeP3+pNzAYEz/XT+Yedi+70DGmU6H
         pv1+42vgGpi4fRo3HioPaQmY/ayMNbrDrFs7eDBCZrl/XSIfD2x05krx0KpF0ScrOhCR
         lYj3vSR3LHBhEaxzOHXK7VNSm3iyy7+qQDl9wbPqXvMLcdFo1ye7qNpU1wMkwptmI7VI
         VLHk55hsFGis5+XADqRwbT0VTk6nW/6y77koijhjRyUPvr3X7eer0QcNvoRSUL5Xk4oq
         QcEGW0YWuV2VkpskdAOC9RM7MLH1Y3JnyBjzhkSBrNVVbqMhDc7QTPStGCGCd4RPRslc
         OChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9dXUSfk4gXDbJgWZJ+YVJrGIa/oWkxkwmFfnDNWUNoI=;
        b=oiwTnxRnlhhjznzv9okm5H3x7T3XydTBDznPPONTGvbIh5Afoc1ZuMSkKg0AsVKkOi
         t2U6eKwBuagsEGMZsIOEChREl3qa5MMdGaVC21Q5Vr/BbHsB4l5HeptHRx5KStb89xzu
         OPnZg37scmylYPpLrRB8XuxrXSXH9zflp2g7lAYABP7e8r9y5yt1Bb+Z1NAjEfTxX81K
         otnEzi5YGk08Bw5y4re9FrAC/rc69uzsPdxGUFr62LI9qNRD8chmvyjzCc9Fdbr1LS6A
         R2w9VOvT1a5XoQLYYPE1oh7g2WS7XwqNCefixaqnPGH+XgSypTnUaFPT6y86duGfd2k7
         LoMQ==
X-Gm-Message-State: AOAM533AaPhsUHE2DH6FdVWP+n67v2B+lwokOhl8UA/UMBXwz/OiFMj8
        cusJbZlqjxfbwsmKzKMuMPJ/8SL0Kr4=
X-Google-Smtp-Source: ABdhPJw7tQG2PQC4mezMUbDnFw2HZWVjrsBTjyn548Ni2ghYRaaoYw4PqbJ2czwxUitIKD1blQdCfw==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr33786397wrr.61.1608056895389;
        Tue, 15 Dec 2020 10:28:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10sm38218819wrp.39.2020.12.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:14 -0800 (PST)
Message-Id: <6b79da5e8a40e768b91d0742aff2919a0095a3f9.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:28:03 +0000
Subject: [PATCH v3 08/11] merge-ort: add implementation of rename/delete
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
 merge-ort.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 19477cfae60..a10c3f5046f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -657,6 +657,7 @@ static int process_renames(struct merge_options *opt,
 		unsigned int old_sidemask;
 		int target_index, other_source_index;
 		int source_deleted, collision, type_changed;
+		const char *rename_branch = NULL, *delete_branch = NULL;
 
 		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
 		oldpath = old_ent->key;
@@ -779,6 +780,15 @@ static int process_renames(struct merge_options *opt,
 			/* special handling so later blocks can handle this */
 			die("Not yet implemented");
 		}
+		if (source_deleted) {
+			if (target_index == 1) {
+				rename_branch = opt->branch1;
+				delete_branch = opt->branch2;
+			} else {
+				rename_branch = opt->branch2;
+				delete_branch = opt->branch1;
+			}
+		}
 
 		assert(source_deleted || oldinfo->filemask & old_sidemask);
 
@@ -790,13 +800,26 @@ static int process_renames(struct merge_options *opt,
 			/* rename/add/delete or rename/rename(2to1)/delete */
 			die("Not yet implemented");
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
@@ -1332,12 +1355,21 @@ static void process_entry(struct merge_options *opt,
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

