Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C2C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA6E617E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbhI3Fmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348132AbhI3Fmc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:42:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC6C06176A
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 73so4729184qki.4
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0RYkvD3jXF3R7X1J750AqUZotdnlAMclD5KrtkiSvM=;
        b=n30U9Snkgn5WTl/ni6WOIrjiaTIcQDn4lXi3dP9GuHD5fFPO0KYsw20iDkiweLvFv+
         At53fgmATagn5y2xcAO0qqH//AZ4GgUydINi5n7li+DHdC/UJkBqS6dv4vZAaTQjUUwn
         Rh9PFE1EknqZWzfOTreZBsApbGwZ07zHx7wtzsUk8rvCXCBLOnN1ay/mv79mpw0amnOe
         5egV5GwUlP4zSx5cc1RCXCxOnVzJc+XjB3ES2o7HiGC0iTWJHpb4qQhd69oCmkwTUQap
         Cnyd6ur32hGLoYl9GAemUvO1Sb0hu3vaYv9koQt2LvHRd0E7eR7Bzmgf19Rn/Xupz8cy
         5+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0RYkvD3jXF3R7X1J750AqUZotdnlAMclD5KrtkiSvM=;
        b=58XJKJPe5YMlZkc2AwXgYJMu7sc2Xw5m4DXLHRpTQypibuzayWeZvBBUlV29B+CLm+
         GWOq+/sJzw5+qebDjK3ZY33vWNdxrmtzCfYypGJT5riSl51IPrIrsaYzKNC7GWTefLwl
         2DxrMr15kDBX0Wslgav0uvLg3RusBN5g8bANR5D/cfxbxhyqF3lZqp3T3lwYyRe74vyo
         30heQZ7H3emIq9kcW5S+NzBmEnSSPMaXjL2rYptSLt6+E6C0BDtA1hEHWIzU5da7j0sK
         oq7oem1GA4LEdxAKHWRkWmA8/rOLq4J6u/xIiAlLuDEtQK2Zb2tQoGrpKqMX/LE5ee2E
         F0Ew==
X-Gm-Message-State: AOAM531zwZ0Seyx96eq3L9vrN1EpKqFewJ7sWEK55W9/2CL13Q9bx24v
        Q81xY9iB6qP2gn1ZGU3RD2XGR7/en3HihA==
X-Google-Smtp-Source: ABdhPJy+klXxlumzcHjrITB4UCf/bPonV3Pr5vZubsgMSf6USstLnuH41EUubcaJoFdRc8uulNGI2w==
X-Received: by 2002:a37:8883:: with SMTP id k125mr3144679qkd.458.1632980449000;
        Wed, 29 Sep 2021 22:40:49 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a2sm1006826qkk.53.2021.09.29.22.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Sep 2021 22:40:48 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 4/4] reftable: avoid non portable compile time pointer to function
Date:   Wed, 29 Sep 2021 22:40:32 -0700
Message-Id: <20210930054032.16867-5-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210930054032.16867-1-carenas@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
 <20210930054032.16867-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While GNU compilers (and even MSVC) allow as an extension setting
at compile time the address of a dynamic function into a static
variables, it trigger C4232[1] with a warning for portability.

Avoid it by resolving at runtime the address that will be used
on each case, and not relying on the pointer initialization
to be honour at compile time.

[1] https://docs.microsoft.com/en-us/cpp/error-messages/compiler-warnings/compiler-warning-level-4-c4232

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/publicbasics.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index bd0a02d3f6..b5767bccc5 100644
--- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -11,23 +11,32 @@ license that can be found in the LICENSE file or at
 #include "basics.h"
 #include "system.h"
 
-static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
-static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
-static void (*reftable_free_ptr)(void *) = &free;
+static void *(*reftable_malloc_ptr)(size_t sz);
+static void *(*reftable_realloc_ptr)(void *, size_t);
+static void (*reftable_free_ptr)(void *);
 
 void *reftable_malloc(size_t sz)
 {
-	return (*reftable_malloc_ptr)(sz);
+	if (reftable_malloc_ptr)
+		return reftable_malloc_ptr(sz);
+	else
+		return malloc(sz);
 }
 
 void *reftable_realloc(void *p, size_t sz)
 {
-	return (*reftable_realloc_ptr)(p, sz);
+	if (reftable_realloc_ptr)
+		return reftable_realloc_ptr(p, sz);
+	else
+		return realloc(p, sz);
 }
 
 void reftable_free(void *p)
 {
-	reftable_free_ptr(p);
+	if (reftable_free_ptr)
+		reftable_free_ptr(p);
+	else
+		free(p);
 }
 
 void *reftable_calloc(size_t sz)
-- 
2.33.0.955.gee03ddbf0e

