Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5664207D6
	for <e@80x24.org>; Thu,  4 May 2017 21:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbdEDVg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 17:36:26 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35424 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdEDVgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 17:36:25 -0400
Received: by mail-io0-f194.google.com with SMTP id v34so6629098iov.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFqQqKGdyyGTNE8GhU5LuQD/d8SCUq8HAmp578zBMsQ=;
        b=o+KfEZboNw07ArXDDMK1ZyHNBJGclreWtu7NOTabO7uIC/C6UhezOFiJiR1gB+BWHP
         m3EfSWmjEPMbd70zWV9PjAux1rjtfKizyCOgSe2bJR1Fu/VLbC7XLrgGefJ7d44/gnMa
         PloBYvzAsjmrSvWEHNM9iUymQ8F8fojLFF8RQHqmeDhej5Y6GQ3G65h6uyF4D7Jq4Dmu
         nAWuUYWwfUlYKgNSW3QIqArPxf+IVlWTht2eZaRbZ6aAxTy8gtAf84520NdJoGE9zl5+
         PoLV9MORtHX3ZrFVr84a3wm0uxe28buk3oy5/fxX8SgpsGXljzH8YGq9mbtPxvOA3dLw
         BjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rFqQqKGdyyGTNE8GhU5LuQD/d8SCUq8HAmp578zBMsQ=;
        b=JpUVPNIV9H9FpfOItEALYRKCi4anboLRLkCQvpaoteIt4hGt8v6O/XqISHiuW/THjb
         DNPNKux5wbQG1AMQS+8TY5N1YQtWUrq8ftSFW0ojgHjOUQCjShJz7oz2GmJQLi65y7Nq
         77+zPNJVzh1ewnP0HsVM7ah2K/+HY596Vb6GHhy9k2cieLTt2OkAHIC70y1Oc0efnYNc
         F/r0qmEEZTSAKS8Mwpbk8rOs/1ggeOdhmEt2FLivZdvALlE9ML9wB3cCujDR/gQL9GZr
         PozRNtaJAykMHnTqrpu2DLvM5TFaTCSw6xLbsPJvZMIWSTxqDQ7Svnz2FTCRwBdf2FZN
         hm+g==
X-Gm-Message-State: AN3rC/76RzGwjc9DsRJ3qP7H/5VOOBXl6nC1yggayjgr+B0PKdhDjp+z
        q38hHlaJ7WfeO6t1
X-Received: by 10.107.8.71 with SMTP id 68mr6430989ioi.66.1493933784416;
        Thu, 04 May 2017 14:36:24 -0700 (PDT)
Received: from berenguela.cam.broadcom.com ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id a137sm11169716ioe.41.2017.05.04.14.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 14:36:23 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] fast-export: deletion action first
Date:   Thu,  4 May 2017 14:36:19 -0700
Message-Id: <1493933779-25611-1-git-send-email-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20170425055817.codq2q3fd54uebfx@sigill.intra.peff.net>
References: <20170425055817.codq2q3fd54uebfx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The delete operations of the fast-export output should precede any addition
belonging to the same commit, Addition and deletion with the same name
entry could happen in case of file to directory and viceversa.

As an equal comparison doesn't have any deterministic final order,
it's better to keep original diff order input when there is no prefer order
( that's done comparing pointers)

The fast-export sorting was added in 060df62 (fast-export: Fix output
order of D/F changes). That change was made in order to fix the case of
directory to file in the same commit, but it broke the reverse case
(File to directory).

The test "file becomes directory" has been added in order to exercise
the original motivation of the deletion reorder.

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 builtin/fast-export.c  | 32 +++++++++++++++-----------------
 t/t9350-fast-export.sh | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e022063..e82f654 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -260,26 +260,19 @@ static void export_blob(const struct object_id *oid)
 		free(buf);
 }
 
-static int depth_first(const void *a_, const void *b_)
+/*
+ * Compares two diff types to order based on output priorities.
+ */
+static int diff_type_cmp(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
 	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
-	const char *name_a, *name_b;
-	int len_a, len_b, len;
 	int cmp;
 
-	name_a = a->one ? a->one->path : a->two->path;
-	name_b = b->one ? b->one->path : b->two->path;
-
-	len_a = strlen(name_a);
-	len_b = strlen(name_b);
-	len = (len_a < len_b) ? len_a : len_b;
-
-	/* strcmp will sort 'd' before 'd/e', we want 'd/e' before 'd' */
-	cmp = memcmp(name_a, name_b, len);
-	if (cmp)
-		return cmp;
-	cmp = len_b - len_a;
+	/*
+	 * Move Delete entries first so that an addition is always reported after
+	 */
+	cmp = (b->status == DIFF_STATUS_DELETED) - (a->status == DIFF_STATUS_DELETED);
 	if (cmp)
 		return cmp;
 	/*
@@ -287,7 +280,12 @@ static int depth_first(const void *a_, const void *b_)
 	 * appear in the output before it is renamed (e.g., when a file
 	 * was copied and renamed in the same commit).
 	 */
-	return (a->status == 'R') - (b->status == 'R');
+	cmp = (a->status == DIFF_STATUS_RENAMED) - (b->status == DIFF_STATUS_RENAMED);
+	if (cmp)
+		return cmp;
+
+	/* For the remaining cases we keep the original ordering comparing the pointers */
+	return (a-b);
 }
 
 static void print_path_1(const char *path)
@@ -347,7 +345,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 	 * Handle files below a directory first, in case they are all deleted
 	 * and the directory changes to a file or symlink.
 	 */
-	QSORT(q->queue, q->nr, depth_first);
+	QSORT(q->queue, q->nr, diff_type_cmp);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *ospec = q->queue[i]->one;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b5149fd..d4f369a 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -419,6 +419,31 @@ test_expect_success 'directory becomes symlink'        '
 	(cd result && git show master:foo)
 '
 
+test_expect_success 'file becomes directory'  '
+	git init filetodir_orig &&
+	git init --bare filetodir_replica.git &&
+	(
+		cd filetodir_orig &&
+		echo foo > filethendir &&
+		git add filethendir &&
+		test_tick &&
+		git commit -mfile &&
+		git rm filethendir &&
+		mkdir filethendir &&
+		echo bar > filethendir/a &&
+		git add filethendir/a &&
+		test_tick &&
+		git commit -mdir
+	) &&
+	git --git-dir=filetodir_orig/.git fast-export master  |
+		git --git-dir=filetodir_replica.git/ fast-import &&
+	(
+		ORIG=$(git --git-dir=filetodir_orig/.git rev-parse --verify master) &&
+		REPLICA=$(git --git-dir=filetodir_replica.git rev-parse --verify master) &&
+		test $ORIG = $REPLICA
+	)
+'
+
 test_expect_success 'fast-export quotes pathnames' '
 	git init crazy-paths &&
 	(cd crazy-paths &&
-- 
2.1.4

