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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08ADC49EA7
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2146196E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYQFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFYQE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFEC061768
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so6677268wmf.0
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r7Z6d5ifsh1v6IjHQmKUm8lmxTGmT95I9U09SdFQEqM=;
        b=pqxrmShRJiw8bVLgOVsVs9c4xUb2vMbRzhsja+pr5O+D7pfIgeiTCjXzQvHmBwpGbe
         yW4NIetOy3WLn84C9T13tBq4pwoPCgxrqBHZNiB6fHicnM7IJBMXvYeYzraj2WfqhGaK
         XsBuOb0kyQPInOiAezBmlshl2aTCHUSTTlCFc28JLIO/uEh9YgFAjX2oqj+Sd+uaxaji
         YGLvnJ6mG9ab0dcjzrJDSzgmaVm3ij2mXSRidhKK4mEph7OilH24aXTp6ierVxh6LtXJ
         EYi7+nZGaOIohEejkfbwkUq7D+RttMezFPRZYzNvyziJ/ad6KeMQADg+oHPboTwpvrGC
         a++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r7Z6d5ifsh1v6IjHQmKUm8lmxTGmT95I9U09SdFQEqM=;
        b=AnT46PVXM+35ktRnJyvhu5f/iF7VuNK0jwc5u4g7BPPOSVYNqMEPLmMXLsaDALwCiN
         eJrZ4TKlq3DTythWSWM/phYsaX55PxAZN7M5Om+ZWAdkjBfrYPVDmuSWHRMrbEZnvtV2
         rVEG/+wSphptNOohnoN4sxbxQs/TyFmO4LKD2NJ6LCfxfK43pHmHkdfV4ob9zkqOE2Au
         dnRQh4yob2Q8BsKFOaGU/j+Kz5Dh0s0fEelv3PFT7vyDcXvaheudOiFp7+vMGlZKQ64S
         IcH9wlEbIry7BiFxSkqtMcycW2tufARQ7aQ+Ng3UnVTmGV1TCciWbhuSI5ICcJ+JS4bZ
         YS4w==
X-Gm-Message-State: AOAM530/RlPISA/l9h4KvyMzLodIlWkXwZin7AMAMbJpti8kSHkQ+J9t
        kbtzYu0U/0fPljWIJCytJu2Ea9nJ9kI=
X-Google-Smtp-Source: ABdhPJwN7EVRHnbyDDGPHBw1V+IdCpG4xyR8Ixqaij8sychZ40PEKy/SeVK/wX7uqiuA44kauB9gZg==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr11601841wmb.65.1624636954118;
        Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm12132375wmb.15.2021.06.25.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:33 -0700 (PDT)
Message-Id: <45657499c55ed91eb78498be4355459b00f76404.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:20 +0000
Subject: [PATCH v5 10/15] [GSOC] cat-file: add has_object_file() check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use `has_object_file()` in `batch_one_object()` to check
whether the input object exists. This can help us reject
the missing oid when we let `cat-file --batch` use ref-filter
logic later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e8..9fd3c04ff20 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -428,6 +428,13 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
+	if (!has_object_file(&data->oid)) {
+		printf("%s missing\n",
+		       obj_name ? obj_name : oid_to_hex(&data->oid));
+		fflush(stdout);
+		return;
+	}
+
 	batch_object_write(obj_name, scratch, opt, data);
 }
 
-- 
gitgitgadget

