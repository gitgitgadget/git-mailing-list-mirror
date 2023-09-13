Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB32EE0207
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjIMTSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjIMTSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:18:09 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250BE19AD
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:18:05 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59bbdb435bfso1845607b3.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632684; x=1695237484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oU5X1YuO1DCAzcnKVtmesO+313Y28xIZL91JU5d57yU=;
        b=zSXzSRCY8y+pGTiLkee3axfrDyXFKbnpS8SzQ/+Jz/bJNhmddsgYBLnH/lJ5HBvJre
         BTBh6ROH6mTD/eCaCCxoBOEZBuUPgdrzKFzmDK4fl6DrrbkIaR560Kv2cr7XygrTmW8y
         B19+sxEiWvFyu6vGfiSZNLJ936+xIePAkkSdeNk4+OGjlO71wkX/cAIohXV1DyWelXyW
         47KwkCh8fHJ3WqDUmJbm7PIYfAc92vOohHcel5oSjqhrPJP95aMIOYi1iOaw1D1vB3TZ
         lDRe2n10iZCwJL5QA4tqJxhCmQBTmKxx7qUNc585Pz8aD2juQFDnvsNu3L3I/uWiJ9qq
         oOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632684; x=1695237484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU5X1YuO1DCAzcnKVtmesO+313Y28xIZL91JU5d57yU=;
        b=DnBshTARngjbjL0crm+CF56uYzRt2xGG3jk6g7To6qTHc2v8tvHv7he3byj/gRwvEd
         HZhhaW6UbtCy1v3q1xSYibiDhNat0bM2NdI34TzhUDevrGMsEssNtA9IqwfiRwXjCnlP
         2vZOVVrvqfJ+jRrqmJjp7jTh/fk7zQ/HTaASO405cqfUGankOr477rzPq1Vyb5Ss+vfT
         wF2Mr0CBQk2kUzyPA25d0Dk61PmTjE7kYuFvcd7HtXOl4r70tX2JdyUhUclbYLwbhWI8
         ePuFYW9kWFAxniYMfbzSmaM/ZBcwTkwGTIRse6PqeP0XRg0UCTtYpQJ0IYFPaGsAPAxQ
         0cyQ==
X-Gm-Message-State: AOJu0YyrOrPaDLB8EWCyCzVGweyCLgDb2KWtSWb47GC5p6FmbDQNT2q+
        J/TmQ3LZaPx8Rjw9Ay6oP3zDXNQ+3oiPPFx+AscXAw==
X-Google-Smtp-Source: AGHT+IG5ZQNVIZkkzMRi0XdDs6+VVaos60zYeFfz/UZAXfHt+HfjJkdo34oOE6LxLUKk34gntlz7Mw==
X-Received: by 2002:a81:a20e:0:b0:581:2887:22be with SMTP id w14-20020a81a20e000000b00581288722bemr3733813ywg.37.1694632684123;
        Wed, 13 Sep 2023 12:18:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id en11-20020a05690c2b8b00b0059bc980b1eesm493698ywb.6.2023.09.13.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:18:03 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:18:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 8/8] builtin/repack.c: extract common cruft pack loop
Message-ID: <68748eb9c865ba8252852713533e2f47e2cac489.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating the list of packs to store in a MIDX (when given the
`--write-midx` option), we include any cruft packs both during
--geometric and non-geometric repacks.

But the rules for when we do and don't have to check whether any of
those cruft packs were queued for deletion differ slightly between the
two cases.

But the two can be unified, provided there is a little bit of extra
detail added in the comment to clarify when it is safe to avoid checking
for any pending deletions (and why it is OK to do so even when not
required).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e9a091fbbc..529e13120d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -702,26 +702,31 @@ static void midx_included_packs(struct string_list *include,
 
 			string_list_insert(include, strbuf_detach(&buf, NULL));
 		}
-
-		for_each_string_list_item(item, &existing->cruft_packs) {
-			/*
-			 * no need to check DELETE_PACK, since we're not
-			 * doing an ALL_INTO_ONE repack
-			 */
-			string_list_insert(include, xstrfmt("%s.idx", item->string));
-		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
 			if (pack_is_marked_for_deletion(item))
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
+	}
 
-		for_each_string_list_item(item, &existing->cruft_packs) {
-			if (pack_is_marked_for_deletion(item))
-				continue;
-			string_list_insert(include, xstrfmt("%s.idx", item->string));
-		}
+	for_each_string_list_item(item, &existing->cruft_packs) {
+		/*
+		 * When doing a --geometric repack, there is no need to check
+		 * for deleted packs, since we're by definition not doing an
+		 * ALL_INTO_ONE repack (hence no packs will be deleted).
+		 * Otherwise we must check for and exclude any packs which are
+		 * enqueued for deletion.
+		 *
+		 * So we could omit the conditional below in the --geometric
+		 * case, but doing so is unnecessary since no packs are marked
+		 * as pending deletion (since we only call
+		 * `mark_packs_for_deletion()` when doing an all-into-one
+		 * repack).
+		 */
+		if (pack_is_marked_for_deletion(item))
+			continue;
+		string_list_insert(include, xstrfmt("%s.idx", item->string));
 	}
 }
 
-- 
2.42.0.166.g68748eb9c8
