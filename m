Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108AECA100D
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjIEUhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbjIEUhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:37:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBA0CFE
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:37:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58d70c441d5so29106737b3.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946222; x=1694551022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFdUY2x58Zha1WVlnRoV5I3qvQr2jZIt6GVF3cd/ntQ=;
        b=Foo5gsvZdvXtVfMZkOCWoEaah3/HqmEQN/5khbGsHLH4FHxdGjQ9Q81lMyIIhOV85J
         FwR7hTIjHIMaEuPGeiK//vkaGXpHFvuULQwxvyer3SKsH/oWuxA2+iDILzxgqhC4Q2bK
         Lip99ypDW/UAMoj2TNzZy0B6ba6stQfnUsIJbNMof2yoh4K4hrbqUva1mZrwocjGjn7R
         3ugaLAfGoScw1U2HFI3XVAXrxyu08+JHIIUWiD2oHJDF/Sptp8eOts+wKDRolYMsKIOh
         vWJ43eGbZxpy5t2LC3G8qj3/65U4UxSzv+zN8iPzoavxrjo8W5ntEX5/OyzECpif6d8l
         nDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946222; x=1694551022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFdUY2x58Zha1WVlnRoV5I3qvQr2jZIt6GVF3cd/ntQ=;
        b=lp82V4zRtIJxPSVKSupi80k3bAesmcu1OeRwS9Dz+vQcnCSn3tG6A+z45jaA8tjek2
         zV+3F++TeGY1J/A1at26RTWykPVAJIV4Zaevje3YdoQvtmF9WFsS+sQifI4leoNUuByX
         Zunk38gtNgsfYkT6CuVhOZdjdKm05P7+2Eox4eJk165G1Oif7OHaNpMGzqe0Bd4J7yBN
         pmXSY5bs+ZOhgEbFgIZGPn3ITujsABvUNyzUQkG9q8/79YvHQWfc5D4zR91x3N4v25CD
         pTmiphZxh832bNWA8sDqSVxv9NG3ROt/1nmGbAxP6aSqY/R9i7RKegoTY5fQvDxaDZ+s
         WMNQ==
X-Gm-Message-State: AOJu0YzCxd/TtQFM24xBokNhUmY+KYKl/C2fX9SXQtncbBIcwvJK+laN
        wFmn/eIPBXA2byk+ONSlPeuKM3s8864PLV5AqCAeJA==
X-Google-Smtp-Source: AGHT+IGDRk46qZv36slJWtlXK73oPVGdXOJOIjtN17J5FoKmLBe9W/e8+7XfMwPx2Q2qmS94GiXCTA==
X-Received: by 2002:a81:8541:0:b0:57a:cf8:5b4 with SMTP id v62-20020a818541000000b0057a0cf805b4mr13924282ywf.51.1693946221909;
        Tue, 05 Sep 2023 13:37:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v139-20020a814891000000b0058c55d40765sm3328532ywa.106.2023.09.05.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:37:01 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:37:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 8/8] builtin/repack.c: extract common cruft pack loop
Message-ID: <ca7d13e7bf7725caefaceab6abd05dae3a7958c3.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
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
 builtin/repack.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6110598a69..e6a1ef9a09 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -695,25 +695,31 @@ static void midx_included_packs(struct string_list *include,
 			string_list_insert(include, strbuf_detach(&buf, NULL));
 		}
 
-		for_each_string_list_item(item, &existing->cruft_packs) {
-			/*
-			 * no need to check for deleted packs, since we're
-			 * not doing an ALL_INTO_ONE repack
-			 */
-			string_list_insert(include, xstrfmt("%s.idx", item->string));
-		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
 			if (item->util)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
+	}
 
-		for_each_string_list_item(item, &existing->cruft_packs) {
-			if (item->util)
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
+		if (item->util)
+			continue;
+		string_list_insert(include, xstrfmt("%s.idx", item->string));
 	}
 }
 
-- 
2.42.0.119.gca7d13e7bf
