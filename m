Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49652C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CD764EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBZB7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBZB7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E5C06178A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3so6188740wmc.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CRNA0pU7+YqSbGzj+hSCPyU0giCp3XplesYi9Yz6SbY=;
        b=SnqZWlAUoWM1QoF7AY1MER6iyBOihQ41TgTeeH4u71yO4znbJhw0eLAapUUauwvigc
         ra2ERoMDG7IFztMZDCEJUtrftrQst+J5Ky8IWlal8hHQ17s+qYMKwwdBoZmC5cVHrXP0
         ATFpuWLXxkfUB2+TCGPtLHqFWlLwfuCIyudJ8ESlnuTvI44u45KVA+C749qNyiUfA7PV
         ao4pUkz1FGH6ZIE3hePrJDhXEH+vIKVATMDgPECQaYv7XTIb7yFvBmXrLrgi9COXufal
         8pIF09pak7HRueVGR5kW6LnxGPLZ7DNXq4UkiEkQQ+a70UnhzqsRG4R00ncFOeARV6YS
         Vf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CRNA0pU7+YqSbGzj+hSCPyU0giCp3XplesYi9Yz6SbY=;
        b=b9LJFS4Pz+i3NnNAu2LAfDlR//aMTbAXSzM/ItRLH6xwQbo2gqF9YRxx/x2XecdgaD
         8k7ywrWtJvi5GFTvnyTB6L7bkx1g/CA4Y5SwAevAHRH/r40FpfCl+Ft8lOkZskQ8co4f
         IGOIc0AkjHJWXWY4XPOagdaI51+OquEPE962+oOxxGWDXJSkLtbMrwz739ZQ9TctMHxJ
         fEJsflYvrkZSusv/eFevAlZ7hP/2gUyaDvHt5koBm5hZPZ20ds5lSdhNu6JH92lWZFSL
         J7O1uDqpxfkaqiIAINssG2DCoaxaI4vv7PkhC4lC46gOa38u6TclG5DSFFP5Ktv3xe1w
         rOSw==
X-Gm-Message-State: AOAM530CaomG6wdfm+HFPhgKCn/a6NXFP1K3/pMSMbzoUTcUCmJjh72q
        T6zIZrhZwS0eRbUVSScTWWrnqOQFMh8=
X-Google-Smtp-Source: ABdhPJy6CFbdrog29JCaNCYOqAI/aBRynbWjK1ZFDqAj0bs5TBTc97xB2FD5ibg9Qm/+T+UErP9fYA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr412660wmc.162.1614304705937;
        Thu, 25 Feb 2021 17:58:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a131sm10134486wmc.48.2021.02.25.17.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:25 -0800 (PST)
Message-Id: <f286e89464ea83c1972eb93ca04e54f9c0568a53.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:14 +0000
Subject: [PATCH v3 05/10] diffcore-rename: add function for clearing
 dir_rename_count
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

As we adjust the usage of dir_rename_count we want to have a function
for clearing, or partially clearing it out.  Add a
partial_clear_dir_rename_count() function for this purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 12 ++++++++++++
 diffcore.h        |  2 ++
 merge-ort.c       | 12 +++---------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 39e23d57e7bc..7dd475ff9a9f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -528,6 +528,18 @@ static void initialize_dir_rename_info(struct dir_rename_info *info)
 	}
 }
 
+void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(dir_rename_count, &iter, entry) {
+		struct strintmap *counts = entry->value;
+		strintmap_clear(counts);
+	}
+	strmap_partial_clear(dir_rename_count, 1);
+}
+
 static void cleanup_dir_rename_info(struct dir_rename_info *info)
 {
 	if (!info->setup)
diff --git a/diffcore.h b/diffcore.h
index db55d3853071..c6ba64abd198 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -161,6 +161,8 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
 				 struct diff_filespec *);
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
+
 void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
diff --git a/merge-ort.c b/merge-ort.c
index c4467e073b45..467404cc0a35 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -351,17 +351,11 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
-		struct hashmap_iter iter;
-		struct strmap_entry *entry;
-
 		strset_func(&renames->dirs_removed[i]);
 
-		strmap_for_each_entry(&renames->dir_rename_count[i],
-				      &iter, entry) {
-			struct strintmap *counts = entry->value;
-			strintmap_clear(counts);
-		}
-		strmap_func(&renames->dir_rename_count[i], 1);
+		partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
+		if (!reinitialize)
+			strmap_clear(&renames->dir_rename_count[i], 1);
 
 		strmap_func(&renames->dir_renames[i], 0);
 	}
-- 
gitgitgadget

