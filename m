Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A081F462
	for <e@80x24.org>; Thu, 20 Jun 2019 08:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfFTIax (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 04:30:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37734 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTIax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 04:30:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so2201303wme.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wu9UaVCsfg4L73n6wmdVpb/edyPW2DqYki4l8ldtxI=;
        b=BY4w7ytKhxJucvrvzfLmlrkWtefABrYIkBYw/wSjEcBKCQEgt1h7ROUAvoYuiAL8dv
         STaVQPtm5mDuk20H4+NYcnAK3AoywaFnqExhj7nGhhEaE0SzBuWtJM3+r0bFvtawO/iE
         sjI0G/zzN8587AcjppietjqNAS9wJY14ZsvrM5QJfdWfCXi9wbO0UnM5WXrMoLTuGL9m
         rFwJ7PCUsvmr2n+nfLoTkTia/ndLcHLZqHE+BQsK3pxE3l3HfyV0cSOOZS5NOcTYaWEv
         A+7TDnLPVlDesvnSIaoQEyfJS6cA+ISTizo76dLzgk2hk2474aFYnLsgJW6u7yBmfpNh
         XqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wu9UaVCsfg4L73n6wmdVpb/edyPW2DqYki4l8ldtxI=;
        b=CCFyzBOJFV9xIjenHI8C7a0AkB3htdwDzhFMG0uQhAm+wdLtYTmbXXMJho2Ojh5BBK
         gnsRfG85bijSB5jSAFIDrL/IgREOcMQz7FbsU0J8Q53kyTKPDqR6S9XxAt/P8teY2CtV
         PKn8Q8fUkdWI4QGvuv1hkxNDrOH/udlH9g4161O9Del/+Wx65GlKrcH6GPNtOoSOg11B
         XFX66cmT99oKIQt88q0QrzcPg0va4AlURzmI+XrSvmAaTJ8VMXEj60VYbr/USnwZ5jTm
         +U3c4sEvk75UtpN6GNsCwfAcdgc2icA4GNatAGnDjTUCiuhjDeGbu7ofBqV1zNyLKiKS
         GJ2w==
X-Gm-Message-State: APjAAAXCSR38VOdfvjLMzhkJ3B7XAHjxPzIXhyl5jICY1kpsSZcyWoZ6
        VaYTp+Sv34Xhmu7hR8309XCy+rVGCEY=
X-Google-Smtp-Source: APXvYqwMEEPiN+AxPgIa1K1szR3P8HJYYS04g2lTRkKe/VjI8f5E6zx+UQuJEPQ+/JPopaEUP+H34A==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr1643033wme.148.1561019450899;
        Thu, 20 Jun 2019 01:30:50 -0700 (PDT)
Received: from localhost.localdomain (73.38.126.78.rev.sfr.net. [78.126.38.73])
        by smtp.gmail.com with ESMTPSA id f204sm5578039wme.18.2019.06.20.01.30.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:30:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] object-store: introduce OBJECT_INFO_NO_FETCH_IF_MISSING
Date:   Thu, 20 Jun 2019 10:30:25 +0200
Message-Id: <20190620083026.14524-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620083026.14524-1-chriscool@tuxfamily.org>
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fetch_if_missing global variable should be replaced as much
as possible by passing a flag to oid_object_info_extended().

The existing OBJECT_INFO_FOR_PREFETCH unfortunately conflates
both a "no fetch if missing" meaning with OBJECT_INFO_QUICK
which is about retrying packed storage.

Let's disambiguate that by adding a new explicit
OBJECT_INFO_NO_FETCH_IF_MISSING flag.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 object-store.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/object-store.h b/object-store.h
index 272e01e452..02c1795d50 100644
--- a/object-store.h
+++ b/object-store.h
@@ -277,10 +277,15 @@ struct object_info {
 #define OBJECT_INFO_IGNORE_LOOSE 16
 /*
  * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero). This is meant for bulk prefetching of missing blobs in a partial
+ * nonzero).
+ */
+#define OBJECT_INFO_NO_FETCH_IF_MISSING 32
+/*
+ * This is meant for bulk prefetching of missing blobs in a partial
  * clone. Implies OBJECT_INFO_QUICK.
  */
-#define OBJECT_INFO_FOR_PREFETCH (32 + OBJECT_INFO_QUICK)
+#define OBJECT_INFO_FOR_PREFETCH \
+  (OBJECT_INFO_NO_FETCH_IF_MISSING + OBJECT_INFO_QUICK)
 
 int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
-- 
2.22.0

