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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B7C43381
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC282253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhADXvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:11 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37058C061793
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:31 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 11so27690635oty.9
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ExD4NwtEea+vxCJJBfFXlp09hukXUB83Uc8F7axU4U=;
        b=ER5dBaExHo4x0oDbU3nhs6Mp/h4UHyDprNHCiBjVpOB+E198S6nCFHjH4FBZNh4SFs
         eCjPwOKouJUsGd0wV+RZfaYyv4lPKA2iWaBdykr06udJ9UDWqV1KMycsT3VO/DEgniem
         2IcVLnIXLJWYf4xIpCAkrjZotkt5ywudSRTUMTd5t1PlZ5ZBD8/vsW5eqGBSEmIoxSkx
         9H/ihugh34/RxlpcRBhuX25JtdQgqWVRyj6or2JeiiutnoDOmR3juN9w4l0hcLHFElky
         BhFM/AZanoPVehfGD9/PHSHygVswTS3xGU8I+jDgRVZFUcb6faZiu3qcV6BcQiBApglv
         RPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ExD4NwtEea+vxCJJBfFXlp09hukXUB83Uc8F7axU4U=;
        b=R/ClI53XaX7nmPzVjy28mI8YeNVyl8IQu+4RvFpwfkVuj0/kjb7Fm+QICHnDhHEes4
         Yex8dKsM1kps0HLLJrhNLNVMdDceJ4K9osl7+IPO6PZtZLao9x/X6zsqB7cWd/4GqWu6
         ExUEhCihIGx2IVsW2VVSelLbtA1A1enmn2/hjwq9FQwS47YeBWfM66OGvs4jmBfG//O8
         oA0FFToNSZqWI5nPpOlr6WDq7R0Fn1oiKuDzWRzMSb9MQDw/8LvkgL9QWWGJgX5Aqydk
         9FH3yTj7s53528RUNqO2HNTsW10VJk3oHqY6RWf22VuNQkTBrej2wegQ2slIid1nXJf7
         3ZbQ==
X-Gm-Message-State: AOAM533hOT9+w88xd9ENZXMjYPKA08wNrgDqeLHsXax2kA4Vy5cQG1pF
        xKlH/PaDVREBEAAa2g0Le+zBmou9rRM=
X-Google-Smtp-Source: ABdhPJxK/5Bv3OTG0q2b5vUTurbOp/DsMmTG4+wQLGc5WvN/Crh3S7TtEt4BIGksS9CAelchWX7mlw==
X-Received: by 2002:a05:6830:15c1:: with SMTP id j1mr54224907otr.211.1609804230513;
        Mon, 04 Jan 2021 15:50:30 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:30 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/17] merge-ort: add new data structures for directory rename detection
Date:   Mon,  4 Jan 2021 15:49:50 -0800
Message-Id: <20210104235006.2867404-2-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6900ab9e7f..719cc1c582 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -52,14 +52,42 @@ enum merge_side {
 };
 
 struct rename_info {
+	/*
+	 * All variables that are arrays of size 3 correspond to data tracked
+	 * for the sides in enum merge_side.  Index 0 is almost always unused
+	 * because we often only need to track information for MERGE_SIDE1 and
+	 * MERGE_SIDE2 (MERGE_BASE can't have rename information since renames
+	 * are determined relative to what changed since the MERGE_BASE).
+	 */
+
 	/*
 	 * pairs: pairing of filenames from diffcore_rename()
-	 *
-	 * Index 1 and 2 correspond to sides 1 & 2 as used in
-	 * conflict_info.stages.  Index 0 unused.
 	 */
 	struct diff_queue_struct pairs[3];
 
+	/*
+	 * dirs_removed: directories removed on a given side of history.
+	 */
+	struct strset dirs_removed[3];
+
+	/*
+	 * dir_rename_count: tracking where parts of a directory were renamed to
+	 *
+	 * When files in a directory are renamed, they may not all go to the
+	 * same location.  Each strmap here tracks:
+	 *      old_dir => {new_dir => int}
+	 * That is, dir_rename_count[side] is a strmap to a strintmap.
+	 */
+	struct strmap dir_rename_count[3];
+
+	/*
+	 * dir_renames: computed directory renames
+	 *
+	 * This is a map of old_dir => new_dir and is derived in part from
+	 * dir_rename_count.
+	 */
+	struct strmap dir_renames[3];
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
-- 
2.29.1.106.g3ff750dc32.dirty

