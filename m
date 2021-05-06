Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095E8C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE7960234
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhEFIVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhEFIVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:21:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C04C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 01:20:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m190so4241754pga.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jyJzVD1YDafrm2RFSmGaTTTU/4xrtJrPvJ+smBZzug=;
        b=hdUm0GpZfPeUW+6/P94iUcjuQ+ERAsVevtQIDlQ9YYOVVCuWRRwTpZtLYbWCQZcRt7
         hVsZ2erMo6EB/MdmKE6+rmSXrdsYdspxGSTV4mU/zdD+rkgLZ752738hcXRZIH5+88dy
         QN6v7V6jXx17I0R7ZwZgUQz8qaiI76OK9TsnXVe3WhKw/cjQZG30g9eilzCzYkGNM231
         uFGGhWoeo2wx+wnJnb3L6EaYs5danrLq8XDATf+Q2A/a9C2FENjng7K2vMexZ97gfRmF
         nL9Z3vN9Ff5v0N2hzEMei465WeFtYd3IrBy/onrMsP7eWW3WsKOpuEILmEi+xSd29ubj
         akXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jyJzVD1YDafrm2RFSmGaTTTU/4xrtJrPvJ+smBZzug=;
        b=kFCjF7IS3G7ceb9Hae7gQIws5CI3xlmad0Mx9KuWrF4+TVmuzRc0XmN6Oa/c7qwRkG
         3zzTVgkhqVvDJXQcXeta1glFIjzMDdftMX6IhVixc9pKdTJligrGjUcWImqNuDmSGJqf
         uvwA3vdE1NZ8dGMGE2s0zvFALEpTz9zbkBBW8OwvjRv2m+21hXokw56GLIS0j1KZvJLX
         7727wFU5bJcxEFGUEfAqj6lJpBY888FWHxCWF6Pn1CERKyY4zahTJQG90ojjNacdX8GQ
         8tKqb11MbxTSHNdU21cT4GX8/yFktvhObLCcfBZKGLBTBYXVVTrEmnjAWdvjbWPrHTKv
         zzmQ==
X-Gm-Message-State: AOAM53115WxCD+7Eocct3r+t3CchgUB9InWban5WhtjnhYnWbAiEvGlx
        b2wiwTy0zcm8uFaV2AbQOTK4nJI5L7uHwCeW9QlKKQ==
X-Google-Smtp-Source: ABdhPJwjdfjRVM1t+TlVstKYum+DHWSlR7UEOBaUrKUm3dydjcaxIFTALmeSLucFwGM7XviCyKuN8g==
X-Received: by 2002:a63:2143:: with SMTP id s3mr3181685pgm.429.1620289212359;
        Thu, 06 May 2021 01:20:12 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.80])
        by smtp.gmail.com with ESMTPSA id h10sm1462015pfk.210.2021.05.06.01.20.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 01:20:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] Fix a small flaw in the comment of strmap.h
Date:   Thu,  6 May 2021 16:19:36 +0800
Message-Id: <20210506081936.29887-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 strmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strmap.h b/strmap.h
index 1e152d832d..0d1d00d14e 100644
--- a/strmap.h
+++ b/strmap.h
@@ -78,7 +78,7 @@ struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str);
 void *strmap_get(struct strmap *map, const char *str);
 
 /*
- * Return non-zero iff "str" is present in the map. This differs from
+ * Return non-zero if "str" is present in the map. This differs from
  * strmap_get() in that it can distinguish entries with a NULL data pointer.
  */
 int strmap_contains(struct strmap *map, const char *str);
-- 
2.31.1

