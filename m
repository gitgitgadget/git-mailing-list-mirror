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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C5FC43467
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF772074A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRFwJ8if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392378AbgJOUqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732772AbgJOUqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B19C0613D5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f21so324752wml.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lbzqgW30tieJU8UI20I0ndzNVJ/GigsXnEdfsKKs0ms=;
        b=GRFwJ8ifeK+MyET3oplojbY/8JI+52PykTtDRI7XlNofFQT6FV3fZBQmepqSi66a/C
         hnt66qzapi8fL9hZpyXVb34jaJ7SBKuYSQEl4nUJ4jzcCo8WWXCjyAYppkqPoyxBGIKo
         02eTqebEtHpwVJlRdaTz/6+fHevbaAF52VL6Blifg/sli5cXjn7NiokOgzFazm8SmbVL
         rAqIL4IgnxG+/p3ai7PfDsRoXbSDhVo9xeGMzqOwzBj7XqAkTroZtoNV2SwFEFn0dxK4
         eD0fmMXhOtz9Orw8U/hV3vngo6UK381euG5NZ/20AaqBLXvdRjlFYnmiUKOVa5hk5dCP
         bbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lbzqgW30tieJU8UI20I0ndzNVJ/GigsXnEdfsKKs0ms=;
        b=nSf8yp26cWO75t8x+g79wSXGcdtsnYGC23JD4AJZSe0qyF7P3exPfV/Kd9lF89GBV2
         YgC6yg1xNUAOrRfUZnvPziWIWFHYfsX9I20MY4zRRIA9ANl9EBI7gwEf+8nJKYXUDIqI
         fA7/It6iRY4/h73L3l1EIXbAkIJT5ePiytYSQ86WzWum3k3N97cxrS91V7Z49XHVCiWv
         zsggZp5ByHxdspb2W9AqngATsAEX9OHUIU8AARxSfg/z+Lxd1lJfOxTpb+9W9ISQ4tIl
         CA4pws5kYPuEekeCIMv4BJais3WfWUGvD1CDdH4BdWIzZfPX70paxdodvyUQ4X625uJw
         JFsw==
X-Gm-Message-State: AOAM530gatHV90+BEIs1LCEIn+a9CaOYH5dm6t+RYUD+UAJVvSYDD5Za
        LA6/8YNzJfoLsQNgSUQ1+kU79J4OMNM=
X-Google-Smtp-Source: ABdhPJwL18uX2Q6fy86cCCyt71zTLt6Ro7QGq++lB02U8q63jFRukxOC9OWkhj1OkLUJgi2EoVz8Vw==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr478644wmg.70.1602794795343;
        Thu, 15 Oct 2020 13:46:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm597647wrr.91.2020.10.15.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:46:34 -0700 (PDT)
Message-Id: <531942d353758305e29879654b93f4ba3dcbcc63.1602794791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
References: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 20:46:30 +0000
Subject: [PATCH 4/4] t6423: more involved rules for renaming directories into
 each other
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

Testcases 12b and 12c were both slightly weird; they were marked as
having a weird resolution, but with the note that even straightforward
simple rules can give weird results when the input is bizarre.

However, during optimization work for merge-ort, I discovered a
significant speedup that is possible if we add one more fairly
straightforward rule: we don't bother doing directory rename detection
if there are no new files added to the directory on the other side of
the history to be affected by the directory rename.  This seems like an
obvious and straightforward rule, but there was one funny corner case
where directory rename detection could affect only existing files: the
funny corner case where two directories are renamed into each other on
opposite sides of history.  In other words, it only results in a
different output for testcases 12b and 12c.

Since we already thought testcases 12b and 12c were weird anyway, and
because the optimization often has a significant effect on common cases
(but is entirely prevented if we can't change how 12b and 12c function),
let's add the additional rule and tweak how 12b and 12c work.  Split
both testcases into two (one where we add no new files, and one where
the side that doesn't rename a given directory will add files to it),
and mark them with the new expectation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .../technical/directory-rename-detection.txt  |   3 +
 t/t6423-merge-rename-directories.sh           | 253 ++++++++++++++++--
 2 files changed, 230 insertions(+), 26 deletions(-)

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 5d03539412..49b83ef3cc 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -73,6 +73,9 @@ additional rules:
   b) Only apply implicit directory renames to directories if the other side
      of history is the one doing the renaming.
 
+  c) Do not perform directory rename detection for directories which had no
+     new paths added to them.
+
 Limitations -- support in different commands
 --------------------------------------------
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 00eac6e9a2..06b46af765 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4049,31 +4049,124 @@ test_expect_success '12a: Moving one directory hierarchy into another' '
 	)
 '
 
