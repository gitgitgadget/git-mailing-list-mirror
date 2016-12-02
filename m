Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9207B1FF6D
	for <e@80x24.org>; Fri,  2 Dec 2016 00:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754357AbcLBABb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:01:31 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34895 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753043AbcLBABW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:01:22 -0500
Received: by mail-pg0-f44.google.com with SMTP id p66so100359429pga.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 16:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZ0hUhuqBVYH1UVFZ46xh/oxkLxeI6Fz7Bu59j70npE=;
        b=apxvcX3SatiwSM231wh7YcJWU+6bZ72wsawGWPruEFIqkn1BmhYpbrVpWLQls+mGvS
         WXexh6krWk1uMqLmK7zO7DJGJ0wi1/QyzckyM93F4ElnggeKcPCKm073pvEUnWIU4Ndi
         4kEiiAIFSq9j524n0wIugBtgrl5dPGuoeIfxISv7Kb5yPuIcYKakU0pm4K6vd2IXTSd9
         9gbQBTIgk2ycwsyPAa6CY/ZVdOqMOYaqLDcxozuYz1/OwJP0LDcGJRDojHjM4sB1hhn3
         ZisDzyV1WqF0Jj+LkH5zncZod5OfwxMzpCAKJ7nANEub3wHBJijKrY16gBTrAawcTcqu
         H3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZ0hUhuqBVYH1UVFZ46xh/oxkLxeI6Fz7Bu59j70npE=;
        b=Msrmh9d7I/pfVbyDudnPf9XRrilY8La93gLDntVy7EyyAtKlQnzR54hyyjuboUlysE
         ZAIldUCU0gN0iY1EO0GdI7U+dcJuHCPYupOT+B0lHvgIyLuTu5Q7hS5XPJKEd61TMwoO
         +hTMjgXWq5XUcBOPbaxNHqJfTxrX5nnZCfTUXD2pdl8xeqF1Z1SLM/qfDbuuO5BcBuTy
         /OJAFrupei8ZzDXK6AatXLfL+01X8ANlL27vzUJj46yq3zPcjQ1O8Ih9VMQ34z3tIF/G
         087IHolXDvJSeOisux32oMjuufVoIx7i9k3CcSYlNiBZRAfy5CG90+UPdGGQTI001UJU
         UaiQ==
X-Gm-Message-State: AKaTC02d8ETpvWRcmrRlOs+JzY/iWG+eGA456gegKhTKYqpTDtmAcQntiH5ZDBMobXhSzWYW
X-Received: by 10.98.198.85 with SMTP id m82mr41727691pfg.69.1480636881026;
        Thu, 01 Dec 2016 16:01:21 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r124sm2692687pgr.6.2016.12.01.16.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 16:01:20 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v8 4/5] http: create function to get curl allowed protocols
Date:   Thu,  1 Dec 2016 16:01:01 -0800
Message-Id: <1480636862-40489-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480636862-40489-1-git-send-email-bmwill@google.com>
References: <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480636862-40489-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the creation of an allowed protocols whitelist to a helper
function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/http.c b/http.c
index fee128b..a1c3a0e 100644
--- a/http.c
+++ b/http.c
@@ -624,11 +624,25 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
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
 
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
-	long allowed_protocols = 0;
 
 	if (!result)
 		die("curl_easy_init failed");
@@ -725,15 +739,8 @@ static CURL *get_curl_handle(void)
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
+	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
+			 get_curl_allowed_protocols());
 #else
 	warning("protocol restrictions not applied to curl redirects because\n"
 		"your curl version is too old (>= 7.19.4)");
-- 
2.8.0.rc3.226.g39d4020

