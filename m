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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2EC4321A
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F2123601
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbhAGVhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE85C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i9so7048390wrc.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4JP1HOJAF5tmslgBv1jJeKDuRrchYeWGkW2hGbQECY0=;
        b=KpzXtijUG5e8jVetzFBxh8rpaUVVRYBsRed22YwC3a7oolo+y/GO7cXsNu++d7q6+Q
         Hr5w1JTrgGK7SJQ5/WRY3Eoggq7D5j86pn2fXqMoZDvhPsGnDjWh9oF8C1lpkahp8j/+
         uAyx35bzFgUSeZXNblG5EYiDQRbh+p+nYdXFJ0BHXedzeQfPnbGQhukztpsparCXLH8v
         vrbL9jD/RihvWAIypMt1fx1CxRPIeHEmEGiUe9manLhGz7W6oqSrDySq9b4WlGEb87S9
         LusqPpufGsDKip9xPFK0ADKlPFsbe9lUrQsnHVymvz6et3/Zh5KpTfX5n94pBf0gYc3w
         q9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4JP1HOJAF5tmslgBv1jJeKDuRrchYeWGkW2hGbQECY0=;
        b=B58CnTeR7RtVtWM3tcomKm0l8mQ61qMMdEdf+q4WE/JyV0jAncCpNFmbyuEbe3Fh0d
         G7+HW6TZoRBlE/GAmmiOw+dxFb+xaFVxo0AQZKhsbZMDoOQfI96q5Igo7b0vRs/CPfKG
         4d5TW2ZtuE02rBcdEH8FkAqGNo6oGRx6+nmaiYZkxPQM9VeXNQnHohKo62ym2vMbWAHI
         ZtdTny20rOvA+NrX1VrfauNLESmfjoMg6W6kNppg01OqvxRvOriANjvzwpRIO8axK8t0
         5sN4PfQf4g7bXbEKnkt7mZnEJcOhBzP2xwkqyk1PO26Xdgk1ocbhsWGxMWOLPXm4LjIT
         hp0Q==
X-Gm-Message-State: AOAM531iWj+YkxOcjfpQ9CgTxIB8tt6MlpweMX4e31CsJ4Pnz1dXlssD
        3YB3Gm5Tz52siuym/7gbcq3JVxQZiTs=
X-Google-Smtp-Source: ABdhPJzB+dJLUafIIizABEHMejyHjaFb9kQ8p6BhfBuuwlR3uxUIj/mJIfbPD4ngEmS6c9LgPUFq5A==
X-Received: by 2002:adf:902a:: with SMTP id h39mr524180wrh.147.1610055375332;
        Thu, 07 Jan 2021 13:36:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm11346580wrx.36.2021.01.07.13.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:14 -0800 (PST)
Message-Id: <1e48cde01b9e2fe24eeda063e0298db8421b13a7.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:55 +0000
Subject: [PATCH v2 07/17] merge-ort: implement compute_rename_counts()
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

This function is based on the first half of get_directory_renames() from
merge-recursive.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7e0cc597055..a8fcc026031 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,7 +721,6 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
-MAYBE_UNUSED
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -825,11 +824,61 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
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

