From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v5 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Tue, 13 Mar 2012 15:06:29 +0100
Message-ID: <4F5F5465.2080206@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 14:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7RVa-0006wC-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab2CMNLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:11:18 -0400
Received: from luthien1.mpt.es ([82.150.0.102]:20872 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab2CMNLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:11:17 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 4BF76B71C7;
	Tue, 13 Mar 2012 14:07:42 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id A97CA2C2F5;
	Tue, 13 Mar 2012 14:07:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 4BF76B71C7.1F9A6
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332248869.14534@gtdzANGqf9oS3qURQ4TUHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193022>

After adding the proxy authentication support in
http, the semantics of HTTP_REAUTH changed more to
a retry rather than a re-authentication, so we
rename it to HTTP_RETRY.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    6 +++---
 http.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 12dcaa1..bc470e8 100644
--- a/http.c
+++ b/http.c
@@ -837,7 +837,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&http_auth);
 				init_curl_http_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_RETRY;
 			}
 		} else if (results.http_code == 407) { /* Proxy authentication failure */
 			if (proxy_auth.username && proxy_auth.password) {
@@ -846,7 +846,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&proxy_auth);
 				set_proxy_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_RETRY;
 			}
 		} else {
 			if (!curl_errorstr[0])
@@ -876,7 +876,7 @@ static int http_request_reauth(const char *url, void *result, int target,
 
 	do {
 		ret = http_request(url, result, target, options);
-	} while (ret == HTTP_REAUTH);
+	} while (ret == HTTP_RETRY);
 
 	return ret;
 }
diff --git a/http.h b/http.h
index 303eafb..3936f7f 100644
--- a/http.h
+++ b/http.h
@@ -123,7 +123,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 #define HTTP_MISSING_TARGET	1
 #define HTTP_ERROR		2
 #define HTTP_START_FAILED	3
-#define HTTP_REAUTH	4
+#define HTTP_RETRY	4
 #define HTTP_NOAUTH	5
 
 /*
-- 
1.7.7.6
