Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491A11F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeKCR7t (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41922 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id c16so2849750lfj.8
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DbyoW90a68bGDlCFgtB/W4/tJnrKo9zwC/US+jgSaA=;
        b=jVqFebAE+ZaGdjnHcl0EaLjt3pfK1dj03WXirHdX9MYGmKf4unMOCTBxHMBtnwX+jt
         RsrFOtid6MWgMwlxlDd2mt3/5sgTclBZA5z5wM0zIGdXvpKm6caNmYTaI4b1F6UoH8Ic
         YmT+4ehC+9hCOPC5Wdea+QJS8j3Fd9/zys4Ig2VnJRmr+Wdx7opgqqGay+BvsaaArZVZ
         YgU57LwDvTClJpYUZwBp8gcAW4xPaUU/rkp4wxr9IVqRHydgTG3q5sdiRCphXGxIhWbK
         U31Ozju2b6OA6lPM0Z+IRzQ9Mov/hPL/PghbMcwr19GNV6u5ODGS0/3ln0ULVk+wQvtE
         vdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DbyoW90a68bGDlCFgtB/W4/tJnrKo9zwC/US+jgSaA=;
        b=plr6iarlyXaUJy3ldZZMwhKlmsp72TgaqKl+kH8u8X8/lZXQvSv5rfktfd/U5Sm5Zo
         XqtZVNx8gkp3df/qTdJTLgoDZRulzo0qp2CbEsptHnX385Vds+gHIlaYMVA/8OLMky8V
         mb7cjfDzwA0hy7M8CfcEoNsBQISU14yphgb+lNpHZ7kDGl6G7cop7rBJSvkBaFTCozIv
         ZYFEwsgg43rnmuYHgpjScs/RqlcLIf1HiBVIVHeJDj7Uifemi8GiQVpZIt8QmmOhZFeM
         VxENMLOsk/qvOJgnbndRdx83jeoLe8OnQHS4xekYRR+urDT2EnL6fWyKpUEOdc6HaIj+
         5lbw==
X-Gm-Message-State: AGRZ1gJbSNGk3xFgb9V7s5npfRc6Ty/gf+Ok6lTQzo120XtpCpg9ltAn
        5Tj+3ivduMPan5Fzze1C++6qO1Z4
X-Google-Smtp-Source: AJdET5cDgQAUAyLfMJB7rH2TRbuWVj/BdaTO66eqLPYaN98y1BLI0/7Kn3o2Doz0Rbotq78t+di1dw==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr8126974lfe.18.1541234952057;
        Sat, 03 Nov 2018 01:49:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 09/14] preload-index.c: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:45 +0100
Message-Id: <20181103084850.9584-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 preload-index.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 9e7152ab14..0e24886aca 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,17 +7,7 @@
 #include "fsmonitor.h"
 #include "config.h"
 #include "progress.h"
-
-#ifdef NO_PTHREADS
-static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec,
-			  unsigned int refresh_flags)
-{
-	; /* nothing */
-}
-#else
-
-#include <pthread.h>
+#include "thread-utils.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
@@ -108,7 +98,7 @@ static void preload_index(struct index_state *index,
 	struct thread_data data[MAX_PARALLEL];
 	struct progress_data pd;
 
-	if (!core_preload_index)
+	if (!HAVE_THREADS || !core_preload_index)
 		return;
 
 	threads = index->cache_nr / THREAD_COST;
@@ -151,7 +141,6 @@ static void preload_index(struct index_state *index,
 
 	trace_performance_leave("preload index");
 }
-#endif
 
 int read_index_preload(struct index_state *index,
 		       const struct pathspec *pathspec,
-- 
2.19.1.1005.gac84295441

