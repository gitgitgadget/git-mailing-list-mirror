Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE3F1FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbcLBABZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:01:25 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33446 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbcLBABX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:01:23 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so100376633pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24bdLuCIH6HVyX8IR+M8KBPOTv3i3zdHE2Cw8g9UmU0=;
        b=eXL6989DH2icjPXFSeIqotB60rlew4udXKzTLXdK9cCDSj57weLjv+oxzO5v0LjAq3
         zDuau4wHuUdP5ypuDIqBdGESGmpv8Gomrduq4Cx3Pqxf8V/5Ews+uUhbXwyTww6c0cgH
         2+3by0CE7VXVx8DrULqxN5Yqsife4aR2APwCTR6++iN3EWldrVwnhO0Eaa1hqvX9hEl+
         0WKRSL+w48WLMkqfE9Bow2Cg+X1tk6vYMiAHqjbOSdupHzNzTDPVwe+bAvSZ/fbMBlh6
         eC2mW5oDAqjD/b5yYFW8Iii//yma58+VDIgJWhR2ggMeEelCLgEQP5RfEE/TbFM4b121
         +xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24bdLuCIH6HVyX8IR+M8KBPOTv3i3zdHE2Cw8g9UmU0=;
        b=M8K53yE/nr3dyRmI0OfazZG50ANhWu24jYW9W7Kwb3sJUUa9KSsmvnV3+NSPR11ers
         3Y0QnfHiU1XwzmbSyy2GcuKxuGmKoCX1XHXiPqOH6im7XsjRKnL/SOVOUN7Ifd8QCshv
         dctJYA561e7j25ACVqgl4BHdsGTW5fc12SR3WNmI7jn+f/qTqU6gBCFR8LMdbQ27rwg/
         sac/5vktsdJxAMAgojiDnhDP2PfvoelnzKAxP1IWlIHV1vcEh+vWI1yj4fRWiEJJlD8l
         M9xBIUPC4BPQRVjNh7d2bXCtk9lcxk/KMuX/kMdrzg8VMcHrGTfMdy3q0SNQaxFHzQFK
         BV5g==
X-Gm-Message-State: AKaTC02myG5FBdTEHrPnpaOAgM7X0iw/p7tAm2AsM6rkWscZiCpC8nGP/NvW03FnZp3e/buh
X-Received: by 10.98.20.131 with SMTP id 125mr41694633pfu.51.1480636882587;
        Thu, 01 Dec 2016 16:01:22 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r124sm2692687pgr.6.2016.12.01.16.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 16:01:21 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v8 5/5] transport: add from_user parameter to is_transport_allowed
Date:   Thu,  1 Dec 2016 16:01:02 -0800
Message-Id: <1480636862-40489-6-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480636862-40489-1-git-send-email-bmwill@google.com>
References: <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480636862-40489-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the from_user parameter to the 'is_transport_allowed' function.
This allows callers to query if a transport protocol is allowed, given
that the caller knows that the protocol is coming from the user (1) or
not from the user (0) such as redirects in libcurl.  If unknown a -1
should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
to determine if the protocol came from the user.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c      | 12 ++++++------
 transport.c |  8 +++++---
 transport.h | 13 ++++++++++---
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/http.c b/http.c
index a1c3a0e..2a02941 100644
--- a/http.c
+++ b/http.c
@@ -624,17 +624,17 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
-static long get_curl_allowed_protocols(void)
+static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
 
-	if (is_transport_allowed("http"))
+	if (is_transport_allowed("http", from_user))
 		allowed_protocols |= CURLPROTO_HTTP;
-	if (is_transport_allowed("https"))
+	if (is_transport_allowed("https", from_user))
 		allowed_protocols |= CURLPROTO_HTTPS;
-	if (is_transport_allowed("ftp"))
+	if (is_transport_allowed("ftp", from_user))
 		allowed_protocols |= CURLPROTO_FTP;
-	if (is_transport_allowed("ftps"))
+	if (is_transport_allowed("ftps", from_user))
 		allowed_protocols |= CURLPROTO_FTPS;
 
 	return allowed_protocols;
@@ -740,7 +740,7 @@ static CURL *get_curl_handle(void)
 #endif
 #if LIBCURL_VERSION_NUM >= 0x071304
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
-			 get_curl_allowed_protocols());
+			 get_curl_allowed_protocols(0));
 #else
 	warning("protocol restrictions not applied to curl redirects because\n"
 		"your curl version is too old (>= 7.19.4)");
diff --git a/transport.c b/transport.c
index 186de9a..8a3597b 100644
--- a/transport.c
+++ b/transport.c
@@ -723,7 +723,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 	return PROTOCOL_ALLOW_USER_ONLY;
 }
 
-int is_transport_allowed(const char *type)
+int is_transport_allowed(const char *type, int from_user)
 {
 	const struct string_list *whitelist = protocol_whitelist();
 	if (whitelist)
@@ -735,7 +735,9 @@ int is_transport_allowed(const char *type)
 	case PROTOCOL_ALLOW_NEVER:
 		return 0;
 	case PROTOCOL_ALLOW_USER_ONLY:
-		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+		if (from_user < 0)
+			from_user = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+		return from_user;
 	}
 
 	die("BUG: invalid protocol_allow_config type");
@@ -743,7 +745,7 @@ int is_transport_allowed(const char *type)
 
 void transport_check_allowed(const char *type)
 {
-	if (!is_transport_allowed(type))
+	if (!is_transport_allowed(type, -1))
 		die("transport '%s' not allowed", type);
 }
 
diff --git a/transport.h b/transport.h
index f4998bc..9820f10 100644
--- a/transport.h
+++ b/transport.h
@@ -153,10 +153,17 @@ extern int transport_summary_width(const struct ref *refs);
 struct transport *transport_get(struct remote *, const char *);
 
 /*
- * Check whether a transport is allowed by the environment. Type should
- * generally be the URL scheme, as described in Documentation/git.txt
+ * Check whether a transport is allowed by the environment.
+ *
+ * Type should generally be the URL scheme, as described in
+ * Documentation/git.txt
+ *
+ * from_user specifies if the transport was given by the user.  If unknown pass
+ * a -1 to read from the environment to determine if the transport was given by
+ * the user.
+ *
  */
-int is_transport_allowed(const char *type);
+int is_transport_allowed(const char *type, int from_user);
 
 /*
  * Check whether a transport is allowed by the environment,
-- 
2.8.0.rc3.226.g39d4020

