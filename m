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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76895C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7FD61279
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGMTf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMTf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:35:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2570C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t5so77756wrw.12
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UtksxVEuW8oPlg3lwNLFR4T2YJ+49CjWCzglLfAr+Zc=;
        b=dutAVEfHghJDAIHaD0hWzSx2FCY2mQtq3qXrG9kl38or964KR7f2AQTf6CaE3JDFod
         1CQsoQHm9cUzlNVSlzv0fRSHbttt7TTP6/Nfh5YZps70rW6ZQuPL62qD9TlmtvtMbfD/
         NPmwKmiZzxuMzqDhQoKJ+JGdPT4D52AwAMFGGAzrWNCCYn30D1uPiphnIzurjaE/rqyf
         j3V8rjXdROs5KsQ8Mxy/E97/IdcoYqnIarfLU3RWsEK6gROIXrFGC1xjtvez/Y9VZUFm
         HfXNBMwhmwc90JG+RQ0smp4qJHkUBzfz1g+Z/UAEbkHWUHsR8b/ynsVSP4denqLYtSRU
         m7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UtksxVEuW8oPlg3lwNLFR4T2YJ+49CjWCzglLfAr+Zc=;
        b=QwdhMigwfKnVRn8ONiDN4rHuVrPBq9G3Krh7AMS8PwTvwT9ukTEjgiRPDlwcvGxNz2
         9I/K68bvkqs5rCwDHvwOL8L60DOu5vKCZiWvDNdZnzXKLsI1Mxa5q6dvKJBsDYqNdg06
         S9/rUh0w7V9qLqD2rSQ0yUnA6F3gT+F+BGkEDRY2edIEsSZBNoM3Eq9tBjkTTTdT32i8
         VeSRW50S31n7Zy3EH3q2MtnGZcoTVAcFj9QSH4WASVbWY1Bp1GoBEviFknBirMScysUS
         VZnRxwiLRvNYYK8f5ryno5wJFOMoz/+KlFjvBFUmbepqCD9epm038pTyi/5e6LktSuCi
         spYw==
X-Gm-Message-State: AOAM531aTqa+Rs7lAMeiRTE1y3pPbcunT4nTU6ZtqzwkqRvi4r4BX8De
        bihzCwN5WIhpfnZDJEYYmCdggH+x5xo=
X-Google-Smtp-Source: ABdhPJyTv5u6xmTz8oo63seHA0n9CoZjBZAYnkpiDPhQZ0RDgjfoD7uxF/+W1oTCYtTSyYa/SJFqWA==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr7706826wrr.47.1626204786494;
        Tue, 13 Jul 2021 12:33:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm19965177wro.3.2021.07.13.12.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:33:06 -0700 (PDT)
Message-Id: <5dca982c0b061ae8d6335d4f22b78811dced054a.1626204784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
        <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 19:32:57 +0000
Subject: [PATCH v2 1/7] merge-ort: resolve paths early when we have sufficient
 information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When there are no directories involved at a given path, and all three
sides have a file at that path, and two of the three sides of history
match, we can immediately resolve the merge of that path in
collect_merge_info() and do not need to wait until process_entries().

This is actually a very minor improvement: half the time when I run it,
I see an improvement; the other half a slowdown.  It seems to be in the
range of noise.  However, this idea serves as the beginning of some
bigger optimizations coming in the following patches.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index e3a5dfc7b31..6299b4f9413 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1023,6 +1023,43 @@ static int collect_merge_info_callback(int n,
 		return mask;
 	}
 
+	/*
+	 * If the sides match, and all three paths are present and are
+	 * files, then we can take either as the resolution.  We can't do
+	 * this with trees, because there may be rename sources from the
+	 * merge_base.
+	 */
+	if (sides_match && filemask == 0x07) {
+		/* use side1 (== side2) version as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+1, side1_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
+	/*
+	 * If side1 matches mbase and all three paths are present and are
+	 * files, then we can use side2 as the resolution.  We cannot
+	 * necessarily do so this for trees, because there may be rename
+	 * destinations within side2.
+	 */
+	if (side1_matches_mbase && filemask == 0x07) {
+		/* use side2 version as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+2, side2_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
+	/* Similar to above but swapping sides 1 and 2 */
+	if (side2_matches_mbase && filemask == 0x07) {
+		/* use side1 version as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+1, side1_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
 	/*
 	 * Gather additional information used in rename detection.
 	 */
-- 
gitgitgadget

