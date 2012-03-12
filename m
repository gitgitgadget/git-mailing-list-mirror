From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Mon, 12 Mar 2012 18:30:00 +0100
Message-ID: <4F5E3298.5030502@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 17:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S789v-0000HV-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab2CLQbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:31:40 -0400
Received: from luthien1.map.es ([213.9.211.102]:3377 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab2CLQbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:31:39 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 164C425351;
	Mon, 12 Mar 2012 17:31:15 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 754602C2EB;
	Mon, 12 Mar 2012 17:31:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 164C425351.05B66
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332174675.37116@wAGYb5NO/zZSJjK/Q/vjIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192900>

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
index 9b98179..4aa5a46 100644
--- a/http.c
+++ b/http.c
@@ -823,7 +823,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&http_auth);
 				init_curl_http_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_RETRY;
 			}
 		} else if (results.http_code == 407) { /* Proxy authentication failure */
 			if (proxy_auth.username && proxy_auth.password) {
@@ -832,7 +832,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&proxy_auth);
 				set_proxy_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_RETRY;
 			}
 		} else {
 			if (!curl_errorstr[0])
@@ -862,7 +862,7 @@ static int http_request_reauth(const char *url, void *result, int target,
 
 	do {
 		ret = http_request(url, result, target, options);
-	} while (ret == HTTP_REAUTH);
+	} while (ret == HTTP_RETRY);
 
 	return ret;
 }
diff --git a/http.h b/http.h
index 0b61653..6499397 100644
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
