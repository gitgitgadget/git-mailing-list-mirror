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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E2DC49EAB
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DF161C51
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhF0Mi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhF0MiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B435C061787
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l8so8264764wry.13
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g3vjHjNnyLQTmf+en7FqTd/OE8rsXg7l/gd2WpOyhZ0=;
        b=d7Qm/jUmirjycLyFAm5AlM71xP61/tur4/reY2/4U+Kl9dLlobYKsHl1bz2bs2URbk
         GEbrRMugcTRA6DOBNYU4WC8ELfx9iJkQtJYWxwNHk52hQyfmBjHPGc0nYNosSWCP1+IP
         g0j2Nmjlcg537cexgMb5SHzUIS26fyu6IBWIz86Y8labGqAF5DY3bygOPHmX85Lhp1Do
         uP1SzpooxPXovcBfd9SZRHN144mW8T9/g807MSBwKUTFOBZ6moxGnn0Njm3RnnfiGTw+
         lK9Sjqaj+oBuy1CLowYBg8BTXW1x5h2GDTFJCTdYjkKeQ0TFCtb7cwOnKONfEvI1ZD7r
         IRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g3vjHjNnyLQTmf+en7FqTd/OE8rsXg7l/gd2WpOyhZ0=;
        b=SwMGXitNTF1skpGxHT8g1M8nCiKqgBprfYqEp0kTYFXHz0wKFXFKuJMbS8iEw+a3DQ
         SVuA2/MAqVSG683noB11y+ShCPwelC3Y51sBbVByZkmlZMjmkr5SBPc/Tb3f+Xb+Nec0
         oFmVYdwjkTuAbmH5SR+L6zuQaAidEhu23nGAg/I+krAljxssvRet7hsTZhqCOEj0GEev
         opz7Yn/EmKeY+7TcJuBfv3cDi6hE/Ht9LzwkUa/iJwVVMSFbO84rCS4V9KkUzbbjV04g
         NB2sHUtG6/bccLxUIODkWM6pRhoTuUKXFvQD08kXvHHSF7PZsbK/kmxpGDWN5QplTseK
         bHJw==
X-Gm-Message-State: AOAM533R+Ow+2VabJbnH/yClxFNnAberzLWCcqhfb8RjthphJSgQH6dj
        2hvsl0JNEpN7F2Vv4Zd8Vi3XAU+Q12A=
X-Google-Smtp-Source: ABdhPJw61euiZ6cJT6TT7WnMxwbF1/S0A98CKullQTxqOf05iFLWHZq3tcObZ1zODwJvZs94SB53NA==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr22405681wrw.41.1624797356744;
        Sun, 27 Jun 2021 05:35:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm15673411wmf.20.2021.06.27.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:56 -0700 (PDT)
Message-Id: <e592c21ea1d74f37e9a217424e734863c4683b7d.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:42 +0000
Subject: [PATCH v6 07/15] [GSOC] ref-filter: introduce
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

