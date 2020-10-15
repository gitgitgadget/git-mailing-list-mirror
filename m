Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1469AC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1242074A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKSAl+iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbgJOUqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392379AbgJOUqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:46:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C4C0613D3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x7so173867wrl.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M7ceWqKic2FObuWRJ0qkU2DCdGI6N/XJS2iWnsK8W9c=;
        b=JKSAl+iLFjSElbCXMWdd4AEptRwFdSP6XH8QFr+Xs5dwdaI5+iMFtdWrD88F4FclLP
         huTzlmXnMOFo3L13NSl3OQiTmE4EGGv05hu+9X1BUbyU2e89qvtDKy+4bFYjit4fSAcw
         Cho79NA671dJtMbOAnwM5SC/HAr8dmKY2rpwldgxsx7bfX5eZstT+l/bMfPZehirM9E/
         0Rhng+BM+vdI+n0V95+k+NMjmqeDw9pFIN4o5OUTjKVK2n2S4hiooX0XsOirJ89czrMW
         7rWc+YIqZm3lcOiiZT0SYddttp6tlA+riqkNI5T8mFRywRq5lsM4jS6tkt2qZ70XldgV
         wPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M7ceWqKic2FObuWRJ0qkU2DCdGI6N/XJS2iWnsK8W9c=;
        b=j2bU4ubkT30HmCMYzSlFn4r1L/e6T+p7RAKMvmsJFeEGb3dramdBvnY1gvqc+WLMNk
         0TG+j6KUqEtPlSOKheqQawSGhMf3iyLi140XsAgWE03eTVrfKe68EOF19Zt5bIo9F7Le
         uEIZaDBelEEfNdm+M/rUM4/+NGcMEVM9bljwn+k5IRgOKW7PKibyhRZLRxS1xhhmjz0W
         d8IWtWeZiOmbOifY/yPcMydyORUmwPcW69b5QI1XCAmAE6irBZvHtpN3iq2aTMVgLtSd
         FUOhskMQbCqnd794EcsV2AbDvNh6IMEpTc/DOlOaW4qr8JbZY7gOKCasTk3Qx220uS84
         W7gw==
X-Gm-Message-State: AOAM531l9n5gvp7i8ssQ128Virx7mOO/UP2OPvtTpgu9sU8+3aFVPeTQ
        orSdkyIlizeHuzP+PGY6Z8lNDyjbiXE=
X-Google-Smtp-Source: ABdhPJxbJRFK9JMku/KnIRDkMql1xRCUJNwNXcKvVktSWtWvKoyl/9rzT8wIMwdYPTU5YAEOUb1vFw==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr161814wrp.24.1602794793966;
        Thu, 15 Oct 2020 13:46:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm674071wrs.26.2020.10.15.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:46:33 -0700 (PDT)
Message-Id: <c9637d70caed8a265096fa701833eca3ed52d0f3.1602794791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
References: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 20:46:28 +0000
Subject: [PATCH 2/4] t6423: more involved directory rename test
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

Add a new testcase modelled on a real world repository example that
served multiple purposes:
  * it uncovered a bug in the current directory rename detection
    implementation.
  * it is a good test of needing to do directory rename detection for
    a series of commits instead of just one (and uses rebase instead
    of just merge like all the other tests in this testfile).
  * it is an excellent stress test for some of the optimizations in
    my new merge-ort engine

I can expand on the final item later when I have submitted more of
merge-ort, but the bug is the main immediate concern.  It arises as
follows:

  * dir/subdir/ has several files
  * almost all files in dir/subdir/ are renamed to folder/subdir/
  * one of the files in dir/subdir/ is renamed to folder/subdir/newsubdir/
  * If the other side of history (that doesn't do the renames) adds a
    new file to dir/subdir/, where should it be placed after the merge?

The most obvious two choices are: (1) leave the new file in dir/subdir/,
don't make it follow the rename, and (2) move the new file to
folder/subdir/, following the rename of most the files.  However,
there's a possible third choice here: (3) move the new file to
folder/subdir/newsubdir/.  The choice reinforce the fact that
merge.directoryRenames=conflict is a good default, but when the merge
machinery needs to stick it somewhere and notify the user of the
possibility that they might want to place it elsewhere.  Surprisingly,
the current code would always choose (3), while the real world
repository was clearly expecting (2) -- move the file along with where
the herd of files was going, not with the special exception.

The problem here is that for the majority of the file renames,
   dir/subdir/ -> folder/subdir/
is actually represented as
   dir/ -> folder/
This directory rename would have a big weight associated with it since
most the files followed that rename.  However, we always consult the
most immediate directory first, and there is only one rename rule for
it:
   dir/subdir/ -> folder/subdir/newsubdir/
Since this rule is the only one for mapping from dir/subdir/, it
automatically wins and that directory rename was followed instead of the
desired dir/subdir/ -> folder/subdir/.

Unfortunately, the fix is a bit involved so for now just add the
testcase documenting the issue.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 195 ++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index f7ecbb886d..31aea47522 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4227,6 +4227,201 @@ test_expect_success '12e: Rename/merge subdir into the root, variant 2' '
 	)
 '
 
