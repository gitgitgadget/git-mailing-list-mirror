Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1D42079F
	for <e@80x24.org>; Tue,  6 Dec 2016 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbcLFMyc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 07:54:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34413 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbcLFMy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 07:54:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so19787848pgc.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 04:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gQEe9X4VP33FoElVZC1lTMX3gPuCEG8NWehc5RKS/c=;
        b=X2FnQGUgNOnHxmCaRSQCbzlGIjLkmBWtthuAH5p/z0nkXnkEGK8uus0F+BlSgFG6jK
         Whlmuw6Uok47wHFxeSTqgQoysM5ExTWHyVuZ03idPzCMWn1WIC+/G012DzIPhz4F/XNP
         VLd0Ean6WH3oBjznmMoV4jF21uh3WqAH0MDgEqBhJazHktH3LJUdsBH0K8AxeAC0AlyU
         12xbYuBT2ePmbyNifyM4gPi8g2kBEG0p2qWT4XUTdYPp8ItxI0fVPG4RGDeMpMwsrimT
         C8PesX2lTBgg66V//3sbaujYPba0y1dwgsinYoMKtR92T7dDj6PI19rpaZu8d3NMhe2a
         vcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gQEe9X4VP33FoElVZC1lTMX3gPuCEG8NWehc5RKS/c=;
        b=T8kYw3inzb/l8I6kJaY4ZNofzMus3uKD+Yb6+LC2Xw0O+NjduBUG5FkNRbiXTGp+qL
         SoZAEzQBjKDyxlEQR44r+NQ551XOOcKrGntkJJqVIpH5LTdJi8jTNjaSjNo0PHHO0j2G
         IIC3Phv+EHj2fcLOS8cZs58keFhKRSv7n1QaQAJqG00oqdq/YTOnZe0F+hfzMbE56yGb
         9VH31qn1DPFTirMGYOhFBPY2kerlwCQYxrBwyHBnxl2gBePRBjvQSlZ1MeO7qW/asCVt
         h1pHCkqPdnr8gqNum0HXNbht0T3A1gsa1nSzbj0/m1gUeqbJxsV7zkaJM+ceq83SZ9ES
         Ucyg==
X-Gm-Message-State: AKaTC03Ds3L/+vYPKeFjm/pChW0Nv0YaBf7xZGAJ+UCRW5/zaGwjG0D7nupGRqA7WBa4lA==
X-Received: by 10.98.201.196 with SMTP id l65mr62817618pfk.116.1481028853010;
        Tue, 06 Dec 2016 04:54:13 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id w11sm34729445pfk.75.2016.12.06.04.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:54:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:54:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/6] shallow.c: avoid theoretical pointer wrap-around
Date:   Tue,  6 Dec 2016 19:53:37 +0700
Message-Id: <20161206125339.16803-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rasmus Villemoes <rv@rasmusvillemoes.dk>

The expression info->free+size is technically undefined behaviour in
exactly the case we want to test for. Moreover, the compiler is likely
to translate the expression to

  (unsigned long)info->free + size > (unsigned long)info->end

where there's at least a theoretical chance that the LHS could wrap
around 0, giving a false negative.

This might as well be written using pointer subtraction avoiding these
issues.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index 75e1702..719f699 100644
--- a/shallow.c
+++ b/shallow.c
@@ -446,7 +446,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	unsigned nr = (info->nr_bits + 31) / 32;
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
-	if (!info->pool_count || info->free + size > info->end) {
+	if (!info->pool_count || size > info->end - info->free) {
 		if (size > POOL_SIZE)
 			die("BUG: pool size too small for %d in paint_alloc()",
 			    size);
-- 
2.8.2.524.g6ff3d78

