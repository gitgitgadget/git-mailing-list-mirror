Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508CD1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJSDCC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:02:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40358 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJSDCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:02:02 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so1656850iti.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjHoKZH5va2Y8Rh7J9by7ejRkNV2SFKPTQKikXwcUVQ=;
        b=U7zsb5/+WJeskSVwrexi+oEnOZ56vAYm/yYRHdSXEMsxjqH+ZGdfUP0v+BfU5133qj
         aefToDc5tTsubOv+Mh0wrz09hBG3FjIM8KtQovmphH9cw8s+ZflSp++bgci5gJblYJWt
         thOgYtRJGNsCPhCJ6v5vicPN6RnA8xh4ngBq2d/Y1gw6y7Qfdj0T7tQPjIhaQiI+Qjyk
         ORrn/kRHCQZF+INw11grgD5BrosWWwHECIsDlTyx6OgKPrb8aG+fiPj/KifA6nfbKlOw
         NLRMQStbxRZuYL4GlvVKPsg6j166H+lZiBKKNMqYTYqNtH2B+sTHYBHBuaQq1HWE6aO6
         L9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjHoKZH5va2Y8Rh7J9by7ejRkNV2SFKPTQKikXwcUVQ=;
        b=CNRnTdqXqbl3VLxk2Sv7XX2FQmt2UFooxvlOv++KOkF/O6XjeCyMFjoDPQKHMk9bJ3
         A8o6GNjyAeomlgP6VlhH/UHKkvkRBFJaVFATkx/gEDS2pZykbN2gMKL/WS4njz1YVELm
         ZJ12vkS7O24w0RTW9Cc8FMs9kqtYX3CFyElbuyprnWV7SmhygPca5Nnhr5R5fcI43SNC
         M385KukKny9212HSV5lkaruP/3cudDJmTWcx4kZ/GrhpcVwEKZqVULvARUg5C7UDZGH2
         H37uwvqy5wYX219VV6os0R41J02dqkWSo/2SvyDVLVUdT2tonMxSku7+2yER5dq4RLVD
         WYLg==
X-Gm-Message-State: ABuFfoggVc1MHUooVl0UWHegk1/8Vqm+uX/hdoNCfFpHqMaBHfhmRHI4
        gTgMSaO+GSFZwuqw/PvyjqHuVllY
X-Google-Smtp-Source: ACcGV61osXWpYNphgnal0atNUEow+u7rYXUqfdTkPalqQvn1uAl0LBzoalC74u9dnF2F8Qwj9cRMgw==
X-Received: by 2002:a24:f884:: with SMTP id a126-v6mr1152844ith.113.1539889179480;
        Thu, 18 Oct 2018 11:59:39 -0700 (PDT)
Received: from Carlos-MBP-2.sf.stch.co (50-207-95-178-static.hfc.comcastbusiness.net. [50.207.95.178])
        by smtp.gmail.com with ESMTPSA id h76-v6sm7785115iof.16.2018.10.18.11.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 11:59:39 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] multi-pack-index: avoid dead store for struct progress
Date:   Thu, 18 Oct 2018 11:59:20 -0700
Message-Id: <20181018185920.22975-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

it is initialized unconditionally by a call to start_progress
below.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index ea2f3ffe2e..4fac0cd08a 100644
--- a/midx.c
+++ b/midx.c
@@ -941,7 +941,7 @@ static void midx_report(const char *fmt, ...)
 int verify_midx_file(const char *object_dir)
 {
 	uint32_t i;
-	struct progress *progress = NULL;
+	struct progress *progress;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
-- 
2.19.1

