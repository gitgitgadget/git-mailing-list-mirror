Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBC91F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 19:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfHOTNW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 15:13:22 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38987 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfHOTNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 15:13:22 -0400
Received: by mail-pf1-f180.google.com with SMTP id f17so1796435pfn.6
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QYEhlMTTXZjPGB4Thk1lTR0RHYYX9CeX4ucGOVNiAE=;
        b=opvAvLzN9RFkLqksajiAwzoqCn8zCYb39aAy6+3m+Uhc4BEFJEbPgNslM2I4r7+eBj
         ifI3xBN6o40Q/pQUIazwtLVwDBDVuSxSERLJ13xShSi1n9obSMrzJHR1WLbU/7rBCpIQ
         2xp2YQ3oEjo12mp6W9hxsoCuVx7Btv0SPzmbmwr5oAChqjJz425enDznroe5BwZc5Vun
         aOXMyTOsErNtn0G+SGWd81QIApiJ2ltVjGQxy/Eg1osCbNj292D3R1JrT5/a0alekRXw
         LO076g55HU9LqfoppShod7Ski+QICSqEYrqcjsgpopv8qJmB23u3OlVmAphnByNMXf0L
         k9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QYEhlMTTXZjPGB4Thk1lTR0RHYYX9CeX4ucGOVNiAE=;
        b=HKCrmOC3j6+agbZ+PzNQy0puAz4zG0inGUbtNN1IU4nujC9BP/YkMz2DPBl5x2q++3
         mcbJtDh2MCseiu19gj5ffEMfe+Na3IjLrezWf+OYqIO+49MuB35HjoiaswBkatAyxiB3
         lQ10fwngMH5nPz1D/piuQ+i55RiumOwPak6oUkhM5wWkse1JA/CaG6juLNeD7kGKWsnr
         4VL0fAak7q2y3MZAvj41ysv4clVIqJE0ToLCtrLXfS2bjzrXGbSm5ZNBgP7jc30lBTAk
         Jo2nwSdellq/ZvnhWoj+YTNhv6a+/LEf3iFMl4Y14LQrzNENy2r7iLhGBGgzY5bjHlrV
         cFAw==
X-Gm-Message-State: APjAAAXu75JiHqE1HJ5oR0w780gBEWJqSqCaIXTpbObkr1mylRBDaolt
        kNgFK1saqILoq2HiueacscBRvxhpW+8=
X-Google-Smtp-Source: APXvYqziVKSSvIhRpb5pv57+PPiojAyRi1ruGFBOih+Cd+1G085iDzaRB4uhHHir1xuKw0hiRGitqw==
X-Received: by 2002:a63:4c21:: with SMTP id z33mr4692343pga.418.1565896401366;
        Thu, 15 Aug 2019 12:13:21 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id a3sm3849109pfc.70.2019.08.15.12.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 12:13:21 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, daniel@haxx.se, peff@peff.net
Subject: [PATCH v2] http: use xmalloc with cURL
Date:   Thu, 15 Aug 2019 12:13:14 -0700
Message-Id: <20190815191314.27440-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
In-Reply-To: <20190815153504.23199-1-carenas@gmail.com>
References: <20190815153504.23199-1-carenas@gmail.com>
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

Notes:
    v2: keep all global_init ifdefs together (as suggested by Junio)

 http.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.h b/http.h
index b429f1cf04..20a2030c94 100644
--- a/http.h
+++ b/http.h
@@ -25,8 +25,12 @@
 #if LIBCURL_VERSION_NUM < 0x070704
 #define curl_global_cleanup() do { /* nothing */ } while (0)
 #endif
+
 #if LIBCURL_VERSION_NUM < 0x070800
 #define curl_global_init(a) do { /* nothing */ } while (0)
+#elseif LIBCURL_VERSION_NUM >= 0x070c00
+#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
+						xrealloc, xstrdup, xcalloc)
 #endif
 
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)

base-commit: 9827d4c185e4da728f51cd77c54a38c9de62495f
-- 
2.23.0.rc2

