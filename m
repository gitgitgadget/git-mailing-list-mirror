Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469A9C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3BE610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhHMIXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhHMIXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFDC061292
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q6so618174wrv.6
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y20aWlRrxOJLaEfYStQAZHABxNh2sm7uigcSyzncrgA=;
        b=P8bTZ4Tnk1853PbV/I1MZrlpRbZWki74fkyV51udp12dKnu1HIXsC8WxROusTKawLj
         QguPp5wLGZZsuK0Cr1nqai324bQQfj+Yqqu9bXHjlA+8jeh+rNvBIpjUTxDADxJZ0iYl
         JdrBVBW7m1trS4vGAnzyEolmzfDLzZwKXtDDSf+o65QY3/k5jquD0thjRDWD94CPn2Du
         Frgcia5QQ5ujCKuTnNG7f38BAy2DtIutrnHszLaI5hqqWL+6/4avngl10QOFs4sjWcsQ
         TczWmsYevuuf+azAnMtk/xjog0u1jgmuybeXkmOdvwNf3Dd5gPOVXMWAaZg03RFY5ZRW
         h57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y20aWlRrxOJLaEfYStQAZHABxNh2sm7uigcSyzncrgA=;
        b=X1SvGA4fDMD5Gw4l25HsrZqW5DM2QIXx+jW+Kwe6BSwMCb14G3qhvHYQwKQLweUThX
         antmRJK/gTVODqidV7ltxV7i4FGhY1H6SLesdKPdI09wfyY2CUdlhyfLTJHjG+kj9Gza
         eBq7pCwhRCVRMFz21Ray3ev+4U6Z1sEoT7R/JNEWl2S8ka1LKUbpWCBBsSI5JKyEcZOw
         lkFLLDoE6pHiZ6MwDJ/JAFFqcmM574gPk6DLIapjV+013nE6jslIZhn9SxX3VOyabRsg
         nUjsnA8CnuD7ULemnvMmG9mGcib6Hd9ZmP4QaqJ7ojZXau9QKZ5JDVeIV9FbWwJUUTPr
         RX4w==
X-Gm-Message-State: AOAM532fcm7B3+nBl97hIco200l3NFu8Lju2xvBPiSQZFkegIJ0ppUvi
        uZBflccr4h4WRLZSF4iy+XocMVaOLi4=
X-Google-Smtp-Source: ABdhPJwIUj4+o9SxO8I/48Z8TBG6KXRyYcGLKglKP97rQ5ZXQJ3gvdvlUoLXE6lqReaDRWpUzkaY2g==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr1716896wrv.72.1628842996408;
        Fri, 13 Aug 2021 01:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm711927wmi.4.2021.08.13.01.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:16 -0700 (PDT)
Message-Id: <9a6e39c4c9994362212551ec99bb2291b27b78d9.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:50 +0000
Subject: [PATCH 07/27] [GSOC] ref-filter: introduce
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
index 2fd3b69f6d6..7df7f06002b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2300,16 +2300,21 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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

