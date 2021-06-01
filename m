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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7228C47093
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968416128A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhFAPA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhFAPAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:00:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71CEC06174A
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:58:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c3so14654848wrp.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MxkjSxNvX20Vsj7SsSwYxyvAkMnX7kw4YWWOD/9s7zg=;
        b=T7qhUoF07n130PRcalV4dMkfMSbwhU+MHhqqKyqtBjU8Zu4tqTfUXWgVKXSG10rQlb
         pVyKgKsmuzXHv8z+KLJM7fW7LW87B2QNEr+otjZXipiN4XOTUgRzP9ajafS2BzkKqBiE
         6PTWLX/t3RMtmQtI2V3XsOjYaz8OuRf7NwjJiEMfgnE04PfCR2forpVn6w3nc97cK91w
         ee34mrvBChfkLosYlR1wHXpSRi5TfkyQFyK4wO+zjldpA4HvuUQOTV7S707ELnHc9SLt
         02oMvKrydOD/wvULEUPMPF2cTX1B70AThkVshMddiMbFkaGciOxh299id7uDGht13wZH
         f9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MxkjSxNvX20Vsj7SsSwYxyvAkMnX7kw4YWWOD/9s7zg=;
        b=E2VOdf4KR5fi4XK0MB6fWSa/k9Yw903FohewfRd+R6v19qkVFUArhPDqSxrTe3oJjU
         7j9rQKkuGdDT/cr0dvRUzqGK9A+mkSvLDgm30P3GY2Dqw9nDf6ELYyp4cL5EhyMK/lae
         d+beKZfLFFkVE79qMkCN7bK4sUfaKr1v9vhshpeid4uWaPnvBsy6HIJuPekd6u58eM6c
         rTHp+Rccs1n+rx08U6bEhn3ev3vT/AG8ycRvkNdMFZcdZ56k5hoU0YuSFoaXfd7gAigC
         sKycmM8ShM68fnkGVXZdmkMhiQiMycjL/qgKgkAzkYBF9Jb4ma24XQ/6lj8y4TA5x2YR
         aG6A==
X-Gm-Message-State: AOAM530VS3T2Pv+c53pPaQR4AqDE150lgaMXLgfpJHwXX+srWupdO91+
        z1p7X/OYby4YgBF2FFkUyAf8e0bhpaU=
X-Google-Smtp-Source: ABdhPJyurH/OLWjc482fQ277BciHwtmG1/76sde3S4mQ0UA8Q99LSmS97SuMXq920CoI/3YJSsLl9g==
X-Received: by 2002:adf:f448:: with SMTP id f8mr12507450wrp.320.1622559520457;
        Tue, 01 Jun 2021 07:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm18528483wmb.35.2021.06.01.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:58:40 -0700 (PDT)
Message-Id: <7156f26ab29919344c929be540d404dce2d5fe50.1622559516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
        <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:58:35 +0000
Subject: [PATCH v2 5/5] merge-ort: miscellaneous touch-ups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add some notes in the code about invariants with match_mask when adding
pairs.  Also add a comment that seems to have been left out in my work
of pushing these changes upstream.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 14b3e14bbe47..d428b73dedd4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -765,6 +765,7 @@ static void add_pair(struct merge_options *opt,
 	int names_idx = is_add ? side : 0;
 
 	if (is_add) {
+		assert(match_mask == 0 || match_mask == 6);
 		if (strset_contains(&renames->cached_target_names[side],
 				    pathname))
 			return;
@@ -772,6 +773,8 @@ static void add_pair(struct merge_options *opt,
 		unsigned content_relevant = (match_mask == 0);
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
+		assert(match_mask == 0 || match_mask == 3 || match_mask == 5);
+
 		/*
 		 * If pathname is found in cached_irrelevant[side] due to
 		 * previous pick but for this commit content is relevant,
@@ -3483,6 +3486,8 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+
+	/* Record metadata for ci->merged in dir_metadata */
 	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
-- 
gitgitgadget
