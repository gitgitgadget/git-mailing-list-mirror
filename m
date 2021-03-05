Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21577C43381
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A4565090
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCEPWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhCEPV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:59 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E29C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 07:21:59 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g185so2281678qkf.6
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 07:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s7hlQUvDHq4CPNNuQV1QFKvrPQVVOTVCw1T1CbYiepM=;
        b=rbkVmHdWDrh3R1B1Ic/sYumz+SKu3OoNdQn513Tf33Zdrr5NvCPHTl/rzYMZgJbMP3
         Pl12VZoyfS9T9hTEj4KvwQipOrF6wpOC1cexmey/Yjw0ojqyYE+EA4y9Yvwtu4dsFqcC
         bpCjj4YDJ+WoyBfjw/GPKmPTE9uUqlu5/nHB8kTgFCjJmVFrlO/g2BrNgwtzgQChpN1c
         2WLr8u8M0KEyw81L+AwW+A34qyy0/tEnArN3a2WM84ub4cxmf5rmmX+Wo7zxTGYgw+dJ
         UEdKkQpHsGvwgkRPXSvPbtq1W6fMqz59QL1CCJkAO3Uu/Dm9LJ0gU/hey4uT+5Riuamt
         Hrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7hlQUvDHq4CPNNuQV1QFKvrPQVVOTVCw1T1CbYiepM=;
        b=BfCQMO5+cSeJ5v/L5QTKVSCqAXHhF06D/LfqYUc4YiCGSLtSXx/lnCchQesNDMak/S
         j4bOTKivflYB+ArvGmQxz5rLwzsoIWczMKBWqnvmrBNDwRz7thwMSl6UHzBfUUc3tmrj
         ujqo88cfAOzGbCDHmE02yqNVs3COXwDL4GQ7hGQBqxDox8Ml5fnNXxfRqqfhq9uFqSRs
         IY/b1KAOF5SVmXeDt+yoXfGO8QdmOsI5mtsW3KPNbZs7iQyLAn5/NIXko024Ge+E2hMy
         M1g2Y6DEvIgBPpIu6dXHc0mj4XwM/dF/up2+Bk2STWuTrUeyHYgAfx1gBFVCXs2hxirR
         gWmw==
X-Gm-Message-State: AOAM531/bUfvbhkqqfUtE82RCccNACZBRlZBlySoESAsrfM729kCFbJf
        aOCicBW7gko7zse+Mq/WEnapp7DZNlTsFHxc
X-Google-Smtp-Source: ABdhPJzzvQRoWTiZ0PV2lnN330qYXEe8fQBVH2PYNmZOq8NIq+e9hb0ixwWX+eB3hqt+r7puF9z+1A==
X-Received: by 2002:a05:620a:1133:: with SMTP id p19mr9929600qkk.340.1614957718090;
        Fri, 05 Mar 2021 07:21:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id b63sm1925850qkd.84.2021.03.05.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:21:57 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:21:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 4/5] builtin/repack.c: be more conservative with unsigned
 overflows
Message-ID: <d55324f7a256fce491a29a1debf142f817eb01d3.1614957681.git.me@ttaylorr.com>
References: <cover.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614957681.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of places in the geometric repack code where we
multiply the number of objects in a pack by another unsigned value. We
trust that the number of objects in a pack is always representable by a
uint32_t, but we don't necessarily trust that that number can be
multiplied without overflow.

Sprinkle some unsigned_add_overflows() and unsigned_mult_overflows() in
split_pack_geometry() to check that we never overflow any unsigned types
when adding or multiplying them.

Arguably these checks are a little too conservative, and certainly they
do not help the readability of this function. But they are serving a
useful purpose, so I think they are worthwhile overall.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 21a5778e73..677c6b75c1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -363,6 +363,12 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	for (i = geometry->pack_nr - 1; i > 0; i--) {
 		struct packed_git *ours = geometry->pack[i];
 		struct packed_git *prev = geometry->pack[i - 1];
+
+		if (unsigned_mult_overflows(factor, geometry_pack_weight(prev)))
+			die(_("pack %s too large to consider in geometric "
+			      "progression"),
+			    prev->pack_name);
+
 		if (geometry_pack_weight(ours) < factor * geometry_pack_weight(prev))
 			break;
 	}
@@ -388,11 +394,25 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	 * packs in the heavy half need to be joined into it (if any) to restore
 	 * the geometric progression.
 	 */
-	for (i = 0; i < split; i++)
-		total_size += geometry_pack_weight(geometry->pack[i]);
+	for (i = 0; i < split; i++) {
+		struct packed_git *p = geometry->pack[i];
+
+		if (unsigned_add_overflows(total_size, geometry_pack_weight(p)))
+			die(_("pack %s too large to roll up"), p->pack_name);
+		total_size += geometry_pack_weight(p);
+	}
 	for (i = split; i < geometry->pack_nr; i++) {
 		struct packed_git *ours = geometry->pack[i];
+
+		if (unsigned_mult_overflows(factor, total_size))
+			die(_("pack %s too large to roll up"), ours->pack_name);
+
 		if (geometry_pack_weight(ours) < factor * total_size) {
+			if (unsigned_add_overflows(total_size,
+						   geometry_pack_weight(ours)))
+				die(_("pack %s too large to roll up"),
+				    ours->pack_name);
+
 			split++;
 			total_size += geometry_pack_weight(ours);
 		} else
-- 
2.30.0.667.g81c0cbc6fd

