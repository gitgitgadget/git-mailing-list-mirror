Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E69DC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D43610CD
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhGLLtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhGLLtv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B59C0613E5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v5so25205074wrt.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R0c19oCV7JaE9Qk6Yj5Q6fZFwz5yzSxqyBk+M85AK50=;
        b=LrXCy86/kvZp+5pb/rjkWxAMFkX1vMSQaBjLeLuwnXLUwP6VTIaDhMk9A6vE2qmWfB
         VFlKloNV95cu8xibtvwGe0uYJXMBo73pwE/vEUr0f5IZRAxW0Nskb7enh8Ph/Vv3z+NH
         DmvLMX4+GNqpYDKrbW6T6336gt2VENMD3FetpwrwRpPVo0bzA6+ohZQQQ19Jh8hRHEQm
         GwpZARzjO1BvCvrYyiA+aE65QfX3BI0KcDXWE/d+x07PJusEZmO+BpOpONqoYuFtruYA
         8+7ndC43Mcty2VegXkWcwLkXRM+NBPPwFkFE0ulJCk4riyMTKMP2usVV4D925bePuToB
         5oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R0c19oCV7JaE9Qk6Yj5Q6fZFwz5yzSxqyBk+M85AK50=;
        b=G5kMdlqlMnyefUT5YW27NYJXeutbarwkku3KurUGWoamCJtRWBV1USMMyEPT5NXmYI
         TxieId0mZhqrhwOos4AV5iUVxfBUsHysrREwQpO8NPo7OAokL26LaJIv5Jfq/daROrkg
         jr2R4Ey+syEOlMODCk9Ep6n2+GlKrdocYY8+LdN/Pi28qZS06tKyZhTDjyhsxDqM9HuZ
         mXmhIR+/2FVL2TnWCrXGZy3LCnz4zzLjtWJyYbgKucL8mBhnuGL34/AeOiS8l3pY6mpr
         BkHwDHiOC0axKcMdoEvFj05q/qK/Ri1Vc6HFxMmGiwVr/ZpakcwLUBh0p4gfYDJs0nny
         ULAg==
X-Gm-Message-State: AOAM532PA3SEw4A3/4n01bksy0QriM/FwSb6PNWLlTSAvJDpxC2MhLia
        mvojMOvsU8N2eBSArG5DSdzvqtgAxRA=
X-Google-Smtp-Source: ABdhPJykrYoVwBty5PyawEv2L4JQlMiK6WFQOzcmssGFGJkSF+cFuIhWNOS15xNMdJ+iJkE46WmblQ==
X-Received: by 2002:a5d:5142:: with SMTP id u2mr31445744wrt.314.1626090422024;
        Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20sm13005163wrd.70.2021.07.12.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:01 -0700 (PDT)
Message-Id: <1332006006f4596122aa05afcb2b35f3ee781e1a.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:42 +0000
Subject: [PATCH 02/19] cat-file: merge two block into one
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

There are two "if (opt->all_objects)" blocks next
to each other, merge them into one to provide better
readability.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 02461bb5ea6..243fe6844bc 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -520,14 +520,11 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
+		struct object_cb_data cb;
 		struct object_info empty = OBJECT_INFO_INIT;
 
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
-	}
-
-	if (opt->all_objects) {
-		struct object_cb_data cb;
 
 		if (has_promisor_remote())
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
-- 
gitgitgadget

