Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0232DCA1008
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbjIEUhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbjIEUhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:37:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7570F4
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59234aaca15so29995447b3.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946218; x=1694551018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JDb3tzUE1sg6L9+uU868gPJRyDrC/J8mq2wo/rsO8Q=;
        b=Hf2F2c9BV4OuYYJoiR7fyvOIywdg1aUqo5ZWPzdTyqTXvM1SSaYJIV1WmtBEIpEJgc
         0XHZgBMgxLFbHijspxfvA5iLLVEjrAJlH3KNWXa0rQDLuWKsxyoNfmZZVnfSDpoV8Zbr
         wSYsEa4G3bb3XF1ZJd+IrNNJ/3KhzYtVqwkPPK2Gfj7QmEWfEdWDLCDilATCe97jvEwB
         pDxvDmyMDJr0qNXxMoPhykOmP49fpt9mRPy5fibFWsicesYoGSJH+pm6Q70O5p7ecofT
         I8K9c3YnzlmKyLQg2hE7nXBjUSBgArNll3obSS3K0sff4R6gvpUja/s+dlSQl6gxrKNM
         7xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946218; x=1694551018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JDb3tzUE1sg6L9+uU868gPJRyDrC/J8mq2wo/rsO8Q=;
        b=TUgQSq7Y6Ob1fY0OYLyBXLlWaxIHbT/0yXhaS6OxkaQhn+2Dqy9tq2y0oJX/CBm6Ke
         hQmZeZP/fTUp0VB+6X9uJ2xNHuQL9mIpp9OtRftMgUOBCxmPRodCdJim8v0STuniL4zN
         e/lzsFVFeTtxZcu+qnl+aGDFO54AWT7ZJ7LWrlQ52/18rJPtssc+dJYoevFGy3lDeXQr
         FBWpOUcmfyaeTOiNMgV27qrs94igZUegwQr5rUBQ+pJ4T5HcxlQgCBwyfmNwf/kAwk5e
         H3jpFAE6P0KG3W/s2hVRLKUTo6cJrqbbeHHnIsNKoP9YP6vBirwDEDi79fkAmC/kEsLa
         yDcA==
X-Gm-Message-State: AOJu0YyC59BjHT0/Wx4Nh46+NyOWBNPH6VsgAaCxoV2+UBwPZg14ta3M
        vX6FYP6POIFF8k4xWOpmq5yKSe3BlScemQhbkB2i/w==
X-Google-Smtp-Source: AGHT+IENWzp1sBblsb7foqurCBfAQPM8xrzwRNcyjn3wMxtsTvuGMeNutoBkGB+HPs7icDyIbBXxZw==
X-Received: by 2002:a81:8315:0:b0:589:8b56:15f with SMTP id t21-20020a818315000000b005898b56015fmr15503358ywf.24.1693946217907;
        Tue, 05 Sep 2023 13:36:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w125-20020a817b83000000b0058427045833sm3388225ywc.133.2023.09.05.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:57 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 7/8] builtin/repack.c: drop `DELETE_PACK` macro
Message-ID: <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 478fab96c9..6110598a69 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -26,8 +26,6 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4
 
-#define DELETE_PACK 1
-
 static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -96,6 +94,10 @@ static int repack_config(const char *var, const char *value,
 
 struct existing_packs {
 	struct string_list kept_packs;
+	/*
+	 * for both non_kept_packs, and cruft_packs, a non-NULL
+	 * 'util' field indicates the pack should be deleted.
+	 */
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
 };
@@ -130,7 +132,7 @@ static void mark_packs_for_deletion_1(struct string_list *names,
 		 * (if `-d` was given).
 		 */
 		if (!string_list_has_string(names, sha1))
-			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
+			item->util = (void*)1;
 	}
 }
 
@@ -158,7 +160,7 @@ static void remove_redundant_packs_1(struct string_list *packs)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
-		if (!((uintptr_t)item->util & DELETE_PACK))
+		if (!item->util)
 			continue;
 		remove_redundant_pack(packdir, item->string);
 	}
@@ -695,20 +697,20 @@ static void midx_included_packs(struct string_list *include,
 
 		for_each_string_list_item(item, &existing->cruft_packs) {
 			/*
-			 * no need to check DELETE_PACK, since we're not
-			 * doing an ALL_INTO_ONE repack
+			 * no need to check for deleted packs, since we're
+			 * not doing an ALL_INTO_ONE repack
 			 */
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
-			if ((uintptr_t)item->util & DELETE_PACK)
+			if (item->util)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
 
 		for_each_string_list_item(item, &existing->cruft_packs) {
-			if ((uintptr_t)item->util & DELETE_PACK)
+			if (item->util)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
-- 
2.42.0.119.gca7d13e7bf

