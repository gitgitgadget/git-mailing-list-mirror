Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD711F461
	for <e@80x24.org>; Sun, 21 Jul 2019 19:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGUTk4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jul 2019 15:40:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43896 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGUTkz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jul 2019 15:40:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so16575612pgv.10
        for <git@vger.kernel.org>; Sun, 21 Jul 2019 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R78c7j/BB3KJT+dajb12nN7wpnV8ZjF26Tk9qXthWIs=;
        b=o93os3ukCFBzwgCjjCR/tFw4UvW2wGq5QHwvEx89mvp0Nb4rSzt62EuMtqVm75NCUu
         w7DwjNyoJFfzZlvnM3WtLr8X82ki/7C4vdbtm5xy1YJo10MMQk/g680isqVamQ8wuEXZ
         wzVGUhH2wArKpRqOTVRrHYyLorZWKqtF0si1maPefaUl5lStkuj5ZLRRYdOMqz9Hwisq
         YBKN/RX2mdYKdzvWMZh92KU/34WE17OXFwmgm2xOnBtjZG5U8TxcYXCY5X1MUdTGDcS6
         zL5U3zVZm+b6E8mXTO34K75aH+bJDappnVF+br/mc7tg73d/xNRJOdys+OZBwmegcdtg
         masA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R78c7j/BB3KJT+dajb12nN7wpnV8ZjF26Tk9qXthWIs=;
        b=YUx8Y0tr9udStca9FTivndvUfgVKAG9hDmmLARsbmnpkyrBmmo5h5//TrlKjR57/fs
         pcc6vsQUHxD4vfBvaexuQUeD49GSLYSPYa6KvKJW8QboVGUwtXM2OnzR01ckdv/pG9s4
         Uvi4cwwNSvSROFNipfKySlmM6bEQu6d89Z8AeSSkP02H3QLLLuKcYvnP7IYzEkpkslci
         wpVVZKDnXVZNbx7X1LyJVd/Wl5pSPOJ1K2QOi3PXQ5982DyaEsxK/a0FNDRUI+w7OGv8
         ggvOmKWMd59iTny0MpTGKec7J/II2SIuwBFUxx98ARIxc2jG2sZyuwBNcr4oYI3qC5s8
         GDCw==
X-Gm-Message-State: APjAAAWP1tYo98WvjQTcCtPtLUK/6oB5KBPklnGNSSCrSmDTlDZogyBX
        QfqcLt2GLQ5AkPxJNk83NfP/RaTJ
X-Google-Smtp-Source: APXvYqz+60VgwEdtiA2yBseTBhHYHpl/hniOa80AYvf1/2b6VcLTu1yymyIL4MblfKYj297kab5Z0A==
X-Received: by 2002:a63:f452:: with SMTP id p18mr42086254pgk.373.1563738054832;
        Sun, 21 Jul 2019 12:40:54 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id m11sm26839477pgl.8.2019.07.21.12.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 12:40:54 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH] grep: use custom JIT stack with pcre2
Date:   Sun, 21 Jul 2019 12:40:52 -0700
Message-Id: <20190721194052.15440-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) allocate
a stack and assign it to a match context, but never pass it to
pcre2_jit_match, using instead the default.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
This might have positive performance consequences (per the comments)
but haven't tested them; if there is no difference might be better
instead to remove the stack and match_context and save the related
memory, since it seems the default was working fine anyway.

 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 146093f590..ff76907ceb 100644
--- a/grep.c
+++ b/grep.c
@@ -564,7 +564,7 @@ static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
 	if (p->pcre2_jit_on)
 		ret = pcre2_jit_match(p->pcre2_pattern, (unsigned char *)line,
 				      eol - line, 0, flags, p->pcre2_match_data,
-				      NULL);
+				      p->pcre2_match_context);
 	else
 		ret = pcre2_match(p->pcre2_pattern, (unsigned char *)line,
 				  eol - line, 0, flags, p->pcre2_match_data,
-- 
2.22.0

