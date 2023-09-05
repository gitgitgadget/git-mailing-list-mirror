Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A9CA1008
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbjIEUhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbjIEUhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:37:03 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A0197
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58fc4eaa04fso30087517b3.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946215; x=1694551015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASFF6ACfQmXR2E/jS2JSQg2gWuVPyob+iPpnASfyzyk=;
        b=kYWeqPsdGXyLzIeccoANNFtSrx3wXhQ+U/9oZ71bREQ+Jrt52vRLL4cE5mnIdT2DUi
         l2xK6JaaFjAU63/JXZntqF3uCCOJJ99wC5cVw5EzRKg6gzKWRqzxOD03Ca/Jtj0XBJAw
         hhWq5czR1X2LfhJRMR9OmkH5tvTb7KOOw6J76DFXMRaCZuqVcHVpw5eMG4LL5T8K2bQO
         flQrWh8tXXV8pAWn5Hhz3NgjvQ1WJ1XM0Ot+j4f7zL8DQzkCTvzArMDGYm7361xHlu9D
         X0Ytv1mCiGtAZ3fX+ongdywimC9JjK1dvOoFMYPRtlMJ4Q4OtlPUWXfi4p57kcp7fSdw
         Dxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946215; x=1694551015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASFF6ACfQmXR2E/jS2JSQg2gWuVPyob+iPpnASfyzyk=;
        b=TuHsD2yLWdbKtVVbNeRrQRD75KtiG6WPrRll0XgMSjukjTTSH+yA/j5xNe7LEhIwRL
         V5TRJEJnC2BeDMp7buMhYLdGSkx7nwDsUsEX5x7TlHqM5g/zW4PBju95v/NV9+hniuKz
         1gW1JwbevCdfDArRoRNU7Vv5kCpReOAxcAstBpTwUWgV1V4U1h19sqDtFfwffpsyjzxI
         vbTIVFNiF84FHF+y9+DZJwLbMFdpq9rIOQhT0lxOW9TX1T5g3K5vu5AJjVB/V68UJQNI
         5PkVDUL+dqJBXDnpZ0vm/7JNda+DKnASz1e1e6o1sY42k4b0tW2zXc4/Tkn79JeOMLK2
         mUWw==
X-Gm-Message-State: AOJu0Yz0kdI6l8Owihbo6Vo9NGa6nRhirwU6Ha8EFXm50jrGIF/pgRlt
        UQKKiwz/Jwml3ZfSafFN4SMvX/8pONwdTwmmx2o/OQ==
X-Google-Smtp-Source: AGHT+IFiZxARE9AJGfqdrp8RfR4yEaS8jLWJl1S/UMZ/CK8+bn53anUzGh8RuCMm8LFWYZKu5M/+uw==
X-Received: by 2002:a81:9988:0:b0:59a:e672:5a03 with SMTP id q130-20020a819988000000b0059ae6725a03mr5961009ywg.44.1693946215190;
        Tue, 05 Sep 2023 13:36:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o4-20020a817304000000b0059b1e1b6e5dsm174973ywc.91.2023.09.05.13.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:55 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 6/8] builtin/repack.c: store existing cruft packs separately
Message-ID: <414a558883830a29924710126960074b37ab97fc.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
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
index 3f0789ff89..478fab96c9 100644
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
 
@@ -836,6 +841,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
 	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "-%s.pack\n", item->string);
+	for_each_string_list_item(item, &existing->cruft_packs)
+		fprintf(in, "-%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
-- 
2.42.0.119.gca7d13e7bf

