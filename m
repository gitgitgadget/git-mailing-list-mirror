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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C62C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D3F61164
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFVDX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFVDXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30649C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so770972wmf.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C+KUgIropPxlggylkgRFVoMA0FHpUH9vFWrim/BC6U8=;
        b=vbT7aKwqk3ohDGw1yTPJ3vw4g9h+P20AY2lQJXd2xG7C3uGHRB/1eMnp8v2LrOdiQy
         GSjkr37QQntDqQPcY6c4mCQ8BkgXcKR+ZK0zWdx9nuY35X1xwCW8KSjUncA/PGH2SeAp
         z9dMRw2OUu3Qudx1fdzSLp6KrxzZIA+TMdcMFFbApgeTjXoELFN4ysqKgZauI4n41IDN
         b8owhfatXE6SsfCBqpqnxWlMuLia8wb8KnSrjV2aExUUUUZUOy8DDHubap7eaSygcCWr
         v4rPeTJZ4Wdr2i2XK45M4v1V1o+B+FsiiMZqt4+xFEt3YwvWG4cQeqPXwgiK9Xetk8o/
         QVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C+KUgIropPxlggylkgRFVoMA0FHpUH9vFWrim/BC6U8=;
        b=QW7FVnTSwR/FP+ZNAsQEstkZIbi7RtVDHraupST6OEoFSQY650qxzjAxwsp/oJurwK
         ypucuf4qLioxtQFAzIZJbEKRksAplbtTIhlaghZbsn8fOtkt2jwuZodj6CUXkMUi3drL
         jM4jtggm/WBKjGDJlffzvPe6e2EMcgT80swDhiCebdce8cb8JW9bLaHMbStV0fovuZCr
         eKd5p0TQ0QQ8sW2LF5bTsXEU/OBEI6T4sKe7VNQp4dyQcAXmITM0xkPCKHlRNCyZ5g19
         vdMZqyLiH3rLKf6eL3S3VwwxTZ5ievq3dIrYG2YviYOw2RCnq2l0Sq+qRWLrnJRkJ/Cf
         bhhg==
X-Gm-Message-State: AOAM5312snM/X8jNGMufFC/A+9ufiIOOFAYT3KHAe1gJmB14gH+lW5Jv
        lpilMH5QoqpcFp/OYfqVJCBQ/sE8VVs=
X-Google-Smtp-Source: ABdhPJzjHO6fQLj1srtUnDDFqSKxlwNGLrivnltsnoSTGepzIp4L7brqv8t9H9SRtLlAPrrEH9hCTQ==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr1698288wmb.118.1624332061843;
        Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x81sm991196wmg.36.2021.06.21.20.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
Message-Id: <6b577969734e9d69dbfbc6f0d523f64454dacab8.1624332055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:50 +0000
Subject: [PATCH v4 10/14] [GSOC] cat-file: add has_object_file() check
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
index 5ebf13359e83..9fd3c04ff20b 100644
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

