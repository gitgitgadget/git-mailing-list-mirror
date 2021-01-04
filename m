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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81988C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532442253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbhADXuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbhADXuy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:50:54 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2703BC0617A0
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:38 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 11so27690835oty.9
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZIxZE7OXOiV/nMspJY3IPbpEz60W3Z7PXDTFbpft1U=;
        b=nhTQ5/m5qBxNJk9u9vjJhtoJ7e19iSgNjhu6arAfWxq6fmolZVNWrfWj3ZtlZTNeY2
         MSHPB9CJgCwaZSQ4Qb48dgKcLBB8gdK5l2x15MVZlN9U7oN84BiIVEtwX9GE9RoJpHXu
         kdR7jZFQnL4G9f/KcZwIDdgWZRla3moABIvrQhn6lorb7DrrLIdBfJLMtE7t0AqJbt85
         vLquXFGeGLFgv0zkrsX78ctg+pf99E/mfJFCr54u9Wq87pyewKjIKj6+RcEtENIeZqUm
         oWE5/Qif1nTaP2QN5ua5YGsPdmAz5gq3bDVZKuO6zsqTKsCPi9zrDx6g6ZLEk0p/Hytv
         KsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZIxZE7OXOiV/nMspJY3IPbpEz60W3Z7PXDTFbpft1U=;
        b=OfVIfAQFImV2FMPb8f2o0t7fIX4NW4YojIObyrDiYeyMx5Djnram8GJH214SlAoa6j
         FdKQMN6MyOZtALO0VzgE4OmupEUEnt4+T81/Lo/uNXlUPJKYBtqMdYVeT/E/9kjtQ7ZG
         15FxxL6wmcuDYgZ6SbOZz1TJTc10rRGxefCq2AM+X9x5w6xebdhyvZUvGGxnOJOvBl06
         Xg37qtHroMSFUFFzUWQEjdLNnwYz8Pc2b3fTuvJp3UTNjqJxp1JR/AhAI1jndEe7tsoB
         oXRD3s/kfevigquQWVkwV+d30DIq6EmcY4vilgTyHXzDk3u459kNuG/DXVbrJwhXSyFp
         S9tw==
X-Gm-Message-State: AOAM533evVLRgE43gHOdmA52oBEA/pvKNsPN2dNr3hYOECAytCS55SP7
        iVkfWbFhHLQl1ZpYp6Fpdq8d5pcGB/o=
X-Google-Smtp-Source: ABdhPJy4V2t8gZdvcDgzVew/xM4h5rw/9eVh5hMwFlkiNlu7qZ1Q0jeE4WUai2GBd9/Ely6xYCfb2Q==
X-Received: by 2002:a05:6830:114a:: with SMTP id x10mr54517091otq.350.1609804237452;
        Mon, 04 Jan 2021 15:50:37 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:37 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/17] merge-ort: implement handle_directory_level_conflicts()
Date:   Mon,  4 Jan 2021 15:49:57 -0800
Message-Id: <20210104235006.2867404-9-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is modelled on the version of handle_directory_level_conflicts()
from merge-recursive.c, but is massively simplified due to the following
factors:
  * strmap API provides simplifications over using direct hashamp
  * we have a dirs_removed field in struct rename_info that we have an
    easy way to populate from collect_merge_info(); this was already
    used in compute_rename_counts() and thus we do not need to check
    for condition #2.
  * The removal of condition #2 by handling it earlier in the code also
    obviates the need to check for condition #3 -- if both sides renamed
    a directory, meaning that the directory no longer exists on either
    side, then neither side could have added any new files to that
    directory, and thus there are no files whose locations we need to
    move due to such a directory rename.

In fact, the same logic that makes condition #3 irrelevant means
condition #1 is also irrelevant so we could drop this function.
However, it is cheap to check if both sides rename the same directory,
and doing so can save future computation.  So, simply remove any
directories that both sides renamed from the list of directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 05bac9c5bd..c4f437d4c0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1359,7 +1359,23 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
 {
-	die("Not yet implemented!");
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct string_list duplicated = STRING_LIST_INIT_NODUP;
+	struct strmap *side1_dir_renames = &opt->priv->renames.dir_renames[1];
+	struct strmap *side2_dir_renames = &opt->priv->renames.dir_renames[2];
+	int i;
+
+	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
+		if (strmap_contains(side2_dir_renames, entry->key))
+			string_list_append(&duplicated, entry->key);
+	}
+
+	for (i=0; i<duplicated.nr; ++i) {
+		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
+		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
+	}
+	string_list_clear(&duplicated, 0);
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
-- 
2.29.1.106.g3ff750dc32.dirty

