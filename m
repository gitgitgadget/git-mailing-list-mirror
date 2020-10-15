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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C51C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8024A2074A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuEXrgrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392377AbgJOUqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbgJOUqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5978AC0613D4
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so123738wrq.11
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xBD9U6E1R7F9x+XBIByf3oC2vlklCFMaMgd1ZRo9l2w=;
        b=QuEXrgrHY/vpyS52kyg1P4uRZzTg+0KujEUVfzygkYmO4YeMOC/KkZ96VUVHLBIJl0
         u88XvzU4zfFJE6JrRl1Z9j3u+JhQOXWIgGjHigbf/mL+LJ4gczXeTwQAj91ekACNdaRF
         Lse71p+vW2Jlh1pDEwhLWHimChvTcU33/DFR3J+GHoAUXi1YSyHRMq04eq75T53NFPhz
         37rdID+uhe72Gik0uMUAdgvOtXumjHEU46quQezpqIjnqXDo5G+7Hc88nepqbLsHB3Ki
         VyJiop/mT0xwcLLEWkADUMDmV7It9WXXAJHCj8x5LhMKtgQUTR8dfxE09Q0nlErsDFFy
         ChjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xBD9U6E1R7F9x+XBIByf3oC2vlklCFMaMgd1ZRo9l2w=;
        b=smQXQaA8oZFJsVps2muoWoTmzBhG4zsiHoU+nuMlgLlN6FPTfqQ5DE+Fhb3/1nIUMK
         e0iA0s7Ag/FOABCGjNZXjmcVIW5rkRUKXSE19loA9CwfYndlYk6Ci7mjXl9ArZdtPGqP
         0bMLWuDQylGqVksxEGXQJrxwd636dZw9dm0mY0FF/psK/Kgs6AFvK5ABt6I6PbVTyMPZ
         2mw1kvznBbjjI5gjfU+vJpf45zdUKuSGdNumhlS6pfc2ahFCgtO577nara/wVWbzeOsJ
         mM2hEqxJRq08PaRcXRVsljmR0pZGluPwkXuOhNWDicR91mYD5B1mS5HkZ/OBcFRqPWI/
         2Vcw==
X-Gm-Message-State: AOAM531mcDCA0T4aSdkSPKaCrqT80x22c8akGskjyl/+0zP0lD9d6jsi
        MhKnT3UOiIwa6sVNB++rVLUoi6FF87s=
X-Google-Smtp-Source: ABdhPJyHtwGMJQ/Cea8p2pP3R6UfF4sas11qn9OQx8Y8aOdKjrNnhhiC3gVJXRhsMJaOo3lTobsL2A==
X-Received: by 2002:adf:a1cb:: with SMTP id v11mr147530wrv.86.1602794794594;
        Thu, 15 Oct 2020 13:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm774983wrc.23.2020.10.15.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:46:34 -0700 (PDT)
Message-Id: <146d6f4735497f0228d22fc7aae2c419363e063a.1602794791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
References: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 20:46:29 +0000
Subject: [PATCH 3/4] t6423: update directory rename detection tests with new
 rule
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

While investigating the issues highlighted by the testcase in the
previous patch, I also found a shortcoming in the directory rename
detection rules.  Split testcase 6b into two to explain this issue
and update directory-rename-detection.txt to remove one of the previous
rules that I know believe to be detrimental.  Also, update the wording
around testcase 8e; while we are not modifying the results of that
testcase, we were previously unsure of the appropriate resolution of
that test and the new rule makes the previously chosen resolution for
that testcase a bit more solid.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .../technical/directory-rename-detection.txt  |   5 +-
 t/t6423-merge-rename-directories.sh           | 144 +++++++++++++++---
 2 files changed, 124 insertions(+), 25 deletions(-)

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index ce042cfcae..5d03539412 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -70,10 +70,7 @@ additional rules:
   a) If renames split a directory into two or more others, the directory
      with the most renames, "wins".
 
-  b) Avoid directory-rename-detection for a path, if that path is the
-     source of a rename on either side of a merge.
-
-  c) Only apply implicit directory renames to directories if the other side
+  b) Only apply implicit directory renames to directories if the other side
      of history is the one doing the renaming.
 
 Limitations -- support in different commands
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 31aea47522..00eac6e9a2 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -1277,20 +1277,114 @@ test_expect_success '6a: Tricky rename/delete' '
 	)
 '
 
