Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98553C432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F40C610C9
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhHPBQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhHPBQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D0C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t66so17551655qkb.0
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8oDbT2VVCXYAnZPeuQNikhB3mn/OgP5YRYmfaLOKHM=;
        b=p+RsjQtcbpwKjWYzdlwZZQ9xCtU0xETQc8mwaqMUxUp4QruTRcINs2Ri9l52TI0m9w
         O91wyiJeqhcDIkp5GY1a01d6T+gd5MtSl6FCN9JUSO4PTJyOCP0YXJt+b9NBcEpkh15e
         Lv2lVud0YIiGcw3FDw2KuMLI4A5N6ptRnZvCIDLGwOhnTZv1ftKcIaMMObVI+T55GJ1v
         l9doMNTbOMqJ18J078ZiNH7gKRW1NPha5/QVY0I12d7g1uWcI3bBd3Q0Y37nZTDfthvA
         AK66UHvVSsLsSCIo4aHtoxBEwJdyGY+mqesGRE+qnuutSYUgkSC5AYxxOzd9cs4r1rs0
         SY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8oDbT2VVCXYAnZPeuQNikhB3mn/OgP5YRYmfaLOKHM=;
        b=dkH6CHcoQfE/K/myxLrrt1kGqpcMcEQLx73U9rXsMl1lmmBRV4VfNCs3YiYpk1sA93
         UOukFqW8gWAVdn2J94xOHbX6ykTFCqIAzQdI2agTryMks559LvUWroDb+CxszNXsBWD4
         dRcKzF2PYEc1KFnpetPq3D4MXwz52Vgg0v5qiu0T9LIfv5zEykbFmqw+PuC+1BWUwb1r
         UUOdCHRk4II7aK9P/XhEkuKxHlhTCGHjD4uzhPq1VitG1P4pyWvy39kAiQCXLvKELOvy
         tpfUeQe4wR3zwd0K4oRqXT5rKrl/yfEM82bFI8unmMwGf8XLmVp+dTa24ZUCspWEV+6H
         drfQ==
X-Gm-Message-State: AOAM5328Lb+5RRF9Ne5H0BbtSdgx1X6l1T+2mM5V7bl9Aa0CjCcAsBZB
        LHDPXE888Ej2hbiueei4x/ltCQ4jrmA=
X-Google-Smtp-Source: ABdhPJxJcnF+4cWEFJG585VrTh3jDCAlMy90iLgjV7nqcjvnJH0NxvKTpQdsD9tCTrylw2YWyWz9eA==
X-Received: by 2002:a05:620a:890:: with SMTP id b16mr13990046qka.433.1629076553918;
        Sun, 15 Aug 2021 18:15:53 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.15.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:15:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/7] fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
Date:   Sun, 15 Aug 2021 18:15:32 -0700
Message-Id: <20210816011538.34199-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210816011538.34199-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
 <20210816011538.34199-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

124b6e20ef (Provide zlib's uncompress2 from compat/zlib-compat.c,
2021-07-20) adds a compatibility replacement function for uncompress2
that could be used for building with zlib < 1.2.9, but adds it to libgit.

this could result in link failures depending on the library order used
by the link command as shown in (from the 32bit linux CI task for the seen
branch):

  reftable/libreftable.a(block.o): In function `block_reader_init':
  /__w/git/git/reftable/block.c:222: undefined reference to `uncompress2'
  collect2: error: ld returned 1 exit status
  Makefile:2649: recipe for target 'git-daemon' failed

add it instead to the libreftable library that is also the current user.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6014f74a1b..b4f5cc6fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -1739,7 +1739,7 @@ endif
 
 ifdef NO_UNCOMPRESS2
 	BASIC_CFLAGS += -DNO_UNCOMPRESS2
-	LIB_OBJS += compat/zlib-uncompress2.o
+	REFTABLE_OBJS += compat/zlib-uncompress2.o
 endif
 
 ifdef NO_POSIX_GOODIES
-- 
2.33.0.rc2.476.g1b09a32a73

