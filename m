Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081E81FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757656AbcLAU0g (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:36 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36026 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934261AbcLAU0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:32 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so98196265pgc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+C+AZtUKBsMwNW8aFn+2biL3TZGIiV3WTqzvO7VM7y4=;
        b=HLxt2oQsDOQB2jYlPwHz/uTin9VgjYEISruGDYZDeVyFAfIun7iWzFWFKYFZo2A/HH
         mzLoShfW6ry4IAwdMTLPuvUiQ23gtm1iKiWMDjkZvCY7Nw2SdA9L5yxhe/O8bcsV/NHv
         hMs/b1K7tSs7po1aGbUwid0ZHyAP81YFVdKrGJx/rfEFcWYx2z+XptM9fi9EXcLWIgtu
         Ofiec2mpFiQX8ks2obeUI/2Lbk6K6vYsFT5ZlRKiRgz8P3mZyXXT0rLfta8jhNCFu5gL
         rqrbvFw2iyo/nGxPRXVxt0Qd2jhkEIDjA5Uuo4KwhOuFXhADEn9ZhS+q1toMur3UQ2dH
         XCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+C+AZtUKBsMwNW8aFn+2biL3TZGIiV3WTqzvO7VM7y4=;
        b=GKqzMKWksomFWywSDcrL+vtqizAsVcPp40zIRpBThGfUJ24a2hy3gA8AFVz8V0gpwK
         eAKgJgDsvH1lQDRuhOa8MWHd/+SvpjZhec6zq9w/bhezEmOzbx8dlcwZJoIcADKsWR9m
         n+Qze13A5lNM8XtgUqA6G+2HCrjdzTBtZoIXrzRqFR82gA1Y2QcT9ozR0fn0KoRqzcXo
         0PDO4y1Ojhu00lXiBay03J5DIscbX5PlKe/YLWqon2U91gnE7sR3FgNq5LKoRdO5lo7l
         AMfnYRLx/PUzFnW4hhWTrM1KeS7m4AIbqJ1zw9bpmssQYkHzFHYGw5gtBbPt5cXom+Z2
         fQVA==
X-Gm-Message-State: AKaTC0208bKM8SLnkStNN3cshbVG8AlEyrUubWPEinnjq2HMx87OUZzD/pE3WSyP+SUd2GVF
X-Received: by 10.99.94.194 with SMTP id s185mr72107846pgb.35.1480623991530;
        Thu, 01 Dec 2016 12:26:31 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 16sm2230074pfy.4.2016.12.01.12.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:30 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v7 4/4] transport: add from_user parameter to is_transport_allowed
Date:   Thu,  1 Dec 2016 12:25:59 -0800
Message-Id: <1480623959-126129-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480623959-126129-1-git-send-email-bmwill@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the from_user parameter to the 'is_transport_allowed' function.
This allows callers to query if a transport protocol is allowed, given
that the caller knows that the protocol is coming from the user (1) or
not from the user (0), such as redirects in libcurl.  If unknown, a -1
should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
to determine if the protocol came from the user.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c      |  8 ++++----
 transport.c |  8 +++++---
 transport.h | 13 ++++++++++---
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/http.c b/http.c
index fee128b..e74c0f0 100644
--- a/http.c
+++ b/http.c
@@ -725,13 +725,13 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_POST301, 1);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x071304
-	if (is_transport_allowed("http"))
+	if (is_transport_allowed("http", 0))
 		allowed_protocols |= CURLPROTO_HTTP;
-	if (is_transport_allowed("https"))
+	if (is_transport_allowed("https", 0))
 		allowed_protocols |= CURLPROTO_HTTPS;
-	if (is_transport_allowed("ftp"))
+	if (is_transport_allowed("ftp", 0))
 		allowed_protocols |= CURLPROTO_FTP;
-	if (is_transport_allowed("ftps"))
+	if (is_transport_allowed("ftps", 0))
 		allowed_protocols |= CURLPROTO_FTPS;
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
 #else
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

