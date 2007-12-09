From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/4] Cleanup variables in http.[ch]
Date: Sun,  9 Dec 2007 18:04:57 +0100
Message-ID: <1197219900-19334-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 18:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1PbD-0008I0-Jo
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 18:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbXLIRFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 12:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbXLIRFL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 12:05:11 -0500
Received: from smtp23.orange.fr ([193.252.22.126]:12729 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbXLIRFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 12:05:04 -0500
X-Greylist: delayed 155914 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2007 12:05:03 EST
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2319.orange.fr (SMTP Server) with ESMTP id 9306B700009A
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 18:05:01 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2319.orange.fr (SMTP Server) with ESMTP id 53B9C7000098;
	Sun,  9 Dec 2007 18:05:01 +0100 (CET)
X-ME-UUID: 20071209170501343.53B9C7000098@mwinf2319.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1PaO-000529-VF; Sun, 09 Dec 2007 18:05:00 +0100
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: 20071209170250.GA18955@glandium.org
References: 20071209170250.GA18955@glandium.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67630>

Quite some variables defined as extern in http.h are only used in http.c,
and some others, only defined in http.c, were not static. Cleanup that.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c |   28 ++++++++++++++--------------
 http.h |   18 ------------------
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/http.c b/http.c
index e4aa9c1..146f626 100644
--- a/http.c
+++ b/http.c
@@ -4,31 +4,31 @@ int data_received;
 int active_requests = 0;
 
 #ifdef USE_CURL_MULTI
-int max_requests = -1;
-CURLM *curlm;
+static int max_requests = -1;
+static CURLM *curlm;
 #endif
 #ifndef NO_CURL_EASY_DUPHANDLE
-CURL *curl_default;
+static CURL *curl_default;
 #endif
 char curl_errorstr[CURL_ERROR_SIZE];
 
-int curl_ssl_verify = -1;
-char *ssl_cert = NULL;
+static int curl_ssl_verify = -1;
+static char *ssl_cert = NULL;
 #if LIBCURL_VERSION_NUM >= 0x070902
-char *ssl_key = NULL;
+static char *ssl_key = NULL;
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-char *ssl_capath = NULL;
+static char *ssl_capath = NULL;
 #endif
-char *ssl_cainfo = NULL;
-long curl_low_speed_limit = -1;
-long curl_low_speed_time = -1;
-int curl_ftp_no_epsv = 0;
-char *curl_http_proxy = NULL;
+static char *ssl_cainfo = NULL;
+static long curl_low_speed_limit = -1;
+static long curl_low_speed_time = -1;
+static int curl_ftp_no_epsv = 0;
+static char *curl_http_proxy = NULL;
 
-struct curl_slist *pragma_header;
+static struct curl_slist *pragma_header;
 
-struct active_request_slot *active_queue_head = NULL;
+static struct active_request_slot *active_queue_head = NULL;
 
 size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
 			   struct buffer *buffer)
diff --git a/http.h b/http.h
index 72abac2..fe1b0d1 100644
--- a/http.h
+++ b/http.h
@@ -80,24 +80,6 @@ extern void http_cleanup(void);
 extern int data_received;
 extern int active_requests;
 
-#ifndef NO_CURL_EASY_DUPHANDLE
-extern CURL *curl_default;
-#endif
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
-extern int curl_ssl_verify;
-extern char *ssl_cert;
-#if LIBCURL_VERSION_NUM >= 0x070902
-extern char *ssl_key;
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-extern char *ssl_capath;
-#endif
-extern char *ssl_cainfo;
-extern long curl_low_speed_limit;
-extern long curl_low_speed_time;
-
-extern struct curl_slist *pragma_header;
-extern struct curl_slist *no_range_header;
-
 #endif /* HTTP_H */
-- 
1.5.3.7
