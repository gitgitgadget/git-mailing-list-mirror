Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA62C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHIUco (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIUcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:32:43 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7A2108
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:32:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bca38a6618so187654a34.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691613161; x=1692217961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm1zokCH0oZq8NeCLR62fFoRohWIbmJO9YUZih6FryU=;
        b=n5xNcXJDKIMkvnfbD9prFimjce8rMIGpTUaPIVDnomyH/lCCk5h/e1JNjYCyWpYdzs
         /i18uRXya6j4IIYbH8BJZikwGCeaeAC42SkFIIOMWmVy3W4jyHp3En9f6W/jmgA03RIa
         4s07PHVWUmcEH+EW2AuF3imRpfAqivYGq8olx7qy6Mm1eg3HoCrke5ZATFj/FHdDvqS8
         uDEWgzT+XVkRjmraqEedL/b9aFkqUsoWOgL/RI8LGab8le0n+d0Bvl+Apf/i0RNDvBzx
         oiSTExJqXSk3g16sCsvY7nb/JmY15ob5PD2ZZ4/iCnGlZtv2EEcgB3EUU8s7UClpWt8K
         J3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613161; x=1692217961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm1zokCH0oZq8NeCLR62fFoRohWIbmJO9YUZih6FryU=;
        b=g4jZku/21ebmVE+mDAkkWiID8Rdkw6BpatV5c2+v96h+DgPHWB4NoXohkJPQ+W0Pxu
         6GBA6WtmTDPzPkEAOZmk42uUw2t+dpun2gs2SHFMZGUSrYd1jTtW2KadGIS7V6fPGYxB
         JAvuyKqPGVWPSMA/vs1ZFSAeVv6L1vvFwUE8IgCZoOYYtaXNaoNf+MtwTFWUvQW3S1Du
         rsHf6cBmtY21jRPSb2rL+xlKx/+8VNdx3QBkFsp6wt5C0P3oiRqEts5aq5pR+iKBmVxA
         yI17pXfmd7do8Zqgz1I56Tvr6cvgm2K62tddbyvwM5lCtBwdj7Yr37m3EJLxGiEio6VB
         4AQQ==
X-Gm-Message-State: AOJu0Yx2qXnNG2UEtpTfv0i+xBCoVej3KCadm6i6pO/k+yqfcckcahz5
        TQqOL0rFpAqAkR8Jnj1ldYqp2rDodFnMBHPDiRm4+Q==
X-Google-Smtp-Source: AGHT+IHmLkMZa1+64ZX5vyvMNSYCruCf/lLrTwLSMwVNWsgmvNRC0A05WpBoQnh89VW5RwGuXJ3X9w==
X-Received: by 2002:a05:6358:2796:b0:135:73b0:cc6c with SMTP id l22-20020a056358279600b0013573b0cc6cmr446928rwb.28.1691613160799;
        Wed, 09 Aug 2023 13:32:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s84-20020a817757000000b005774338d039sm4214962ywc.96.2023.08.09.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:32:40 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:32:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] repack: free geometry struct
Message-ID: <6bb4c3805c8f1bdf021d1bf8005f7e944731b586.1691613149.git.me@ttaylorr.com>
References: <20230808211759.GA322409@coredump.intra.peff.net>
 <cover.1691613149.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691613149.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When the program is ending, we call clear_pack_geometry() to free any
resources in the pack_geometry struct. But the struct itself is
allocated on the heap, and leak-checkers will complain about the
resulting small leak.

This one was marked by Coverity as a "new" leak, though it has existed
since 0fabafd0b9 (builtin/repack.c: add '--geometric' option,
2021-02-22). This might be because recent unrelated changes in the file
confused it about what is new and what is not. But regardless, it is
worth addressing.

We can fix it easily by free-ing the struct. We'll convert our "clear"
function to "free", since the allocation happens in the matching init()
function (though since there is only one call to each, and the struct is
local to this file, it's mostly academic).

Another option would be to put the struct on the stack rather than the
heap. However, this gets tricky, as we check the pointer against NULL in
several places to decide whether we're in geometric mode.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index aea5ca9d44..97051479e4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -492,15 +492,13 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
-static void clear_pack_geometry(struct pack_geometry *geometry)
+static void free_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
 		return;
 
 	free(geometry->pack);
-	geometry->pack_nr = 0;
-	geometry->pack_alloc = 0;
-	geometry->split = 0;
+	free(geometry);
 }
 
 struct midx_snapshot_ref_data {
@@ -1228,7 +1226,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 1);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
-	clear_pack_geometry(geometry);
+	free_pack_geometry(geometry);
 
 	return ret;
 }
-- 
2.42.0.rc0.27.g2e2a760381

