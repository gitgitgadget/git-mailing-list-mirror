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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9E4C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C09D227C3
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440278AbgLNQX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440259AbgLNQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD4EC061285
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v14so14284296wml.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AnzqRRRy1g2L+onWadSEE6xu1o46r+kbeVuvHKawzo4=;
        b=p6Q6Y3QUUcp5sAdkT56lhNAkQypkpze0BZnFl/fQHYgV0WIPBeTVsM+wvadOr4amO/
         HRprUyUqzpvwq3u9qvgSxOx4kxKj4DX1yLpehBSpX7vDWpkt16CuoDVmQX5YBDpcSdFe
         JIaMVSM6wmgogTqFZLUvjRwyJkX4rFhhA2w9o/ybmomxFf1sElWeUQmOVF1KlsLgGJM2
         cJGm5MfEEWjwdlEg6R3JYnuLaNgim41PbrmorMWMrvbodTNqDWYr34XjgWuMdEkPVWop
         v6499Y6h6hataRPYZ6huhdxs2AcXoEM85zmMLtWZq5IlFH+qLovOWMM/j44uqDZFq8dy
         B8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AnzqRRRy1g2L+onWadSEE6xu1o46r+kbeVuvHKawzo4=;
        b=JYmVw4IuGx9fD7P1Z5vNLeawoSHrzDbLDPXgRsT1c3BNilG8tnuYtcTd4o1nFQKrsm
         k+z28nL2adMqju1MJ2qUWuy+0V3Qb2XFFcikd7Zz4qNjjFd4n3hVl+acP96JHxOf89T1
         /TJMqc7rrnWDnD2dOQwz5Q1G8kVhquPLj01tafy0LnqiEZ87rmcH+XildcL+d2QUhg/W
         9v2aEmQUnv13eI0k05CMT4BMjhJXvWovAzg8F1PRYvRmqYRqUsPip0SDKK1Clmcdb0YL
         7YvbcmeUbYsWFkp424YGvsUG3xqr/ZBAmzhPiVXUu0xRdPYU74mp7OksPfoQyWkg48Bb
         9eBA==
X-Gm-Message-State: AOAM533bETA3oBKDm+z7/ZLzkX/k0/htVM2zFueBC98Ya3N/eiLakPM8
        5GbFJLLwOlJ4p9+GPFjIX9UmcNSEgoo=
X-Google-Smtp-Source: ABdhPJw8/j9TlwrbcSkCgJ9sWIvNYD5HcC71viPtviWx8nVu/Q9MXZ7fuOPMlieAqRuYROvjHxK/jQ==
X-Received: by 2002:a1c:2783:: with SMTP id n125mr24518213wmn.74.1607962909900;
        Mon, 14 Dec 2020 08:21:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q143sm32579274wme.28.2020.12.14.08.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:49 -0800 (PST)
Message-Id: <edd610321a053b431def5b06bb2983c7f4a84547.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:37 +0000
Subject: [PATCH v2 08/11] merge-ort: add implementation of rename collisions
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
index 19477cfae60..04a16837849 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -785,10 +785,58 @@ static int process_renames(struct merge_options *opt,
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

