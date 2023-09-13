Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A5EE020E
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjIMTSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIMTSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:18:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EA1BCD
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:59 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-590685a3be5so2065117b3.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632678; x=1695237478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bx2exNJucV3lvU1J+WGOSw53yJledT2LKaXdlFpKl9s=;
        b=z0lVaYm0xjLUXHuY+kb69gJ83mHfiSl+2Whq2YCrbY9j6E40wbhNOs7MXLvdcBSi0z
         qqsNVfpAdr3vUkudiQaRLYVK3kV1PRh6K/CuzF2OEEs23J/XUUq3CJEv6ZwR0e/e5RUf
         JMmRQEJwbXKoZG4a/8wb+19Mr7eJZXVwUU8ScSykaID6LAEDdftAA9VCTJ9/sVGWiIzK
         pShRHJkva8bnjvnEa2aHgHUFBPIY+FPwFk5aAxYql/box6xeLs3j3dkas6iqE1ryNIqd
         1sqg+aHrVzl4PLRpYx+NPl4+NPRPCmNSpuQterad8rTsxPwPwNZP5rlnBEbcnLGzN8Wq
         Bybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632678; x=1695237478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx2exNJucV3lvU1J+WGOSw53yJledT2LKaXdlFpKl9s=;
        b=Z4XghTdmjgs4FAoyL6idlmvISpnDgsMrYs0mnwY7tK/Nu5bSrI/c0ZOb7S9LYhANTZ
         1qcW1zBxpKZDL7gA8XFj3CPgd3vCcUexpnVSFDKUbc6VKhqiYxi07CfLtIaI6gtfZDgs
         6acAhS79HLtoEBXZ+Bj7245kgQBdH/nS6FRCE/EA4O/h9fzJ2NS5nJaCZ0RidNMwI2MR
         uXr4Hm5ZuqiO7tBienJanFvhFPEMwR97M3fGY4Asl5HQppoSnHiimbTcSk2t9ek7zL7p
         uwmeUiQCzMYmBXryaUjZWuCChQqg90moGKdeSnL4WdDPG/7YEkLDQpjaVLjzszsIzL3i
         LtPQ==
X-Gm-Message-State: AOJu0YzxAZC7/R2zwoKq2ISjdQApBzt2B3ZFeASBtGjnCsPO7S5kt7hv
        jlud0vWO8bYar+P2I8pyWmwW7+w33c0ffXoCHD9s/w==
X-Google-Smtp-Source: AGHT+IHSeXOATheLTIeau2pUy+UVDVVPxY/DMnDogL2kngOKdr8QmfOuKPaYbC2Qz8SyGqpqxCBRXA==
X-Received: by 2002:a81:9c44:0:b0:571:11ea:b2dd with SMTP id n4-20020a819c44000000b0057111eab2ddmr3473734ywa.32.1694632678570;
        Wed, 13 Sep 2023 12:17:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a81d34f000000b005772abf6234sm3259020ywl.11.2023.09.13.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:58 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/8] builtin/repack.c: store existing cruft packs
 separately
Message-ID: <d68a88dbd5606d532b91761ae1acdb410fa30e85.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When repacking with the `--write-midx` option, we invoke the function
`midx_included_packs()` in order to produce the list of packs we want to
include in the resulting MIDX.

This list is comprised of:

  - existing .keep packs
  - any pack(s) which were written earlier in the same process
  - any unchanged packs when doing a `--geometric` repack
  - any cruft packs

Prior to this patch, we stored pre-existing cruft and non-cruft packs
together (provided those packs are non-kept). This meant we needed an
additional bit to indicate which non-kept pack(s) were cruft versus
those that aren't.

But alternatively we can store cruft packs in a separate list, avoiding
the need for this extra bit, and simplifying the code below.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9ebc2e774b..8103a9d308 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -27,7 +27,6 @@
 #define PACK_CRUFT 4
 
 #define DELETE_PACK 1
-#define CRUFT_PACK 2
 
 static int pack_everything;
 static int delta_base_offset = 1;
@@ -98,16 +97,18 @@ static int repack_config(const char *var, const char *value,
 struct existing_packs {
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
+	struct string_list cruft_packs;
 };
 
 #define EXISTING_PACKS_INIT { \
 	.kept_packs = STRING_LIST_INIT_DUP, \
 	.non_kept_packs = STRING_LIST_INIT_DUP, \
+	.cruft_packs = STRING_LIST_INIT_DUP, \
 }
 
 static int has_existing_non_kept_packs(const struct existing_packs *existing)
 {
-	return existing->non_kept_packs.nr;
+	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
 }
 
 static void mark_packs_for_deletion_1(struct string_list *names,
@@ -138,6 +139,7 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 
 {
 	mark_packs_for_deletion_1(names, &existing->non_kept_packs);
+	mark_packs_for_deletion_1(names, &existing->cruft_packs);
 }
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
@@ -165,12 +167,14 @@ static void remove_redundant_packs_1(struct string_list *packs)
 static void remove_redundant_existing_packs(struct existing_packs *existing)
 {
 	remove_redundant_packs_1(&existing->non_kept_packs);
+	remove_redundant_packs_1(&existing->cruft_packs);
 }
 
 static void existing_packs_release(struct existing_packs *existing)
 {
 	string_list_clear(&existing->kept_packs, 0);
 	string_list_clear(&existing->non_kept_packs, 0);
+	string_list_clear(&existing->cruft_packs, 0);
 }
 
 /*
@@ -204,12 +208,10 @@ static void collect_pack_filenames(struct existing_packs *existing,
 
 		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
 			string_list_append(&existing->kept_packs, buf.buf);
-		else {
-			struct string_list_item *item;
-			item = string_list_append(&existing->non_kept_packs, buf.buf);
-			if (p->is_cruft)
-				item->util = (void*)(uintptr_t)CRUFT_PACK;
-		}
+		else if (p->is_cruft)
+			string_list_append(&existing->cruft_packs, buf.buf);
+		else
+			string_list_append(&existing->non_kept_packs, buf.buf);
 	}
 
 	string_list_sort(&existing->kept_packs);
@@ -691,14 +693,11 @@ static void midx_included_packs(struct string_list *include,
 			string_list_insert(include, strbuf_detach(&buf, NULL));
 		}
 
-		for_each_string_list_item(item, &existing->non_kept_packs) {
-			if (!((uintptr_t)item->util & CRUFT_PACK)) {
-				/*
-				 * no need to check DELETE_PACK, since we're not
-				 * doing an ALL_INTO_ONE repack
-				 */
-				continue;
-			}
+		for_each_string_list_item(item, &existing->cruft_packs) {
+			/*
+			 * no need to check DELETE_PACK, since we're not
+			 * doing an ALL_INTO_ONE repack
+			 */
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
 	} else {
@@ -707,6 +706,12 @@ static void midx_included_packs(struct string_list *include,
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
+
+		for_each_string_list_item(item, &existing->cruft_packs) {
+			if ((uintptr_t)item->util & DELETE_PACK)
+				continue;
+			string_list_insert(include, xstrfmt("%s.idx", item->string));
+		}
 	}
 }
 
@@ -835,6 +840,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
 	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "-%s.pack\n", item->string);
+	for_each_string_list_item(item, &existing->cruft_packs)
+		fprintf(in, "-%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
-- 
2.42.0.166.g68748eb9c8

