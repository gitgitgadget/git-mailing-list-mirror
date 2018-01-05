Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D671F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeAEU3C (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:02 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33732 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeAEU27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:59 -0500
Received: by mail-it0-f65.google.com with SMTP id o130so5546779itg.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yd//B0WfSPK4SaJZg8wfjZhvZ6oq7YaIoSc4yACV4Lc=;
        b=MnbWoTo4vsTOicmMM7tADe9McyAFAFLb8kFBZlXQxmZXOPZviOeciFz9gQXg66Byuf
         eERjaDWNrcRzEpB+WXCbQfdz3xTONy82ij66QU7aATjwHTk9LLZ97vovLQ6eNayr0lDQ
         W6zlU+/uiaAAddctJ5oaYrJ6EWiR54O4CRp3DWQHj0AtBCef9JwVapv55y58J0L7q44E
         gdcufGGhZuHhakcBv3bgOzHSq9QA6ARLWtf8PKqIZtogxqc6yL0/jJILYNQawlXW46HX
         +o81j+fvfNuRmAQ/D1kqwdj+/AamI/QnRdDERAFXj6JAgqrqCiaBVICgOUFA8uhEUv0G
         mXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yd//B0WfSPK4SaJZg8wfjZhvZ6oq7YaIoSc4yACV4Lc=;
        b=pbjyxG7ZL/5jC8mYQg4fKv3gcE0j/ArGXIF4EsPiRDpm8+9sbCB6EDY3gLBsB7Lqc8
         2F0nyJdLLrz+8jibxB2ynIc0mL3cJICBbrmxg4C8ydh6j9fNpBHQmPm8yhDjs7d6a0vc
         fOVSpGZl2btVAich8qqwXHemSyr5Xu+MURPTzo4PPm9843JGWXPjZXC/PdjBVjxD7Z/u
         SnkgGCMZ4x6KWVlZ/fxCr2nE0f+xt3+JOvYc0yyqSH10ioQvsD58VIVP4tVfapC3vYFy
         Fq6CS3dNZyYu9iXjOzb5l1K+A01tAth7YgFVfm2I0/A7Q48lg6OwHLnNlaLQjbjs/Mqh
         pNzw==
X-Gm-Message-State: AKGB3mLxe7bpst/oYTzhR3+3Di/I4xews6CnW9t2XjNtHe6hGImPNMGp
        DcOcg53B3zHgZ2nWGeaEuzbgPtYK
X-Google-Smtp-Source: ACJfBouIXwNgjXkzuwhMyuk9UYTNcjcT3jPWai2PCDO9Cd9sRCq8fhTZfbFc+skxzsLdAc1dHfZvOA==
X-Received: by 10.36.254.200 with SMTP id w191mr4542268ith.26.1515184138594;
        Fri, 05 Jan 2018 12:28:58 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 30/31] merge-recursive: avoid spurious rename/rename conflict from dir renames
Date:   Fri,  5 Jan 2018 12:27:10 -0800
Message-Id: <20180105202711.24311-31-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a file on one side of history was renamed, and merely modified on the
other side, then applying a directory rename to the modified side gives us
a rename/rename(1to2) conflict.  We should only apply directory renames to
pairs representing either adds or renames.

