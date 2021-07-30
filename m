Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE8C432BE
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158026023B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhG3SAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhG3R76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:59:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38692C061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b7so12347337wri.8
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mhz8/Jff+MGr1+f0RbjGFK83HBGZhLviQrzDOWtXu6M=;
        b=nQY/n8rxeRiUMBvOJpFDNAKcmP1gDDl08ldgZOMhQDStYZRoCT2bKkeJxdsHX82GUI
         ckCLFBvZTMI9jq6gnuzqKzBBiZLA9HJWjjiOQJrLxh3PgiVHUMYbp2OPMg+wOPVRaJHl
         Ny7awnC7kn/ZtEEFaiyD+XkzTRG8yVB3SjTw9YMesFKKzoxVUa08hmJW08ocfW5L4KAc
         rdx/2PadridaclrmDY/Wc4Ec1iOOaOlsvVYMXXucDNKw/BnRsQo/ecYRxpNjqWeww+zf
         IiHn7GxrvdxxTSIUd+YQiLPKUi5u96ij6wwMYlLg1JGFri1PHdqMqFrSVpattx0dKloB
         P2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mhz8/Jff+MGr1+f0RbjGFK83HBGZhLviQrzDOWtXu6M=;
        b=GVOsunRvywyIecMLInvW3k0VIPr5LZLdmxfI3stCO3tcTYkNx8VB76mGCfcDeOXxWZ
         2cjoyL2ZYAYw9KVpr3dByahUFcKbhgFrCrS0uxWqUb1uM+Z6kwBTuvPdtjFSTjaIqiOZ
         SvxbNbLP2GZWzOeMcrgPFkC1vC5nQ1+8IrzOAxFLPNuy4kjf4Wf1vGgZaAg4w/V7+uYj
         L0lxE/l23rYNrssmOuzum3pKde0loPj5YQlW9aWpIwH2c/9bL8cOQWVvt3WgKvEIIt4b
         nuVdYR6GRxnCegCW0u/2pdbw9ZCxeX95IB4zdd44gv+CEba5y17FQm6s17LmpNQwqAL/
         qdsw==
X-Gm-Message-State: AOAM532z7fzR2zufwg2/HHkcQOwLMGTfAdI971mxURlqlPZiOBk9kbRn
        7wz/2ScUXccrHogikWlp368JdUHQymF9tQ==
X-Google-Smtp-Source: ABdhPJyszNXnCtZ55hUc6BkfNSXgrghBhE7AZTPh58rra0NKEV+c/PHOiLGEfRGn2tFYbJFIble4lA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr4389287wrx.110.1627667990469;
        Fri, 30 Jul 2021 10:59:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i186sm2540311wmi.43.2021.07.30.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:59:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/5] http: drop support for curl < 7.16.0
Date:   Fri, 30 Jul 2021 19:59:43 +0200
Message-Id: <patch-v4-2.5-fb308258e2b-20210730T175650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1071.g36f34456314
In-Reply-To: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In the last commit we dropped support for curl < 7.11.1, let's
continue that and drop support for versions older than 7.16.0. This
allows us to get rid of some now-obsolete #ifdefs.

Choosing 7.16.0 is a somewhat arbitrary cutoff:

  1. It came out in October of 2006, almost 15 years ago.
     Besides being a nice round number, around 10 years is
     a common end-of-life support period, even for conservative
     distributions.

  2. That version introduced the curl_multi interface, which
     gives us a lot of bang for the buck in removing #ifdefs

RHEL 5 came with curl 7.15.5[1] (released in August 2006). RHEL 5's
extended life cycle program ended on 2020-11-30[1]. RHEL 6 comes with
curl 7.19.7 (released in November 2009), and RHEL 7 comes with
7.29.0 (released in February 2013).

1. http://lore.kernel.org/git/873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c   | 23 ---------------------
 http-walker.c | 12 -----------
 http.c        | 56 +--------------------------------------------------
 http.h        | 25 +----------------------
 imap-send.c   |  4 ----
 remote-curl.c |  4 ----
 6 files changed, 2 insertions(+), 122 deletions(-)

diff --git a/http-push.c b/http-push.c
index d7cb1675a2d..aa3de7c1086 100644
--- a/http-push.c
+++ b/http-push.c
@@ -203,10 +203,8 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
 	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
 	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);
-#endif
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
@@ -249,8 +247,6 @@ static void process_response(void *callback_data)
 	finish_request(request);
 }
 
