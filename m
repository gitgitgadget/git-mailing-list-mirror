Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBEFC49EA6
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A759E61C2F
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFZRHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFZRHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 13:07:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59764C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so14389734wrv.2
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oiM9fffUL0nbCGmSppFNqI0tAxYDhzVU8K5Oy6k25AE=;
        b=MhNYqF5jxxo5O/0uVuN10mPRavx2gVNpXVSsZArxbItedQokJZMXHsZ4kSyf4A6eEx
         VdPXeupGtVfVKvSO03BisLjHi5s2msXKCZSxr2jGNIQTmD2A7fAZZ/b7l8IEi7K7VTKl
         0Gh5q90bd/XQLUwyNSX0sUcyqCOohwPWB5PWY3VxNHPrksrHvvVLsyX/T/P68vo9RO/b
         6yakv2JSrodQUzKeDRo5YST1NUl8zJQsqMWoE9O3XkYXCEDH6VWL1g1GZ3xBafiAc4WE
         /6B/bD0pZJOAWTXTWmzpekQ/C+0b2RQcONzk3Ii4A+WrN5rnGorpONPY57KvIgM4mUej
         uEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oiM9fffUL0nbCGmSppFNqI0tAxYDhzVU8K5Oy6k25AE=;
        b=IG9pFbIVloGL2GtfT4HUJugL7H3eL9l3nNt4bXaj+AjbWwroLua5olOALNHQjamNZ6
         CeEOJusaElrCg8hZN3gLRrpjbJI1w2C9w7D1QOEZdosgICVWQCl6p/qKiwrU7b+QRqTK
         hdpqghEjkM+VyJ3hLZZgefg16FJAGykMTtq5QlpkmppvtFJgflvaUNiyv8SmVfiIUNVQ
         dr/gRMsglRS1UY9peAGOnPnX2sgYTCKyVnMaAIcoM7KVm6aMcvceb9b/SNSlj7ILrT55
         dbykktarX7ciwREBvTkUnAwyNRZINtQkfn6K0kB1R2WlGuxGRqC2ghLhA3dG7ClM/PMs
         9pbg==
X-Gm-Message-State: AOAM532lbHEc8UcWnJPZh8nwJBU6ejlti9ab2EyvgmJw61M66nw+bKS7
        8U7pJIdkIC+IAWgfm+0/F3BpGCH5v5w=
X-Google-Smtp-Source: ABdhPJz6HKYF6ElYWa+SvNWUm7ypB02p9/CPkwOs2wBg92osL1r/F5rGUp1jgGYz52lOnQ1hLbExAg==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr17754582wrj.48.1624727124979;
        Sat, 26 Jun 2021 10:05:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm8740551wrh.65.2021.06.26.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 10:05:24 -0700 (PDT)
Message-Id: <dea97c25e52c0c5dcba7698cdc2af742344fe36d.1624727122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Jun 2021 17:05:21 +0000
Subject: [PATCH 3/3] merge-recursive: handle rename-to-self case
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

Directory rename detection can cause transitive renames, e.g. if the two
different sides of history each do one half of:
    A/file -> B/file
    B/     -> C/
then directory rename detection transitively renames to give us
    A/file -> C/file

However, when C/ == A/, note that this gives us
    A/file -> A/file.

merge-recursive assumed that any rename D -> E would have D != E.  While
that is almost always true, the above is a special case where it is not.
So we cannot do things like delete the rename source, we cannot assume
that a file existing at path E implies a rename/add conflict and we have
to be careful about what stages end up in the output.

This change feels a bit hackish.  It took me surprisingly many hours to
find, and given merge-recursive's design causing it to attempt to
enumerate all combinations of edge and corner cases with special code
for each combination, I'm worried there are other similar fixes needed
elsewhere if we can just come up with the right special testcase.
Perhaps an audit would rule it out, but I have not the energy.
merge-recursive deserves to die, and since it is on its way out anyway,
fixing this particular bug narrowly will have to be good enough.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 19 +++++++++++++------
 t/t6423-merge-rename-directories.sh |  4 ++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d146bb116f7..c895145a8f5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2804,12 +2804,19 @@ static int process_renames(struct merge_options *opt,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
+			/*
+			 * Directory renames have a funny corner case...
+			 */
+			int renamed_to_self = !strcmp(ren1_src, ren1_dst);
+
 			/* BUG: We should only remove ren1_src in the base
 			 * stage and in other_stage (think of rename +
 			 * add-source case).
 			 */
-			remove_file(opt, 1, ren1_src,
-				    renamed_stage == 2 || !was_tracked(opt, ren1_src));
+			if (!renamed_to_self)
+				remove_file(opt, 1, ren1_src,
+					    renamed_stage == 2 ||
+					    !was_tracked(opt, ren1_src));
 
 			oidcpy(&src_other.oid,
 			       &ren1->src_entry->stages[other_stage].oid);
@@ -2823,6 +2830,9 @@ static int process_renames(struct merge_options *opt,
 			    ren1->dir_rename_original_type == 'A') {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
 							   opt, ren1, NULL);
+			} else if (renamed_to_self) {
+				setup_rename_conflict_info(RENAME_NORMAL,
+							   opt, ren1, NULL);
 			} else if (oideq(&src_other.oid, null_oid())) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   opt, ren1, NULL);
@@ -3180,7 +3190,6 @@ static int handle_rename_normal(struct merge_options *opt,
 	struct rename *ren = ci->ren1;
 	struct merge_file_info mfi;
 	int clean;
-	int side = (ren->branch == opt->branch1 ? 2 : 3);
 
 	/* Merge the content and write it out */
 	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
@@ -3190,9 +3199,7 @@ static int handle_rename_normal(struct merge_options *opt,
 	    opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
 	    ren->dir_rename_original_dest) {
 		if (update_stages(opt, path,
-				  NULL,
-				  side == 2 ? &mfi.blob : NULL,
-				  side == 2 ? NULL : &mfi.blob))
+				  &mfi.blob, &mfi.blob, &mfi.blob))
 			return -1;
 		clean = 0; /* not clean, but conflicted */
 	}
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 7480daab46a..d67b5c28944 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5058,7 +5058,7 @@ test_setup_12i () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12i: Directory rename causes rename-to-self' '
+test_expect_success '12i: Directory rename causes rename-to-self' '
 	test_setup_12i &&
 	(
 		cd 12i &&
@@ -5116,7 +5116,7 @@ test_setup_12j () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12j: Directory rename to root causes rename-to-self' '
+test_expect_success '12j: Directory rename to root causes rename-to-self' '
 	test_setup_12j &&
 	(
 		cd 12j &&
-- 
gitgitgadget