-# Testcase 6b, Same rename done on both sides
+# Testcase 6b1, Same rename done on both sides
+#   (Related to testcase 6b2 and 8e)
+#   Commit O: z/{b,c,d,e}
+#   Commit A: y/{b,c,d}, x/e
+#   Commit B: y/{b,c,d}, z/{e,f}
+#   Expected: y/{b,c,d,f}, x/e
+#   Note: Directory rename detection says A renamed z/ -> y/ (3 paths renamed
+#         to y/ and only 1 renamed to x/), therefore the new file 'z/f' in B
+#         should be moved to 'y/f'.
+#
+#         This is a bit of an edge case where any behavior might surprise users,
+#         whether that is treating A as renaming z/ -> y/, treating A as renaming
+#         z/ -> x/, or treating A as not doing any directory rename.  However, I
+#         think this answer is the least confusing and most consistent with the
+#         rules elsewhere.
+#
+#         A note about z/ -> x/, since it may not be clear how that could come
+#         about: If we were to ignore files renamed by both sides
+#         (i.e. z/{b,c,d}), as directory rename detection did in git-2.18 thru
+#         at least git-2.28, then we would note there are no renames from z/ to
+#         y/ and one rename from z/ to x/ and thus come to the conclusion that
+#         A renamed z/ -> x/.  This seems more confusing for end users than a
+#         rename of z/ to y/, it makes directory rename detection behavior
+#         harder for them to predict.  As such, we modified the rule, changed
+#         the behavior on testcases 6b2 and 8e, and introduced this 6b1 testcase.
+
+test_setup_6b1 () {
+	test_create_repo 6b1 &&
+	(
+		cd 6b1 &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		echo e >z/e &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		mkdir x &&
+		git mv y/e x/e &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir z &&
+		git mv y/e z/e &&
+		echo f >z/f &&
+		git add z/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_failure '6b1: Same renames done on both sides, plus another rename' '
+	test_setup_6b1 &&
+	(
+		cd 6b1 &&
+
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:x/e HEAD:y/f &&
+		git rev-parse >expect \
+			O:z/b    O:z/c    O:z/d    O:z/e    B:z/f &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6b2, Same rename done on both sides
 #   (Related to testcases 6c and 8e)
 #   Commit O: z/{b,c}
 #   Commit A: y/{b,c}
 #   Commit B: y/{b,c}, z/d
-#   Expected: y/{b,c}, z/d
-#   Note: If we did directory rename detection here, we'd move z/d into y/,
-#         but B did that rename and still decided to put the file into z/,
-#         so we probably shouldn't apply directory rename detection for it.
-
-test_setup_6b () {
-	test_create_repo 6b &&
+#   Expected: y/{b,c,d}
+#   Alternate: y/{b,c}, z/d
+#   Note: Directory rename detection says A renamed z/ -> y/, therefore the new
+#         file 'z/d' in B should be moved to 'y/d'.
+#
+#         We could potentially ignore the renames of z/{b,c} on side A since
+#         those were renamed on both sides.  However, it's a bit of a corner
+#         case because what if there was also a z/e that side A moved to x/e
+#         and side B left alone?  If we used the "ignore renames done on both
+#         sides" logic, then we'd compute that A renamed z/ -> x/, and move
+#         z/d to x/d.  That seems more surprising and uglier than allowing
+#         the z/ -> y/ rename.
+
+test_setup_6b2 () {
+	test_create_repo 6b2 &&
 	(
-		cd 6b &&
+		cd 6b2 &&
 
 		mkdir z &&
 		echo b >z/b &&
@@ -1318,10 +1412,10 @@ test_setup_6b () {
 	)
 }
 
-test_expect_success '6b: Same rename done on both sides' '
-	test_setup_6b &&
+test_expect_failure '6b2: Same rename done on both sides' '
+	test_setup_6b2 &&
 	(
-		cd 6b &&
+		cd 6b2 &&
 
 		git checkout A^0 &&
 
@@ -1335,7 +1429,7 @@ test_expect_success '6b: Same rename done on both sides' '
 		test_line_count = 1 out &&
 
 		git rev-parse >actual \
-			HEAD:y/b HEAD:y/c HEAD:z/d &&
+			HEAD:y/b HEAD:y/c HEAD:y/d &&
 		git rev-parse >expect \
 			O:z/b    O:z/c    B:z/d &&
 		test_cmp expect actual
@@ -1343,7 +1437,7 @@ test_expect_success '6b: Same rename done on both sides' '
 '
 
 # Testcase 6c, Rename only done on same side
-#   (Related to testcases 6b and 8e)
+#   (Related to testcases 6b1, 6b2, and 8e)
 #   Commit O: z/{b,c}
 #   Commit A: z/{b,c} (no change)
 #   Commit B: y/{b,c}, z/d
@@ -2269,14 +2363,22 @@ test_expect_success '8d: rename/delete...or not?' '
 # Notes: In commit A, directory z got renamed to y.  In commit B, directory z
 #        did NOT get renamed; the directory is still present; instead it is
 #        considered to have just renamed a subset of paths in directory z
-#        elsewhere.  However, this is much like testcase 6b (where commit B
-#        moves all the original paths out of z/ but opted to keep d
-#        within z/).  This makes it hard to judge where d should end up.
+#        elsewhere.  This is much like testcase 6b2 (where commit B moves all
+#        the original paths out of z/ but opted to keep d within z/).
+#
+#        It was not clear in the past what should be done with this testcase;
+#        in fact, I noted that I "just picked one" previously.  However,
+#        following the new logic for testcase 6b2, we should take the rename
+#        and move z/d to y/d.
 #
-#        It's possible that users would get confused about this, but what
-#        should we do instead?  It's not at all clear to me whether z/d or
-#        y/d or something else is a better resolution here, and other cases
-#        start getting really tricky, so I just picked one.
+#        6b1, 6b2, and this case are definitely somewhat fuzzy in terms of
+#        whether they are optimal for end users, but (a) the default for
+#        directory rename detection is to mark these all as conflicts
+#        anyway, (b) it feels like this is less prone to higher order corner
+#        case confusion, and (c) the current algorithm requires less global
+#        knowledge (i.e. less coupling in the algorithm between renames done
+#        on both sides) which thus means users are better able to predict
+#        the behavior, and predict it without computing as many details.
 
 test_setup_8e () {
 	test_create_repo 8e &&
-- 
gitgitgadget

