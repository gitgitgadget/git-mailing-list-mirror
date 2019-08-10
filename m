Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D618D1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 22:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHJWCy (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 18:02:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfHJWCy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 18:02:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so47596987pgl.11
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX/Ay8TbUMKXEtrC8u6edqGFauUHuJ8au8B76YJRR9E=;
        b=dh/hr0iLWWRmuFbDQSrDcKxjSedERW2t1/ytIyXeuy7vEzUqlsnQktF4owGUfJYlI/
         Le+4ICOPzjQlC1iSXWcVSmj1DOncgYRuqFmbf0xCGSLFcVjPG2+AKLEggUmk8HbK56AI
         f1zmFaEiGAYdwxKfkh1xI+fJS3s+JUtU6D/OFTQZeawdIsbYu/rVoBA51QUvSygxG9zC
         inEM7qiEfS4Pprx+8zGFbFYizYnEqXHPRg2MODm5mdkZ5bRY5kxyQaCn9zQLW6eKSxNz
         e28vDrOVeEAqgAn+aLn873iPLfany04s7T0V5jiFJwP3zCFZ5ukrHQeD2fsfMRh63mft
         QGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX/Ay8TbUMKXEtrC8u6edqGFauUHuJ8au8B76YJRR9E=;
        b=UhKWKOHC4P4/riRPCAo9MI5ahwrLLal4WWMQuZXgNhIRb7xpxUiRpsGvZBYS8QRbbr
         R/w7136mtV92fQIJ/z0dUy8aISs4B1d9IPjlWzLoCS+wq32GPmji0nji7mCji/JPQS5s
         LoY/1U2ekyVAxeIFdQZyo01CsasyA26W7gjIFZPeYIDlq7B07d1sDtUmce4+2keOfp3j
         J2ijd6fdNWLwD3fJaOwqtsYy7TC8ZVlGM9jelJAsNtP1M/iUoupPAfVKv4/9Wh3pCedU
         y/ihQtuYhDZksK4RFgWCFeEkp7943G2MxSiZg4Cf2N4ZvBBWrIQ/A/C5hr7d2MsxXasV
         //lA==
X-Gm-Message-State: APjAAAWFEqg3ysiAuxik14AOLLb88TtL3T1b3HLlud8Lkip3rFcaJWAB
        DENDpdw/XMNCCG1GccD3yQjjRrgEo3o=
X-Google-Smtp-Source: APXvYqzfosq1eBSKXYkLhrrdFdnmYGGttiJEqwrKVHLN/L3hu6QYd+dVeajsm0czAzOPFaJziR0ddQ==
X-Received: by 2002:a17:90a:32c7:: with SMTP id l65mr16292911pjb.1.1565474573336;
        Sat, 10 Aug 2019 15:02:53 -0700 (PDT)
Received: from localhost.localdomain ([207.62.246.71])
        by smtp.gmail.com with ESMTPSA id m9sm157176432pgr.24.2019.08.10.15.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Aug 2019 15:02:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH] http: use xmalloc with cURL
Date:   Sat, 10 Aug 2019 15:02:51 -0700
Message-Id: <20190810220251.3684-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4a30976e28 ([PATCH] support older versions of libcurl, 2005-07-28) added
support for conditionally initializing cURL but when f0ed8226c9
(Add custom memory allocator to MinGW and MacOS builds, 2009-05-31) that
support wasn't updated to make sure cURL will use the same allocator than
git if compiled with USE_NED_ALLOCATOR=YesPlease (usually done in Windows)

tested in macOS 10.14.6 with the system provided cURL (7.54.0)
and latest (7.65.3) and while the API used should be added starting around
7.12.0 (mid 2014). couldn't get a release that old to build and therefore
the current mismatch is unlikely to be found while testing because of that.

cURL is very strict about its allocator being thread safe and so that might
be an issue to look for.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 http.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.h b/http.h
index b429f1cf04..59ec4cbd30 100644
--- a/http.h
+++ b/http.h
@@ -27,6 +27,9 @@
 #endif
 #if LIBCURL_VERSION_NUM < 0x070800
 #define curl_global_init(a) do { /* nothing */ } while (0)
+#else
+#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
+						xrealloc, xstrdup, xcalloc)
 #endif
 
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
-- 
2.23.0.rc2

