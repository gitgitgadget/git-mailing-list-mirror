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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B8C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC5261416
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhGAQK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhGAQKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0CBC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n33so4892530wms.2
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g3vjHjNnyLQTmf+en7FqTd/OE8rsXg7l/gd2WpOyhZ0=;
        b=Arf3hjyyMREtqv0ipmw/FUvHUYgDUyPYo1vLP2w0bmtH/ez7CIZvwQmktLBdWDGour
         qvujVFBC4wcvFrWgbht3auqlffKnmmSPRCvGgR7D0Htda0ZpHD6efFGPqKBd74AEHWd5
         tKNk205YY/Rlcdsnjs2A10ltLBN0f94eZJim4Zz0xz69AVSnMpMUDotccMIjrmdbFh61
         SXy59xL8SrwBb6pXUiSXrhBwpdWVBmgyQ1utuHaOQEMQNDJrfX7esrPj+TAaGxxlVBP1
         6Ci9wtt8HZUYwwqxsDrlUoc1O/vmBbWpCiQu9vbAwlyKz7iLtQ0E4Xrh59nzhck0njwn
         YKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g3vjHjNnyLQTmf+en7FqTd/OE8rsXg7l/gd2WpOyhZ0=;
        b=Oz/LowsYqie9rxDr38PzHewihFaLqmWSb/Hthp9ITs7cjj7QYNwpYOj3k+egwLzo9V
         /iSZM2/suLmBAJmEHJjpNXnURpi4amzDEe4sCBalBIyCFvBKbBqQEiNO3H+t607cxmFS
         eJdwzKepZ8x7Pre3YARQNCSYhnHZL3HSTofKcZP3ZV9o3uP0XCnsag4LMqbUHomB81Fl
         EG743R2ELVUspWmSDNBDsq40AMcg4YLIXP801NObopCLQsY5Uxbq5WdeOUIc0birSIHR
         zjW7E7jtYPKTkm+5V9+TlUbBH+7lZClKchUmB6V7ItF2Fq5/Weam4YRNnq3Dwd4lit3N
         Fm/g==
X-Gm-Message-State: AOAM533PudDmqAk9jx19NO/1VVi9CNVbxgTQIn8EEXxWZCHsQ0sfOhs4
        ymCtytUpGRmvfrDa9wr0Fl85QPFBdEU=
X-Google-Smtp-Source: ABdhPJyS/bGDJpjVZYJi9frbOciqnFcb/0DUq65SnvBYefr2iwP/YQ8mgWxbZt3CTOsh+vqvLEBEUQ==
X-Received: by 2002:a05:600c:3502:: with SMTP id h2mr520984wmq.68.1625155699083;
        Thu, 01 Jul 2021 09:08:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y66sm435383wmy.39.2021.07.01.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:18 -0700 (PDT)
Message-Id: <ac97ca70234240f9b67892c9a53b431f972a290e.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:05 +0000
Subject: [PATCH 07/15] [GSOC] ref-filter: introduce
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
index e4988aa8a24..731e596eaa6 100644
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