+# Testcase 12f, Rebase of patches with big directory rename
+#   Commit O:
+#              dir/subdir/{a,b,c,d,e_O,Makefile_TOP_O}
+#              dir/subdir/tweaked/{f,g,h,Makefile_SUB_O}
+#              dir/unchanged/<LOTS OF FILES>
+#   Commit A:
+#     (Remove f & g, move e into newsubdir, rename dir/->folder/, modify files)
+#              folder/subdir/{a,b,c,d,Makefile_TOP_A}
+#              folder/subdir/newsubdir/e_A
+#              folder/subdir/tweaked/{h,Makefile_SUB_A}
+#              folder/unchanged/<LOTS OF FILES>
+#   Commit B1:
+#     (add newfile.{c,py}, modify underscored files)
+#              dir/{a,b,c,d,e_B1,Makefile_TOP_B1,newfile.c}
+#              dir/tweaked/{f,g,h,Makefile_SUB_B1,newfile.py}
+#              dir/unchanged/<LOTS OF FILES>
+#   Commit B2:
+#     (Modify e further, add newfile.rs)
+#              dir/{a,b,c,d,e_B2,Makefile_TOP_B1,newfile.c,newfile.rs}
+#              dir/tweaked/{f,g,h,Makefile_SUB_B1,newfile.py}
+#              dir/unchanged/<LOTS OF FILES>
+#   Expected:
+#          B1-picked:
+#              folder/subdir/{a,b,c,d,Makefile_TOP_Merge1,newfile.c}
+#              folder/subdir/newsubdir/e_Merge1
+#              folder/subdir/tweaked/{h,Makefile_SUB_Merge1,newfile.py}
+#              folder/unchanged/<LOTS OF FILES>
+#          B2-picked:
+#              folder/subdir/{a,b,c,d,Makefile_TOP_Merge1,newfile.c,newfile.rs}
+#              folder/subdir/newsubdir/e_Merge2
+#              folder/subdir/tweaked/{h,Makefile_SUB_Merge1,newfile.py}
+#              folder/unchanged/<LOTS OF FILES>
+#
+# Notes: This testcase happens to exercise lots of the
+#        optimization-specific codepaths in merge-ort, and also
+#        demonstrated a failing of the directory rename detection algorithm
+#        in merge-recursive; newfile.c should not get pushed into
+#        folder/subdir/newsubdir/, yet merge-recursive put it there because
+#        the rename of dir/subdir/{a,b,c,d} -> folder/subdir/{a,b,c,d}
+#        looks like
+#            dir/ -> folder/,
+#        whereas the rename of dir/subdir/e -> folder/subdir/newsubdir/e
+#        looks like
+#            dir/subdir/ -> folder/subdir/newsubdir/
+#        and if we note that newfile.c is found in dir/subdir/, we might
+#        overlook the dir/ -> folder/ rule that has more weight.
+
+test_setup_12f () {
+	test_create_repo 12f &&
+	(
+		cd 12f &&
+
+		mkdir -p dir/unchanged &&
+		mkdir -p dir/subdir/tweaked &&
+		echo a >dir/subdir/a &&
+		echo b >dir/subdir/b &&
+		echo c >dir/subdir/c &&
+		echo d >dir/subdir/d &&
+		test_seq 1 10 >dir/subdir/e &&
+		test_seq 10 20 >dir/subdir/Makefile &&
+		echo f >dir/subdir/tweaked/f &&
+		echo g >dir/subdir/tweaked/g &&
+		echo h >dir/subdir/tweaked/h &&
+		test_seq 20 30 >dir/subdir/tweaked/Makefile &&
+		for i in `test_seq 1 88`; do
+			echo content $i >dir/unchanged/file_$i
+		done &&
+		git add . &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git rm dir/subdir/tweaked/f dir/subdir/tweaked/g &&
+		test_seq 2 10 >dir/subdir/e &&
+		test_seq 11 20 >dir/subdir/Makefile &&
+		test_seq 21 30 >dir/subdir/tweaked/Makefile &&
+		mkdir dir/subdir/newsubdir &&
+		git mv dir/subdir/e dir/subdir/newsubdir/ &&
+		git mv dir folder &&
+		git add . &&
+		git commit -m "A" &&
+
+		git switch B &&
+		mkdir dir/subdir/newsubdir/ &&
+		echo c code >dir/subdir/newfile.c &&
+		echo python code >dir/subdir/newsubdir/newfile.py &&
+		test_seq 1 11 >dir/subdir/e &&
+		test_seq 10 21 >dir/subdir/Makefile &&
+		test_seq 20 31 >dir/subdir/tweaked/Makefile &&
+		git add . &&
+		git commit -m "B1" &&
+
+		echo rust code >dir/subdir/newfile.rs &&
+		test_seq 1 12 >dir/subdir/e &&
+		git add . &&
+		git commit -m "B2"
+	)
+}
+
+test_expect_failure '12f: Trivial directory resolve, caching, all kinds of fun' '
+	test_setup_12f &&
+	(
+		cd 12f &&
+
+		git checkout A^0 &&
+		git branch Bmod B &&
+
+		git -c merge.directoryRenames=true rebase A Bmod &&
+
+		echo Checking the pick of B1... &&
+
+		test_must_fail git rev-parse Bmod~1:dir &&
+
+		git ls-tree -r Bmod~1 >out &&
+		test_line_count = 98 out &&
+
+		git diff --name-status A Bmod~1 >actual &&
+		q_to_tab >expect <<-\EOF &&
+		MQfolder/subdir/Makefile
+		AQfolder/subdir/newfile.c
+		MQfolder/subdir/newsubdir/e
+		AQfolder/subdir/newsubdir/newfile.py
+		MQfolder/subdir/tweaked/Makefile
+		EOF
+		test_cmp expect actual &&
+
+		# Three-way merged files
+		test_seq  2 11 >e_Merge1 &&
+		test_seq 11 21 >Makefile_TOP &&
+		test_seq 21 31 >Makefile_SUB &&
+		git hash-object >expect      \
+			e_Merge1             \
+			Makefile_TOP         \
+			Makefile_SUB         &&
+		git rev-parse >actual              \
+			Bmod~1:folder/subdir/newsubdir/e     \
+			Bmod~1:folder/subdir/Makefile        \
+			Bmod~1:folder/subdir/tweaked/Makefile &&
+		test_cmp expect actual &&
+
+		# New files showed up at the right location with right contents
+		git rev-parse >expect                \
+			B~1:dir/subdir/newfile.c            \
+			B~1:dir/subdir/newsubdir/newfile.py &&
+		git rev-parse >actual                      \
+			Bmod~1:folder/subdir/newfile.c            \
+			Bmod~1:folder/subdir/newsubdir/newfile.py &&
+		test_cmp expect actual &&
+
+		# Removed files
+		test_path_is_missing folder/subdir/tweaked/f &&
+		test_path_is_missing folder/subdir/tweaked/g &&
+
+		# Unchanged files or directories
+		git rev-parse >actual        \
+			Bmod~1:folder/subdir/a          \
+			Bmod~1:folder/subdir/b          \
+			Bmod~1:folder/subdir/c          \
+			Bmod~1:folder/subdir/d          \
+			Bmod~1:folder/unchanged         \
+			Bmod~1:folder/subdir/tweaked/h &&
+		git rev-parse >expect          \
+			O:dir/subdir/a         \
+			O:dir/subdir/b         \
+			O:dir/subdir/c         \
+			O:dir/subdir/d         \
+			O:dir/unchanged        \
+			O:dir/subdir/tweaked/h &&
+		test_cmp expect actual &&
+
+		echo Checking the pick of B2... &&
+
+		test_must_fail git rev-parse Bmod:dir &&
+
+		git ls-tree -r Bmod >out &&
+		test_line_count = 99 out &&
+
+		git diff --name-status Bmod~1 Bmod >actual &&
+		q_to_tab >expect <<-\EOF &&
+		AQfolder/subdir/newfile.rs
+		MQfolder/subdir/newsubdir/e
+		EOF
+		test_cmp expect actual &&
+
+		# Three-way merged file
+		test_seq  2 12 >e_Merge2 &&
+		git hash-object e_Merge2 >expect &&
+		git rev-parse Bmod:folder/subdir/newsubdir/e >actual &&
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

