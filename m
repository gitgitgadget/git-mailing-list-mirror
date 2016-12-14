Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8A71FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934725AbcLNWke (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:34 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34104 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935044AbcLNWkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:20 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so12523031pgx.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5rPM6Mbmrsg5qTSd6mq2UJBlIbZjYXwjdmNSwgjc90=;
        b=ZkNPIH+th0yFU+IcATn/QmiwH/v79bUi8Pqh+l7CVCNmMK308Lo96ZEq9Sim+qYOBe
         gNJ/lbcV3FdWdplVfnrkwgySSe2D+SHlg6GqlF8RSjS6iBW/yGQw2cfZRpGwyEtuynbS
         T16F6PG4qrYJkmtVGIB9HrUtZatiQqm7SCVJPV3mE87pVen+11J1ojOksgjdvHF69Q2Y
         R2jaOr4j9SP21L7H64z1BgAEANt5UkqjOf5MoweGM47ImhLatAtm9/vpRicFNEhjkehh
         ag07Ywf2Aypu7ZYOPY0jVPYbDmu1n1u7Dq7hwxRrThM+nFo9muzkC/dNoscECqNXfrL2
         6wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5rPM6Mbmrsg5qTSd6mq2UJBlIbZjYXwjdmNSwgjc90=;
        b=RGKDWQ3m3Nz9YzkigH+a0tUoo7E3em3VZif8ThzVc/10nvmdOPasc2IKLMBZcGrkT+
         lAjCKARb6CSM8dGJbWXiNn3ycoktm07QFoR4MIPUYN05lcVK8IXz8GyxG/p90BPcl03w
         b19qOogrGHcWU8k1d0qNiwfOuZKsNH60qzkpIyGGqeqlVtpV2iB/1lz8LDgWK55g5sGv
         WVidO5HheBTvT62jdw/nYmKIowz28eQ6mS/Fv2e7BWAFgz7Vr6mqKzUP63Qo6NKKR6la
         pWGdSHkyHBEikNku8GXrXOJFgFHgZoUisb9+8jGVm+g/WmdfRf1CjJOOtC5wdnSc9nX7
         eunQ==
X-Gm-Message-State: AKaTC02U5jtBu9TSMl8gT4nScrMOiC2WaJGI0lTm78EvX6g7CLQAKGQw2sP0k/oHOawA8maE
X-Received: by 10.84.206.37 with SMTP id f34mr213385429ple.127.1481755219864;
        Wed, 14 Dec 2016 14:40:19 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:18 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH v10 4/6] http: create function to get curl allowed protocols
Date:   Wed, 14 Dec 2016 14:39:53 -0800
Message-Id: <1481755195-174539-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the creation of an allowed protocols whitelist to a helper
function. This will be useful when we need to compute the set of
allowed protocols differently for normal and redirect cases.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/http.c b/http.c
index 034426e..f7c488a 100644
--- a/http.c
+++ b/http.c
@@ -489,10 +489,25 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
+static long get_curl_allowed_protocols(void)
+{
+	long allowed_protocols = 0;
+
+	if (is_transport_allowed("http"))
+		allowed_protocols |= CURLPROTO_HTTP;
+	if (is_transport_allowed("https"))
+		allowed_protocols |= CURLPROTO_HTTPS;
+	if (is_transport_allowed("ftp"))
+		allowed_protocols |= CURLPROTO_FTP;
+	if (is_transport_allowed("ftps"))
+		allowed_protocols |= CURLPROTO_FTPS;
+
+	return allowed_protocols;
+}
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
-	long allowed_protocols = 0;
 
 	if (!result)
 		die("curl_easy_init failed");
@@ -572,16 +587,10 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_POST301, 1);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x071304
-	if (is_transport_allowed("http"))
-		allowed_protocols |= CURLPROTO_HTTP;
-	if (is_transport_allowed("https"))
-		allowed_protocols |= CURLPROTO_HTTPS;
-	if (is_transport_allowed("ftp"))
-		allowed_protocols |= CURLPROTO_FTP;
-	if (is_transport_allowed("ftps"))
-		allowed_protocols |= CURLPROTO_FTPS;
-	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
-	curl_easy_setopt(result, CURLOPT_PROTOCOLS, allowed_protocols);
+	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
+			 get_curl_allowed_protocols());
+	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
+			 get_curl_allowed_protocols());
 #else
 	warning("protocol restrictions not applied to curl redirects because\n"
 		"your curl version is too old (>= 7.19.4)");
-- 
2.8.0.rc3.226.g39d4020

