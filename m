Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCB81F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbdL1EOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:51 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35764 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbdL1EOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:37 -0500
Received: by mail-it0-f54.google.com with SMTP id f143so27500544itb.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lPjk0eHUVUL8cnb5RdMH7rolnpS08cVXjh9X5WQYD5E=;
        b=L8M1ezVS+1GEvkbzH2mQ3MOAM1nBZ0gBUH7tn4AvNEt7VXPj5cbFuFeUChzK3tn5EI
         pRzudykeNb4EdPNLFi7evumD6PDLyrrJAX8lsOu5/fUR0GWZOo8JkxkVwaupcGhHy5eL
         W4MkB1n9y/Vw2hnSOhJn5+4jcf2esU4izLa5mYcvB2tUOYg7RCFSR3YViJO7ZbKmtWQj
         x9382Uz4lZP8kxoB32edAx1jjSeARgKJi+Wr7ywpLvbh9z6IbfCRTwZBIlL/3O1z8zV7
         aFXi8LgFX51GMIva5T7ZOb/dLzVhCJpduq7H3ID5CnvXdRPuA40CXWiUL6XKQ4irV1MW
         xYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lPjk0eHUVUL8cnb5RdMH7rolnpS08cVXjh9X5WQYD5E=;
        b=o+EHcOe8/jhHKOBVLU1WwjyHTuM6CIY2linvgUu1+3Lbo2H+/yMTDYnomAFr4YMfKE
         XjBfS1ZUjh7pnTDYkZ0L51NmC7l9i1bracyndx+rBpQUJl8ozvd9aThJP2fvZ2EsNOUa
         S9RdvRpcTcK2a7t0xs1frwFwIHzkKWtMmvovE6LxytcpER15JuJtSGlJPHB4fGEGr/LQ
         2Pgd3HvoJQFWi1MXOfrn0rqqzXygFIAPqWVQ0C8ZSK12hewdoZOWxwUeNqJmbm7o1F5i
         lFClgJWb3xT0U1jn3VQMAuA9R9ltH+D110O2+biaRuRPCq3X0jFcRvvVVi4D5fmENa5w
         wzcw==
X-Gm-Message-State: AKGB3mL57BaZ73VvetOMGERiJ+bQVKOJi9o9pdEIKCjCd7pEDKpqOgQR
        lK4LkLEk6gGLLZROTbYzZgE49Q==
X-Google-Smtp-Source: ACJfBou/vR5vtHU58YOr8j3t1zO8hrzYimaD1LfRK+bvUko6PQRd5qRmPdl55tVZTzfKqPdE4ujXiQ==
X-Received: by 10.36.55.138 with SMTP id r132mr39437145itr.34.1514434476025;
        Wed, 27 Dec 2017 20:14:36 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 33/34] merge-recursive: avoid spurious rename/rename conflict from dir renames
Date:   Wed, 27 Dec 2017 20:13:51 -0800
Message-Id: <20171228041352.27880-34-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
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
index 0c205fac5..ccfe48596 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2000,18 +2000,23 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
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
@@ -2044,29 +2049,29 @@ test_expect_success '8c-setup: rename+modify/delete' '
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
 
-		test 4 -eq $(git ls-files -s | wc -l) &&
-		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
 		test 1 -eq $(git ls-files -o | wc -l) &&
 
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
-		test -f y/d
+		test_must_fail git rev-parse :2:z/d &&
+		git ls-files -s z/d | grep ^100755 &&
+		test -f z/d &&
+		! test -f y/d
 	)
 '
 
@@ -2080,16 +2085,6 @@ test_expect_success '8c-check: rename+modify/delete' '
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
@@ -2804,7 +2799,7 @@ test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
 	)
 '
 
-test_expect_failure '9h-check: Avoid dir rename on merely modified path' '
+test_expect_success '9h-check: Avoid dir rename on merely modified path' '
 	(
 		cd 9h &&
 
@@ -3785,7 +3780,7 @@ test_expect_success '12c-setup: Moving one directory hierarchy into another w/ c
 	)
 '
 
-test_expect_failure '12c-check: Moving one directory hierarchy into another w/ content merge' '
+test_expect_success '12c-check: Moving one directory hierarchy into another w/ content merge' '
 	(
 		cd 12c &&
 
-- 
2.15.0.408.g8e199d483

