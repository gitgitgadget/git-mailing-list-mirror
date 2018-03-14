Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641201F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeCNV4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:56:09 -0400
Received: from avasout04.plus.net ([212.159.14.19]:35746 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNV4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:56:08 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id wENSeLdDhsD7bwENTe46qb; Wed, 14 Mar 2018 21:56:07 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=yBhdaeT2Iq6GER-ebPwA:9
 a=IrBGYhS9lLBEK1yT:21 a=FkKNdbij_UiL2GXW:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] http: fix an unused variable warning for 'curl_no_proxy'
Message-ID: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
Date:   Wed, 14 Mar 2018 21:56:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMJ3+W/QlKN1PMV+mCgSRMvK65dDkfZBHAFPdiumOwbIlv7I+SsQ6jsj6v3zdc0Bvl7U94cQnM/md/gfnMUF2jZwPK5trhgGJKIZIblIgYDum508/mN6
 SbOuxZaYHiIGfJ65gEK1F68fjwnJcv+HxzgIgm+q85UQ2W2Jump1E/IDPXSfQ5Lc+fq3LGFtIvw+gQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I happened to be building git on an _old_ laptop earlier this evening
and gcc complained, thus:

      CC http.o
  http.c:77:20: warning: ‘curl_no_proxy’ defined but not used [-Wunused-variable]
   static const char *curl_no_proxy;
                      ^
The version of libcurl installed was 0x070f04. So, while it was fresh in my
mind, I applied and tested this patch.

ATB,
Ramsay Jones

 http.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 8c11156ae..a5bd5d62c 100644
--- a/http.c
+++ b/http.c
@@ -69,6 +69,9 @@ static const char *ssl_key;
 #if LIBCURL_VERSION_NUM >= 0x070908
 static const char *ssl_capath;
 #endif
+#if LIBCURL_VERSION_NUM >= 0x071304
+static const char *curl_no_proxy;
+#endif
 #if LIBCURL_VERSION_NUM >= 0x072c00
 static const char *ssl_pinnedkey;
 #endif
@@ -77,7 +80,6 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
-static const char *curl_no_proxy;
 static const char *http_proxy_authmethod;
 static struct {
 	const char *name;
-- 
2.16.0
