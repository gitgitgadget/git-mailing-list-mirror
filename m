Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED03C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A529E64E4E
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhB0AcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB0AcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1355C06178C
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so10232615wrx.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z1A+8EyXFNW1JMng/HVEyaSUwKmkK6DIAI/dLN1n5Xw=;
        b=NEwQOS1trb0ULDjthR6is2LQoVgfpor01w8olY/EBCctDFwJiciCTVZgkYe/UKL+8D
         YZ5n7uE8Goc8WIyBmXlZpi5TcGLqnDM5FjK4xiD4jPbdVjll629Z2uHX2EpOHFLzx6+a
         YqDqf7xJ8Ej2IkM6wF9k4yu+8RpEwFhURpq547HEBDkWavRlA/Layw+eNvGf0aOSfcRr
         1GiGfgQa9DTuAvAtIQvQCE/XzRul5ty9zNUlH0WINfj0Ylytgt3Xpp7o7D+bdNV7kEKx
         T6UuYmZa2+BHwvwj+H3UGW6ovBbu7veQ9ZHfbvEgwdR1vGDUYMOUf9ezW5lzYueL3o1r
         pQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z1A+8EyXFNW1JMng/HVEyaSUwKmkK6DIAI/dLN1n5Xw=;
        b=hzYe2Y0fmFeMFyeXqHA/SPSDGuI+4ayhir9ttqa82y3SDZWvVNFWyauYMXsL3dX0UW
         ziEJgnrcEMFagdKZUBmMQBrUr4BGO8OF4f01OKsfoVMTB0ftJTQJcEJyXOccFvpPgqaO
         yxdEL2X9wAAiRCUagkNhd6uHo/9J5aSClfcMpesv7zt1Q9fBXZxj78KSfaZNjlxOrg/p
         wC245igtP0GG7LCMGJ52QyUWm/KFhTZ5TdBzLI2Df/Nij+zoztuTkY4mKdOMQtQt4tWm
         KxbPTZ8WhyhC145WGzeajRbH1q60hecovcUbZa9erDgt3zBbiEoFV2PLXOA2t3hEanWS
         RH5A==
X-Gm-Message-State: AOAM533sAxrAcc7hg56pye1IBFRrPtX8792aXafp/NVD7+okhIMZXVnT
        cFraftWW23yQ74LLZ229Aa+R/Ec0VmU=
X-Google-Smtp-Source: ABdhPJzsMGkjSI6DtaAazb4aiPV2VRjacwKf4oR8Nkt74SmNqVUeAOlSi4iKresC8NAd6TcPnMZMBw==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr5749299wrn.17.1614385854665;
        Fri, 26 Feb 2021 16:30:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm13688979wmk.32.2021.02.26.16.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:54 -0800 (PST)
Message-Id: <02f1f7c02d32dc37813abf5fcf767cc374b17fd3.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:44 +0000
Subject: [PATCH v4 06/10] diffcore-rename: move dir_rename_counts into
 dir_rename_info struct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This continues the migration of the directory rename detection code into
diffcore-rename, now taking the simple step of combining it with the
dir_rename_info struct.  Future commits will then make dir_rename_counts
be computed in stages, and add computation of dir_rename_guess.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7dd475ff9a9f..a1ccf14001f5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -388,7 +388,7 @@ static void dirname_munge(char *filename)
 	*slash = '\0';
 }
 
-static void increment_count(struct strmap *dir_rename_count,
+static void increment_count(struct dir_rename_info *info,
 			    char *old_dir,
 			    char *new_dir)
 {
@@ -396,20 +396,20 @@ static void increment_count(struct strmap *dir_rename_count,
 	struct strmap_entry *e;
 
 	/* Get the {new_dirs -> counts} mapping using old_dir */
-	e = strmap_get_entry(dir_rename_count, old_dir);
+	e = strmap_get_entry(info->dir_rename_count, old_dir);
 	if (e) {
 		counts = e->value;
 	} else {
 		counts = xmalloc(sizeof(*counts));
 		strintmap_init_with_options(counts, 0, NULL, 1);
-		strmap_put(dir_rename_count, old_dir, counts);
+		strmap_put(info->dir_rename_count, old_dir, counts);
 	}
 
 	/* Increment the count for new_dir */
 	strintmap_incr(counts, new_dir, 1);
 }
 
-static void update_dir_rename_counts(struct strmap *dir_rename_count,
+static void update_dir_rename_counts(struct dir_rename_info *info,
 				     struct strset *dirs_removed,
 				     const char *oldname,
 				     const char *newname)
@@ -463,7 +463,7 @@ static void update_dir_rename_counts(struct strmap *dir_rename_count,
 		}
 
 		if (strset_contains(dirs_removed, old_dir))
-			increment_count(dir_rename_count, old_dir, new_dir);
+			increment_count(info, old_dir, new_dir);
 		else
 			break;
 
@@ -479,12 +479,15 @@ static void update_dir_rename_counts(struct strmap *dir_rename_count,
 	free(new_dir);
 }
 
-static void compute_dir_rename_counts(struct strmap *dir_rename_count,
-				      struct strset *dirs_removed)
+static void compute_dir_rename_counts(struct dir_rename_info *info,
+				      struct strset *dirs_removed,
+				      struct strmap *dir_rename_count)
 {
 	int i;
 
-	/* Set up dir_rename_count */
+	info->setup = 1;
+	info->dir_rename_count = dir_rename_count;
+
 	for (i = 0; i < rename_dst_nr; ++i) {
 		/* File not part of directory rename counts if not a rename */
 		if (!rename_dst[i].is_rename)
@@ -497,7 +500,7 @@ static void compute_dir_rename_counts(struct strmap *dir_rename_count,
 		 * the old filename and the new filename and count how many
 		 * times that pairing occurs.
 		 */
-		update_dir_rename_counts(dir_rename_count, dirs_removed,
+		update_dir_rename_counts(info, dirs_removed,
 					 rename_dst[i].p->one->path,
 					 rename_dst[i].p->two->path);
 	}
@@ -551,7 +554,9 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info)
 	/* dir_rename_guess */
 	strmap_clear(&info->dir_rename_guess, 1);
 
-	/* Nothing to do for dir_rename_count, yet */
+	/* dir_rename_count */
+	partial_clear_dir_rename_count(info->dir_rename_count);
+	strmap_clear(info->dir_rename_count, 1);
 }
 
 static const char *get_basename(const char *filename)
@@ -1140,7 +1145,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	/*
 	 * Now that renames have been computed, compute dir_rename_count */
 	if (dirs_removed && dir_rename_count)
-		compute_dir_rename_counts(dir_rename_count, dirs_removed);
+		compute_dir_rename_counts(&info, dirs_removed, dir_rename_count);
 
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
-- 
gitgitgadget

