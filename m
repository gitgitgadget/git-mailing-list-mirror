Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0AAC433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiERXMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiERXLz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:55 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07BB41FE
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:29 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s5so3175675qvo.12
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zg8D+mVhTqbxYEbGanVURWql8MDAlH6HQ57KJAQ9z7Q=;
        b=7kIiUk88CtMxKB/NVo/8xQJOgGHqzNwtFiGP84C2733cBIUV7AjNfYSWXtoQdLJg+u
         /qoztlh4/Eo+TiIDddXrcTZCoxm5Qu/7a4GRZj8ZWxw6+dm8UmpUJTxX8poQl94SEzZI
         ZRyx5p7wDtFqsXdKh2wbU5Fm5ETFFPfOZ1FsYnDaXcqAV9GSPelfAs+WGja0Akf91yHr
         F5RwCvZy0wgd+SmeFKg0NHe9y6bOpphxdj0Ylpk8fip4d/hNlRhxhCY656f4DvgEtBpl
         +tRG0i3vABiye83zL6hYTnOZlOWPmdhucueggbBjxKnNTiiOi7HKI/8LLCBtcZyooGh5
         eRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zg8D+mVhTqbxYEbGanVURWql8MDAlH6HQ57KJAQ9z7Q=;
        b=gMT/u8ABsPI9aKSqMRw5OLmXF5+u3DQwxn90+2pp+ifMcWQLucmf0WJrB6JgqnR9HX
         3cIbjEftN0X6VuK+f3MwZqjq8XFPkIS5GaO/9OxP7cMKQWdVJViOMbWZ6cMJOjIH26Lr
         XsfT5U9UyhOBxuZbyiyBt7An0Hfv6XbUAWCNcO70nnJUq4qluk+7HTOjZuFLKXlJaXRi
         KR/Ji8nLiqaN38BHa3V/MxP4ajmftf7Xh/iy3/5Cwvf3z71HrVl7FXq4MeGjAy4CqEpQ
         GpWGXFmyy5c1xkw7tTauTJCZtTb/McvW50TxJco3wHtiNvXj4Ewt7g5p8yt3KeGRxr20
         xQMg==
X-Gm-Message-State: AOAM532Wb589scLNzg3VUiGpcj4uWO2TYgaRS45JYURHivmMDJkYOa3B
        N4FRRf0yWd1qESdSBJMca+8TsCY83s6aWmOc
X-Google-Smtp-Source: ABdhPJxKWJTT4/sRvqFZmq8atB1ePLZpqVvF3LyZwgZK4jMl6tSADze//knSPo/Sp5nwQgytCiWwXQ==
X-Received: by 2002:ad4:5945:0:b0:45a:ff7c:15c9 with SMTP id eo5-20020ad45945000000b0045aff7c15c9mr2026124qvb.100.1652915488719;
        Wed, 18 May 2022 16:11:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 128-20020a370c86000000b0069fc13ce205sm327978qkm.54.2022.05.18.16.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:28 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 14/17] builtin/repack.c: use named flags for existing_packs
Message-ID: <ffae78852c54682ed4240f3b2f8cb9c46e2756ec.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the `util` pointer for items in the `existing_packs` string list
to indicate which packs are going to be deleted. Since that has so far
been the only use of that `util` pointer, we just set it to 0 or 1.

But we're going to add an additional state to this field in the next
patch, so prepare for that by adding a #define for the first bit so we
can more expressively inspect the flags state.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b85483a148..36d1f03671 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -22,6 +22,8 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4
 
+#define DELETE_PACK 1
+
 static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -564,7 +566,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
-			if (item->util)
+			if ((uintptr_t)item->util & DELETE_PACK)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
@@ -1002,7 +1004,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			 * was given) and that we will actually delete this pack
 			 * (if `-d` was given).
 			 */
-			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
+			if (!string_list_has_string(&names, sha1))
+				item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
 		}
 	}
 
@@ -1026,7 +1029,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delete_redundant) {
 		int opts = 0;
 		for_each_string_list_item(item, &existing_nonkept_packs) {
-			if (!item->util)
+			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
 		}
-- 
2.36.1.94.gb0d54bedca

