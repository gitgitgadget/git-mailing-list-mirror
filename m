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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE5C11F6B
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C5B61480
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhGADsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhGADsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC686C0617A8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j34so3446194wms.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UtksxVEuW8oPlg3lwNLFR4T2YJ+49CjWCzglLfAr+Zc=;
        b=OFrnRl2DskHsS/SdGZP5KGonHyEx4zLcstMhhY1FXUJNYSz0N0bZn+PxqdngkaeeJ5
         TZc6Lt3cfRrakiseUS0xNfm4aiCRU3k0nTzuPPaFohuq1T3QGpu2L9XB5seRcJkTwuWk
         gLN84Otx0DIhfZXxW5t4XYe0rne9osQn+Xd0ycn9bI3KguWa0h01kYNptPBvMddAvPyj
         AG23nkLh8GtPRo40L8U/4/lcTpKIEHB1YffgbByLfcUh/5aY9jC48Dee9lHxZKyA5LsI
         KqEL+pWmpmyOIpueuk1bqaYvjLFgNXTch8U4Le0r2jzGhTZbv+qxmrDBDefA5OgWbmGp
         TUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UtksxVEuW8oPlg3lwNLFR4T2YJ+49CjWCzglLfAr+Zc=;
        b=MRNRnvR7O/AXkhv1Re8qsdFb3bmAzvvJ+eDXatupXzwfnZwKiPI2oyBoO8spUdjPIy
         MU0mSI8OS+eefr5JUJXhgbLmF1qMa5GSUaoCWT4+RmU82QKSQ6Rfdrf/AHKb9DPY9s7s
         YjgRSAFeL+bb2QT6tQh69Bjh9IBnb4b+aqPF7LD9+un9SehgRMiobthgxEmuqpg0UQXQ
         sIKJe+qfJlxdYw6J2Imx3aMKJLEmuB2KAVaKh6uCLOLMBipVJ64WUuNrLA38A+hHm14J
         rZip9Xv6E6KqzVWDgUwlrhRlkieC+Z8abIn6WOpECHNoXrx6c8FHlTG77Q9fZyXFpgJP
         O/lQ==
X-Gm-Message-State: AOAM532RYqSXRvq/ViIT7cdkDTD8IuudBvS/6+T4m4BZEDoA4R9+Cl1f
        NbUP1dTZeAYx/y/Yfl0/LmIVmD7aWdc=
X-Google-Smtp-Source: ABdhPJy2C5ATiTp7hCa0BVt5uJkpXbTdceW408twcp+oFHn4xqXfm+KosKQ0WKAu3lLR/Yf50FICSA==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr40894047wmc.127.1625111179392;
        Wed, 30 Jun 2021 20:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm6921218wru.79.2021.06.30.20.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:19 -0700 (PDT)
Message-Id: <5dca982c0b061ae8d6335d4f22b78811dced054a.1625111177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:11 +0000
Subject: [PATCH 1/7] merge-ort: resolve paths early when we have sufficient
 information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
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

