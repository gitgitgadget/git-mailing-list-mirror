Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF5C433E6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8D564EBB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhBJXDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhBJXDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:13 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6ADC0613D6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:33 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l11so1745933qvt.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVZ3E9GQHnWV41SVS6M7+FitO0zEL3XoI4C+EeuPiig=;
        b=qz9sH4pndrg2XPaEGFmGHCfUhE8mVtt2fUrQ94dDCotCQg1mwaLrv+xspTeYdhxdzG
         y0r8XeWeiQ8H8XjsrKBSVvMrJ5NXybYDjn4aQatKn61bwnGLh4ALMA9FPNB1UhM3CNA3
         EbYvvX7+USUi3oCPrQ4hYcx5ZqN4LTYfrRF2kaZjxBLmpV08zwkaKtscxEtyw7mQ2hN8
         wN0Ay32+F4Cdw0KCcVgTvsLWg3FS0uMgYq4YfIAkSovrz0cjNU09tU6y4hne2ruLV+SZ
         GyfQe673vZQyWlf3rJmPcDXhi93NohR2BDUdYduZFV+IXNsKg9UwsjAgjZpXG0Jx7mvu
         FPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVZ3E9GQHnWV41SVS6M7+FitO0zEL3XoI4C+EeuPiig=;
        b=QOaFTjbq3Cn8RFj9jaIQPJZv/v0L3Ke2jZxItdGvsQwGOiFAMdi4JxJHBh8zlPnyjb
         6ogTwpkm0Cmp2ypjHTYVqQcxHMUQ4IyBGlbqyqLsPJ0GDwU7MI7TLNwKElFU5bEHdycg
         mwGx5UlkQJxzzqj2dw9tb6t4MUmqsKjW949veFXKiV2gnD6PSJrle0XH5+VPt1/BRPPA
         /2q6mTwCjhXfUWoN25JamgN4vhYlULYmn+AcPk/bSpJT8iEdR20Et4fjifLmjV4XQHSy
         R8MtThZdbgr7WwXgZiRbJrIHHLPH0nDp65IUxwm/V/E7f7UEdch89oyRKjdLnnboGVBt
         TgZA==
X-Gm-Message-State: AOAM530hXxgYN1dfqH82Adeg+674YGZz9HqSKbEHixBbEFucQFsDnbQH
        KR/LBahM9pyhO9jv0S0P3mfk7qBvl+uJpwVH
X-Google-Smtp-Source: ABdhPJxJXAiy9nbL50nXadB1aWzunDgTE4vZ7tMsHzG62jH5duC4aVFM5DT4QA4Mc5N7c82FpoMbYQ==
X-Received: by 2002:a05:6214:7cd:: with SMTP id bb13mr5019499qvb.7.1612998152054;
        Wed, 10 Feb 2021 15:02:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id r80sm40062qke.97.2021.02.10.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:02:31 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:02:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 1/9] t/helper/test-read-midx.c: add '--show-objects'
Message-ID: <e36acb005d3563db772711207d2af3df03685bd4.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'read-midx' helper is used in places like t5319 to display basic
information about a multi-pack-index.

In the next patch, the MIDX writing machinery will learn a new way to
choose from which pack an object is selected when multiple copies of
that object exist.

To disambiguate which pack introduces an object so that this feature can
be tested, add a '--show-objects' option which displays additional
information about each object in the MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 2430880f78..4ec12f77a0 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -4,7 +4,7 @@
 #include "repository.h"
 #include "object-store.h"
 
-static int read_midx_file(const char *object_dir)
+static int read_midx_file(const char *object_dir, int show_objects)
 {
 	uint32_t i;
 	struct multi_pack_index *m;
@@ -15,6 +15,20 @@ static int read_midx_file(const char *object_dir)
 	if (!m)
 		return 1;
 
+	if (show_objects) {
+		struct object_id oid;
+		struct pack_entry e;
+
+		for (i = 0; i < m->num_objects; i++) {
+			nth_midxed_object_oid(&oid, m, i);
+			fill_midx_entry(the_repository, &oid, &e, m);
+
+			printf("%s %"PRIu64"\t%s\n",
+			       oid_to_hex(&oid), e.offset, e.p->pack_name);
+		}
+		return 0;
+	}
+
 	printf("header: %08x %d %d %d %d\n",
 	       m->signature,
 	       m->version,
@@ -48,8 +62,10 @@ static int read_midx_file(const char *object_dir)
 
 int cmd__read_midx(int argc, const char **argv)
 {
-	if (argc != 2)
-		usage("read-midx <object-dir>");
+	if (!(argc == 2 || argc == 3))
+		usage("read-midx [--show-objects] <object-dir>");
 
-	return read_midx_file(argv[1]);
+	if (!strcmp(argv[1], "--show-objects"))
+		return read_midx_file(argv[2], 1);
+	return read_midx_file(argv[1], 0);
 }
-- 
2.30.0.667.g81c0cbc6fd

