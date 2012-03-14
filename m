From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Wed, 14 Mar 2012 12:11:43 +0100
Message-ID: <4F607CEF.5010209@seap.minhap.es>
References: <4F5E3298.5030502@seap.minhap.es><7vk42pr3c7.fsf@alter.siamese.dyndns.org> <4F5F41FF.4000204@seap.minhap.es><7vy5r4wfru.fsf@alter.siamese.dyndns.org><20120313220411.GA28357@sigill.intra.peff.net> <7v1uowt83u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 11:14:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7lDc-000214-L3
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 11:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030713Ab2CNKOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 06:14:01 -0400
Received: from luthien1.map.es ([213.9.211.102]:57137 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760447Ab2CNKOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 06:14:00 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id D817824E8A;
	Wed, 14 Mar 2012 11:12:58 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 613DED4251;
	Wed, 14 Mar 2012 11:12:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v1uowt83u.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: D817824E8A.0B557
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332324779.82804@V1JGFYCwETECDYR2vPRYjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193092>

After adding the proxy authentication support in
http, the semantics of HTTP_REAUTH changed more to
a retry rather than a re-authentication, so we
rename it to HTTP_AUTH_RETRY.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
Ok this is a new 5/5 patch that have HTTP_AUTH_RETRY as
Junio suggested, is responding with this patch good or
do I need to send a new re-roll just for this?

thanks, 

 http.c |    6 +++---
 http.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 12dcaa1..7468cdb 100644
--- a/http.c
+++ b/http.c
@@ -837,7 +837,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&http_auth);
 				init_curl_http_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_AUTH_RETRY;
 			}
 		} else if (results.http_code == 407) { /* Proxy authentication failure */
 			if (proxy_auth.username && proxy_auth.password) {
@@ -846,7 +846,7 @@ static int http_request(const char *url, void *result, int target, int options)
 			} else {
 				credential_fill(&proxy_auth);
 				set_proxy_auth(slot->curl);
-				ret = HTTP_REAUTH;
+				ret = HTTP_AUTH_RETRY;
 			}
 		} else {
 			if (!curl_errorstr[0])
@@ -876,7 +876,7 @@ static int http_request_reauth(const char *url, void *result, int target,
 
 	do {
 		ret = http_request(url, result, target, options);
-	} while (ret == HTTP_REAUTH);
+	} while (ret == HTTP_AUTH_RETRY);
 
 	return ret;
 }
diff --git a/http.h b/http.h
index 303eafb..6e3ea59 100644
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
