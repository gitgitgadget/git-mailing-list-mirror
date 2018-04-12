Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813CA1F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDLAVo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40227 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeDLAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:43 -0400
Received: by mail-pl0-f65.google.com with SMTP id x4-v6so2603137pln.7
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W71yQLLcSIxs9kaxrtZSVBPPypeIFChZPiVHdN4/MmM=;
        b=YzTKAcE+81qaLOlLMZ09y2AIdXieH482jScQhqQmC1WN5XtaZixlWEUtZfgjhrxpce
         vZ2rKSn9kZwsuJqACyS4leJ8ZBh/eotonjC2rOEcSW7mx3HQM9uNYbTse/IrL9hpn0wb
         LvS8Ol+bOcaBo9+bNAu3bb1d8M3PNXhJcnFBXqG+qh96oLcjuSnJWQimdXhw3IuVeqt0
         F7TZgBHV85BLn33bWDIbZ/bfZ+gNTXzo2NGNlJMb7LlzxVfEmWcOpIJIR5XRIvKOT11e
         29syuhiKbBl8UM+EuhaDK5ZAufCQWK+90z0g1L1rkV84Lkw1fdunmaQRbnyZJbQ1G4/W
         Q5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W71yQLLcSIxs9kaxrtZSVBPPypeIFChZPiVHdN4/MmM=;
        b=LhZInkukwXfWUhztHEI3Hl48s4Kwnaik/NmnSyVcEnG8BK8yUGIAzBPSPgiecxN9Qo
         YrnRdILV0fpMPh+SHj/wIJ6iXSuKjdHy7hwr741nI3JUP6IZmPwNtp2b4djYyErae7QU
         MLHISf3YYIA512UXjalMpuCKYOCVxfwATDxM0MsYj83tgdOZc+Gtce8ZQx5tdLBF9V0P
         s4lQPJzMFsHKyRjptzCBA694o33UZWc4eHoNgKFoU+Y3R54qAPFourwSTOZvqTgzhIP2
         VUuMWnqffPSWQuv8vyeRS1fLweuMYpjfPPcZqldjfjhWgBVjBScxyJ1vlwQ6vAfx7FRE
         KQoA==
X-Gm-Message-State: ALQs6tAIxiimL99XF86sGxwm+hFxK9UXSrgerW9vT/Xu22yDJ5u00fls
        ztiKdFkcOBp2bJXDxf86eaSgdA==
X-Google-Smtp-Source: AIpwx49fG8iojWxaTwXxc1gJAg2dHghGVUs60QDSbeDexiOQkOQvG2h6EZyBpmF6zOzFyljboLw/rQ==
X-Received: by 2002:a17:902:69ce:: with SMTP id m14-v6mr7396586pln.358.1523492502826;
        Wed, 11 Apr 2018 17:21:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i186sm4635677pfg.53.2018.04.11.17.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 13/15] replace-object: allow prepare_replace_object to handle arbitrary repositories
Date:   Wed, 11 Apr 2018 17:21:16 -0700
Message-Id: <20180412002118.102976-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace_object.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index adfed78901..eae52c66f3 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -31,18 +31,16 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-#define prepare_replace_object(r) \
-	prepare_replace_object_##r()
-static void prepare_replace_object_the_repository(void)
+static void prepare_replace_object(struct repository *r)
 {
-	if (the_repository->objects->replace_map)
+	if (r->objects->replace_map)
 		return;
 
-	the_repository->objects->replace_map =
+	r->objects->replace_map =
 		xmalloc(sizeof(*the_repository->objects->replace_map));
-	oidmap_init(the_repository->objects->replace_map, 0);
+	oidmap_init(r->objects->replace_map, 0);
 
-	for_each_replace_ref(the_repository, register_replace_ref, NULL);
+	for_each_replace_ref(r, register_replace_ref, NULL);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.17.0.484.g0c8726318c-goog

