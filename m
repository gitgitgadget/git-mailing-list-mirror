Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3608EE14B9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjIFRXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjIFRXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 13:23:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C619A2
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 10:23:01 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-592976e5b6dso465197b3.2
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694020980; x=1694625780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFUDtwnx4Y4jr09TaFBHEV+S1P+Qnwge4MMk0tqPVYs=;
        b=BN+QsYz3unizTf7k/Y+zNm6mBNvrCvlFom3Kk6ra0dUdhCNQAbG2EoWmzLZeYE2vdn
         V3ZeYKApp4/qp7UL0GLkYWKKN8HK+/8knmbZTxxjXJKYsVN45Q2At8htVPvayMv6zWnc
         kmZgPvYXu0mi6+TVIvgUNqD2TEsYKidC8Ngg7eZ7pSxAoA1J7DXvw6axIYOGEdBeVEWa
         6t7PLCzLd4AIsUp3PXfAxr6Hv9wKspyIoIsvEESfIjlBii1NOLpnuWDfqN23eobIwEBN
         5WEzhZOuYB/qlvq39war5VhHP4GeMq0EqGyeaP96jmaingY6brwECTRotHSeblPMEP78
         hR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694020980; x=1694625780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFUDtwnx4Y4jr09TaFBHEV+S1P+Qnwge4MMk0tqPVYs=;
        b=jBp82dgAfD/e/X/8q5wVMGHAF5B6kziUmvvMecLH6EETi53m16X0Q2WSc3uP7vyMre
         1XaTiNxdn8qhwdjzVCzGplxfEqC4r0NTIP6hvutZURCD/7Ja2d+dM7roPIK4RoD1xl9X
         oBVET6nwj+EwFxrZU9jBZ9BpxdXCW1xoKKYzvssQjZsr7oXTcuuM2kuRhYAiHJmYIHX/
         aIEt/6K8ysOcOx4X5o4GlFwWFHDoxs62760hOoEwNjnTaW5F4ML84iBX6hHH+j5ko2/n
         0IzyKHezv4yd4YNhDISh9Tc1s8bNAcfs0Tyy21WuscFVkRQBI9gfH90tpviVrpX9F4V5
         Pwog==
X-Gm-Message-State: AOJu0Yyr4N7AO83Dc691S51ipJhml1UsqIs8P7bEISqqvBTXMiBpkNYP
        JVikL+/Jn7J0oByzsC8Aa4Ecvhah3z8KtRmwGt6hmA==
X-Google-Smtp-Source: AGHT+IHtURAeP0asGuvcryejnWdvsE5GbvwUVWMH2BIZSbglrJGtt6f4EuhWg9JWEpFj3wJf+ThD+Q==
X-Received: by 2002:a81:9e0e:0:b0:586:a684:e7ba with SMTP id m14-20020a819e0e000000b00586a684e7bamr19126058ywj.39.1694020980597;
        Wed, 06 Sep 2023 10:23:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r133-20020a815d8b000000b005704c4d3579sm3865433ywb.40.2023.09.06.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:23:00 -0700 (PDT)
Date:   Wed, 6 Sep 2023 13:22:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 7/8] builtin/repack.c: drop `DELETE_PACK` macro
Message-ID: <ZPi1c98o2fKB/U+e@nand.local>
References: <cover.1693946195.git.me@ttaylorr.com>
 <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
 <xmqqh6o7nsf2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6o7nsf2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2023 at 10:05:37AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  builtin/repack.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
>
> The reason being...?

Wow, I have no idea how this got sent out without a commit message! At
least it was signed off ;-).

Here's a replacement that I cooked up, with your Helped-by. Let me know
if you want to replace this patch manually, or if you'd prefer a reroll
of the series. Either is fine with me! :-)

--- 8< ---
Subject: [PATCH] builtin/repack.c: treat string_list_item util as booleans

The `->util` field corresponding to each string_list_item used to track
the existence of some pack at the beginning of a repack operation was
originally intended to be used as a bitfield.

This bitfield tracked:

  - (1 << 0): whether or not the pack should be deleted
  - (1 << 1): whether or not the pack is cruft

The previous commit removed the use of the second bit, meaning that we
can treat this field as a boolean instead of a bitset.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 478fab96c9..575e69b020 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -26,7 +26,7 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4

-#define DELETE_PACK 1
+#define DELETE_PACK ((void*)(uintptr_t)1)

 static int pack_everything;
 static int delta_base_offset = 1;
@@ -96,6 +96,10 @@ static int repack_config(const char *var, const char *value,

 struct existing_packs {
 	struct string_list kept_packs;
+	/*
+	 * for both non_kept_packs, and cruft_packs, a non-NULL
+	 * 'util' field indicates the pack should be deleted.
+	 */
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
 };
@@ -130,7 +134,7 @@ static void mark_packs_for_deletion_1(struct string_list *names,
 		 * (if `-d` was given).
 		 */
 		if (!string_list_has_string(names, sha1))
-			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
+			item->util = DELETE_PACK;
 	}
 }

@@ -158,7 +162,7 @@ static void remove_redundant_packs_1(struct string_list *packs)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
-		if (!((uintptr_t)item->util & DELETE_PACK))
+		if (!item->util)
 			continue;
 		remove_redundant_pack(packdir, item->string);
 	}
@@ -695,20 +699,20 @@ static void midx_included_packs(struct string_list *include,

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
2.38.0.16.g393fd4c6db

--- >8 ---

Thanks,
Taylor
