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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBB8C2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6E422A99
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440093AbgLNQZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgLNQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:11 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B2C061282
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:50 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so15797238wmb.5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3wvkdW5XE1G4uCvT4fhJgWOMCaldDUb3UyHgtne7vvg=;
        b=UXFeTWcPBK8C//Y5CBimTV79+qphhQY4S26vDvH10pOI9S/RVenz3/IyfQcBM3bfhO
         Mu/IYLjrwR11qgHLmD1gfXjfMyyIMKTZJrUwZrR67P9DBPD1kSfBt3NAI9dj6fJwxG5F
         +pjPMb0Fw1P+13agtesc69X++Si9fJtEvnli74UhWTewrU6s9Bl5jJPlPbRnLuAINCHK
         8sxVBAXMEpDJpPONgLSRUKm5DkEBt3+1a9qzznmouD+hfWXKGaC6mOzcAFaao2HzcOPy
         5Ji+lLFEny5qEhtCwSOcIEkmVnBH90Yg7aBSlWpeWUQSBGUH3mfLnZZGwRIg5KcLf+o4
         fa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3wvkdW5XE1G4uCvT4fhJgWOMCaldDUb3UyHgtne7vvg=;
        b=BNQMXjPYwRyW5x6pvVxzwcYZJSw74od8MbZmzkVTyVUy8XFaxOlEJ2nmyQJZiTVpcp
         pQXWTzxiEHFTCcAsQ3X2GldXKbkBZxDcpN71dvczgrsiO0UwBWJ4IPRQRusAnM8AmcB1
         IlAadrAbhjcq9Lt4Xy+dk3/v0nyj903a/3OQwFSTV0HiqULqnde4gmcf5ADmafKu3Y6s
         uA73ZxacNRHlhEFUqZNinuaV3E2HB3AlUoVtgc6sAx32Uw7CVYp4W8bXyoOJ94xSM0Je
         IvZoUdiYVqvWW7VVXm6rxw5O493klzg88PGmEQorp+zO7X4AawcZ5OwjpuX6xsJCY12Y
         NbxA==
X-Gm-Message-State: AOAM531OK7z9JRY6VfBBixgiZrJmIj6ouPVvrBJAIgD14DOcEMqvptUS
        IKvLXbmTxlqRwww+gdASLFOy7eYh0jE=
X-Google-Smtp-Source: ABdhPJyZ38AlbB42SG2+/WUdK0ZsfVsX114z9Vj2D4QOtgmjjmlKBjVmPkMAOBxqaZwsPfjj52KpcA==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192mr28159109wmc.126.1607962908896;
        Mon, 14 Dec 2020 08:21:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm9402438wmi.15.2020.12.14.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:48 -0800 (PST)
Message-Id: <d00e26be784d7915b2d476b0c86f37aa366a4274.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:36 +0000
Subject: [PATCH v2 07/11] merge-ort: add implementation of both sides renaming
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
 merge-ort.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4034ffcf501..19477cfae60 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -707,7 +707,58 @@ static int process_renames(struct merge_options *opt,
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
@@ -1292,13 +1343,13 @@ static void process_entry(struct merge_options *opt,
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

