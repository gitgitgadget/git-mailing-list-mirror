Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADBBC4332B
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B6522519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbhADXvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbhADXvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:17 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380DCC06179F
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:37 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id q25so27699869otn.10
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSa86NgttJOKxMMPzERywp7Xg2m01EcqQ8oR72Q8BZo=;
        b=ptCvtjrW80vWG3ECa+3QV4WGC+UJbNKFeuc1/VvCToRRt9cgeOSLAJcMUrWFje9p0u
         44zxKB8P1aRhIoIDm1p4/lOeA3JoMy02jxAWclHmHTX2P2OMGuAoM7JLugQfh0DDgfmP
         Mi1Qj1daA7Yd+AL/lYy7hihzKOfzOldc5VjVkwpwnOzS6eMlohurK07fmhBMqstkjZ1p
         hr+EkKgRMIY+A0DmtROREFwHcxs6DIEf49Uh8hRl1RtssVsrbDGtL7Ko84bG2gD3x7D+
         qTNviYjw0dCBQMCyJQtmJVj1soufgyQ9uEN/QtkaQxp7hsGAycNfm+CHRiMKv6dgstiX
         UWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSa86NgttJOKxMMPzERywp7Xg2m01EcqQ8oR72Q8BZo=;
        b=AvKKUOVkI9BA2/fK74Dj2fj2R1IaI2Xwfz2ZucE4sJF7HxgQDQk8yJOa4WTaqvebhG
         92gZPi8T84Oz9dRVC8ot5d5EhcWb2Jw8JGglDvvF6iauUfXCNbwVCAUBPTQZXSDUW8P+
         oW/L1f6l5aIkvJDWGgxujjthRKJaSZxHUsLTrqNZHeIh7gCRVw0SHeD9z8+sfvnbFvR8
         qF0NOOGcCI2xKHMCI1lwGz1NB5hAGxT1Owxklksc/o9wk7AnZntvs621XcbPWo1sl6S7
         4QYh3WMzU8mB5MgXetYcdgphwzDe4w67sB4PpOaBWb3jFF+WSc6m8m6o2GCRBEzqFFXm
         qhtQ==
X-Gm-Message-State: AOAM53382uTMCt0lYbzl3v795y3vDmSaYLpsJ1FTHORXCitIRe5svvf7
        RKlI6YCmBl5U4olIY6wDjpLw0xdmdWs=
X-Google-Smtp-Source: ABdhPJyRPFnVkCwE+D3O6Bjo1qmRbGySCG7FuANqkyhDpisSnfr/uFqQfcUTwpRqlCO8OCGqS4PbqQ==
X-Received: by 2002:a05:6830:1411:: with SMTP id v17mr55789593otp.352.1609804236387;
        Mon, 04 Jan 2021 15:50:36 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/17] merge-ort: implement compute_rename_counts()
Date:   Mon,  4 Jan 2021 15:49:56 -0800
Message-Id: <20210104235006.2867404-8-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is based on the first half of get_directory_renames() from
merge-recursive.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 19c3f8d41d..05bac9c5bd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1139,7 +1139,6 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
-MAYBE_UNUSED
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1243,11 +1242,61 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
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
2.29.1.106.g3ff750dc32.dirty