-#ifdef USE_CURL_MULTI
-
 static void start_fetch_loose(struct transfer_request *request)
 {
 	struct active_request_slot *slot;
@@ -299,7 +295,6 @@ static void start_mkcol(struct transfer_request *request)
 		FREE_AND_NULL(request->url);
 	}
 }
-#endif
 
 static void start_fetch_packed(struct transfer_request *request)
 {
@@ -605,7 +600,6 @@ static void finish_request(struct transfer_request *request)
 	}
 }
 
-#ifdef USE_CURL_MULTI
 static int is_running_queue;
 static int fill_active_slot(void *unused)
 {
@@ -629,7 +623,6 @@ static int fill_active_slot(void *unused)
 	}
 	return 0;
 }
-#endif
 
 static void get_remote_object_list(unsigned char parent);
 
@@ -658,10 +651,8 @@ static void add_fetch_request(struct object *obj)
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 }
 
 static int add_send_request(struct object *obj, struct remote_lock *lock)
@@ -696,10 +687,8 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 
 	return 1;
 }
@@ -1682,21 +1671,15 @@ static int delete_remote_branch(const char *pattern, int force)
 
 static void run_request_queue(void)
 {
-#ifdef USE_CURL_MULTI
 	is_running_queue = 1;
 	fill_active_slots();
 	add_fill_function(NULL, fill_active_slot);
-#endif
 	do {
 		finish_all_active_slots();
-#ifdef USE_CURL_MULTI
 		fill_active_slots();
-#endif
 	} while (request_queue_head && !aborted);
 
-#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
-#endif
 }
 
 int cmd_main(int argc, const char **argv)
@@ -1770,10 +1753,6 @@ int cmd_main(int argc, const char **argv)
 		break;
 	}
 
-#ifndef USE_CURL_MULTI
-	die("git-push is not available for http/https repository when not compiled with USE_CURL_MULTI");
-#endif
-
 	if (!repo->url)
 		usage(http_push_usage);
 
@@ -1786,9 +1765,7 @@ int cmd_main(int argc, const char **argv)
 
 	http_init(NULL, repo->url, 1);
 
-#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
-#endif
 
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
diff --git a/http-walker.c b/http-walker.c
index 90d8ecb57ef..19e31623f04 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -127,7 +127,6 @@ static void release_object_request(struct object_request *obj_req)
 	free(obj_req);
 }
 
-#ifdef USE_CURL_MULTI
 static int fill_active_slot(struct walker *walker)
 {
 	struct object_request *obj_req;
@@ -146,7 +145,6 @@ static int fill_active_slot(struct walker *walker)
 	}
 	return 0;
 }
-#endif
 
 static void prefetch(struct walker *walker, unsigned char *sha1)
 {
@@ -163,10 +161,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	http_is_verbose = walker->get_verbosely;
 	list_add_tail(&newreq->node, &object_queue_head);
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 }
 
 static int is_alternate_allowed(const char *url)
@@ -357,11 +353,9 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	 * wait for them to arrive and return to processing this request's
 	 * curl message
 	 */
-#ifdef USE_CURL_MULTI
 	while (cdata->got_alternates == 0) {
 		step_active_slots();
 	}
-#endif
 
 	/* Nothing to do if they've already been fetched */
 	if (cdata->got_alternates == 1)
@@ -505,12 +499,8 @@ static int fetch_object(struct walker *walker, unsigned char *hash)
 		return 0;
 	}
 
-#ifdef USE_CURL_MULTI
 	while (obj_req->state == WAITING)
 		step_active_slots();
-#else
-	start_object_request(walker, obj_req);
-#endif
 
 	/*
 	 * obj_req->req might change when fetching alternates in the callback
@@ -623,9 +613,7 @@ struct walker *get_http_walker(const char *url)
 	walker->cleanup = cleanup;
 	walker->data = data;
 
-#ifdef USE_CURL_MULTI
 	add_fill_function(walker, (int (*)(void *)) fill_active_slot);
-#endif
 
 	return walker;
 }
diff --git a/http.c b/http.c
index 56182a89e25..ef00e930232 100644
--- a/http.c
+++ b/http.c
@@ -26,10 +26,8 @@ ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
 static int min_curl_sessions = 1;
 static int curl_session_count;
-#ifdef USE_CURL_MULTI
 static int max_requests = -1;
 static CURLM *curlm;
-#endif
 #ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
 #endif
@@ -117,14 +115,6 @@ static int curl_empty_auth = -1;
 
 enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
-#if LIBCURL_VERSION_NUM >= 0x071700
-/* Use CURLOPT_KEYPASSWD as is */
-#elif LIBCURL_VERSION_NUM >= 0x070903
-#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
-#else
-#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
-#endif
-
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
 static unsigned long http_auth_methods = CURLAUTH_ANY;
