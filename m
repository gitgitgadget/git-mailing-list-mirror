Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D971FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935052AbcLNWk0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:26 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35172 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbcLNWkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:22 -0500
Received: by mail-pg0-f47.google.com with SMTP id p66so12498484pga.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXXN1VYNJlUcW2nGvU2Kbj8Q2D0VbeF3i+rmEq0TERY=;
        b=XguXyapQDASMOu8AtPdv1o62/FC2FueQ8CPfgRNgkM6nKGGg9CHppj740Dz4MW7xhq
         P2t7qx25MidE2sKOrYqDBXJL/TCseeF37ZBTVG+PZcc6L0j52gs3Zi6vUOMrv1lKMkIy
         uQP+FTqFLiKpOVEOM5h1LHA/8KxnWwyaOB3tf1KYJcBzFc9VVyKNINAersLYwCAntasE
         nZYkjMJ8sMK2LBDiyoDYUH2eFcz8fLDleGzE25qpIawJjF+KmzVuxgJ/VFNmaNUfEVhJ
         ZMi3MbmSJojsin4tMrVG5MqcY/frF5G1aFNKUFG3wsMdpmb2Y9KwBUmNVd8LVnO7cUCo
         T2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXXN1VYNJlUcW2nGvU2Kbj8Q2D0VbeF3i+rmEq0TERY=;
        b=dT5bil0aWnYlAMftzzGOPtcTAJRCTaO+643A38cIouAJpOk1gc07lJ4WI9JRVrQ8Ea
         y6rUwDi6Ei5FlYuucDVmNDtbzaTlY+ew3U4w0Fe4KGavyXNlPiaT9jV+j6BUcmlAf/UG
         Zm3Zjtk/BwcgbrVbCC6J8OfU1ra8Qpz6uNwqoc5kooeD5fCt8uTP7cUXeeg9YPLirHbX
         Px45IceQR1yvqVee6x+RrfW+22A3J5X9zR8LeFDNxNir4tpSPrXgtSi5qpIxiIh7tcP0
         lrc3LMGYJIt4v8KGsAe/rCXIBTzdnxTtmHM41VQTf4xrDKrHQut5q9xRBh0ccqi2HMsC
         5Anw==
X-Gm-Message-State: AKaTC03aOoFhYVytE1PJv3gPhHCaDXemrGbUSIREylbX2Y/LDb9g/43yAGYuAqpNPGyLzgrq
X-Received: by 10.84.169.36 with SMTP id g33mr215601341plb.174.1481755221661;
        Wed, 14 Dec 2016 14:40:21 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:20 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH v10 5/6] transport: add from_user parameter to is_transport_allowed
Date:   Wed, 14 Dec 2016 14:39:54 -0800
Message-Id: <1481755195-174539-6-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a from_user parameter to is_transport_allowed() to allow http to be
able to distinguish between protocol restrictions for redirects versus
initial requests.  CURLOPT_REDIR_PROTOCOLS can now be set differently
from CURLOPT_PROTOCOLS to disallow use of protocols with the "user"
policy in redirects.

This change allows callers to query if a transport protocol is allowed,
given that the caller knows that the protocol is coming from the user
(1) or not from the user (0) such as redirects in libcurl.  If unknown a
-1 should be provided which falls back to reading
`GIT_PROTOCOL_FROM_USER` to determine if the protocol came from the
user.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c                        | 14 +++++++-------
 t/t5812-proto-disable-http.sh |  7 +++++++
 transport.c                   |  8 +++++---
 transport.h                   | 13 ++++++++++---
 4 files changed, 29 insertions(+), 13 deletions(-)

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
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 044cc15..d911afd 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -30,5 +30,12 @@ test_expect_success 'curl limits redirects' '
 	test_must_fail git clone "$HTTPD_URL/loop-redir/smart/repo.git"
 '
 
+test_expect_success 'http can be limited to from-user' '
+	git -c protocol.http.allow=user \
+		clone "$HTTPD_URL/smart/repo.git" plain.git &&
+	test_must_fail git -c protocol.http.allow=user \
+		clone "$HTTPD_URL/smart-redir-perm/repo.git" redir.git
+'
+
 stop_httpd
 test_done
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

