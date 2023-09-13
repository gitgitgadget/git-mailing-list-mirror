Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C3EE0207
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjIMTSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjIMTSG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:18:06 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1F1999
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:18:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59234aaca15so1744967b3.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632681; x=1695237481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aa83gloW/RSLi/CWbT6UII5KKGTKMtXEFWIeXs8Yq7A=;
        b=O+Hikdc9l0qkOij8V4iOGxgG/KhgnrL1oWx6mPMwSg5h7oIrLoA4t7G1+DB49DNVGC
         wPU7x5KGyOnUg4sir7Ola7FyqewiZv7cwnyatKNrkzhq48lMHA1ei83p/uT6rXxrCCur
         wSl7GBCzAPnIpNNuGQANxXkA+l4Oq3KbUh9M+BQRyadFMOqYRySFSFploGe36hhIK3Si
         cdirqFbFo3C2CqKNofJt/r5PTY9KsFfQuHAd6JhRvIZcT82QPNDFiZx5AMsEHY7STc5f
         bST3kXdeWb2Q6pVJwwWQeLZg85VA4gTHr0ulCdXWNdaYsvDi5nueGbsnCGExLTWCmgz+
         yCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632681; x=1695237481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa83gloW/RSLi/CWbT6UII5KKGTKMtXEFWIeXs8Yq7A=;
        b=boIidforqwuroSutedH6PNZPC8UdKFQHpwL7vDy6dH9GOmVKJBtNKH7yaJEatK5nUI
         4rruS+OLqP2EFgIEdz1yXA2Np5zBVqgTAYYlMTFVZcwsxYfvTwx1DExwAlUwgp9W1BBf
         S5xm18GHFFyZDmHSqMCRYkv+aHnv9uA8oFljHCM9NdH0RLDHcCc6EhScEtFUT6tJwZMH
         f55Crh49ONI0yqwSNzAov/rKEnfzg1fT2z/XfXir1ZpBm5BZCcJF1stYqgwq49SqYk+N
         jdBRtxSfnpsnUz0u4snT1kOFSNERribAnG7r3eAddWBtMRhIDqxr78M5Ssq9dBHZp7RS
         xMSA==
X-Gm-Message-State: AOJu0YygXlvfxVoMBmkEeCPOJiuZsac6iQHAYC/A5mgPPGJffzRtSepc
        GwvcX82w+iCPUfJR59wr7E+tPe2bjPVS4Y3WExjcIQ==
X-Google-Smtp-Source: AGHT+IHD6Fsg9ovE8eod0Qk9bbFh48OkKD9Q3N4NkZ0SJgaMxC2xkG1ELS5wJ8y3BQf8GjYljCzCFQ==
X-Received: by 2002:a0d:cb0c:0:b0:57a:50ba:b3a0 with SMTP id n12-20020a0dcb0c000000b0057a50bab3a0mr3300647ywd.12.1694632681418;
        Wed, 13 Sep 2023 12:18:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020a0ddf06000000b005832ca42ba6sm3270787ywe.3.2023.09.13.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:18:01 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:18:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 7/8] builtin/repack.c: avoid directly inspecting "util"
Message-ID: <481a29599b1871af4f58a68bdf227b1fe477d365.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `->util` field corresponding to each string_list_item is used to
track the existence of some pack at the beginning of a repack operation
was originally intended to be used as a bitfield.

This bitfield tracked:

  - (1 << 0): whether or not the pack should be deleted
  - (1 << 1): whether or not the pack is cruft

The previous commit removed the use of the second bit, but a future
patch (from a different series than this one) will introduce a new use
of it.

So we could stop treating the util pointer as a bitfield and instead
start treating it as if it were a boolean. But this would require some
backtracking when that later patch is applied.

Instead, let's avoid touching the ->util field directly, and instead
introduce convenience functions like:

  - pack_mark_for_deletion()
  - pack_is_marked_for_deletion()

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8103a9d308..e9a091fbbc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -111,6 +111,16 @@ static int has_existing_non_kept_packs(const struct existing_packs *existing)
 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
 }
 
+static void pack_mark_for_deletion(struct string_list_item *item)
+{
+	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
+}
+
+static int pack_is_marked_for_deletion(struct string_list_item *item)
+{
+	return (uintptr_t)item->util & DELETE_PACK;
+}
+
 static void mark_packs_for_deletion_1(struct string_list *names,
 				      struct string_list *list)
 {
@@ -130,7 +140,7 @@ static void mark_packs_for_deletion_1(struct string_list *names,
 		 * (if `-d` was given).
 		 */
 		if (!string_list_has_string(names, sha1))
-			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
+			pack_mark_for_deletion(item);
 	}
 }
 
@@ -158,7 +168,7 @@ static void remove_redundant_packs_1(struct string_list *packs)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
-		if (!((uintptr_t)item->util & DELETE_PACK))
+		if (!pack_is_marked_for_deletion(item))
 			continue;
 		remove_redundant_pack(packdir, item->string);
 	}
@@ -702,13 +712,13 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
-			if ((uintptr_t)item->util & DELETE_PACK)
+			if (pack_is_marked_for_deletion(item))
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
 
 		for_each_string_list_item(item, &existing->cruft_packs) {
-			if ((uintptr_t)item->util & DELETE_PACK)
+			if (pack_is_marked_for_deletion(item))
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
-- 
2.42.0.166.g68748eb9c8

