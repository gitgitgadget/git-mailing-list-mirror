Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7821F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfHOPfI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 11:35:08 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:32776 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfHOPfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 11:35:07 -0400
Received: by mail-pf1-f174.google.com with SMTP id g2so1524899pfq.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZFT4N+Fo9NgHu6AGerqZq/veKwiJpoOZf19ALlAN8k=;
        b=PXH2avchzG1/5LAqiZSfxCvyYcL1I/oStkHDDUTnbUdHx4tQWqQRYbElepfPxVW+ds
         Avsp/bIJ3TJI6k4SGcpjrhLUhc1gzGbXbIuV03TvhU4BSJCuZNIafQ0hyBoNmi4QvBQu
         LQWcVithIXM9gkUobo685ySqAjvIWuEkk/Z2oJctE0YRl52UocD0ZbiIrHlSGigeGb9M
         2wVwsuXef6tXvs/yhQLnwLlnfmx9PMAWXoHsW2nC90DSMlcN32CdsPcfd5sWk2I9oXes
         MDhjQIxby1434BcOpdou7Q5L4xHETMZJJxRR4jgFM9668ZWBqr7FP5O49QSJXx/PWvBX
         RbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZFT4N+Fo9NgHu6AGerqZq/veKwiJpoOZf19ALlAN8k=;
        b=Pjj/wD4HTXlBnRA0U/Uic1NuyoGmXespNYJtV8s4CDYW4dvgBUMx5oHgqxsSJemoXb
         gP8wa14QYYHXLxUE25DmFY1hYReg9AEZ5BMrDf6JvCCRNl+aotTl8Se/FID/vH3iHRuF
         E+EZ/2a0XrFjB50yTT5G/z6cj9W64Um9U5O+R3ZO5ZvQkCSwIP5r10YTu9C4YsYLfCcZ
         ZUgOEvW+NESmIN0qNUXtkQjc6OZgUpTayPcx/QOCwfJJ8wJUZiFBq3eKuXJnpIgVDEnO
         pIM3D5+1QSr8jTxQJ7ceGK7unMQkUh/K4/ROBFNDjyWq1j9Gqo2I27gUqBkcIfBs6N7h
         VdOw==
X-Gm-Message-State: APjAAAWssQ1WfXVhPVwBtB4nIK5H4lByYG7Ra6qXz6MFAWyG5DLKyN+j
        Iatidg7bvAzSgLlIWfaz2IC0VPLUakM=
X-Google-Smtp-Source: APXvYqyaidXVKiOipamgdfcbwSH4zS6ntexpUMJtzM22BlV/hG6Q1FKY01OZYeWBLB5Zopl8NcJYng==
X-Received: by 2002:a17:90a:f485:: with SMTP id bx5mr2809370pjb.113.1565883305922;
        Thu, 15 Aug 2019 08:35:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w189sm3030439pfb.35.2019.08.15.08.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 08:35:05 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, daniel@haxx.se, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH] http: use xmalloc with cURL
Date:   Thu, 15 Aug 2019 08:35:04 -0700
Message-Id: <20190815153504.23199-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f0ed8226c9 (Add custom memory allocator to MinGW and MacOS builds, 2009-05-31)
never told cURL about it.

Correct that by using the cURL initializer available since version 7.12 to
point to xmalloc and friends for consistency which then will pass the
allocation requests along when USE_NED_ALLOCATOR=YesPlease is used (most
likely in Windows)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
This doesn't conflict with anything and was originally based on maint (so it
applies cleanly also to master and next), but is now rebased on top of
jk/drop-release-pack-memory so the final product wouldn't have any chance to
introduce problems (thanks Peff)

it has been built and tested in Windows through Azure Pipelines (thanks Dscho)
and shouldn't introduce any build problems even with ancient versions or cURL
(thanks Daniel) and while not strictly needed is a nice thing to have for
consistency (thanks Junio)

 http.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/http.h b/http.h
index b429f1cf04..e5f075dcbf 100644
--- a/http.h
+++ b/http.h
@@ -22,9 +22,15 @@
 #define DEFAULT_MAX_REQUESTS 5
 #endif
 
+#if LIBCURL_VERSION_NUM >= 0x070c00
+#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
+						xrealloc, xstrdup, xcalloc)
+#endif
+
 #if LIBCURL_VERSION_NUM < 0x070704
 #define curl_global_cleanup() do { /* nothing */ } while (0)
 #endif
+
 #if LIBCURL_VERSION_NUM < 0x070800
 #define curl_global_init(a) do { /* nothing */ } while (0)
 #endif

base-commit: 9827d4c185e4da728f51cd77c54a38c9de62495f
-- 
2.23.0.rc2

