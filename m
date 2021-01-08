Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE47C4332B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D01B23A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbhAHSSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbhAHSSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:16 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322E6C061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:29 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z5so10615643iob.11
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CpNdxqZGfiO4jb4DgI/7fB5wIx6DjqDt1SGCXFIuBIk=;
        b=Vxw71O1YG3FUVr+bZTPuOXpvumNUh7SYV0eH1Dy3wo94QZqQApn5CceWAzIFPbS6qG
         b0avSnlJTIXETv118xept30KcsYq11ZDndhoSOMCKrS2I9ZnlV2Lv+uEY6cR23E1A9/X
         ioIOUW6649061X89w6SkDiy24gSUPscgkOlJbOk1O3WZT4h/cTjmmY9HQILdlnmJS/o0
         CkNmKySWgG/hwrVhDoshcxio4wl5A10JbSG61OlACOgYol8oPVpNA/RWtIHk+gYjeFtb
         2E2Z+SQq0/xSCNab9EEdxOzCQVFuVv+cy1w+IZFsf8jYnN3cZonAzkHggWz0cjpXOM2M
         bEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CpNdxqZGfiO4jb4DgI/7fB5wIx6DjqDt1SGCXFIuBIk=;
        b=LMjZ1AsvI79ojwszKN8T6xuNNUprWtsHJmKuITpPp4dcXNiQKaoKv3Pn6QszIgF9Nu
         6IB3TBkxRkEFYKGiIYA1czTzzOC8WE4sT5J8cb2CagbBZfPOJZVjK+seI6deXJoOpSv7
         pCmFTUigGFuyQheWA2Z+gvXgmIa63c9C8lQ60C2UfGlF3Y7+Ee7jxNOQIZLjEPoAS5Vu
         hC6AALWH9H0vnmllVGsZyGiEBIPTefFmUKvADWfVdRqKfGDKbzqZ/248bZ+aNCZxguVi
         5/ymUL3un8kiYSjCyJFhEQECjYz8//wx6phjxAG8J6sJdFw0Mhs43ypBtjB/Au1HjJhw
         F0FQ==
X-Gm-Message-State: AOAM532CMTi77vDoo9CqVbs1njo+MBxW2FM+5V5ikc4mCfrm4vwpAqFr
        YYR2DXSLqNfRqzUUpQxG9zdmytTDSjQpjw==
X-Google-Smtp-Source: ABdhPJw/O/9SjdbNT08D/AA5na8CFy+JCqU/2RtuF8ucljbuK4oQrRV+eu1WZYfTXmMCEFCdFP0aeQ==
X-Received: by 2002:a02:a304:: with SMTP id q4mr4443410jai.97.1610129848374;
        Fri, 08 Jan 2021 10:17:28 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id r11sm7505245ilg.39.2021.01.08.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:27 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 11/20] get_delta_base_oid(): convert to new revindex API
Message-ID: <e00c434ab283698be638022bacab4c0ee248a0a8.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace direct accesses to the 'struct revindex' type with a call to
'pack_pos_to_index()'.

Likewise drop the old-style 'find_pack_revindex()' with its replacement
'offset_to_pack_pos()' (while continuing to perform the same error
checking).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 86f5c8dbf6..3e3f391949 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1235,18 +1235,18 @@ static int get_delta_base_oid(struct packed_git *p,
 		oidread(oid, base);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
-		struct revindex_entry *revidx;
+		uint32_t base_pos;
 		off_t base_offset = get_delta_base(p, w_curs, &curpos,
 						   type, delta_obj_offset);
 
 		if (!base_offset)
 			return -1;
 
-		revidx = find_pack_revindex(p, base_offset);
-		if (!revidx)
+		if (offset_to_pack_pos(p, base_offset, &base_pos) < 0)
 			return -1;
 
-		return nth_packed_object_id(oid, p, revidx->nr);
+		return nth_packed_object_id(oid, p,
+					    pack_pos_to_index(p, base_pos));
 	} else
 		return -1;
 }
-- 
2.30.0.138.g6d7191ea01

