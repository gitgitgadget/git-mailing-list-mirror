Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D21320451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754490AbcLNBup (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:50:45 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36768 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbcLNBuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:50:44 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so2054811pgc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ItXHMObQuG9RbUoi+C0con6P53et35iZOWTGeQ/CFY=;
        b=ZBMVjZb59JW9EwbKFrBi9LeT9+blmm2bgu25D3CoRq+FLr7IOnGA25lSnTmu9Dsodt
         dqhm7zQ4sd23/vNgW09yaFEn9j3d5LRm6TvQWTFdk0lXWnXyZZIpagnGu6kxf1xc0xKz
         CR7Qm9CgSHCDlLnJvQds5r+NDe7hEFNCvT2ZfV+LNyBY/9eT2pQ29lqdA36neFysGxZB
         hDx2FCcF/2a8k7ygzWGk4FU7cWMO7HosascXChHOCqce2MM5ocSzy3YK0/F7gHXyfdQj
         YW7uW/H3fU3dR/sMmICrz5kmdOLhlWhoGidEL4RuvP+h3FRK+B1k30lWn8JfleZoYiaj
         0E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ItXHMObQuG9RbUoi+C0con6P53et35iZOWTGeQ/CFY=;
        b=rBY8RpJTzOdpIyMASCj/nfVkq9MOBZn/FrNpCKSnL4KHEPe7duPVMcnf0Are3o9ZrS
         UUXtpNuTUFvUE4QCQU+PplsyKyRMb4d9cGiR51yDy+jJRQPJAEjU6UtXeikXVPB0RBhM
         ISJxPVjGVNyTxcb9tn3nIekVkGSPHdWm7d27u9cwC7CpRcXJPqTlYPZ97hEKqevblW2T
         ad9URH1kURpnOvvDgbq6afLXwHt0wappvfRXlF7ZaegL/pVyhoZm3qgyi+jcYLbnFnof
         zkGb1Ty9KAymYAzREthA15d9XB9b02dtpgWaLiSksb0S/SFHRg8SjY5zkvVqdGEMJcdL
         81bA==
X-Gm-Message-State: AKaTC00X6cydI5BIazyP7hJqE7AmsIT9RwRMHCgd15QFc/J028V538w3lPi9E7us00i8OQy0
X-Received: by 10.84.210.130 with SMTP id a2mr203606952pli.106.1481679705569;
        Tue, 13 Dec 2016 17:41:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id b12sm82462599pfb.78.2016.12.13.17.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 17:41:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCH v9 4/5] http: create function to get curl allowed protocols
Date:   Tue, 13 Dec 2016 17:40:36 -0800
Message-Id: <1481679637-133137-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481679637-133137-1-git-send-email-bmwill@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the creation of an allowed protocols whitelist to a helper
function.

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

