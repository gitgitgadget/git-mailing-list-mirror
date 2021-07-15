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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3164C47E4E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D0D61396
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhGOPnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbhGOPn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3662C061765
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so6337049wms.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e0jaRxoSDbvjSbYc4km+v8HozV2Lm56nE1KTtjAQGpk=;
        b=MujnGlcX2peD9/ZzdGFGh5em+YdMgvI856ww8BKpYW4AziLLvFaVHj+cFxzmllnnpP
         vB8cilujQU8F2CLcX/D/YiZFvt868REY34+efV3x0XSRC9SggS+eVj7qv4trJdkh8Vh2
         bzxBRakzuX4uuQphQYAxz5jc7vvPo7yYTR7HTsOEKNHOiyFntjJLW7fo9RPrNhoxdFW9
         Y7EfP23pchTeOngKy1UKKLwojFxDk9o0NQ13KnkIJ8lZfC7+/K2CdW6qedJESF9RlvdA
         T48tNnME5jWPBGczcpZuhvSuahBr5GUJyAUAGm9o92s459HzrK2AEyJcCiiSW0rqUMZU
         VYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e0jaRxoSDbvjSbYc4km+v8HozV2Lm56nE1KTtjAQGpk=;
        b=d91Lyu4MmvagwXIncqXmUjQ1UZu3knuLFn35/gOc0BI1TIWaGX7JgcNkeNPpEXsyy7
         DDOJ+/24n1ktv4LhNYLxuEWb8jVohgCg9BOqXOoUCH2kV9J1q0Roic2hfxTanRy1+Vev
         lW2zcI0FVc1XodtZU1r7ybsF/6hfDGS+NSkqZyxYEBAeo5QxUV8LtblEjBEb3Cg0BtG0
         l64Vht9tGI031Gui1w+IsFSrp/pBuyxkU9lysr+A2Pnbjr0nufFMV7d3JYc7AQ5be2ZM
         4SY508dfJcBbqqTcf050aanK0S72Tiss0/IVYMMPSsiF3whiT8hliiG/UYRTjCySzJO7
         HJsg==
X-Gm-Message-State: AOAM533JFTrvaX8rbYsOeo/o4dLjuOHTx6Wd+r+XZp5tL/I9m/XLGl9n
        8WUAjr/mL8VLh+mIN1R/9eU39zGeJ5w=
X-Google-Smtp-Source: ABdhPJyrPlScV4qZVxwi9pWo2rf3afIRAdhrlx1/LN34bl+oHDP2f45PKiYdK3FjROUe/Nzwv5SrOw==
X-Received: by 2002:a05:600c:4304:: with SMTP id p4mr491732wme.93.1626363632583;
        Thu, 15 Jul 2021 08:40:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm7359760wrp.34.2021.07.15.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:32 -0700 (PDT)
Message-Id: <e5cf5541024fb1744d1b9e8417d2148129c53f8e.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:15 +0000
Subject: [PATCH v2 07/17] [GSOC] ref-filter: introduce
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
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
index cfcea0e507e..d70b295672f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2296,16 +2296,21 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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

