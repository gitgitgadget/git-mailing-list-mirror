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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE63C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7898961019
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhGUDnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 23:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhGUDna (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 23:43:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7BFC061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c15so653966wrs.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gKWw0d1gC9tSRFpyxyCf2xMnXMTq4D/wJsfrMxHIeU8=;
        b=oacE0PF0KR0rraUFNYFNI+Igq4bYIh7Rz6rjhY8BJp50mpo2Sglb4c6wL5QAYaTZ25
         hiAVDv/zMllTMd0LfVSGnbCYc/vpFYGQ3Tq/FaOC1LDnGZ28J93VQrcx92EJA0MpDBly
         RbYcr0iQSpsJlkyIaixG9MT75x9u+qGBQwMJCvMSzv+qCN5x1vZKs3TaYBq1z6fYt43n
         vC9qO5P36/b3yeR2vtBpxIT98n7rS8EsH1LExKLQGkH7bTShkbIweo3nW58U/WiR1uU8
         Jo78WXCGh80HhXfh3nA+BswU28NUm9PmU/k5aC4VTdQuK8BfvPfDT3c5OSdeTe8gC+P1
         C+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gKWw0d1gC9tSRFpyxyCf2xMnXMTq4D/wJsfrMxHIeU8=;
        b=lm4hO5qpr+epJ+mCn4jo1t0ccVArOzLQm0HoW09zKcdlcZx0y7Z4b73pJhGY+4PXDb
         8MuIrHt7zGVDhTPdy3ryemcoLEX3dbOfg+41YJIiRcV1n+Dk/fDZc4l9otfS2KGc6Twe
         iyf7EbaPHU4GGy7nEQrp0cjgJVo3EdqR/5bGs/zPokH+OvX45AwOEIKRT7ar2kNpjyEL
         OD/y7uK4BFqHeLkWGckYceX9YMWO8DTTmUOco/sFKpEwYjZoxyu27hceHhjQ4Vj1od+v
         +9hlZhXIxZ1fvN9MXXPmN8wGbqWo9tfkqwTQqNZRzv4tcOrCOUsRZ05b4sPeWzJPjNiS
         CBiQ==
X-Gm-Message-State: AOAM530nqARbiFwussc/81wtfZrhTVybeY4c1uXxuJS2HGKsZZpfwgCy
        mB5yoKlFeSa+uqovRCUwTKntRHZPfNo=
X-Google-Smtp-Source: ABdhPJysNH7hBGyMvJelZreZhpVDUNb652/+MowgkfpaSKNX2Wi+VpPhVbEdCvSHP2c1ilaiXcfi4Q==
X-Received: by 2002:adf:c5d2:: with SMTP id v18mr40172455wrg.386.1626841446455;
        Tue, 20 Jul 2021 21:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm27439250wrg.74.2021.07.20.21.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:24:06 -0700 (PDT)
Message-Id: <7fdfeb159d0125cce980e63bcc1415144b91e486.1626841444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
References: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
        <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 04:23:58 +0000
Subject: [PATCH v4 1/7] merge-ort: resolve paths early when we have sufficient
 information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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

Acked-by: Derrick Stolee <stolee@gmail.com>
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

