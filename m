Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FAC0018C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90BC207A9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgLCQAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbgLCQAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6DBC061A56
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v14so3220664wml.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yPu6RUJO5LaNqx6tk96dR9KSLH8x+DNpjquDN/HBBhM=;
        b=U87Sn9doLqe9C+NzUkuhhfbVclSXw62xvhdHppC4C8Xp60lvvhExNM80j3nP5G91A6
         tdfbPdUdbdQUDkpS2xqgR03TbSCkdUof7lN4CTnDpPCmNbbHgFSovbKzkaXuS1Wk2Xvd
         pnzHur+Mm0Fr7vEHWSvpg/ZiW0p2DQH7ZTXqg2ysPZRNjnhHuOjsOF8HvvcI6QRLxeBv
         NC5TiTHiwRk4xMXNQWDo/owInpLyN7Vn+I7ifROgUwsEOhmsAL1NtZ7E7U6vZWzS0MNB
         ui/7DK4R72EfissS3XTA3oLpK3xmUI6dtX0iTAbVuWeFFM2ExEa3Yj6G92bTMP9be8+q
         6WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yPu6RUJO5LaNqx6tk96dR9KSLH8x+DNpjquDN/HBBhM=;
        b=pOovI7mKVsN8TZgHszLpUcZSQ6CTnCXzHw3wXmhKr910d33Qj8NWICTx78xG+ZibyX
         7xMc9pfpC+Z7o00rmS/N6eESMzE/su5QSjausvaQKSasGS8vsV3R7rfnm4QfSeOoTWm0
         eqWtkj8YnOLezXBI7s2Vr7apMDEegTRbrO81PwBhVJGZzTLLbLWw8STZZGWkH8dMAyHs
         evk+CYxGpzBrJDQGiYm/vqHBw/LPP3EQnR4ZuMHdzcvi2kci5VuvZmVb+OdciRU1r1ef
         ywC8r1fAFhugl2YJwKPjcdXQRy04vxsHygYZyRzNvD/Y8PrcyjeBWrXwoaVNWVo0VRSD
         YbAg==
X-Gm-Message-State: AOAM531wZ5mk0x/T+coENDCVbZnj0rZnbMfKnlR+gPSbaA8Xn0zAm0r0
        JA0Nyk2gBwpgkMVpq8Q0E97SRl6z4dQ=
X-Google-Smtp-Source: ABdhPJz7XkojKeRV4js+9YUOYRBhCK2W/PtPaH9uJi7u9ratmXpNIkKQ8W2Q1gKGskNEtCcG52MvKQ==
X-Received: by 2002:a1c:a583:: with SMTP id o125mr4023088wme.91.1607011196581;
        Thu, 03 Dec 2020 07:59:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b74sm2204344wme.27.2020.12.03.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:56 -0800 (PST)
Message-Id: <181627c30cc1995b66eb5659e54737d05964f8a1.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:44 +0000
Subject: [PATCH 5/7] merge-ort: add function grouping comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit b658536f59 ("merge-ort: add some high-level algorithm structure",
2020-10-27) added high-level structure of the ort merge algorithm.  As
we have added more and more functions, that high-level structure has
been slightly obscured.  Since functions are still grouped according to
this high-level structure, add comments denoting sections where all the
functions are specifically tied to a piece of the high-level structure.

This function groupings include a few sub-divisions of the original
high-level structure, including some sub-divisions that are yet to be
submitted.  Each has (or will have) several functions all serving as
helpers to one or two main functions for each section.

As an added bonus, the comments will serve to provide a small textual
separation between nearby sections and allow the next three patch series
to be submitted independently and merge cleanly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 89b9fdb04a..e653ba35ea 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -183,6 +183,8 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+/*** Function Grouping: various utility functions ***/
+
 /*
  * For the next three macros, see warning for conflict_info.merged.
  *
@@ -263,6 +265,8 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+/*** Function Grouping: functions related to collect_merge_info() ***/
+
 static void setup_path_info(struct merge_options *opt,
 			    struct string_list_item *result,
 			    const char *current_dir_name,
@@ -517,6 +521,15 @@ static int collect_merge_info(struct merge_options *opt,
 	return ret;
 }
 
+/*** Function Grouping: functions related to threeway content merges ***/
+
+/*** Function Grouping: functions related to detect_and_process_renames(), ***
+ *** which are split into directory and regular rename detection sections. ***/
+
+/*** Function Grouping: functions related to directory rename detection ***/
+
+/*** Function Grouping: functions related to regular rename detection ***/
+
 static int detect_and_process_renames(struct merge_options *opt,
 				      struct tree *merge_base,
 				      struct tree *side1,
@@ -534,6 +547,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+/*** Function Grouping: functions related to process_entries() ***/
+
 static int string_list_df_name_compare(const char *one, const char *two)
 {
 	int onelen = strlen(one);
@@ -1001,6 +1016,8 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&dir_metadata.offsets, 0);
 }
 
+/*** Function Grouping: functions related to merge_switch_to_result() ***/
+
 static int checkout(struct merge_options *opt,
 		    struct tree *prev,
 		    struct tree *next)
@@ -1189,6 +1206,8 @@ void merge_finalize(struct merge_options *opt,
 	FREE_AND_NULL(opti);
 }
 
+/*** Function Grouping: helper functions for merge_incore_*() ***/
+
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	/* Sanity checks on opt */
@@ -1239,6 +1258,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	string_list_init(&opt->priv->paths_to_free, 0);
 }
 
+/*** Function Grouping: merge_incore_*() and their internal variants ***/
+
 /*
  * Originally from merge_trees_internal(); heavily adapted, though.
  */
-- 
gitgitgadget

