Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89660C4321A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C96823A7A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbhAHSSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbhAHSSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:23 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F558C0612FF
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:18:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 75so11124376ilv.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqCXcF3s42aVhCLcgyqbKz+bbVfloj8Z9G3uiLc3txc=;
        b=Qoca/PEjIUHZBmqW5Vg/kRWuimb65fZcWBiCEYUchcQl0D0428XGbqi6v7jMx4lsSG
         LvVZFxyyjOZxH3CWJC6vQLkFqHC65eAVBFgncDU6XVeZoPrb45SOA+yqA+rFeEHecdpd
         uaizIwASykYhK758iXrRm39duDqLoJcZuX62YEMB7aqwGE+vh6/uVPl8UEG7/RcG4rz5
         38sbjXvMWEdptSzZlNrhrztYKlMfr2H77Ioda1DXkJFvcPbVumIIqAfF+rPBjT3FMvd2
         uptE1w1CL/fyOdLhZe7IpfYECQxPMXhK4rqPchWfOLJ9wqWeqh29t4O4oz8gi9cARvO1
         ejJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqCXcF3s42aVhCLcgyqbKz+bbVfloj8Z9G3uiLc3txc=;
        b=rwTyPkj1fpDeWqSuvyPlTOVX1LorL9RsUdauQEyY21kWndOOdtdn324f/w0y+qHCt0
         s1SWo20MprN2LeC3sA/KaRTeWBS5ASHIfAEDGuS+p4/wNr0tOaMUYvQx19xr4Crs3RSu
         tKnVmvpvVIPjl3WpYHaxzTeaq03wE0+DOX9m6ckyyO/Cslnugw8hysTIm8zuZUMc75lG
         LXl0jIYCCvSiMjjJ7PAiAHN9chQa6Wqy0yEQhAhHYhsIdCF9V6CqsGYWT92v+IQ0QhGC
         qbhpLObExU+gOUnyVH37h0UvonI8ikK7gKEReya+aCxQj2ZM8igmb9OMWF2OD8SnQM8o
         dH6Q==
X-Gm-Message-State: AOAM532Yre8AEN2ZijrCl6bTqflNBNWjt/dm7rcV6klnJxQmpx1wxRLU
        CEXzHtcybHXWEU2NC5ZCPtElDj47+0JpMA==
X-Google-Smtp-Source: ABdhPJxXye+6mr6ZXetxf9HjK1MpPQhjucBFC77D3pxMp7otH8G+yLtO9Uh8+6c5G/kk1Hq4TMsAjQ==
X-Received: by 2002:a05:6e02:1a82:: with SMTP id k2mr5053226ilv.164.1610129884252;
        Fri, 08 Jan 2021 10:18:04 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id 15sm7487952ilx.84.2021.01.08.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:18:03 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:18:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 19/20] pack-revindex: hide the definition of 'revindex_entry'
Message-ID: <7c0e4acc845d1135e684188b2ccc61cf358994dc.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all spots outside of pack-revindex.c that reference 'struct
revindex_entry' directly have been removed, it is safe to hide the
implementation by moving it from pack-revindex.h to pack-revindex.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 5 +++++
 pack-revindex.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 9392c4be73..36ef276378 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -3,6 +3,11 @@
 #include "object-store.h"
 #include "packfile.h"
 
+struct revindex_entry {
+	off_t offset;
+	unsigned int nr;
+};
+
 /*
  * Pack index for existing packs give us easy access to the offsets into
  * corresponding pack file where each object's data starts, but the entries
diff --git a/pack-revindex.h b/pack-revindex.h
index b5dd114fd5..b501a7cd62 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -3,11 +3,6 @@
 
 struct packed_git;
 
-struct revindex_entry {
-	off_t offset;
-	unsigned int nr;
-};
-
 int load_pack_revindex(struct packed_git *p);
 
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
-- 
2.30.0.138.g6d7191ea01