-# Testcase 12b, Moving two directory hierarchies into each other
+# Testcase 12b1, Moving two directory hierarchies into each other
 #   (Related to testcases 1c and 12c)
 #   Commit O: node1/{leaf1, leaf2}, node2/{leaf3, leaf4}
 #   Commit A: node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
 #   Commit B: node2/{leaf3, leaf4, node1/{leaf1, leaf2}}
-#   Expected: node1/node2/node1/{leaf1, leaf2},
+#   Expected: node1/node2/{leaf3, leaf4}
+#             node2/node1/{leaf1, leaf2}
+#   NOTE: If there were new files added to the old node1/ or node2/ directories,
+#         then we would need to detect renames for those directories and would
+#         find that:
+#             commit A renames node2/ -> node1/node2/
+#             commit B renames node1/ -> node2/node1/
+#         Applying those directory renames to the initial result (making all
+#         four paths experience a transitive renaming), yields
+#             node1/node2/node1/{leaf1, leaf2}
 #             node2/node1/node2/{leaf3, leaf4}
+#         as the result.  It may be really weird to have two directories
+#         rename each other, but simple rules give weird results when given
+#         weird inputs.  HOWEVER, the "If" at the beginning of those NOTE was
+#         false; there were no new files added and thus there is no directory
+#         rename detection to perform.  As such, we just have simple renames
+#         and the expected answer is:
+#             node1/node2/{leaf3, leaf4}
+#             node2/node1/{leaf1, leaf2}
+
+test_setup_12b1 () {
+	test_create_repo 12b1 &&
+	(
+		cd 12b1 &&
+
+		mkdir -p node1 node2 &&
+		echo leaf1 >node1/leaf1 &&
+		echo leaf2 >node1/leaf2 &&
+		echo leaf3 >node2/leaf3 &&
+		echo leaf4 >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv node1/ node2/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_failure '12b1: Moving two directory hierarchies into each other' '
+	test_setup_12b1 &&
+	(
+		cd 12b1 &&
+
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+
+		git rev-parse >actual \
+			HEAD:node2/node1/leaf1 \
+			HEAD:node2/node1/leaf2 \
+			HEAD:node1/node2/leaf3 \
+			HEAD:node1/node2/leaf4 &&
+		git rev-parse >expect \
+			O:node1/leaf1 \
+			O:node1/leaf2 \
+			O:node2/leaf3 \
+			O:node2/leaf4 &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12b2, Moving two directory hierarchies into each other
+#   (Related to testcases 1c and 12c)
+#   Commit O: node1/{leaf1, leaf2}, node2/{leaf3, leaf4}
+#   Commit A: node1/{leaf1, leaf2, leaf5, node2/{leaf3, leaf4}}
+#   Commit B: node2/{leaf3, leaf4, leaf6, node1/{leaf1, leaf2}}
+#   Expected: node1/node2/{node1/{leaf1, leaf2}, leaf6}
+#             node2/node1/{node2/{leaf3, leaf4}, leaf5}
 #   NOTE: Without directory renames, we would expect
-#                   node2/node1/{leaf1, leaf2},
-#                   node1/node2/{leaf3, leaf4}
+#             A: node2/leaf3 -> node1/node2/leaf3
+#             A: node2/leaf1 -> node1/node2/leaf4
+#             A: Adds           node1/leaf5
+#             B: node1/leaf1 -> node2/node1/leaf1
+#             B: node1/leaf2 -> node2/node1/leaf2
+#             B: Adds           node2/leaf6
 #         with directory rename detection, we note that
 #             commit A renames node2/ -> node1/node2/
 #             commit B renames node1/ -> node2/node1/
-#         therefore, applying those directory renames to the initial result
-#         (making all four paths experience a transitive renaming), yields
-#         the expected result.
+#         therefore, applying A's directory rename to the paths added in B gives:
+#             B: node1/leaf1 -> node1/node2/node1/leaf1
+#             B: node1/leaf2 -> node1/node2/node1/leaf2
+#             B: Adds           node1/node2/leaf6
+#         and applying B's directory rename to the paths added in A gives:
+#             A: node2/leaf3 -> node2/node1/node2/leaf3
+#             A: node2/leaf1 -> node2/node1/node2/leaf4
+#             A: Adds           node2/node1/leaf5
+#         resulting in the expected
+#             node1/node2/{node1/{leaf1, leaf2}, leaf6}
+#             node2/node1/{node2/{leaf3, leaf4}, leaf5}
 #
 #         You may ask, is it weird to have two directories rename each other?
 #         To which, I can do no more than shrug my shoulders and say that
 #         even simple rules give weird results when given weird inputs.
 
-test_setup_12b () {
-	test_create_repo 12b &&
+test_setup_12b2 () {
+	test_create_repo 12b2 &&
 	(
-		cd 12b &&
+		cd 12b2 &&
 
 		mkdir -p node1 node2 &&
 		echo leaf1 >node1/leaf1 &&
@@ -4090,43 +4183,51 @@ test_setup_12b () {
 
 		git checkout A &&
 		git mv node2/ node1/ &&
+		echo leaf5 >node1/leaf5 &&
+		git add node1/leaf5 &&
 		test_tick &&
 		git commit -m "A" &&
 
 		git checkout B &&
 		git mv node1/ node2/ &&
+		echo leaf6 >node2/leaf6 &&
+		git add node2/leaf6 &&
 		test_tick &&
 		git commit -m "B"
 	)
 }
 
-test_expect_success '12b: Moving two directory hierarchies into each other' '
-	test_setup_12b &&
+test_expect_success '12b2: Moving two directory hierarchies into each other' '
+	test_setup_12b2 &&
 	(
-		cd 12b &&
+		cd 12b2 &&
 
 		git checkout A^0 &&
 
 		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
+		test_line_count = 6 out &&
 
 		git rev-parse >actual \
 			HEAD:node1/node2/node1/leaf1 \
 			HEAD:node1/node2/node1/leaf2 \
 			HEAD:node2/node1/node2/leaf3 \
-			HEAD:node2/node1/node2/leaf4 &&
+			HEAD:node2/node1/node2/leaf4 \
+			HEAD:node2/node1/leaf5       \
+			HEAD:node1/node2/leaf6       &&
 		git rev-parse >expect \
 			O:node1/leaf1 \
 			O:node1/leaf2 \
 			O:node2/leaf3 \
-			O:node2/leaf4 &&
+			O:node2/leaf4 \
+			A:node1/leaf5 \
+			B:node2/leaf6 &&
 		test_cmp expect actual
 	)
 '
 
-# Testcase 12c, Moving two directory hierarchies into each other w/ content merge
+# Testcase 12c1, Moving two directory hierarchies into each other w/ content merge
 #   (Related to testcase 12b)
 #   Commit O: node1/{       leaf1_1, leaf2_1}, node2/{leaf3_1, leaf4_1}
 #   Commit A: node1/{       leaf1_2, leaf2_2,  node2/{leaf3_2, leaf4_2}}
@@ -4134,13 +4235,13 @@ test_expect_success '12b: Moving two directory hierarchies into each other' '
 #   Expected: Content merge conflicts for each of:
 #               node1/node2/node1/{leaf1, leaf2},
 #               node2/node1/node2/{leaf3, leaf4}
-#   NOTE: This is *exactly* like 12c, except that every path is modified on
+#   NOTE: This is *exactly* like 12b1, except that every path is modified on
 #         each side of the merge.
 
-test_setup_12c () {
-	test_create_repo 12c &&
+test_setup_12c1 () {
+	test_create_repo 12c1 &&
 	(
-		cd 12c &&
+		cd 12c1 &&
 
 		mkdir -p node1 node2 &&
 		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf1\n" >node1/leaf1 &&
@@ -4171,10 +4272,10 @@ test_setup_12c () {
 	)
 }
 
-test_expect_success '12c: Moving one directory hierarchy into another w/ content merge' '
-	test_setup_12c &&
+test_expect_failure '12c1: Moving one directory hierarchy into another w/ content merge' '
+	test_setup_12c1 &&
 	(
-		cd 12c &&
+		cd 12c1 &&
 
 		git checkout A^0 &&
 
@@ -4183,6 +4284,102 @@ test_expect_success '12c: Moving one directory hierarchy into another w/ content
 		git ls-files -u >out &&
 		test_line_count = 12 out &&
 
+		git rev-parse >actual \
+			:1:node2/node1/leaf1 \
+			:1:node2/node1/leaf2 \
+			:1:node1/node2/leaf3 \
+			:1:node1/node2/leaf4 \
+			:2:node2/node1/leaf1 \
+			:2:node2/node1/leaf2 \
+			:2:node1/node2/leaf3 \
+			:2:node1/node2/leaf4 \
+			:3:node2/node1/leaf1 \
+			:3:node2/node1/leaf2 \
+			:3:node1/node2/leaf3 \
+			:3:node1/node2/leaf4 &&
+		git rev-parse >expect \
+			O:node1/leaf1 \
+			O:node1/leaf2 \
+			O:node2/leaf3 \
+			O:node2/leaf4 \
+			A:node1/leaf1 \
+			A:node1/leaf2 \
+			A:node1/node2/leaf3 \
+			A:node1/node2/leaf4 \
+			B:node2/node1/leaf1 \
+			B:node2/node1/leaf2 \
+			B:node2/leaf3 \
+			B:node2/leaf4 &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12c2, Moving two directory hierarchies into each other w/ content merge
+#   (Related to testcase 12b)
+#   Commit O: node1/{       leaf1_1, leaf2_1}, node2/{leaf3_1, leaf4_1}
+#   Commit A: node1/{       leaf1_2, leaf2_2,  node2/{leaf3_2, leaf4_2}, leaf5}
+#   Commit B: node2/{node1/{leaf1_3, leaf2_3},        leaf3_3, leaf4_3,  leaf6}
+#   Expected: Content merge conflicts for each of:
+#               node1/node2/node1/{leaf1, leaf2}
+#               node2/node1/node2/{leaf3, leaf4}
+#             plus
+#               node2/node1/leaf5
+#               node1/node2/leaf6
+#   NOTE: This is *exactly* like 12b2, except that every path from O is modified
+#         on each side of the merge.
+
+test_setup_12c2 () {
+	test_create_repo 12c2 &&
+	(
+		cd 12c2 &&
+
+		mkdir -p node1 node2 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf1\n" >node1/leaf1 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf2\n" >node1/leaf2 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf3\n" >node2/leaf3 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf4\n" >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		for i in `git ls-files`; do echo side A >>$i; done &&
+		git add -u &&
+		echo leaf5 >node1/leaf5 &&
+		git add node1/leaf5 &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv node1/ node2/ &&
+		for i in `git ls-files`; do echo side B >>$i; done &&
+		git add -u &&
+		echo leaf6 >node2/leaf6 &&
+		git add node2/leaf6 &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_success '12c2: Moving one directory hierarchy into another w/ content merge' '
+	test_setup_12c2 &&
+	(
+		cd 12c2 &&
+
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 14 out &&
+		git ls-files -u >out &&
+		test_line_count = 12 out &&
+
 		git rev-parse >actual \
 			:1:node1/node2/node1/leaf1 \
 			:1:node1/node2/node1/leaf2 \
@@ -4195,7 +4392,9 @@ test_expect_success '12c: Moving one directory hierarchy into another w/ content
 			:3:node1/node2/node1/leaf1 \
 			:3:node1/node2/node1/leaf2 \
 			:3:node2/node1/node2/leaf3 \
-			:3:node2/node1/node2/leaf4 &&
+			:3:node2/node1/node2/leaf4 \
+			:0:node2/node1/leaf5       \
+			:0:node1/node2/leaf6       &&
 		git rev-parse >expect \
 			O:node1/leaf1 \
 			O:node1/leaf2 \
@@ -4208,7 +4407,9 @@ test_expect_success '12c: Moving one directory hierarchy into another w/ content
 			B:node2/node1/leaf1 \
 			B:node2/node1/leaf2 \
 			B:node2/leaf3 \
-			B:node2/leaf4 &&
+			B:node2/leaf4 \
+			A:node1/leaf5 \
+			B:node2/leaf6 &&
 		test_cmp expect actual
 	)
 '
-- 
gitgitgadget
