Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073B31F406
	for <e@80x24.org>; Tue, 19 Dec 2017 17:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdLSRYj (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 12:24:39 -0500
Received: from dogben.com ([172.104.80.166]:45176 "EHLO dogben.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbdLSRYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 12:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
         s=main; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fuuZfqUhBnyvVU0Z9AlM+JsugyWW2d6BPD0p5Gx/lOE=; b=qrhH/7wp7tv2Zk5FalsSJWOG+2
        h2yzO3JyYR/43J3AiWUYlN8a0Ve/PeZYOwiZ1/jfYA5KWDkcnsCAcFAfF+pA8ItDkAlkp9CKvpaes
        XW0j6y8FILelHdrM4k3Tztrc5efW3fGX9BZBlWHr9KWtPAGuFRfXwcmEDLW43JuCKiSN0xMhB7Oyt
        hqntpQAwqHLNNS/biwl2KOw6tYkamMCXKH2MYBdfEbgcZASBiNmzZq77/eHzhWtVXSGPZLvqIQO5D
        m9yQCTRhmK5c+CPgEtUIs1+Xc4jEbjzXYv3rR0zqa0vz40VyFM9LcHIiv8/HX1xCoaOX/Si5Z8r2V
        vwp3JMQw==;
Received: from home.dogben.com ([2400:8902:e001:30:e221:c60b:10c8:13bd])
        by dogben.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_RC4)
        (envelope-from <wsy@dogben.com>)
        id 1eRLd6-000241-Et; Tue, 19 Dec 2017 17:24:36 +0000
Received: from wsy by home.dogben.com with local (Exim 4.90_RC4)
        (envelope-from <wsy@home.dogben.com>)
        id 1eRLd5-0001O0-4M; Wed, 20 Dec 2017 01:24:35 +0800
From:   Wei Shuyu <wsy@dogben.com>
To:     git@vger.kernel.org
Cc:     Wei Shuyu <wsy@dogben.com>, gitster@pobox.com
Subject: [PATCH] http: support CURLPROXY_HTTPS
Date:   Wed, 20 Dec 2017 01:24:01 +0800
Message-Id: <20171219172401.5263-1-wsy@dogben.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HTTP proxy over SSL is supported by curl since 7.52.0.
This is very useful for networks with protocol whitelist.

Signed-off-by: Wei Shuyu <wsy@dogben.com>
---
 http.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/http.c b/http.c
index 215bebef1..32d33261c 100644
--- a/http.c
+++ b/http.c
@@ -865,6 +865,11 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+#endif
+#if LIBCURL_VERSION_NUM >= 0x073400
+		else if (starts_with(curl_http_proxy, "https"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
 #endif
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
-- 
2.15.1

