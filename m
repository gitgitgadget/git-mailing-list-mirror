Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25161FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbcLATsh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:48:37 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32777 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932933AbcLATsg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:48:36 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so47730135pfd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b0sGGpoL3R78bG+hLM4e9V6d3E5r9irTveDnNg8Ypyo=;
        b=P7prWw30Cv2Vy79JsRyQzT+9YvzbQC+/DiyC8v9Y2aVAwtWdemlbu67YLjHNdEYruy
         EOgLrDBGrImlne/qNeALTPD/MfAOlXR6pbXEtT3HRqfGzmap/kC4zyljRTNxN4lNF747
         wDKm4hUrg4q5zrTau0411cFqDfVb2bVYyXerfybleTLjsbCCK+xPBNLEgykuDwzCCdAi
         4jhWM5LwNVdru9liLbMD6Du/2ZUv5ezh0Wo9+Pc1zXuvmQwbx6QscgHJfwXl+iTnpRhH
         z7rF6NqqiHPvnr+XRjkbpBXnKHhi4FPwZgH6Gej3KqcFY+ttzrdhfuwgOefDe/pNoFDp
         gr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b0sGGpoL3R78bG+hLM4e9V6d3E5r9irTveDnNg8Ypyo=;
        b=C8Ghz/ZjJ/lOq04gOtvbkUuwzLFF2Nw63qAvHpkcvAkAzb4JuQ6NaFU2Ii6ur+Fi/+
         LsoqVqpQaPHSo/F5DcqGS5WizX47gJ+gxCKAxzYsNw8SzPR0KcKxsWwjaHB0waUePPvq
         Ryk4BpnC73QBl6BTvfeJ4sGL7xMEg3JI3vpx3weIgu2LDgjn4vwrzFFYU/qS41lqvzxQ
         tkrkuDJlDs2yDYGBLOlvBJJab+XTV+RaJs30CGmjru9phMnPAWGN9mxoSBKDkKjFDLvq
         ywLqYzTYy8xir0MYj0q8Yuyx/meRWh9K6pVDAWsHLvP6ECqDHIIR/qR5im8ccNPAblW7
         pYTw==
X-Gm-Message-State: AKaTC033d4yR2dnPGEvnd1S6fZiwfJ5NAlwk/dhnTXbIuPthDl6RWvyF6JIMXoliUyDbge7j
X-Received: by 10.98.141.153 with SMTP id p25mr40061866pfk.148.1480621715912;
        Thu, 01 Dec 2016 11:48:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id a24sm2035016pfh.57.2016.12.01.11.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:48:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v6 4/4] transport: check if protocol can be used on a redirect
Date:   Thu,  1 Dec 2016 11:48:20 -0800
Message-Id: <1480621700-53222-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480621447-52399-5-git-send-email-bmwill@google.com>
References: <1480621447-52399-5-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a the 'redirect' parameter to 'is_transport_allowed' which allows
callers to query if a transport protocol can be used on a redirect.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c      | 8 ++++----
 transport.c | 6 +++---
 transport.h | 7 ++++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/http.c b/http.c
index fee128b..d31ded8 100644
--- a/http.c
+++ b/http.c
@@ -725,13 +725,13 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_POST301, 1);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x071304
-	if (is_transport_allowed("http"))
+	if (is_transport_allowed("http", 1))
 		allowed_protocols |= CURLPROTO_HTTP;
-	if (is_transport_allowed("https"))
+	if (is_transport_allowed("https", 1))
 		allowed_protocols |= CURLPROTO_HTTPS;
-	if (is_transport_allowed("ftp"))
+	if (is_transport_allowed("ftp", 1))
 		allowed_protocols |= CURLPROTO_FTP;
-	if (is_transport_allowed("ftps"))
+	if (is_transport_allowed("ftps", 1))
 		allowed_protocols |= CURLPROTO_FTPS;
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
 #else
diff --git a/transport.c b/transport.c
index 186de9a..7c4a757 100644
--- a/transport.c
+++ b/transport.c
@@ -723,7 +723,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 	return PROTOCOL_ALLOW_USER_ONLY;
 }
 
-int is_transport_allowed(const char *type)
+int is_transport_allowed(const char *type, int redirect)
 {
 	const struct string_list *whitelist = protocol_whitelist();
 	if (whitelist)
@@ -735,7 +735,7 @@ int is_transport_allowed(const char *type)
 	case PROTOCOL_ALLOW_NEVER:
 		return 0;
 	case PROTOCOL_ALLOW_USER_ONLY:
-		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+		return redirect ? 0 : git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
 	}
 
 	die("BUG: invalid protocol_allow_config type");
@@ -743,7 +743,7 @@ int is_transport_allowed(const char *type)
 
 void transport_check_allowed(const char *type)
 {
-	if (!is_transport_allowed(type))
+	if (!is_transport_allowed(type, 0))
 		die("transport '%s' not allowed", type);
 }
 
diff --git a/transport.h b/transport.h
index f4998bc..4bcf5d3 100644
--- a/transport.h
+++ b/transport.h
@@ -153,10 +153,11 @@ extern int transport_summary_width(const struct ref *refs);
 struct transport *transport_get(struct remote *, const char *);
 
 /*
- * Check whether a transport is allowed by the environment. Type should
- * generally be the URL scheme, as described in Documentation/git.txt
+ * Check whether a transport is allowed by the environment. Setting 'redirect'
+ * can be used to query if the transport can be used in a redirect.  Type
+ * should generally be the URL scheme, as described in Documentation/git.txt
  */
-int is_transport_allowed(const char *type);
+int is_transport_allowed(const char *type, int redirect);
 
 /*
  * Check whether a transport is allowed by the environment,
-- 
2.8.0.rc3.226.g39d4020

