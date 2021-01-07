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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A2EC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7AD235E4
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbhAGUCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbhAGUCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A39C0612FB
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r7so6824613wrc.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2Tke+PYbrPjdh/VepLSu52qSdEUam57Tg136FE7V/g=;
        b=MM9il2W9kHJqw10TYgdenggIMtapdgVN4F3WpUNzKslcaGKW7iJX9ffb9NYfnFG6TA
         9IRIgu1w50DxkyH2LH9IW7EObEdv8xMr3roLd8clOrGwZdlX/JMPdMNR/K40ylQEoipZ
         F96L6Iqe3rxa2b6Y2qrK1A5Nm4fCSJe5paStwmRL1BgYdPp1yGmVQRqzkTp7/ST4fA75
         S5g30RmgQxaML8lENEEZ+WOhaA0tuoaLdhS7vR3/2oOFA9XFFUEzOolB+0ch9padWfvN
         hgpAyEYD/TKmBSeyJfbm+pZ5Des0X1F63GpgJ3jaqq6LTE3va3J9+kkS1DgxmvTg+hj9
         Uy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b2Tke+PYbrPjdh/VepLSu52qSdEUam57Tg136FE7V/g=;
        b=cqlLLPgbwRw2g/9iXPfFhR9M+RfVb71IknPqgyOuue+3GKk8wELOjVbFoPqSE8HWUz
         PWdsC5qaQXQ4H51oyTgsMA5KfTpZd3GEkjgKlaYcKxLNrpRZFKnlYQsNedG1aIyfxr1I
         SCU+bmWGAMq+onZvC/SBWQILc5mgTdzGZVmq0xeQaN7ajqgEmQRXYtGla1wWltx19NuW
         VCORWHZtXsn7WSUxk669YEUmJrnkBjpkGIw0ydI/pKZgw0BB3wUuUvM1wCsirb0IxQrn
         pjGzCgzrVgAmBD3LmeNUnZR8Jia8XsC/CQUe762sg8oT/9tORw3DtJjk2Nlbjho+HRGm
         U3Yw==
X-Gm-Message-State: AOAM533yMjw34XT5MNTJ5wXAiUDiajLiurcxGEqjTliuj6Ydl0mnkfGu
        rR5yT9d4O5Bac/kat7pkC7zd+h7sZoM=
X-Google-Smtp-Source: ABdhPJwS/iJur4r3cfRO/M/fZZjGn92rwJ6oWn0CNpk60E8eTzaBwMQ2+tol+D3Sb9kW1s3TkZT0bQ==
X-Received: by 2002:a5d:4242:: with SMTP id s2mr256449wrr.187.1610049693798;
        Thu, 07 Jan 2021 12:01:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm9043083wmb.41.2021.01.07.12.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:33 -0800 (PST)
Message-Id: <bb4285250cdef2fcd16a22f8540968c871302c9f.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:14 +0000
Subject: [PATCH 05/18] merge-ort: add outline of
 get_provisional_directory_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This function is based on merge-recursive.c's get_directory_renames(),
except that the first half has been split out into a not-yet-implemented
compute_rename_counts().  The primary difference here is our lack of the
non_unique_new_dir boolean in our strmap.  The lack of that field will
at first cause us to fail testcase 2b of t6423; however, future
optimizations will obviate the need for that ugly field so we have just
left it out.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 378ac495d09..73d3ff97f52 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,11 +721,69 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
+static void compute_rename_counts(struct diff_queue_struct *pairs,
+				  struct strmap *dir_rename_count,
+				  struct strset *dirs_removed)
+{
+	die("Not yet implemented!");
+}
+
 static void get_provisional_directory_renames(struct merge_options *opt,
 					      unsigned side,
 					      int *clean)
 {
-	die("Not yet implemented!");
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct rename_info *renames = &opt->priv->renames;
+
+	compute_rename_counts(&renames->pairs[side],
+			      &renames->dir_rename_count[side],
+			      &renames->dirs_removed[side]);
+	/*
+	 * Collapse
+	 *    dir_rename_count: old_directory -> {new_directory -> count}
+	 * down to
+	 *    dir_renames: old_directory -> best_new_directory
+	 * where best_new_directory is the one with the unique highest count.
+	 */
+	strmap_for_each_entry(&renames->dir_rename_count[side], &iter, entry) {
+		const char *source_dir = entry->key;
+		struct strintmap *counts = entry->value;
+		struct hashmap_iter count_iter;
+		struct strmap_entry *count_entry;
+		int max = 0;
+		int bad_max = 0;
+		const char *best = NULL;
+
+		strintmap_for_each_entry(counts, &count_iter, count_entry) {
+			const char *target_dir = count_entry->key;
+			intptr_t count = (intptr_t)count_entry->value;
+
+			if (count == max)
+				bad_max = max;
+			else if (count > max) {
+				max = count;
+				best = target_dir;
+			}
+		}
+
+		if (max == 0)
+			continue;
+
+		if (bad_max == max) {
+			path_msg(opt, source_dir, 0,
+			       _("CONFLICT (directory rename split): "
+				 "Unclear where to rename %s to; it was "
+				 "renamed to multiple other directories, with "
+				 "no destination getting a majority of the "
+				 "files."),
+			       source_dir);
+			*clean &= 0;
+		} else {
+			strmap_put(&renames->dir_renames[side],
+				   source_dir, (void*)best);
+		}
+	}
 }
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
-- 
gitgitgadget

