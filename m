Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A580BC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691A02067B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9yspRMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787077AbgJZRCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:41 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53223 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786821AbgJZRB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:58 -0400
Received: by mail-wm1-f44.google.com with SMTP id c194so12409208wme.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2mpRIinLJnrUhtC1xJIdwbTVBuUCv8xBw3tYAaTtAaQ=;
        b=n9yspRMq6WagL+ywwUHULIAzWQk/rwnel8ziWFJYv20+vn1C7LDuQBZ7yRWT6QTjPu
         /tpGjWNkTvy7asZjcCM2y9hrBJxDMN7dKINi+ErF2X+1hl6KLOt8zgKsEjq9FVC36yCT
         CKJldGhSBZggqo5MLa5Y5++GUFed8dTD5WyPjONoSTzQ256/8HYDL1udBcIXK+CZWtl9
         H083nVFP0l420sMzPlXQD7QU1IlPNAdPCA2j0rU3R2KrKnu3JiCIiEE7aGFqzNFg/vEc
         KBN4a642N4NqUEfcokQNsi1TaqOq5AuRKf+h1cFEXfN+A2RlN/jq9uEdw1OfUxU+QSvT
         K3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2mpRIinLJnrUhtC1xJIdwbTVBuUCv8xBw3tYAaTtAaQ=;
        b=i0O+FdmB2lv29YuoLdUyQBqgiAgbWOTx19IxbpY4Q2vZr4xvcUTQUmiO0p6pSZ0BXq
         NxSh1xTIVV5frDgSOrahID6H0RvVaIb+EL4Wari7TwvIOj7z7YNwHF9fkAp5NRCQxfKS
         szJdU/AyutX3sKFkFIkWx6RacCS3FEYp4BiSRuZjK/WPJJEvaG13a2b3y7Qrg8gnN9xd
         JNBnO74ZNMYkT2+SsEAu/MsvDIQQ4iuCIwLYhvbwJsG7L8pkBZ8TTyEdKDjkcjaFDqPX
         JrQaoFBWR57AdxnABitVoTnfVPwo2S10sBA2wFG/PtKQw7l+XXCcHW7nRRPQoR1fCl79
         m9dg==
X-Gm-Message-State: AOAM532VPBueiQiiobjDlSWduCu18Cc5AXHtyV/w/j+vgHBPOGHBMhhG
        yxW/M6DbWjzcfzK1izD3k344hWom2QI=
X-Google-Smtp-Source: ABdhPJyEKW8iP8GrOEvMvL3hFByGRC+3f8iWCJ8X/kv9n54y5VX685Vxq1W//+1WZw5u17lu1xE7qQ==
X-Received: by 2002:a1c:254:: with SMTP id 81mr12542467wmc.21.1603731714528;
        Mon, 26 Oct 2020 10:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm1898484wmj.41.2020.10.26.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:54 -0700 (PDT)
Message-Id: <6e308768ff925eb4858be3247976526b21c3a464.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:44 +0000
Subject: [PATCH v2 9/9] t6423: add more details about direct resolution of
 directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 39 +++++++++++++++++------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index db694a6316..4ab133f489 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4725,20 +4725,22 @@ test_expect_success '12e: Rename/merge subdir into the root, variant 2' '
 #              folder/subdir/newsubdir/e_Merge2
 #              folder/subdir/tweaked/{h,Makefile_SUB_Merge1,newfile.py}
 #              folder/unchanged/<LOTS OF FILES>
-#
-# Notes: This testcase happens to exercise lots of the
-#        optimization-specific codepaths in merge-ort, and also
-#        demonstrated a failing of the directory rename detection algorithm
-#        in merge-recursive; newfile.c should not get pushed into
-#        folder/subdir/newsubdir/, yet merge-recursive put it there because
-#        the rename of dir/subdir/{a,b,c,d} -> folder/subdir/{a,b,c,d}
-#        looks like
-#            dir/ -> folder/,
-#        whereas the rename of dir/subdir/e -> folder/subdir/newsubdir/e
-#        looks like
-#            dir/subdir/ -> folder/subdir/newsubdir/
-#        and if we note that newfile.c is found in dir/subdir/, we might
-#        overlook the dir/ -> folder/ rule that has more weight.
+# Things being checked here:
+#   1. dir/subdir/newfile.c does not get pushed into folder/subdir/newsubdir/.
+#      dir/subdir/{a,b,c,d} -> folder/subdir/{a,b,c,d} looks like
+#          dir/ -> folder/,
+#      whereas dir/subdir/e -> folder/subdir/newsubdir/e looks like
+#          dir/subdir/ -> folder/subdir/newsubdir/
+#      and if we note that newfile.c is found in dir/subdir/, we might overlook
+#      the dir/ -> folder/ rule that has more weight.  Older git versions did
+#      this.
+#   2. The code to do trivial directory resolves.  Note that
+#      dir/subdir/unchanged/ is unchanged and can be deleted, and files in the
+#      new folder/subdir/unchanged/ are not needed as a target to any renames.
+#      Thus, in the second collect_merge_info_callback() we can just resolve
+#      these two directories trivially without recursing.)
+#   3. Exercising the codepaths for caching renames and deletes from one cherry
+#      pick and re-applying them in the subsequent one.
 
 test_setup_12f () {
 	test_create_repo 12f &&
@@ -4803,7 +4805,7 @@ test_expect_merge_algorithm failure success '12f: Trivial directory resolve, cac
 		git checkout A^0 &&
 		git branch Bmod B &&
 
-		git -c merge.directoryRenames=true rebase A Bmod &&
+		GIT_TRACE2_PERF="$(pwd)/trace.output" git -c merge.directoryRenames=true rebase A Bmod &&
 
 		echo Checking the pick of B1... &&
 
@@ -4884,7 +4886,12 @@ test_expect_merge_algorithm failure success '12f: Trivial directory resolve, cac
 		test_seq  2 12 >e_Merge2 &&
 		git hash-object e_Merge2 >expect &&
 		git rev-parse Bmod:folder/subdir/newsubdir/e >actual &&
-		test_cmp expect actual
+		test_cmp expect actual &&
+
+		grep region_enter.*collect_merge_info trace.output >collect &&
+		test_line_count = 4 collect &&
+		grep region_enter.*process_entries$ trace.output >process &&
+		test_line_count = 2 process
 	)
 '
 
-- 
gitgitgadget
