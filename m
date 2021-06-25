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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65911C48BC2
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3EB6196E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhFYQFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFYQEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D19C0617A6
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r3so2061678wmq.1
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HpqslNZoUVwD073Xtsuq4EgEbeUegw9CooHr/ZNAVwc=;
        b=HokEFIa1LQUXdcEipaS9oWJR6hvR9H6o32PyIMFsIK13KlVB+rsAES/rhvixwxPSCG
         4wXpHm0wVr2+GxnDbKFX0t/WmT7U20yiVnoTIQsF368Yrbbm5yP60nYQXpRajwVd3aOQ
         YeL5zDxEXUmSLGJiNp5Dz2ODEp+qzimojiXgvmFXgqmH/MKePU90f9eOxA5d/a82X88P
         EV85EosskHc+2SHeMI/j2SvTEMGWQDDbbVFbkoYC40z1Fa3JMdk8FozQoNkN+2TMUYhQ
         AN4CYmuJy3iFBL2VlVJifJbTQLZAmJPr2n/ao80qBW9MnkQ/3r7cO0Ggzkz3LlmtG6dI
         B+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HpqslNZoUVwD073Xtsuq4EgEbeUegw9CooHr/ZNAVwc=;
        b=ods6A3Bs8ykFrFs6IwHsC897TBsF9fU/jJXfYvmU6AssWn3b27Wp7nNDaDZbGcUYai
         hPNnDMCuV/WalNdJx1hgCfj54WXNcJ/K52/BAvBDammaQ7vHy7OieSQP5tKD87OYrIDy
         +479NL20JWkCzhx2C5nmVutQGjxvg0QMd74W61sPoWPVPUU8G1y725YmcnJTTdhukVzR
         tDX7Pw1P9cNdVk3F3Tg44Xa5nFFDiDcpd1MpHDA774kLgTUcuInKfHQXInWtXsDsOEP5
         e+t8Xq+WmYDeUV6QadpQSDBRa6e3hBHV11PVli30JaR61dEJ6vFmnQWAszSXf+nmlnmg
         BoLA==
X-Gm-Message-State: AOAM5308ZzponCC15RT1k0nB0hAAAHWKf/UpuQYURoRqcM0YP5NITmvA
        nb6oT0oPDwgcNKoHRDix2nI/AnbWgQs=
X-Google-Smtp-Source: ABdhPJxSMU5l5OLubDOHEhJMuFgMvfND94cFD8W2EH0jZom3EMsSepQtHMOXJYdt5PcrLTazDDkljA==
X-Received: by 2002:a05:600c:3ba6:: with SMTP id n38mr10467300wms.9.1624636952135;
        Fri, 25 Jun 2021 09:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm2371700wrt.76.2021.06.25.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:31 -0700 (PDT)
Message-Id: <2a48a48e81c6389c1eb8dd943bb8e323ed574bd2.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:17 +0000
Subject: [PATCH v5 07/15] [GSOC] ref-filter: introduce
 free_ref_array_item_value() function
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

When we use ref_array_item which is not dynamically allocated and
want to free the space of its member "value" after the end of use,
free_array_item() does not meet our needs, because it tries to free
ref_array_item itself and its member "symref".

Introduce free_ref_array_item_value() for freeing ref_array_item value.
It will be called internally by free_array_item(), and it will help
`cat-file --batch` free ref_array_item's value memory later.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 ++++++++---
 ref-filter.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 58def6ccd33..22315d4809d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2291,16 +2291,21 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-/*  Free memory allocated for a ref_array_item */
-static void free_array_item(struct ref_array_item *item)
+void free_ref_array_item_value(struct ref_array_item *item)
 {
-	free((char *)item->symref);
 	if (item->value) {
 		int i;
 		for (i = 0; i < used_atom_cnt; i++)
 			free((char *)item->value[i].s);
 		free(item->value);
 	}
+}
+
+/*  Free memory allocated for a ref_array_item */
+static void free_array_item(struct ref_array_item *item)
+{
+	free((char *)item->symref);
+	free_ref_array_item_value(item);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index c15dee8d6b9..44e6dc05ac2 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -111,6 +111,8 @@ struct ref_format {
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
+/* Free ref_array_item's value */
+void free_ref_array_item_value(struct ref_array_item *item);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
gitgitgadget

