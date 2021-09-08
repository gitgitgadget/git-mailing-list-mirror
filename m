Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF99C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F21610C8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350701AbhIHHrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347842AbhIHHrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:47:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED1C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 00:46:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 22so1601961qkg.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MP5JpvQwFJuuUYm1/KZXxQOAtAOPrTm88HToA4LvW14=;
        b=bHMIFKPuQ7NzpqcJC5M0hfrYzBuhBjllqQ5S6DiPKYFm1q+BNafH9TYXJmqRc6HFRT
         tAsL2nGzNd0GNNTbKvVyydSfqHgou7fpVhEY04tIgthHlLbieITxhT78Og+hEAGl9Wmf
         LYJnNPf3Ua27Bt5b64woZe4DrI7RACD+OyDrADvjqLDVhjCjly58q0Ni046LoEuf0XF5
         Y89sETRKCMus5iWyC3KteWmeSFdx/kfM8c/jGyuMG6/onFsxaXhLD7baAbnWlKMQab5W
         ZW1zxz9EwyNgqsVs/iBaK4xetGclqIUXcX9kSHaI3IzQYoXYlZwTGe5PMZrmHnRO/+ao
         N/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MP5JpvQwFJuuUYm1/KZXxQOAtAOPrTm88HToA4LvW14=;
        b=jB1vJBG0TS0ngOFei2gJK4qNCM21k7fUufm9ff4fwRQVtJqD/iU8dR6Yul6D7OVRjB
         GRgd17Af4/1PY62JE9BiU1NOa3ySarixl2W970CChnJwwCd6jr1yP9xz0kHxkHFBattv
         ZshlQf0xnzN9fvpCGpjZYcEwbVPn3Zegertr/YjBtDGQ9Xqv8hLN5W/x1D6AK+YQjbgI
         RtPgWTx12Qy0I6R5F9sPLDsGbs0UbqsmNWwn8zLu2+p1gfB35TEQ452vkMyyAEjGAlzY
         F3WVbUR/VVGOgPY13whOp0KbXic31z0sqqUmyTK6R1yp7p31u0k+0+F85bTZAoMR3PEl
         L9MQ==
X-Gm-Message-State: AOAM533domJgl1wqxWg1XMqY/RAnUQ0UYpzdwab5V14jnxrja0So47yR
        J1kQHcr74UAhgrnWHYxIhy2MN9Qf4bw=
X-Google-Smtp-Source: ABdhPJxhbTN/34WJ0ksbhr6n9qFKuxTFzukb6uj4X6reEkh0VyzkkmEQ6fWucQCXp19JnXkDCtlirw==
X-Received: by 2002:a37:a00b:: with SMTP id j11mr2145020qke.337.1631087170376;
        Wed, 08 Sep 2021 00:46:10 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v14sm1122935qkb.88.2021.09.08.00.46.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:46:10 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/4] fixup! reftable: reading/writing blocks
Date:   Wed,  8 Sep 2021 00:45:54 -0700
Message-Id: <20210908074557.38141-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210908074557.38141-1-carenas@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <20210908074557.38141-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

move the definition to "system.h" because it needs to be accessible
also to the compat file.
---
 reftable/block.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index eb5268dd3a..11387b260a 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -15,15 +15,6 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include <zlib.h>
 
-#ifdef NO_UNCOMPRESS2
-/*
- * This is uncompress2, which is only available in zlib >= 1.2.9
- * (released as of early 2017)
- */
-int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
-		uLong *sourceLen);
-#endif
-
 int header_size(int version)
 {
 	switch (version) {
-- 
2.33.0.481.g26d3bed244

