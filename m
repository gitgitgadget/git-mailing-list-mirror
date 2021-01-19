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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5278BC43381
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EE72310B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbhASTyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbhASTyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:54:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5FC061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so890401wmz.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hDyryaov45i5VpCMwMfYmGC3XG+kMJuhszeqQ9Ks0RE=;
        b=fE8JwkdnhqtPkfMetcZosnfNX5/o4RA/xJU5IgmaJXMetjDfiHnVQfdCbMz+a2v8Gw
         WysbpIyiibIhBdobJ5FAtZ+Bm0ZAzhzLrlxcIWyNQJztXnv6qNpq6fXTV6An2aYJTz9C
         VuJW7zm54x4yX0kkNMrz/Ber8rDSbzjNI1RHj40dw4XIXlmnavVxgm0pQfxiMW+1I0wf
         p28mPaJcwlNXkMQXSMw007W0CtM4v/RmWUJisyjKkRZN+lWToNXBXtsKiD3WXoRcbkBQ
         PsVXxNykIyTArsxrL5wEgzs+rVRYva3GjpUKQStKvpz4ZUrAbUtGogxy9rs4M9HuALQA
         WIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hDyryaov45i5VpCMwMfYmGC3XG+kMJuhszeqQ9Ks0RE=;
        b=epn4fkaMf4vPD+EQUgJR5s3Jc/wUP4h6hut2HbhKioJ/pNkMYLGkpCDhKTOL0HBqpD
         nylz3Hl9thTcdVYhseyZq1/3NwTWRn62d7Oj8QxH0verVo16sFRKCtS4AQkqd0h/7P1V
         yLnTb/N3TgbDs10jczx3C9sHh93+2B0kBP96cr6KZXEHzXwmcohjUN4HVgDjkRiBQnSw
         IxGOpDVJnW3iVci3YTw8X4uY23nN6BLBPs7sxdx6tT4GRMWtAhtaCYvF199Wbu1zhd/9
         cbZtsKiZBMxu5k8A1wiKYX1OuhF4h3kVl2phA78IKh+mAL21UtEkax78dDmi2IC15iHV
         CZBw==
X-Gm-Message-State: AOAM533Pc9fWNbINsoKrSQiHfjUjyGhhoFz7MZBRmnwsNYH5PYPRx+Qd
        7k9ZMQwTJkmn+4HY4fmWnaJUKo+me1k=
X-Google-Smtp-Source: ABdhPJwu0Q534Bxgnt/GhjsKZ1WDuRhcsCKM3YlxE5305OS36D7A9j8zQvmYunHJ9JuUARvciytbBA==
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr1161994wmc.42.1611086035821;
        Tue, 19 Jan 2021 11:53:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h187sm6356180wmf.30.2021.01.19.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:53:55 -0800 (PST)
Message-Id: <3b14afd4129f19ecb581025a94cc816a5f2ff28b.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:37 +0000
Subject: [PATCH v3 01/17] merge-ort: add new data structures for directory
 rename detection
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d36a92b59b7..652ff730afa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -49,14 +49,42 @@ enum merge_side {
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
gitgitgadget

