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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E88C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB0F23B45
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbgLITvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgLITm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC85C06138C
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t16so3037891wra.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0VyEQXT13srAIfFtThM3gDHUbX8RH79WPD4e3lC2j0Q=;
        b=A5Nx3MW3nX1nzKNHUY+8t8CEQwW2P2/VFJF/pwXqVPznsMY8dDrWYgDJHfe02y2EZa
         Y72uqhfgk4Um3bg0vaJ30xd4XAiPBSAPPtVeEWBFhhha7yskbRedUlo/sD1B99lfHoXp
         Ht8oPrC/ja/6obOXT8zz5agNO3jcGUCN38f2kbC9lKDiFBeA8HZoKFlHMINa03E0rMfw
         e1CUARC6vLHrqKEcfyETSVasyKWujdednziLJdOaKwxuX6D/iBCXhGmhayZ1UgfawR1f
         6am+uv+Pp8Lkd4Tid+yiCcRu9LNPwWCJJK3+zksJs7uElTSOEYryBGRCeHJyPYzv1YbS
         2i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0VyEQXT13srAIfFtThM3gDHUbX8RH79WPD4e3lC2j0Q=;
        b=n+T9pIj5On+IEYOenSoGmw9WaPcrdY/hIYEebmi0TVavW6IfXfUIYbSTJ1V95PBi93
         d4wOwDle1f65GJ8F0hmDz3Vfl/xPW5RRhCR8OgVZHficwjhNJ4LMdKIaRS5IEuld0Ldt
         5PDluHebsuwz19xsplSi1+cJc1UP/gGoJAzJQ2Im0kwJdnFnUzmQpXsXMb42T/gfEgaN
         JHAMjVU70avlkHv5BNJpUCye8d4m9tgxsEYpHuNTR67JlKX0MydCIT4wey9S9DO12Pm8
         9iRkzVXqisqnYH0EOcV9aCASUwHkEwBMwhQ5OaC/kNtONWyxL0Ucfp2fFWJQBZEGdSaD
         uCeg==
X-Gm-Message-State: AOAM5306EBk066qgwk7JmFRmz3mRVraKRLdX0/htWQm1nYfCySdgFMaX
        bVWTOFDuNlmfqL/zXSNoMcpka1mWUsw=
X-Google-Smtp-Source: ABdhPJwLtJmmA/35QzpkzgS7yGMoK+JZJtp6SsP901uE8l4qZ+y3DB3VHGUVI3PndiTOwHX5KB5oqg==
X-Received: by 2002:adf:eeca:: with SMTP id a10mr4368707wrp.186.1607542896816;
        Wed, 09 Dec 2020 11:41:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm5067854wmd.43.2020.12.09.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:36 -0800 (PST)
Message-Id: <ab15f85f6988ffe55e84b7aa3d804fcee4189805.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:24 +0000
Subject: [PATCH 08/11] merge-ort: add implementation of rename collisions
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

Implement rename/rename(2to1) and rename/add handling, i.e. a file is
renamed into a location where another file is added (with that other
file either being a plain add or itself coming from a rename).  Note
that rename collisions can also have a special case stacked on top: the
file being renamed on one side of history is deleted on the other
(yielding either a rename/add/delete conflict or perhaps a
rename/rename(2to1)/delete[/delete]) conflict.

One thing to note here is that when there is a double rename, the code
in question only handles one of them at a time; a later iteration
through the loop will handle the other.  After they've both been
handled, process_entry()'s normal add/add code can handle the collision.

This code replaces the following from merge-recurisve.c:

  * all the 2to1 code in process_renames()
  * the RENAME_TWO_FILES_TO_ONE case of process_entry()
  * handle_rename_rename_2to1()
  * handle_rename_add()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_file_collision()
  * setup_rename_conflict_info()

The consolidation of six separate codepaths into one is made possible
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 75e638a23eb..4ec6b0701f1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -759,10 +759,58 @@ static int process_renames(struct merge_options *opt,
 		/* Need to check for special types of rename conflicts... */
 		if (collision && !source_deleted) {
 			/* collision: rename/add or rename/rename(2to1) */
-			die("Not yet implemented");
+			const char *pathnames[3];
+			struct version_info merged;
+
+			struct conflict_info *base, *side1, *side2;
+			unsigned clean;
+
+			pathnames[0] = oldpath;
+			pathnames[other_source_index] = oldpath;
+			pathnames[target_index] = newpath;
+
+			base = strmap_get(&opt->priv->paths, pathnames[0]);
+			side1 = strmap_get(&opt->priv->paths, pathnames[1]);
+			side2 = strmap_get(&opt->priv->paths, pathnames[2]);
+
+			VERIFY_CI(base);
+			VERIFY_CI(side1);
+			VERIFY_CI(side2);
+
+			clean = handle_content_merge(opt, pair->one->path,
+						     &base->stages[0],
+						     &side1->stages[1],
+						     &side2->stages[2],
+						     pathnames,
+						     1 + 2*opt->priv->call_depth,
+						     &merged);
+
+			memcpy(&newinfo->stages[target_index], &merged,
+			       sizeof(merged));
+			if (!clean) {
+				path_msg(opt, newpath, 0,
+					 _("CONFLICT (rename involved in "
+					   "collision): rename of %s -> %s has "
+					   "content conflicts AND collides "
+					   "with another path; this may result "
+					   "in nested conflict markers."),
+					 oldpath, newpath);
+			}
 		} else if (collision && source_deleted) {
-			/* rename/add/delete or rename/rename(2to1)/delete */
-			die("Not yet implemented");
+			/*
+			 * rename/add/delete or rename/rename(2to1)/delete:
+			 * since oldpath was deleted on the side that didn't
+			 * do the rename, there's not much of a content merge
+			 * we can do for the rename.  oldinfo->merged.is_null
+			 * was already set, so we just leave things as-is so
+			 * they look like an add/add conflict.
+			 */
+
+			newinfo->path_conflict = 1;
+			path_msg(opt, newpath, 0,
+				 _("CONFLICT (rename/delete): %s renamed "
+				   "to %s in %s, but deleted in %s."),
+				 oldpath, newpath, rename_branch, delete_branch);
 		} else {
 			/* a few different cases... */
 			if (type_changed) {
-- 
gitgitgadget

