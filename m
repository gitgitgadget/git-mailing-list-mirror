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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2166C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A29B23104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbhAST7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbhASTzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFFC061786
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i63so870426wma.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m8rNPCROge/KXdKMUmdsHImLFeBiC8U5I3xNvcm92VM=;
        b=aL8Gbu7YG7E34YEcnhEZ4adIN3aPQZbngzcqkvCb52rL3G3W4WaPyrJF+BOfGDYn7s
         /406r2QvbPyy5haiyDLoaJZXTN2BJsRrVjK6ivHHNMeFO0lmO02o7um9/ZwEDWErDz+g
         qYEsMcuHZ0B24ujHDLTFPaf0xoAnZb0u0svkEwJCply7nq7nzYS/S1PUy7M9Dr8o3UX/
         6xsyn82YpxRvKT97YmAxZJjMuFx6fF7+g50iycefdrLgdnl4oR4NHrXXiRKFb7kpcaFZ
         tiqwlxjxO0HFq9CExRXw43oDPRNMAuF/Eq9uYtO0XuM6XONCG47PZa+kgrpICtetW7w7
         Hw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m8rNPCROge/KXdKMUmdsHImLFeBiC8U5I3xNvcm92VM=;
        b=uB7YYc/VGBXE8qez+VprWPA31LYrnrdrPS0LGLQx9+SL4C/U8+NSotOgwBMIa3X6Ui
         koDf4CLyLqCVIvPaD6+STgEkiBHGjclluXwUwSyWaB9C3zrhaLk9R++tWeZ60jxBKwCi
         ZKmAJy75qX3BS0qlvgp6mAPBG0v70xUWMoqWSA+fdp6+9+M/4+k27UaERKTSnSzVpjxT
         qcVCWoR7O2k4HqlsyGT2k0UQGvuV+cFeXTbb6k6fOHFskboXk5wgO/NEIkbUOnsPSLFJ
         PUjO7wqHDTURnOprySeHAyDrTDEMk2ohj+b1JFRdjuhkSVYEFdi5c1lDUXSzoZLc2yrD
         +bOg==
X-Gm-Message-State: AOAM532tQ03td/Vp2zS2PPI+DKU3iSWHHYUhEtPjsUOSTUGk0kX8zj1o
        Sm08rS+fA/kIRZLN4uGqeA6n+eNf7zA=
X-Google-Smtp-Source: ABdhPJyqOpWwyO27nmtwsZTgxsIcx0jznNx6BxY7xYfpFAEjMR5w0qmMsisY7G/ainpBkTCENbiovQ==
X-Received: by 2002:a1c:9a90:: with SMTP id c138mr1040725wme.147.1611086042111;
        Tue, 19 Jan 2021 11:54:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm33016108wrt.87.2021.01.19.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:01 -0800 (PST)
Message-Id: <cafff61893a148e20df414230c3c610ce6382d90.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:44 +0000
Subject: [PATCH v3 08/17] merge-ort: implement
 handle_directory_level_conflicts()
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

This is modelled on the version of handle_directory_level_conflicts()
from merge-recursive.c, but is massively simplified due to the following
factors:
  * strmap API provides simplifications over using direct hashmap
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
 merge-ort.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8aa415c542f..6dea4206dc6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -939,7 +939,24 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
 {
-	die("Not yet implemented!");
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct string_list duplicated = STRING_LIST_INIT_NODUP;
+	struct rename_info *renames = &opt->priv->renames;
+	struct strmap *side1_dir_renames = &renames->dir_renames[MERGE_SIDE1];
+	struct strmap *side2_dir_renames = &renames->dir_renames[MERGE_SIDE2];
+	int i;
+
+	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
+		if (strmap_contains(side2_dir_renames, entry->key))
+			string_list_append(&duplicated, entry->key);
+	}
+
+	for (i = 0; i < duplicated.nr; i++) {
+		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
+		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
+	}
+	string_list_clear(&duplicated, 0);
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
-- 
gitgitgadget

