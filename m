From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 3/3] http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
Date: Fri, 11 May 2012 15:14:08 +0200
Message-ID: <4FAD10A0.6040306@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSona-0002mO-8v
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993Ab2EKMSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:18:13 -0400
Received: from luthien1.map.es ([213.9.211.102]:55944 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756552Ab2EKMSL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:18:11 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 47CDF377E2;
	Fri, 11 May 2012 14:16:58 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id B0DE5203CFC;
	Fri, 11 May 2012 14:16:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 47CDF377E2.EC65F
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1337343418.4536@YRLU5f8Cj/saLxedt8geCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197669>

The semantics of HTTP_REAUTH have been always more
of a retry rather than a re-authentication, so we
rename it to HTTP_AUTH_RETRY to make it more clear.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |    6 +++---
 http.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index d34d741..0023119 100644
--- a/http.c
+++ b/http.c
@@ -817,7 +817,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&http_auth);
 				init_curl_http_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_AUTH_RETRY;
 			}
 		} else if (results.http_code == 407) { /* Proxy authentication failure */
 			if (proxy_auth.username && proxy_auth.password) {
@@ -826,7 +826,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&proxy_auth);
 				set_proxy_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_AUTH_RETRY;
 			}
 		} else {
 			if (!curl_errorstr[0])
@@ -856,7 +856,7 @@ static int http_request_reauth(const char *url, void *result, int target,
 
 	do {
 		ret = http_request(url, result, target, options);
-	} while (ret == HTTP_REAUTH);
+	} while (ret == HTTP_AUTH_RETRY);
 
 	return ret;
 }
diff --git a/http.h b/http.h
index 915c286..629bbcf 100644
--- a/http.h
+++ b/http.h
@@ -123,7 +123,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 #define HTTP_MISSING_TARGET	1
 #define HTTP_ERROR		2
 #define HTTP_START_FAILED	3
-#define HTTP_REAUTH	4
+#define HTTP_AUTH_RETRY	4
 #define HTTP_NOAUTH	5
 
 /*
-- 
1.7.7.6
