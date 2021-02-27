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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D2BC433E6
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2AE64E4E
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhB0AcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB0AcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499ACC06178B
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id x16so8651973wmk.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=thfVd0tHN5z+Pv8zu46+TgGQ7hsjp/64gQDt7RDlSeQ=;
        b=l50olkwpGrVg1gDXGo1tn6DRhSubqpjQa779BoFgrnpmoSV8ixgRsVdwSX4xZdYxIw
         Qrni24EIuT13M6SI6JHrl9WpIdvvzpzAXHfSYt481SzjgiBSaTfIJwVdzlpwLkgUW+4v
         D4L6CFpR++Vze+e5WBe9pYAUtKUXTQGir3v6AriO49GMJXiJtGiuPpSS8cFJkgF/+Y8p
         0kNH+XcunXPJaVBqSfmyAkEDi+n3C2F+6erruSyfWzY7xV4nZ321X36ZXav11yVIau3s
         IJYAUhiZrq8Vvi/gzhy6/5ECtvEi1yg02XbNzr9LB9IJZMgZYYNjHlmsgkFaqfSLvrar
         3lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=thfVd0tHN5z+Pv8zu46+TgGQ7hsjp/64gQDt7RDlSeQ=;
        b=aw9BZAGX7VgDTWNJENoJJ/fnoNdyNx/76+B0mZOYzYzxdE5FTBQ5u1hduydDsLN+EZ
         1o1+J8yDYrb2iw5oZeSp1DD2j9fswJdjjOGe9hR7sirDKrNoi00pnIcCMZzC9fi7PN5P
         Qhv/4waZUXvWte5izTLvYtQaFROZESo6w6diUXG6/YiX1nE1F3R7tekmofPjytMxiIRp
         kF07pptMXyCVffmTR9kBjpKARFVxU4cyCpugA60kMTvovSLyRRXGa68YYwI3imgLY4YB
         wAKoBr2efeqJgF3efGWgNX5eMerI4nZsycH0Jc3cxu8P+PH7bjB48/VelPLKzD9mwXOt
         8gxA==
X-Gm-Message-State: AOAM533Df/Cyw5PTMi/uOPMpnEzJQE8x7pb2Ys2M99ghEuBneD7YrJ0x
        uZNzq1YkhCSglzUAkskl+/1F4AV2f18=
X-Google-Smtp-Source: ABdhPJydG8mnKELqArRSZcIp2Jp5e31zHhf6VnMUsFGc2YY4vHIaEwISPvuG9+JtUy3bRuGwctowuQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr4881434wmc.124.1614385854075;
        Fri, 26 Feb 2021 16:30:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm15719961wrv.6.2021.02.26.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:53 -0800 (PST)
Message-Id: <2baf39d82f3ed40925addd778356b143f516f157.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:43 +0000
Subject: [PATCH v4 05/10] diffcore-rename: add function for clearing
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
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