Making this change means that a directory rename testcase that was
previously reported as a rename/delete conflict will now be reported as a
modify/delete conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   |  4 +--
 t/t6043-merge-rename-directories.sh | 55 +++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fe42cabad..d00786f71 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1951,7 +1951,7 @@ static void compute_collisions(struct hashmap *collisions,
 		char *new_path;
 		struct diff_filepair *pair = pairs->queue[i];
 
-		if (pair->status == 'D')
+		if (pair->status != 'A' && pair->status != 'R')
 			continue;
 		dir_rename_ent = check_dir_renamed(pair->two->path,
 						   dir_renames);
@@ -2178,7 +2178,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct diff_filepair *pair = pairs->queue[i];
 		char *new_path; /* non-NULL only with directory renames */
 
-		if (pair->status == 'D') {
+		if (pair->status != 'A' && pair->status != 'R') {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index c684f34b6..99dca4ff0 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2070,18 +2070,23 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
 	)
 '
 
-# Testcase 8c, rename+modify/delete
-#   (Related to testcases 5b and 8d)
+# Testcase 8c, modify/delete or rename+modify/delete?
+#   (Related to testcases 5b, 8d, and 9h)
 #   Commit O: z/{b,c,d}
 #   Commit A: y/{b,c}
 #   Commit B: z/{b,c,d_modified,e}
-#   Expected: y/{b,c,e}, CONFLICT(rename+modify/delete: x/d -> y/d or deleted)
+#   Expected: y/{b,c,e}, CONFLICT(modify/delete: on z/d)
 #
-#   Note: This testcase doesn't present any concerns for me...until you
-#         compare it with testcases 5b and 8d.  See notes in 8d for more
-#         details.
-
-test_expect_success '8c-setup: rename+modify/delete' '
+#   Note: It could easily be argued that the correct resolution here is
+#         y/{b,c,e}, CONFLICT(rename/delete: z/d -> y/d vs deleted)
+#         and that the modifed version of d should be present in y/ after
+#         the merge, just marked as conflicted.  Indeed, I previously did
+#         argue that.  But applying directory renames to the side of
+#         history where a file is merely modified results in spurious
+#         rename/rename(1to2) conflicts -- see testcase 9h.  See also
+#         notes in 8d.
+
+test_expect_success '8c-setup: modify/delete or rename+modify/delete?' '
 	test_create_repo 8c &&
 	(
 		cd 8c &&
@@ -2114,32 +2119,32 @@ test_expect_success '8c-setup: rename+modify/delete' '
 	)
 '
 
-test_expect_success '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: modify/delete or rename+modify/delete' '
 	(
 		cd 8c &&
 
 		git checkout A^0 &&
 
 		test_must_fail git merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/delete).* z/d.*y/d" out &&
+		test_i18ngrep "CONFLICT (modify/delete).* z/d" out &&
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
-		test_line_count = 1 out &&
+		test_line_count = 2 out &&
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
 		git rev-parse >actual \
-			:0:y/b :0:y/c :0:y/e :3:y/d &&
+			:0:y/b :0:y/c :0:y/e :1:z/d :3:z/d &&
 		git rev-parse >expect \
-			O:z/b O:z/c B:z/e B:z/d &&
+			O:z/b O:z/c B:z/e O:z/d B:z/d &&
 		test_cmp expect actual &&
 
-		test_must_fail git rev-parse :1:y/d &&
-		test_must_fail git rev-parse :2:y/d &&
-		git ls-files -s y/d | grep ^100755 &&
-		test_path_is_file y/d
+		test_must_fail git rev-parse :2:z/d &&
+		git ls-files -s z/d | grep ^100755 &&
+		test_path_is_file z/d &&
+		test_path_is_missing y/d
 	)
 '
 
@@ -2153,16 +2158,6 @@ test_expect_success '8c-check: rename+modify/delete' '
 #
 #   Note: It would also be somewhat reasonable to resolve this as
 #             y/{b,c,e}, CONFLICT(rename/delete: x/d -> y/d or deleted)
-#   The logic being that the only difference between this testcase and 8c
-#   is that there is no modification to d.  That suggests that instead of a
-#   rename/modify vs. delete conflict, we should just have a rename/delete
-#   conflict, otherwise we are being inconsistent.
-#
-#   However...as far as consistency goes, we didn't report a conflict for
-#   path d_1 in testcase 5b due to a different file being in the way.  So,
-#   we seem to be forced to have cases where users can change things
-#   slightly and get what they may perceive as inconsistent results.  It
-#   would be nice to avoid that, but I'm not sure I see how.
 #
 #   In this case, I'm leaning towards: commit A was the one that deleted z/d
 #   and it did the rename of z to y, so the two "conflicts" (rename vs.
@@ -2891,7 +2886,7 @@ test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
 	)
 '
 
-test_expect_failure '9h-check: Avoid dir rename on merely modified path' '
+test_expect_success '9h-check: Avoid dir rename on merely modified path' '
 	(
 		cd 9h &&
 
@@ -3927,7 +3922,7 @@ test_expect_success '12c-setup: Moving one directory hierarchy into another w/ c
 	)
 '
 
-test_expect_failure '12c-check: Moving one directory hierarchy into another w/ content merge' '
+test_expect_success '12c-check: Moving one directory hierarchy into another w/ content merge' '
 	(
 		cd 12c &&
 
-- 
2.14.2

