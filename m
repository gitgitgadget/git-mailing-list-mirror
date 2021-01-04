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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5461BC433E6
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1938022519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhADXvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbhADXvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:15 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5EC061798
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j12so27703368ota.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gske+Yavvz+ocnpd1TmNj2kn5OMntlBdi/x6/WJqZdg=;
        b=uRE66ULjJgy37M7cy7pcbCm0EdLSdZF/cr+2nqbbTnCMHeXTebuLJ9RjcXo83XPDKL
         /mTfFtAJzEigY3pYj4ZvlcLp3wwEu1WkDQonCAHeGGKbzSXj9HKHSH2Tfg5aLfr24dn4
         xcpDxTpUU5os8mMgKpLryUfDhdckN74VfZsDSF9rirOaaS0vE9eU9ABMBSHhppvaoZR3
         wpdrS2WjfVk6jKHkbwV6T+q7UjkY8r0n0hI+deVAslP5JuHqj/bgRq5Lx9YLgttXGMZ3
         EOZaOZlkyNjkmgz0cz1+E9nwGrLsOBDQPkYDpmPristjUnIN7xAkURcUPuQiDuwF4zpI
         uzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gske+Yavvz+ocnpd1TmNj2kn5OMntlBdi/x6/WJqZdg=;
        b=XX3O79UvqSWZC+SH5qj8avHqRvn7iOoiyJZ/Er0L7SR7pS0wk2bVNogcho3mAGetSU
         Ek5VbcjfTCefqTvJu8BIgWJxY7EuS/+0A2Tsc8KZXh3cqFliRCagwMnYVEGb+cwUNHcS
         7n4gj6J8QnBRmtkEse7ghLVadMPO3/yR4u8BlhH35l5J1WZN/ViV15dVyX3jwsZxsE3t
         EpPJAza0GrDSiWC8UAYPMFEQjQfToyY+9KCn3F+0HqU3Z1wtnqL3qFjMw8MkPeewA0ff
         m3X8pmtTE1LCS7hV7AHA2yUmogHSC2Y++X/3woCIXMwFvDv1p+iYDyPjW6E3kHD9mlPq
         G9tA==
X-Gm-Message-State: AOAM532KATmR5Tn3bwEnmwqj2il1RrLjBrrrvChi0pYZGhhhBqNyRNbW
        iCCwQ102F+OdU2z+F15V81amRESlMxA=
X-Google-Smtp-Source: ABdhPJw0QEsoSBbt5mig9GTPe5M5IegYSFCREI8M28nvSQJ6iWVYN9x9Tii6nqkjRkmBrzl4GuCarg==
X-Received: by 2002:a05:6830:1352:: with SMTP id r18mr52465158otq.73.1609804234449;
        Mon, 04 Jan 2021 15:50:34 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/17] merge-ort: add outline of get_provisional_directory_renames()
Date:   Mon,  4 Jan 2021 15:49:54 -0800
Message-Id: <20210104235006.2867404-6-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 0bd0ab1e8b..6ccc7a1a45 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1139,11 +1139,69 @@ static int handle_content_merge(struct merge_options *opt,
 
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
2.29.1.106.g3ff750dc32.dirty

