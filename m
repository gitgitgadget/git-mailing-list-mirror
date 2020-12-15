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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4BBC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4BD22B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgLOS2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgLOS2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:28:51 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B0C0617A7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:10 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c133so146404wme.4
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bjCZpoR7X/4iQp728JJIq89yo2vC+dnNlcpJ/DFfq80=;
        b=XYtK0NQGnoYEexS+augD5TzBI/8dAhhlZfIkc3ZfEfKXv98nay9zWVozs6qZHHtVEz
         bgCsvPUF3B5Keyrnm1DocYEpiupoUDdwYlcrBtCkRE+hvMz0Q+4nMEAjXaiWdEZ22H3O
         vk8dkilIR9kjdCPbJanX7fFpvJ7PA4AJMBncnbMK2c3JBDKq6oUQK9tT5qyne9kZsVug
         +0K1SkbVa//OoXG/C3HMT6DfMV+ImeN3PSB7B5WBNleIUvsNaG6ziMuZfMDC+3Clq6JH
         blaqzRaonVt/pI8jz9uwHlcbScUhypUDQvop1sIMy6mtvqO98wDkGDtlgBrRb/Utm01E
         B7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bjCZpoR7X/4iQp728JJIq89yo2vC+dnNlcpJ/DFfq80=;
        b=XIaeJvsG1s1dBMB/rWa6Wms5Jl5LfaigMfvL8pT8U7UDTfINtizShIqaB68UabYIlj
         Y7NY8rseRkNYCzumjB8X8OJ+Uu87h/jKW/NjY9jgbhZF7lZfkU2ydrKsTUKZFpqqtCw+
         gbsq+aNHYkN2IB6LAB6XZ+8l1Z2vUvP4tOmAJRV6PpA8e9hFAMbVtD0KSN5iEZPtCaOz
         3sUQnS+nRMxZEYBDA1kHWGgWz2agfPQsz2TGobL7+Ix7Qrpo49ElMMBYLpRdraRnezLy
         BR6gVdVQ8nbMNp4020PB1VuyS1KFAuT5IP3WAJU5vwLYYnSEfuUbQmi7i5kymLr+wrqT
         6c+g==
X-Gm-Message-State: AOAM530CI1WnPZuKIs4h0mFi87/cftAkWcjHyid4zRvdOJnffy4N0J60
        TFm0kXkUN+B4/kMj7VcTy9Lu2XyvkIA=
X-Google-Smtp-Source: ABdhPJzuxcPEP/XneYACh+M15+VIrvzd2cjfRC1yKKMfDeE6t1BFky3YMzsoMnaVu4wMgBQszWANxA==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr171965wme.41.1608056889107;
        Tue, 15 Dec 2020 10:28:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm40476857wrv.67.2020.12.15.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:08 -0800 (PST)
Message-Id: <78621ca07887e39a41ad9cff7b8dd5dcc9b33fbc.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:27:56 +0000
Subject: [PATCH v3 01/11] merge-ort: add basic data structures for handling
 renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This will grow later, but we only need a few fields for basic rename
handling.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 414e7b7eeac..1c1a7fa4bf1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -46,6 +46,25 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+struct rename_info {
+	/*
+	 * pairs: pairing of filenames from diffcore_rename()
+	 *
+	 * Index 1 and 2 correspond to sides 1 & 2 as used in
+	 * conflict_info.stages.  Index 0 unused.
+	 */
+	struct diff_queue_struct pairs[3];
+
+	/*
+	 * needed_limit: value needed for inexact rename detection to run
+	 *
+	 * If the current rename limit wasn't high enough for inexact
+	 * rename detection to run, this records the limit needed.  Otherwise,
+	 * this value remains 0.
+	 */
+	int needed_limit;
+};
+
 struct merge_options_internal {
 	/*
 	 * paths: primary data structure in all of merge ort.
@@ -113,6 +132,11 @@ struct merge_options_internal {
 	 */
 	struct strmap output;
 
+	/*
+	 * renames: various data relating to rename detection
+	 */
+	struct rename_info renames;
+
 	/*
 	 * current_dir_name: temporary var used in collect_merge_info_callback()
 	 *
-- 
gitgitgadget

