Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED911FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 19:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbcLATpo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:45:44 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33235 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760037AbcLATpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:45:34 -0500
Received: by mail-pg0-f42.google.com with SMTP id 3so98259407pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZoLG0OFTz6TVIBv6S+nVE0tDOCzUowbSHW3ukakCEOs=;
        b=Ki6PbeGG1eNdYoy5iSki+dQ2MPtr4utvF3F3KdQhXWAnFB3JMu+z4UcnzzX514p69b
         Zq5UTAwrnFDgACtV9nUP5XtXiah39nKUiFc+9MvXhah2g9kE50RcPECVZ3TAMV0zFehe
         tcDb4tbRhkwLY1NAUMWxkF08+Q73b1iP6EipBlXLwtI4KsTMxSsLR+kzoElfb3xNEtAm
         c1ai5r2z/YDmAZ52IlOoxG5OkIisYpD2R+g6Ye4WVGiIGzw/p1TnqbJfRjEeRhMecPBx
         DxOuYoNH/Dl7M+5x4pLrzZmABOPP54zW+MWe3ML+QhkJVyaM76stamydVj0MPhvdvnJo
         JfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZoLG0OFTz6TVIBv6S+nVE0tDOCzUowbSHW3ukakCEOs=;
        b=WGRf6Z/OvH5iTzLLOMLtkHNLhlBrRptO2nZXJFKOt2Nvr6lQG21ot6NwOeiz9cmBDL
         pCrbxK7T1PxQX8IIfsCPFsbG7lzkBqd2cjd3Dx3HsHpznxLy682K7+2GnNwGMJoZRanA
         IOF4NW8kILWkxbC+fP8ap5xSaatYcydh8vi6NmsKKBEODdhY6jmz9+TTA/lDls2J8hT6
         9NMHDA1K0OWIDsZAbPJaUwqqI0rnEVP0okv0+ai6MErZzJpDHBo14b5DajLN7R+oiZR/
         pClnHbE18YLrN7i1Spj8JScCJipzzEoh4x4mayeYGo27IK+DbgjaExkC72M7qY1WESIh
         kKWg==
X-Gm-Message-State: AKaTC03TStjIBMpzAq64HQ6ckblDc2Tpd/6kgJGWOwSXyF6VjBOPRlBtSTrvJVqt7kOG6Tis
X-Received: by 10.99.124.20 with SMTP id x20mr38042046pgc.142.1480621495978;
        Thu, 01 Dec 2016 11:44:55 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q145sm2090998pfq.22.2016.12.01.11.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:44:53 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v6 4/4] transport: check if protocol can be used on a redirect
Date:   Thu,  1 Dec 2016 11:44:07 -0800
Message-Id: <1480621447-52399-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480621447-52399-1-git-send-email-bmwill@google.com>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1480621447-52399-1-git-send-email-bmwill@google.com>
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
index 186de9a..9fee241 100644
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
+		return git_env_bool("GIT_PROTOCOL_FROM_USER", !redirect);
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
index f4998bc..72971ad 100644
--- a/transport.h
+++ b/transport.h
@@ -153,10 +153,11 @@ extern int transport_summary_width(const struct ref *refs);
 struct transport *transport_get(struct remote *, const char *);
 
 /*
- * Check whether a transport is allowed by the environment. Type should
- * generally be the URL scheme, as described in Documentation/git.txt
+ * Check whether a transport is allowed by the environment. Setting 'redirect'
+ * can be used to querry if the transport can be used in a redirect.  Type
+ * should generally be the URL scheme, as described in Documentation/git.txt
  */
-int is_transport_allowed(const char *type);
+int is_transport_allowed(const char *type, int redirect);
 
 /*
  * Check whether a transport is allowed by the environment,
-- 
2.8.0.rc3.226.g39d4020

