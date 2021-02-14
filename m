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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E9C433E6
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0833E64E43
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBNH75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBNH7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:59:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09DFC0613D6
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:07 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l17so3515881wmq.2
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dtn2wkmX7msgWH+66SXQpt+Ko4iDx/XxyOyo9sZP6QE=;
        b=fFZPtdD0ATBR5bOs7KRGX1nve8DPRv7AQERZ0SRrDH9gTZ8i5tnRCeWKV3NBG172JT
         lLThCWWxaBm9gLu7jwbstWu4MJjUdgoMNEok9MB4SxLgPIsAmXrWRxepGL01XnFiUBpi
         qLvqCl/VtCjfQW7dBa/M8sAqZ7ENItvDD1H5ljqjEHD7TU2KW1t3Y6YxvZd7gh0xflhM
         SvaQy0tXuYhyTq/rN1v5WJzRq9RcnLHG5k7djLsTlaaKA39UaLn8Xi1rdQY5MrMRwn4O
         KXPwXSEvlZAOWumI5+TU54RN8CDicGkQzttYycBS7Q/Yw76f36LpjT2mWv7/kUr+kfsD
         gRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dtn2wkmX7msgWH+66SXQpt+Ko4iDx/XxyOyo9sZP6QE=;
        b=lfiH6nlrrlu0LclgQZMvQvzef77osmOcblTBRsNFTOwBguR+OOq0XgxIW7fJf3QG34
         +o7/q6Kxu7Oj+PjugpWbDtiHvi6kUa5HQcl9tIGOtNhDM7IO08gT46umSZcWfZs60t/u
         43LfflHGRNxBYRlMVUWruhB031EuGh5kL/2biecYg8Jb4vSQ+4OH9pM1H2sJGU73XbwX
         82fJSmkrFmlKWcbN/d9rYmLKJKFv+ZsSfAXkTGwrA+SKGJKMJkjiE8BS05IH7kZfRUG6
         qWiSszJN7ywN7A19KI/vXH+7dLUa1vZ0SXrXitq8RY/Po30heNFNASqa2QLtsQ3ylDDc
         Ls6g==
X-Gm-Message-State: AOAM5320hIgxVU5jxVuJCkeeyftqREvnXpJR7etBH/QbHiue/P0SHliA
        qqcBQKiWgauH6RsF8XPlGocheGYyUj4=
X-Google-Smtp-Source: ABdhPJxNBWmIfVQiTIgOKEtxl1W0jgVszF4XfzAku4wIVYR2a9nXHt66mVu/RMSY5VgbTvho4Tp8GA==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr2162065wmh.1.1613289546428;
        Sat, 13 Feb 2021 23:59:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm5209191wrr.29.2021.02.13.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:06 -0800 (PST)
Message-Id: <612da82f049cbe877cf924f743a3e4059483ce51.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:58:55 +0000
Subject: [PATCH 02/10] diffcore-rename: add functions for clearing
 dir_rename_count
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

As we adjust the usage of dir_rename_count we want to have functions for
clearing, or partially clearing it out.  Add such functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 19 +++++++++++++++++++
 diffcore.h        |  2 ++
 merge-ort.c       | 12 +++---------
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 33cfc5848611..614a8d63012d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -486,6 +486,25 @@ static void compute_dir_rename_counts(struct strmap *dir_rename_count,
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
+MAYBE_UNUSED
+static void clear_dir_rename_count(struct strmap *dir_rename_count)
+{
+	partial_clear_dir_rename_count(dir_rename_count);
+	strmap_clear(dir_rename_count, 1);
+}
+
 static const char *get_basename(const char *filename)
 {
 	/*
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