@@ -168,7 +158,6 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size / eltsize;
 }
 
-#ifndef NO_CURL_IOCTL
 curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 {
 	struct buffer *buffer = clientp;
@@ -185,7 +174,6 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 		return CURLIOE_UNKNOWNCMD;
 	}
 }
-#endif
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
@@ -233,12 +221,9 @@ static void finish_active_slot(struct active_request_slot *slot)
 
 static void xmulti_remove_handle(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	curl_multi_remove_handle(curlm, slot->curl);
-#endif
 }
 
-#ifdef USE_CURL_MULTI
 static void process_curl_messages(void)
 {
 	int num_messages;
@@ -266,7 +251,6 @@ static void process_curl_messages(void)
 		curl_message = curl_multi_info_read(curlm, &num_messages);
 	}
 }
-#endif
 
 static int http_options(const char *var, const char *value, void *cb)
 {
@@ -315,18 +299,14 @@ static int http_options(const char *var, const char *value, void *cb)
 
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
-#ifndef USE_CURL_MULTI
 		if (min_curl_sessions > 1)
 			min_curl_sessions = 1;
-#endif
 		return 0;
 	}
-#ifdef USE_CURL_MULTI
 	if (!strcmp("http.maxrequests", var)) {
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
-#endif
 	if (!strcmp("http.lowspeedlimit", var)) {
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
@@ -574,7 +554,7 @@ static void set_curl_keepalive(CURL *c)
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
 }
 
-#elif LIBCURL_VERSION_NUM >= 0x071000
+#else
 static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 {
 	int ka = 1;
@@ -595,12 +575,6 @@ static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
 }
-
-#else
-static void set_curl_keepalive(CURL *c)
-{
-	/* not supported on older curl versions */
-}
 #endif
 
 static void redact_sensitive_header(struct strbuf *header)
@@ -1121,7 +1095,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma:");
 
-#ifdef USE_CURL_MULTI
 	{
 		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 		if (http_max_requests != NULL)
@@ -1131,7 +1104,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	curlm = curl_multi_init();
 	if (!curlm)
 		die("curl_multi_init failed");
-#endif
 
 	if (getenv("GIT_SSL_NO_VERIFY"))
 		curl_ssl_verify = 0;
@@ -1154,10 +1126,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 1;
 
 	curl_session_count = 0;
-#ifdef USE_CURL_MULTI
 	if (max_requests < 1)
 		max_requests = DEFAULT_MAX_REQUESTS;
-#endif
 
 	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
 	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
@@ -1201,9 +1171,7 @@ void http_cleanup(void)
 	curl_easy_cleanup(curl_default);
 #endif
 
-#ifdef USE_CURL_MULTI
 	curl_multi_cleanup(curlm);
-#endif
 	curl_global_cleanup();
 
 	string_list_clear(&extra_http_headers, 0);
@@ -1250,7 +1218,6 @@ struct active_request_slot *get_active_slot(void)
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
 
-#ifdef USE_CURL_MULTI
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -1259,7 +1226,6 @@ struct active_request_slot *get_active_slot(void)
 		if (num_transfers < active_requests)
 			process_curl_messages();
 	}
-#endif
 
 	while (slot != NULL && slot->in_use)
 		slot = slot->next;
@@ -1330,7 +1296,6 @@ struct active_request_slot *get_active_slot(void)
 
 int start_active_slot(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
 	int num_transfers;
 
@@ -1348,11 +1313,9 @@ int start_active_slot(struct active_request_slot *slot)
 	 * something.
 	 */
 	curl_multi_perform(curlm, &num_transfers);
-#endif
 	return 1;
 }
 
-#ifdef USE_CURL_MULTI
 struct fill_chain {
 	void *data;
 	int (*fill)(void *);
@@ -1411,11 +1374,9 @@ void step_active_slots(void)
 		fill_active_slots();
 	}
 }
