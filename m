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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14EC43331
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C422464EDF
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhCMWWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhCMWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA769C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j18so3740286wra.2
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4FRkm4/v++XAhRpciS2SHqHnvytpt2phjEYNeQhsfmU=;
        b=tczDFaD9GHR76uk4wEChP4sxYAqSERGY5lKPtgBBmqrYW8kV4Q0NBfmWRfYcqJVLs7
         +QJuTptvUuUbIv+1lBXDF1n+M3BdJrTtswrMUjvUo8jzeEJtjmMCQq8qMLFpQbLgyPXi
         XR1dn5RAP0TpSRXdtrS1yhFUixSGtKWvurDB5ldLliGRPvckri3v1GyhVccMm1wo38US
         m1uPD4zV1sDsDNWRXwq+o9EV1bYLaLtLbqDL//ogzktCgU3jAvDaWD3SKG8Q9MnockK7
         WuQSiCgE2ymGusIBiGh0ZERT/Cjw3vtWU0/vqHT+vyTxki9/WLOezA34nnKnPtObsbCM
         +V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4FRkm4/v++XAhRpciS2SHqHnvytpt2phjEYNeQhsfmU=;
        b=XbGwTd8wb8PAosJeNceK76HfuiQa25iC2M/NbeOuqmBe7DMsJKpa8h0aENhCm9gcFY
         G7tSqI6zSm5iWfg4Bvk+bFFwixbqRSYrDMDOta4dHNHH2jgRSk31bBVrpjSt8sFSr2SX
         TDZylV3CxKKdpAdoK/H29KfRIaev6XbR9qammGuoDh6luN2mui+YagSFb9J+Dy8/sFXf
         lDR4o9ZJoyQrVhNmq7WXd3lkoa3jELRhnQs48Y1lQ/ujZtWvNi9+3dT7TqKy2Lyg3n+m
         v9SR6+EDB3h0U5wRTjPxHJtHLMBeTDEwVhxxVxH5x4BlbeDSLjMkiKRdqPZ426/Vd1Ap
         ZA7Q==
X-Gm-Message-State: AOAM5328jcpYpM3HmVGEJTmhxiawUbqhB+TM2PgCEt58YWmiy4rhHqq4
        Zm54Ydp9iHMCxsPF0MXzOrDs95dsVGs=
X-Google-Smtp-Source: ABdhPJyNussruSecqpb4RQzLzuNgU0HcXoMg+Hd8T4mZHOuxY0x0chs4MpMDMncmKvrD6FMAIYnWYw==
X-Received: by 2002:a5d:6a86:: with SMTP id s6mr21310997wru.307.1615674133598;
        Sat, 13 Mar 2021 14:22:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm14813251wrf.41.2021.03.13.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:13 -0800 (PST)
Message-Id: <1de40b1b88adee4d40a141f1eb796676b18da670.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:07 +0000
Subject: [PATCH 7/8] merge-ort: record the reason that we want a rename for a
 file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are two different reasons we might want a rename for a file -- for
three-way content merging or as part of directory rename detection.
Record the reason.  diffcore-rename will potentially be able to filter
some of the ones marked as needed only for directory rename detection,
if it can determine those directory renames based solely on renames
found via exact rename detection and basename-guided rename detection.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore.h  |  6 ++++++
 merge-ort.c | 15 ++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/diffcore.h b/diffcore.h
index d5a497b7a162..cf8d4cb8617d 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -167,6 +167,12 @@ enum dir_rename_relevance {
 	RELEVANT_FOR_ANCESTOR = 1,
 	RELEVANT_FOR_SELF = 2
 };
+/* file_rename_relevance: the reason(s) we want rename information for a file */
+enum file_rename_relevance {
+	RELEVANT_NO_MORE = 0,  /* i.e. NOT relevant */
+	RELEVANT_CONTENT = 1,
+	RELEVANT_LOCATION = 2
+};
 
 void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
 
diff --git a/merge-ort.c b/merge-ort.c
index f2b259986e22..7f5750ce6ab0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -99,16 +99,18 @@ struct rename_info {
 	struct strmap dir_renames[3];
 
 	/*
-	 * relevant_sources: deleted paths for which we need rename detection
+	 * relevant_sources: deleted paths wanted in rename detection, and why
 	 *
 	 * relevant_sources is a set of deleted paths on each side of
 	 * history for which we need rename detection.  If a path is deleted
 	 * on one side of history, we need to detect if it is part of a
 	 * rename if either
-	 *    * we need to detect renames for an ancestor directory
 	 *    * the file is modified/deleted on the other side of history
+	 *    * we need to detect renames for an ancestor directory
 	 * If neither of those are true, we can skip rename detection for
-	 * that path.
+	 * that path.  The reason is stored as a value from enum
+	 * file_rename_relevance, as the reason can inform the algorithm in
+	 * diffcore_rename_extended().
 	 */
 	struct strintmap relevant_sources[3];
 
@@ -677,8 +679,11 @@ static void add_pair(struct merge_options *opt,
 		unsigned content_relevant = (match_mask == 0);
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
-		if (content_relevant || location_relevant)
-			strintmap_set(&renames->relevant_sources[side], pathname, 1);
+		if (content_relevant || location_relevant) {
+			/* content_relevant trumps location_relevant */
+			strintmap_set(&renames->relevant_sources[side], pathname,
+				      content_relevant ? RELEVANT_CONTENT : RELEVANT_LOCATION);
+		}
 	}
 
 	one = alloc_filespec(pathname);
-- 
gitgitgadget

