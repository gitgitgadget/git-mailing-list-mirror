Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A2C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F6A21D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqRRvnYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbgJWQBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460371AbgJWQBk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D1C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w23so973780wmi.4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3IuLa9F3kKubcVyPwscUTm7O5LitS+oeoDzry0DsLaw=;
        b=WqRRvnYnYD4iHu9INrPWEKKDAtE6EvKNRjJK77lNCTHi3OmbBTQNbym/dz5pTbw236
         XPDpc8lG0Rd+nW5Y9tlp+C+BE9gg8W6x2ILj69Mda/zRSiv7LED1j0iNDVDzCkiXhFXS
         fdFUacEK6LlgYJYbVVwDA8Kr/+os/vl6nnlaSscq9hru6xngFKijIx0JWBh6g8xIwJbC
         UmFiCzOSvkxFxcxv1CjCvPbNFQdSqUmLYIMytfSjDR5I7IaKN8QZEcPLV9MWN/lAob4j
         MPSPg6z/PMMEWW6uz/UuWBW7Lyp+PzYPhHnjHzZW7cNrkQfFo+5hfSRRYTitK55kYF6+
         Vz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3IuLa9F3kKubcVyPwscUTm7O5LitS+oeoDzry0DsLaw=;
        b=Y/1mAF8ZhOurDU2+SzuU2sgDaqQGRELglp9aToxc4EjT5OFx/65UgFIPLjc01t2kc3
         66VDM+vcbrsxlO1+1a1KtPVrJb4hcF62m5IFEPhuM0dudYm3wFfrWGNzsMmKZUrXu2Oo
         bDxXbA1NrsvYq77BYH9u1aWFm9KzxN+9fYYkcJviIy1yv2/E6tR8GLolf2qOGMzyQGUO
         mOW16PalhpI98SPy7JHj5qOW/lQ7qAGQB8dGzGwrZ+QXl61Fl16HxKzMqDvc98dSugS3
         7NlUCLb2sQgGl5jk5BHPRLelANaeNUXXh/Xs/mDa2ZtjxfZTnTzoO0MGdQ08LhM6PUQ/
         XUxA==
X-Gm-Message-State: AOAM532dTxHdMWxwuKFBByJL91wA2Og8Os7X2gLBZQtMjn7mfFsrOXTw
        7yt6o5N+XvnAVDFEmp0rvQL1tjfPP5M=
X-Google-Smtp-Source: ABdhPJwa8b/NJSoMa3oOzwPaS6+LhIHDGLYAWEZcLTEryJhSolooJrn5/x3h3DxL7/4LS2EdRZLshA==
X-Received: by 2002:a1c:5f84:: with SMTP id t126mr2987171wmb.89.1603468899179;
        Fri, 23 Oct 2020 09:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i33sm4209815wri.79.2020.10.23.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:38 -0700 (PDT)
Message-Id: <2659d1cb987735ec123ca7a82ed7e058e4d6bef0.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:24 +0000
Subject: [PATCH 9/9] t6423: add more details about direct resolution of
 directories
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 37 ++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index db694a6316..9e51320ee0 100755
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
 
@@ -4884,7 +4886,10 @@ test_expect_merge_algorithm failure success '12f: Trivial directory resolve, cac
 		test_seq  2 12 >e_Merge2 &&
 		git hash-object e_Merge2 >expect &&
 		git rev-parse Bmod:folder/subdir/newsubdir/e >actual &&
-		test_cmp expect actual
+		test_cmp expect actual &&
+
+		grep region_enter.*collect_merge_info trace.output >collect &&
+		test_line_count = 4 collect
 	)
 '
 
-- 
gitgitgadget
