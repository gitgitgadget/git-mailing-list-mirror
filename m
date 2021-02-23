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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF83C43381
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76E964E57
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhBWXyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhBWXrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:47:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0AFC061797
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3so288669wmc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fVtGL9oxPIeXkpNd5TvKQjAWx6Z6VstTh0BJNl3lABw=;
        b=l5N9PfYh5xPLxA8MpjIUmizN/BCgqh1i11R7NaEBrI/FJiBTG/DBpQGOG0JqVGSZxA
         ecQQjxpYXmO6TiqkVinjofmy3F7OznG4Beevp5w1vdmKGKUakgct3ssiwcp7/UBeTpA0
         psA/quQGX/uD/PzMJXkfxGZTMAHA1YppeT8v/jgNDWDD5rV9ogz7jkMeKRWYFEL9KyDZ
         kovBe8oNAGfSu/AELPTYqLD+7sslftv0dg3M/H8AKrGKUWD1bcmQvNfUrClQ8AR87q9V
         YM6C40wY+uw5qG+1xc/tN1NDzZO7kfCN7WvCjxgHhYuH5dd9FQGVkwfDs7DLezEC/z5c
         3CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fVtGL9oxPIeXkpNd5TvKQjAWx6Z6VstTh0BJNl3lABw=;
        b=IlGNmGt7j2URWfCtDs18qpIJbEJujJ1j7gTLEY36EbY1etGrMlqrDklChe5BIgI8dT
         1rLETc0rAZRj6r/7ofYpF52oYgy8BScAAlFvcqg2JZ5qW0TwFlUEFsHX+vWZOjETTOHq
         pFjqKmfu/6bqlERPhHbPV61awi9xBL4kx7nOAcyQQrEKvO4Wk0rY6v3fbRhSh4OEN0kA
         627Vm0khe6KAOBJW0IKZQWiv57Mr+Xv9dahq2fiEl3msVv3Qpg57wa/07YSDGyAjx2Ea
         j9sGjFyoLwNA51A1C5nx+2IWYWwva3f4uaXRneGmHhQVZFWNTnfzJ+ixNbqpR2WkCdVK
         A4lQ==
X-Gm-Message-State: AOAM532rT6Ug7w8ZAF5SfalqD7ybH/N47KzDLC8jiydd5EGC5f5lK6uv
        Hc6EjnKNsgeV0Y9xYp55KBnHXOTQahs=
X-Google-Smtp-Source: ABdhPJxnTZR/n5LvMO7HnpA0gWJGJ2Sv5yo7CR4BT8LpSBDLZBbUdYan8COL5+ZeiSfF3qGgPZbwSw==
X-Received: by 2002:a1c:a985:: with SMTP id s127mr998584wme.158.1614123852884;
        Tue, 23 Feb 2021 15:44:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s124sm155665wms.40.2021.02.23.15.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:12 -0800 (PST)
Message-Id: <dffecc064dd36d9ba3885d947e544a2ce010a01d.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:44:03 +0000
Subject: [PATCH v2 06/10] diffcore-rename: add a mapping of destination names
 to their indices
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

Add an idx_map member to struct dir_rename_info, which tracks a mapping
of the full filename to the index within rename_dst where that filename
is found.  We will later use this for quickly finding an array entry in
rename_dst given the pathname.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 489e9cb0871e..db569e4a0b0a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -368,6 +368,7 @@ static int find_exact_renames(struct diff_options *options)
 }
 
 struct dir_rename_info {
+	struct strintmap idx_map;
 	struct strmap *dir_rename_count;
 	unsigned setup;
 };
@@ -509,10 +510,26 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 		info->dir_rename_count = xmalloc(sizeof(*dir_rename_count));
 		strmap_init(info->dir_rename_count);
 	}
+	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
 
+	/*
+	 * Loop setting up both info->idx_map, and doing setup of
+	 * info->dir_rename_count.
+	 */
 	for (i = 0; i < rename_dst_nr; ++i) {
 		/*
-		 * Make dir_rename_count contain a map of a map:
+		 * For non-renamed files, make idx_map contain mapping of
+		 *   filename -> index (index within rename_dst, that is)
+		 */
+		if (!rename_dst[i].is_rename) {
+			char *filename = rename_dst[i].p->two->path;
+			strintmap_set(&info->idx_map, filename, i);
+			continue;
+		}
+
+		/*
+		 * For everything else (i.e. renamed files), make
+		 * dir_rename_count contain a map of a map:
 		 *   old_directory -> {new_directory -> count}
 		 * In other words, for every pair look at the directories for
 		 * the old filename and the new filename and count how many
@@ -546,6 +563,9 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	if (!info->setup)
 		return;
 
+	/* idx_map */
+	strintmap_clear(&info->idx_map);
+
 	if (!keep_dir_rename_count) {
 		partial_clear_dir_rename_count(info->dir_rename_count);
 		strmap_clear(info->dir_rename_count, 1);
-- 
gitgitgadget

