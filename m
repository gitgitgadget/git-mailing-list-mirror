Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0060C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ADD6146E
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhF3Rci (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhF3Rce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:32:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73248C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso2219010wmj.0
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kp55Syi8wt9xGzMqLjkASrKSnJTvUnh5ifMJ9TPXpHs=;
        b=oAMc5k4Otv4lgTOIxZdzmB0MPWWUv3PWpF+4gxrRxtB2IYvlgjKFl1vqrMYLp5m2bd
         eKwX6XWmDOhYXTm0Uwd/ghMdVKDk389qdi8PNfZEXALSHbHxiA41Oq/s2YPnBo8jqPWw
         uKv+w5s9PAY26ZZKuDaOLU+L6NY0Uy3/YXN7KJ0e1tuWoK0Y2RaBVpABScUdk/woiIVQ
         ofNH/nfsZZOWN7DduP0OpN1pmC6kkyln74QDBmrtYTW8/mCCvZH57fDuYy7D6Dz2nao9
         ZOFZM92DIp/kSzSRpGHsBdl7cC0seeJ0EZLLF/x8StyIMWaODqEjHE32rfJ+K2w0Wc1y
         6j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kp55Syi8wt9xGzMqLjkASrKSnJTvUnh5ifMJ9TPXpHs=;
        b=aaatC9O6oW/DlYH5EHPPlNmbeQLVIeVYwe5fEX7Qh5mx/9U2s/lRo11Vcmo/4RniGs
         hMFSbI6Br//a+E7Jp6EGaxkvhYP3rbCxVacqfZkIahq4j4JFj9ogTxC5LrngHYX16PIg
         pOtgm+lVh0dhF6qC8rHEQ0LVVycQdHh8SmymmjLSG6+0+AXK9dEFTusmpO/a5t8W4hUM
         wbgPSi4xg6neNLce5LPJq25o7Q8tcDc1Ac47EquS8zPR9uKIV4a86lS5QxN9NQkiO/6J
         oYlWr5sDmoRnirrv59BoOHIQD67bpVXZnHpPVdb6huksXqj2YMhnHLtb0+H8fc4wf/++
         X0kg==
X-Gm-Message-State: AOAM533jeVQhfe8LRMyZeLkhfLdyDV+AQBfD0efEDp7zLivdQ1GhbLcc
        i57hB33c8aIqlX2sQVaQ6Zn/d8PkDY0=
X-Google-Smtp-Source: ABdhPJxqu6hwelJjwDvdFBVufdtv+0q48L1cZ8QzcaiZNthWH2F0q+2g9GBJ24sd1NKbSGa5jYfu4g==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr38967043wmh.63.1625074203994;
        Wed, 30 Jun 2021 10:30:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm6506437wmq.37.2021.06.30.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:30:03 -0700 (PDT)
Message-Id: <7c96d6c7a0a4fd25794856e556e071f048771fd1.1625074200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
        <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Jun 2021 17:30:00 +0000
Subject: [PATCH v2 3/3] merge-recursive: handle rename-to-self case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
 t/t6423-merge-rename-directories.sh |  6 +++---
 2 files changed, 16 insertions(+), 9 deletions(-)

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
index c3968dc3642..01d27b66399 100755
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
@@ -5174,7 +5174,7 @@ test_setup_12k () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12k: Directory rename with sibling causes rename-to-self' '
+test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 	test_setup_12k &&
 	(
 		cd 12k &&
-- 
gitgitgadget
