From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] http.c: fix various style violations
Date: Sun,  1 Feb 2009 22:31:13 -0800
Message-ID: <1233556274-1354-3-git-send-email-gitster@pobox.com>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com>
 <1233556274-1354-2-git-send-email-gitster@pobox.com>
Cc: Moriyoshi Koizumi <mozo@mozo.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 07:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTsMk-0005wS-E1
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 07:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZBBGb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 01:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbZBBGb2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 01:31:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZBBGb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 01:31:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 93A0994EA6;
	Mon,  2 Feb 2009 01:31:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7B48994EA5; Mon,
  2 Feb 2009 01:31:24 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.333.ged98f
In-Reply-To: <1233556274-1354-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1E3BA1E6-F0F3-11DD-8DDB-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108054>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |   46 +++++++++++++++++++++-------------------------
 1 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index ee58799..86be906 100644
--- a/http.c
+++ b/http.c
@@ -1,7 +1,7 @@
 #include "http.h"
 
 int data_received;
-int active_requests = 0;
+int active_requests;
 
 #ifdef USE_CURL_MULTI
 static int max_requests = -1;
@@ -13,22 +13,22 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
-static const char *ssl_cert = NULL;
+static const char *ssl_cert;
 #if LIBCURL_VERSION_NUM >= 0x070902
-static const char *ssl_key = NULL;
+static const char *ssl_key;
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-static const char *ssl_capath = NULL;
+static const char *ssl_capath;
 #endif
-static const char *ssl_cainfo = NULL;
+static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
-static int curl_ftp_no_epsv = 0;
-static const char *curl_http_proxy = NULL;
+static int curl_ftp_no_epsv;
+static const char *curl_http_proxy;
 
 static struct curl_slist *pragma_header;
 
-static struct active_request_slot *active_queue_head = NULL;
+static struct active_request_slot *active_queue_head;
 
 size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
@@ -94,9 +94,8 @@ static void process_curl_messages(void)
 static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.sslverify", var)) {
-		if (curl_ssl_verify == -1) {
+		if (curl_ssl_verify == -1)
 			curl_ssl_verify = git_config_bool(var, value);
-		}
 		return 0;
 	}
 
@@ -158,9 +157,9 @@ static int http_options(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static CURL* get_curl_handle(void)
+static CURL *get_curl_handle(void)
 {
-	CURL* result = curl_easy_init();
+	CURL *result = curl_easy_init();
 
 	if (!curl_ssl_verify) {
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
@@ -322,15 +321,13 @@ struct active_request_slot *get_active_slot(void)
 	/* Wait for a slot to open up if the queue is full */
 	while (active_requests >= max_requests) {
 		curl_multi_perform(curlm, &num_transfers);
-		if (num_transfers < active_requests) {
+		if (num_transfers < active_requests)
 			process_curl_messages();
-		}
 	}
 #endif
 
-	while (slot != NULL && slot->in_use) {
+	while (slot != NULL && slot->in_use)
 		slot = slot->next;
-	}
 	if (slot == NULL) {
 		newslot = xmalloc(sizeof(*newslot));
 		newslot->curl = NULL;
@@ -341,9 +338,8 @@ struct active_request_slot *get_active_slot(void)
 		if (slot == NULL) {
 			active_queue_head = newslot;
 		} else {
-			while (slot->next != NULL) {
+			while (slot->next != NULL)
 				slot = slot->next;
-			}
 			slot->next = newslot;
 		}
 		slot = newslot;
@@ -404,7 +400,7 @@ struct fill_chain {
 	struct fill_chain *next;
 };
 
-static struct fill_chain *fill_cfg = NULL;
+static struct fill_chain *fill_cfg;
 
 void add_fill_function(void *data, int (*fill)(void *))
 {
@@ -535,9 +531,8 @@ static void finish_active_slot(struct active_request_slot *slot)
 	}
 
 	/* Run callback if appropriate */
-	if (slot->callback_func != NULL) {
+	if (slot->callback_func != NULL)
 		slot->callback_func(slot->callback_data);
-	}
 }
 
 void finish_all_active_slots(void)
@@ -567,8 +562,10 @@ static inline int needs_quote(int ch)
 
 static inline int hex(int v)
 {
-	if (v < 10) return '0' + v;
-	else return 'A' + v - 10;
+	if (v < 10)
+		return '0' + v;
+	else
+		return 'A' + v - 10;
 }
 
 static char *quote_ref_url(const char *base, const char *ref)
@@ -591,8 +588,7 @@ static char *quote_ref_url(const char *base, const char *ref)
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
 			*dp++ = hex(ch & 0xF);
-		}
-		else
+		} else
 			*dp++ = ch;
 	}
 	*dp = 0;
-- 
1.6.1.2.333.ged98f
