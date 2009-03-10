From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/Patch 1/2] http.c: style cleanups
Date: Mon, 09 Mar 2009 19:19:40 -0700
Message-ID: <7vljrece6b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 03:24:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgrbC-0001LZ-47
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 03:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbZCJCTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 22:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZCJCTr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 22:19:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZCJCTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 22:19:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 61913407B;
	Mon,  9 Mar 2009 22:19:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7ED2C407A; Mon, 
 9 Mar 2009 22:19:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB7D685A-0D19-11DE-BEE1-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112775>

The file is littered with coding style violations; this cleans-up before I
touch it with the next patch.

 - We do not initialize statics to NULL/0; we let BSS take care of it
   instead.

 - Asterisk that means a pointerness comes next to variable, not type;
   i.e. a decl looks like "type *variable", not "type* variable".

 - A single-statement in true/false clause of an "if () ... else ...;"
   statement comes on its own line, without curlies {} around it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is not what I am asking for help by sending the series, but the
   next one is.

 http.c |   44 +++++++++++++++++++++-----------------------
 1 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/http.c b/http.c
index 56f18f1..d1ead66 100644
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
@@ -322,15 +321,14 @@ struct active_request_slot *get_active_slot(void)
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
+
 	if (slot == NULL) {
 		newslot = xmalloc(sizeof(*newslot));
 		newslot->curl = NULL;
@@ -341,9 +339,8 @@ struct active_request_slot *get_active_slot(void)
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
@@ -404,7 +401,7 @@ struct fill_chain {
 	struct fill_chain *next;
 };
 
-static struct fill_chain *fill_cfg = NULL;
+static struct fill_chain *fill_cfg;
 
 void add_fill_function(void *data, int (*fill)(void *))
 {
@@ -535,9 +532,8 @@ static void finish_active_slot(struct active_request_slot *slot)
 	}
 
 	/* Run callback if appropriate */
-	if (slot->callback_func != NULL) {
+	if (slot->callback_func != NULL)
 		slot->callback_func(slot->callback_data);
-	}
 }
 
 void finish_all_active_slots(void)
@@ -567,8 +563,10 @@ static inline int needs_quote(int ch)
 
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
-- 
1.6.2.206.g5bda76