-#endif
 
 void run_active_slot(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	fd_set readfds;
 	fd_set writefds;
 	fd_set excfds;
@@ -1428,7 +1389,6 @@ void run_active_slot(struct active_request_slot *slot)
 		step_active_slots();
 
 		if (slot->in_use) {
-#if LIBCURL_VERSION_NUM >= 0x070f04
 			long curl_timeout;
 			curl_multi_timeout(curlm, &curl_timeout);
 			if (curl_timeout == 0) {
@@ -1440,10 +1400,6 @@ void run_active_slot(struct active_request_slot *slot)
 				select_timeout.tv_sec  =  curl_timeout / 1000;
 				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
 			}
-#else
-			select_timeout.tv_sec  = 0;
-			select_timeout.tv_usec = 50000;
-#endif
 
 			max_fd = -1;
 			FD_ZERO(&readfds);
@@ -1466,12 +1422,6 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
-#else
-	while (slot->in_use) {
-		slot->curl_result = curl_easy_perform(slot->curl);
-		finish_active_slot(slot);
-	}
-#endif
 }
 
 static void release_active_slot(struct active_request_slot *slot)
@@ -1485,9 +1435,7 @@ static void release_active_slot(struct active_request_slot *slot)
 			curl_session_count--;
 		}
 	}
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
-#endif
 }
 
 void finish_all_active_slots(void)
@@ -1613,12 +1561,10 @@ static int handle_curl_result(struct slot_results *results)
 	} else {
 		if (results->http_connectcode == 407)
 			credential_reject(&proxy_auth);
-#if LIBCURL_VERSION_NUM >= 0x070c00
 		if (!curl_errorstr[0])
 			strlcpy(curl_errorstr,
 				curl_easy_strerror(results->curl_result),
 				sizeof(curl_errorstr));
-#endif
 		return HTTP_ERROR;
 	}
 }
diff --git a/http.h b/http.h
index d2f8cc56617..cb092622a73 100644
--- a/http.h
+++ b/http.h
@@ -10,31 +10,12 @@
 #include "remote.h"
 #include "url.h"
 
-/*
- * We detect based on the cURL version if multi-transfer is
- * usable in this implementation and define this symbol accordingly.
- * This shouldn't be set by the Makefile or by the user (e.g. via CFLAGS).
- */
-#undef USE_CURL_MULTI
-
-#if LIBCURL_VERSION_NUM >= 0x071000
-#define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
-#endif
-
-#if LIBCURL_VERSION_NUM >= 0x070c00
-#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
-						xrealloc, xstrdup, xcalloc)
-#endif
 
-#if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
+#if LIBCURL_VERSION_NUM == 0x071000
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070c03
-#define NO_CURL_IOCTL
-#endif
-
 /*
  * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
  * and the constants were known as CURLFTPSSL_*
@@ -72,9 +53,7 @@ struct buffer {
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-#ifndef NO_CURL_IOCTL
 curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
-#endif
 
 /* Slot lifecycle functions */
 struct active_request_slot *get_active_slot(void);
@@ -91,11 +70,9 @@ void finish_all_active_slots(void);
 int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results);
 
-#ifdef USE_CURL_MULTI
 void fill_active_slots(void);
 void add_fill_function(void *data, int (*fill)(void *));
 void step_active_slots(void);
-#endif
 
 void http_init(struct remote *remote, const char *url,
 	       int proactive_auth);
diff --git a/imap-send.c b/imap-send.c
index a0540ba5cf4..49a5f8aa597 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1517,11 +1517,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	if (cred.username) {
 		if (res == CURLE_OK)
 			credential_approve(&cred);
-#if LIBCURL_VERSION_NUM >= 0x070d01
 		else if (res == CURLE_LOGIN_DENIED)
-#else
-		else
-#endif
 			credential_reject(&cred);
 	}
 
diff --git a/remote-curl.c b/remote-curl.c
index e738ae2c48a..09f09aeece3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -706,7 +706,6 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-#ifndef NO_CURL_IOCTL
 static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 {
 	struct rpc_state *rpc = clientp;
@@ -727,7 +726,6 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 		return CURLIOE_UNKNOWNCMD;
 	}
 }
-#endif
 
 struct check_pktline_state {
 	char len_buf[4];
@@ -946,10 +944,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-#ifndef NO_CURL_IOCTL
 		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
 		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
-#endif
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);
-- 
2.32.0.1071.g36f34456314

