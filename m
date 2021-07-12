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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2AC11F66
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E88360C3F
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhGLLuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhGLLt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D198C0613EF
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j25-20020a05600c1c19b02902269686f585so1007681wms.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BXvbXQ0ubHB2seBzwtG+86JuqzyN8NpL5FHkziqcdKQ=;
        b=Ps1LFUwP0DoiZePhHfd+LOGue5Vg0eZQlI69+JsJNcjQU7bEGbc7wKv7mjKhetk0LF
         Zo9g9yt+dTUnd0hPYGfhakCel3kWlaqEkjp3h3XvBkwMajhescL9cBaamTt/IQAeIKVz
         7qnu5EcFLiYiUat+3lKXDWhtSSL4fgACpOprMLv1oDWuMX6/bqvzDehXyhs+Y/Lf6DeA
         O7jQMFY6KQHJylURi4Aqd3puZFL4xWD2osikinVYdJjwo4DodApyJ6CUEtfH1FoSL9dO
         b8utYcXVtpkdTzw0KlB7tHBD/eww1+roPZrtuNcFUPrBRQf3jxXuxPhq+bxWXZ0XA8xo
         Ccdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BXvbXQ0ubHB2seBzwtG+86JuqzyN8NpL5FHkziqcdKQ=;
        b=RjN6GZy1T4A7uGEwSDuGoTeVy9X3tPBF60NFob3ZrWsjaMfB0B5Iegeetahm47djxM
         KMLkFrEJ0MhrAfDC+oKYW2JsCgOYpA81LyaIXDnFYZ9zYz2CYQWiVtOp0761DzEKULQt
         eWQYol/N+27Tq7FO8i2LESYnvxxAQriSbF2lwxiv9O/o0mzwtlWIvMFtMVCl9/Pe7POW
         T89LJWpZUqMGlmADk+QzS3qPSB0AlPFyWEm7bGMkhUgF7GqXi/wBoy5a8t/7QLKgJwjP
         M0HADqATLR9B4J9f6QVspgfFNv3iN9A3Cd+EbJw4DQkzvD4dBS2WZ2becjyMZF5aYLx3
         WlZA==
X-Gm-Message-State: AOAM5339/dzePjnZn6oYjmVvXVkf86NA1fdAspsOlIPBlOZ2F8UTQVwF
        FJ1dnEsEa2f/Tu6Ued4dIXoZskkfBgk=
X-Google-Smtp-Source: ABdhPJySlvMTQT+OqS/ZAfMi1Zaw/Xi8U6xz4zc16pHSRRuHiLz8jkHpbpY9un03aoQKEvn2rVHP+A==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr55867658wmq.9.1626090426050;
        Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r18sm7410810wrt.96.2021.07.12.04.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:05 -0700 (PDT)
Message-Id: <6ad42c964053c9342554d9b43f8cbbb0e69385ad.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:49 +0000
Subject: [PATCH 09/19] [GSOC] ref-filter: introduce
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
index 3189872188a..80b09fce1d5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2292,16 +2292,21 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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

