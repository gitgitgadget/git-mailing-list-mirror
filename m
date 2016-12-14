Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6F320451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbcLNBvd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:51:33 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34809 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcLNBvc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:51:32 -0500
Received: by mail-pf0-f182.google.com with SMTP id c4so936356pfb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=taNAVY5OD05njCNqNxk6Fb29OSjFtBg/U7Sydh3bAw0=;
        b=L1KYLndtPWXuwtdPJHFS1KBDYvvYFIutDVG2tTOCQLMP/DNU50y1bCZWN01hWQrzB5
         2BqL204OaqvtjdwpWqYMNfflGzu3Clhd+HM/mXQ8I4ft4gVQqLA4EckIHShoXqoozQ/O
         LftsfHfgD+anImL5kGG0h+nTqfAjxv/arc95MYvY683JAU+zTMXkNRPDR8DeaK6evg8v
         B2E9MGMsM/C6jcRu+KYLrWhLBqoKL3W47Z4gJLRtiTYTpBvxaSzVWpXOFJrF0R5Faywx
         putQvhIhI6ThxpANDtdl0qdyUktirFz+hopMp0C4nWRiX1IC6yxrdNIybNQkhtOJmcka
         wOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=taNAVY5OD05njCNqNxk6Fb29OSjFtBg/U7Sydh3bAw0=;
        b=YDb5eyxzSkL0hOJZ0fySZSjLMDScZjWyWrTd1VxC1BUFAlMDO6usJAbfskZOu19/7j
         7PFNs/8Ts7UG0rCbj+nzZFAeQbxPT0kUOMqQUG71VwAZQFQCMFlVDZbNZR45cRZj6Ts0
         dWdxdAcNUbwlHYh/V4UwAzVTKS1QVXQbLX1LnKPKj53YB6eYym2HSMwSzaDohfjBArkG
         +Z/RUCoFc3FP659awh3/TYhxif/qB3smyK9CqOqo/znUplCTWmGlhPaByioSEzkP7xg3
         BrQmEgS15cxSFkYS3o5MN7aDjb02RAAYf7G1t/jfdBocbbw3uCv3HYkWxd0MhR0YsEQ3
         cKUA==
X-Gm-Message-State: AKaTC00mobePB1oXFXnByJKhUJWgb1pFRxbBAgAHxW9NWm7e4qti1J6DETfFztmDubwH+kUX
X-Received: by 10.99.208.21 with SMTP id z21mr181476378pgf.79.1481679707101;
        Tue, 13 Dec 2016 17:41:47 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id b12sm82462599pfb.78.2016.12.13.17.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 17:41:46 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCH v9 5/5] transport: add from_user parameter to is_transport_allowed
Date:   Tue, 13 Dec 2016 17:40:37 -0800
Message-Id: <1481679637-133137-6-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481679637-133137-1-git-send-email-bmwill@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
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
 http.c      | 14 +++++++-------
 transport.c |  8 +++++---
 transport.h | 13 ++++++++++---
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/http.c b/http.c
index f7c488a..2208269 100644
--- a/http.c
+++ b/http.c
@@ -489,17 +489,17 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
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
@@ -588,9 +588,9 @@ static CURL *get_curl_handle(void)
 #endif
 #if LIBCURL_VERSION_NUM >= 0x071304
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
-			 get_curl_allowed_protocols());
+			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
-			 get_curl_allowed_protocols());
+			 get_curl_allowed_protocols(-1));
 #else
 	warning("protocol restrictions not applied to curl redirects because\n"
 		"your curl version is too old (>= 7.19.4)");
diff --git a/transport.c b/transport.c
index fbd799d..f50c31a 100644
--- a/transport.c
+++ b/transport.c
@@ -676,7 +676,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 	return PROTOCOL_ALLOW_USER_ONLY;
 }
 
-int is_transport_allowed(const char *type)
+int is_transport_allowed(const char *type, int from_user)
 {
 	const struct string_list *whitelist = protocol_whitelist();
 	if (whitelist)
@@ -688,7 +688,9 @@ int is_transport_allowed(const char *type)
 	case PROTOCOL_ALLOW_NEVER:
 		return 0;
 	case PROTOCOL_ALLOW_USER_ONLY:
-		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+		if (from_user < 0)
+			from_user = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+		return from_user;
 	}
 
 	die("BUG: invalid protocol_allow_config type");
@@ -696,7 +698,7 @@ int is_transport_allowed(const char *type)
 
 void transport_check_allowed(const char *type)
 {
-	if (!is_transport_allowed(type))
+	if (!is_transport_allowed(type, -1))
 		die("transport '%s' not allowed", type);
 }
 
diff --git a/transport.h b/transport.h
index 3396e1d..4f1c801 100644
--- a/transport.h
+++ b/transport.h
@@ -142,10 +142,17 @@ struct transport {
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

