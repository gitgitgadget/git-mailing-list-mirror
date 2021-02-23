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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DCAC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C8764E85
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhBWXvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhBWXoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:44:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB5C06178B
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w7so277595wmb.5
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dtn2wkmX7msgWH+66SXQpt+Ko4iDx/XxyOyo9sZP6QE=;
        b=TzigRVTeSaWvFy/Tu7F+iz3Wat9dY22lCmQ+21L9SpGirCv1neKmL0BXmD096NpY61
         HD72vHTVp+gYOnb/TdNZ7EKkzS/PFmTyxumDegGf9Voja+Nq8cg/PMewJaXK8Q8qpjnL
         viz5c2ittyHOzAH40iCHL1ms7Ju5Sy2zE4tOOSVJUZutf7RXwYr8TH/rprHKXfPAoydH
         uQOGi136ik/ElKD3we2Ljbmig/4hxcr6XwEuZ0F/Ceqso6xE8iRU/juvC6qAuTtevU2b
         AE6UQ9uVrMhZwNHXDfCqKpTBBzP2fennTLMeQLVGnLLdCCKWRA80zZ8L1EF5w0iF19VF
         8Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dtn2wkmX7msgWH+66SXQpt+Ko4iDx/XxyOyo9sZP6QE=;
        b=o1X+Hp6kgNKk5oSVwJRoOHXNvhXwIxIFhoJ1knPHd8RqAntYjeVNR96i1vuwA/K0cF
         CxlHdG5F2OvjQRll9GrmPGFjxZZqLu83iAMH4fcFEVjagvv1FxulYBBMIJovTFAx60LS
         YvLE5b4PH81FGTPqgO8kl1sU9UiSoRImOi9KL3Om1znFm+3lPJo8sL969dcC3dWiGhY9
         FcmVyyfU1eDk8pVtlbKLx71PWyEXZdrxJ4EE753yesfnIExnVTJWLhL7xpu3Yz1+aD1f
         tWM8OmqqQ0cYxxDZO2habtsZAPxaprz/LMsbLY9ze5yg1+hjiXFQCt8XFpCDbps+FzDE
         fs/Q==
X-Gm-Message-State: AOAM531RPESA6JPGSZ4xk/duAitKruAukuNGwj5jVBTINYWhRmht5kP3
        bVtkNRQghg+IZYjpiqoEcgvTbozkjLM=
X-Google-Smtp-Source: ABdhPJyWJb/hfEc7VVyqfiqpyCx5NQFVtAiNMcVC3tyXu5XcJu+l+xEYKvcnY6lZLEf6cfjdA3rThg==
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr966996wmg.183.1614123850642;
        Tue, 23 Feb 2021 15:44:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm164330wmc.29.2021.02.23.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:10 -0800 (PST)
Message-Id: <612da82f049cbe877cf924f743a3e4059483ce51.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:43:59 +0000
Subject: [PATCH v2 02/10] diffcore-rename: add functions for clearing
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

