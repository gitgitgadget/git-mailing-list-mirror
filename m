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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6942C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6715723104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391760AbhASUAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391966AbhASTzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3DC0613ED
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y187so832614wmd.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O5wTBKeWiHf7mJrnNho3TBC79jlaWAJ7FeqyH8aQJ/4=;
        b=bHP4ZTsnItQT2MmZX7LPWb78TTIx2ZIS1DUhG5SL8qnadpCnd63O9phqPpnlwSqxau
         Bp1auFbyoFVhivSIr8WUsn5ThYTZ6JdC7DCCXFyM0EN2ewjIS15UksF+U/IojDxZEeNW
         ksfQzq0s4BaPzPO3XXoZzqjNnwrnXUP0p3zbAasWeUOebQWkVg0dhWJvIuTQKnL4RFrb
         1q+/+LXICOJVV9NHiG8MHsx+YBkJjZRxN5vA4xdmyeknu9iUn8f2T/p5TwIo4TYkj9UI
         xZBrClDIp10AIdGpKoIzjl58lRr5DF3lgA0DmaoqGeqKSCbzTD2XRnqz6+IQLbwvqgee
         fMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O5wTBKeWiHf7mJrnNho3TBC79jlaWAJ7FeqyH8aQJ/4=;
        b=Ra7dQXR1L4ffZYrpUpql+ASdwswgx5MV0sdidEPKhBRphNslqoRTZytweRxYvT5W4s
         cMYTm7TFhISQ128E3XdIyI8GmlC+x/udYpuDQazrcMO52IguAVDH0AtoYDQreQLIApe9
         yalC5LicZDlO8lWK9EerMNr2xwlMuEaPCCNtjJRCcqopVukZVm/MipfwMkid1wfjhk+L
         Haa9TM7WZiZ3Sa0uPsa6EnNRrBiqndlLMTpYNp+l6d0zGfjqRFG5xplJwNJ5sHD2YABD
         sHWgRTJboz1nKB22YTZDXJGPP1khldvWX4xNVcPPMrHglAeKKnEBVmYVVnbMXazYUgYq
         Oirg==
X-Gm-Message-State: AOAM532DHxNZMildCnryFsAfOdUTcb3i4BqrWh7wYtwfLDX1BvnwQbkw
        KMRQ3cEo/plyNKz5shFcFC9RGzHnOnc=
X-Google-Smtp-Source: ABdhPJzrgZajrhBvJ2BrkpcB7TTkd0oyVh6/0CPm/8tSnvjk5w+00NpIFlV8nNMnAAiCIqXhUfhdvg==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr1081558wmq.93.1611086041069;
        Tue, 19 Jan 2021 11:54:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm39748893wrp.56.2021.01.19.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:00 -0800 (PST)
Message-Id: <5b5c8368174179272b67659d9babd251fbf07497.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:43 +0000
Subject: [PATCH v3 07/17] merge-ort: implement compute_rename_counts()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This function is based on the first half of get_directory_renames() from
merge-recursive.c; as part of the implementation, factor out a routine,
increment_count(), to update the bookkeeping to track the number of
items renamed into new directories.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index eb609ab0063..8aa415c542f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,7 +721,6 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
-MAYBE_UNUSED
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -825,11 +824,62 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
+static void increment_count(struct strmap *dir_rename_count,
+			    char *old_dir,
+			    char *new_dir)
+{
+	struct strintmap *counts;
+	struct strmap_entry *e;
+
+	/* Get the {new_dirs -> counts} mapping using old_dir */
+	e = strmap_get_entry(dir_rename_count, old_dir);
+	if (e) {
+		counts = e->value;
+	} else {
+		counts = xmalloc(sizeof(*counts));
+		strintmap_init_with_options(counts, 0, NULL, 1);
+		strmap_put(dir_rename_count, old_dir, counts);
+	}
+
+	/* Increment the count for new_dir */
+	strintmap_incr(counts, new_dir, 1);
+}
+
 static void compute_rename_counts(struct diff_queue_struct *pairs,
 				  struct strmap *dir_rename_count,
 				  struct strset *dirs_removed)
 {
-	die("Not yet implemented!");
+	int i;
+
+	for (i = 0; i < pairs->nr; ++i) {
+		char *old_dir, *new_dir;
+		struct diff_filepair *pair = pairs->queue[i];
+
+		/* File not part of directory rename if it wasn't renamed */
+		if (pair->status != 'R')
+			continue;
+
+		/* Get the old and new directory names */
+		get_renamed_dir_portion(pair->one->path, pair->two->path,
+					&old_dir,        &new_dir);
+		if (!old_dir)
+			/* Directory didn't change at all; ignore this one. */
+			continue;
+
+		/*
+		 * Make dir_rename_count contain a map of a map:
+		 *   old_directory -> {new_directory -> count}
+		 * In other words, for every pair look at the directories for
+		 * the old filename and the new filename and count how many
+		 * times that pairing occurs.
+		 */
+		if (strset_contains(dirs_removed, old_dir))
+			increment_count(dir_rename_count, old_dir, new_dir);
+
+		/* Free resources we don't need anymore */
+		free(old_dir);
+		free(new_dir);
+	}
 }
 
 static void get_provisional_directory_renames(struct merge_options *opt,
-- 
gitgitgadget

