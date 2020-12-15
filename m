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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D9C2BBCF
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E05122B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgLOS3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgLOS3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE06C0611CB
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a3so137719wmb.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Hl5t6ldWvNNCki4XoGnclhpcPrhke0r9Tp4YSPkKKE=;
        b=c0RP6SyQ5zg2BtOTlqbqXRNT27Fy/p+szQx2W32MCEjsdIJDfVB2zHgU+jXsmOD0Pc
         GljzsbZwVmkOpZZ3Ch8yF4fgOGX+4y0gZp5pVm+gNtYO8UeWgIUHq/+35IRdweNiyhPu
         C3feRvCl2WmNLWA1HBqaTp1QFvDXKyzI/qhhzwCsRrlkDPalWvpKcGiJATYk9uEBLp/3
         EhI8hYzdFq1KhajBxxET2faxum9KR22Aiuj+KZztXmTQxm2Y1qH8e7jM1MQ4NzijRXrd
         goUuAlEUUhZbnfg1MuMYtBeR8aVEkkjaZnMIqnJf66NLX71YwEGPqHTIZwxpK3skTX9C
         gBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Hl5t6ldWvNNCki4XoGnclhpcPrhke0r9Tp4YSPkKKE=;
        b=Lfyj90+dKYOA8NJlpB/d92cGNPDJE3faQAJr3YS2aT6a656m/AaQ5DHLMeMfgpTcmd
         ZwbIGxOqV1JzciCy+3rC7+tNcLtKxdr9+Dw7xkzzonh7Lhr/YtKnkLzUjUlmZNKHw7cm
         7lH4mjcdeinXtaBEp1lAoY3DjUdfnZ7UyqH0EJD3JLeV16/rJ0j9oX4SP8h2tB+nH2rK
         vdstSA7r0WAyS5anvm7qPiWuDjqJojByvCT6T7aFDqm9UYpIQNQmseZ+vaAhEJW7Estx
         UAqEAcajt7cFG80w6a/2SkFJkSo9bit/NXklqKYXRjlXXY7gJOCQdMIw0ETMGlqxrnlr
         S8rQ==
X-Gm-Message-State: AOAM533TxCnSQ61HYen3uXnzOQaR+widlMjrIXpiOLDfYyiRajqUeA8Y
        cTL0xzc+VJRP1Ar32tp6Si3uE+dhPL0=
X-Google-Smtp-Source: ABdhPJxUgdBfDht3MF+yOA3iJIe8du6HagVSY4bMh0NeBagCpXALjFNv0vGURO5s1A9pm6fmzNIc/w==
X-Received: by 2002:a1c:bb07:: with SMTP id l7mr182736wmf.9.1608056896279;
        Tue, 15 Dec 2020 10:28:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm38747651wmg.2.2020.12.15.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:15 -0800 (PST)
Message-Id: <065fc0396dcb0dac080fd921209f77b824eee633.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:28:04 +0000
Subject: [PATCH v3 09/11] merge-ort: add implementation of rename collisions
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
index a10c3f5046f..1c5b2f7e3b9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -795,10 +795,58 @@ static int process_renames(struct merge_options *opt,
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
+						     1 + 2 * opt->priv->call_depth,
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
 			/*
 			 * a few different cases...start by copying the
-- 
gitgitgadget

