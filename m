Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B1E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932356AbeFFHkZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46102 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbeFFHkE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id j13-v6so7537326lfb.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Euk4diy/4P77yW0831lQLiBWzlNcv1SeUwVpoiSHgs=;
        b=stO6i7cGtyfmG0lLwEq9KVSPdt9hNyjcR+an4ec5NW2ScVekhpHcm9mQQOTdwLC2DP
         /5UpSTTf8CeSr9glcUMXBYaAz0v+0JCpR73zoTEd3Ouk/rD9Ydt0k4LV8b6JeZtFrBnJ
         +FVdGKzPqKinhL1OpYUsMV6zXEKHRBvgioxb3Ikz7G2T6HrIbJOXZuyhL4yz7YbG67Cx
         4kl42vaWRd4FEbqQHQ706zTm2F2BAviwa/NiwmgxwfLZJXPSl6WHackiD8/MPr7SUHEL
         14fgx3VbsH4hKaPYc/1uDDnS/J9y9gZ46oMS+YwJPOPMUj2JOs/EoY99C9jKm4uORgfn
         w0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Euk4diy/4P77yW0831lQLiBWzlNcv1SeUwVpoiSHgs=;
        b=BY70I/yCy4oIZC/CfyFQl9Oou6L0ExSWqkMQfz/JRO5xhBib3SRN9RCAEvnt0TejpW
         0FRMHmRmEm221njExnfVtyht1EfLjAJ7sMJn+Wu2FEUvcD8H56nYmDs+rYOUEMovRn+P
         b824JNVDmx5v7T1e61fWIxGsFHQLvl08MmBJEBfu8f9bQ1KxSmSz468w5k/mK3zX9N/H
         zlqa+kkURoWfqfEwOo3pU/rmB++nd9N4oPxv8Eh4XLBbycc2j4aFXT7G5KYzZovv5amD
         IlC2Ic8JYODsx2gH8vOQJR0iYml9n0b1pgkd3gg41TjLwKoihl3rUWo3sIpjDZQJOmhK
         ZrzQ==
X-Gm-Message-State: APt69E0hPonqj8emuH7yP78no7zqZoVyjTdQr9ugc800O0ZE0VxdZbBQ
        /OeIFgk66PtzE1jJFIWxXYM=
X-Google-Smtp-Source: ADUXVKIDUjM0gCTOc9ZFgmknUZ1j5d4nROc1bzSu70pQYC/mT9u0/Sv/MO3oNr4I9ExeSA+2M7wU8Q==
X-Received: by 2002:a19:6387:: with SMTP id v7-v6mr1107586lfi.74.1528270802892;
        Wed, 06 Jun 2018 00:40:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:40:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 16/20] preload-index.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 09:39:29 +0200
Message-Id: <20180606073933.14755-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 preload-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/preload-index.c b/preload-index.c
index d61d7662d5..cc2b579791 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008 Linus Torvalds
  */
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "pathspec.h"
 #include "dir.h"
@@ -58,7 +59,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce->ce_flags & CE_FSMONITOR_VALID)
 			continue;
-		if (!ce_path_match(&the_index, ce, &p->pathspec, NULL))
+		if (!ce_path_match(index, ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
-- 
2.18.0.rc0.333.g22e6ee6cdf

