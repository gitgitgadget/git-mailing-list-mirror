Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAFBC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB9B611C5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhIJW3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhIJW3l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 18:29:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137FC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 15:28:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u19so4603238edb.3
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+AndnaDMfAEmyYSW7kntje5iJXsuzckom/cScVNpYo=;
        b=o9iVcOl1yieEe2nIZnhHfFhRtT/gXpY10/fEVMVkHqzyee8oJ4FTMq3LgF15WVsDR5
         htuYIqZTCaVXY9ppbYoPqGbVdCWYp1khDZDWiDLfPQAzviayHVnc1qFUXcAwpw6UoNyZ
         uadS7WP6ZvM5P0P15DQRfqQYrjpC0NYssmRur5cdOgGY1mKPp3E4g5mTp8Ys+GQPYo3v
         IHxM8A0NckTHqcxLxocEYYxlJFg3GZlPvfYFwh27sHdEb5Q8tujtjXtm4rrQcrag4L/z
         aV0Ck1BycAZr1UVstHOWSPP+atP12FWKxXgzjcc3WMDtFXVEF/UrfCPuDDZ05PBsBIs6
         cJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+AndnaDMfAEmyYSW7kntje5iJXsuzckom/cScVNpYo=;
        b=nl6aJYVtsXIeqsFycaVhtt1AdW9mjWdbEe69jioOY1bew+LpATRnnmzj2jXCETt2TQ
         ef1TbKw89ACueuaVm1M5mlYYsQNqtUS0yldR1IyFkbo10auVSm21ijLKKpuJ9rSGE59o
         tPD7UXqtcHhmoz47SsMZHecKGLIdaoY6cqskAcgE/pPDqMuyV7oafTkcFuC7y/ryIN4m
         wrqDKhEGt3jCd8fdyyqy7u+SFH+eXrKttB1EnCp6FrC1Oraa+XUFzkG2Lc0tUMJPFvuM
         jT1MgUOZLsyqnmBNL8jSiQHYRV2z2OPqEpQe5wJDNvff90usgAA/0whwyONiQe0tbwop
         TeZQ==
X-Gm-Message-State: AOAM530Pq14gferDznZ/mDkIPNKh7Eqb8C1pCFDUv2iz8ZHeBSX+Xwqh
        KU9TwS+Hu3f73HNE6FSC1/scMabBXBRxSTKX
X-Google-Smtp-Source: ABdhPJyAc0OIReJobpA1fFnutmNhCL42o08Zhr7bGlS/HJpV+Om1qzHkjaH8+YaT6WFBft4sSwmlCQ==
X-Received: by 2002:a05:6402:1ac5:: with SMTP id ba5mr9012581edb.20.1631312908627;
        Fri, 10 Sep 2021 15:28:28 -0700 (PDT)
Received: from [10.5.18.6] ([212.102.57.143])
        by smtp.gmail.com with ESMTPSA id e21sm2940171ejj.4.2021.09.10.15.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 15:28:27 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] http: drop support for curl < 7.16.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
 <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <patch-v4-2.5-fb308258e2b-20210730T175650Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <1b18309a-93e8-60cc-1bd3-61857b1da819@gmail.com>
Date:   Sat, 11 Sep 2021 00:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v4-2.5-fb308258e2b-20210730T175650Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/07/2021 19:59, Ævar Arnfjörð Bjarmason wrote:
> From: Jeff King <peff@peff.net>
> 
> In the last commit we dropped support for curl < 7.11.1, let's
> continue that and drop support for versions older than 7.16.0. This
> allows us to get rid of some now-obsolete #ifdefs.
> 
> Choosing 7.16.0 is a somewhat arbitrary cutoff:
> 
>    1. It came out in October of 2006, almost 15 years ago.
>       Besides being a nice round number, around 10 years is
>       a common end-of-life support period, even for conservative
>       distributions.
> 
>    2. That version introduced the curl_multi interface, which
>       gives us a lot of bang for the buck in removing #ifdefs
> 
> RHEL 5 came with curl 7.15.5[1] (released in August 2006). RHEL 5's
> extended life cycle program ended on 2020-11-30[1]. RHEL 6 comes with
> curl 7.19.7 (released in November 2009), and RHEL 7 comes with
> 7.29.0 (released in February 2013).
> 
> 1. http://lore.kernel.org/git/873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

[...]

> diff --git a/http.c b/http.c
> index 56182a89e25..ef00e930232 100644
> --- a/http.c
> +++ b/http.c
> @@ -26,10 +26,8 @@ ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
>   
>   static int min_curl_sessions = 1;
>   static int curl_session_count;
> -#ifdef USE_CURL_MULTI
>   static int max_requests = -1;
>   static CURLM *curlm;
> -#endif
>   #ifndef NO_CURL_EASY_DUPHANDLE
>   static CURL *curl_default;
>   #endif
> @@ -117,14 +115,6 @@ static int curl_empty_auth = -1;
>   
>   enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
>   
> -#if LIBCURL_VERSION_NUM >= 0x071700
> -/* Use CURLOPT_KEYPASSWD as is */
> -#elif LIBCURL_VERSION_NUM >= 0x070903
> -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
> -#else
> -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
> -#endif

In 0x071700, 0x17 == 23, so it seems that this chain of `#if`s
distinguishes between three categories of curl versions:

   1. version < 7.9.3
   2. 7.9.3 <= version < 7.23.0
   3. 7.23.0 <= version

So it seems that this patch [1] drops support for curl < 7.23.0, while
the subject line claims "drop support for curl < 7.16.0".

[1]: already in branch master as commit 013c7e2b07 (http: drop support
      for curl < 7.16.0, 2021-07-30)

> -
>   static struct credential cert_auth = CREDENTIAL_INIT;
>   static int ssl_cert_password_required;
>   static unsigned long http_auth_methods = CURLAUTH_ANY;
> @@ -168,7 +158,6 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>   	return size / eltsize;
>   }
>   
> -#ifndef NO_CURL_IOCTL
>   curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
>   {
>   	struct buffer *buffer = clientp;
> @@ -185,7 +174,6 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
>   		return CURLIOE_UNKNOWNCMD;
>   	}
>   }
> -#endif
>   
>   size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>   {
> @@ -233,12 +221,9 @@ static void finish_active_slot(struct active_request_slot *slot)
>   
>   static void xmulti_remove_handle(struct active_request_slot *slot)
>   {
> -#ifdef USE_CURL_MULTI
>   	curl_multi_remove_handle(curlm, slot->curl);
> -#endif
>   }
>   
> -#ifdef USE_CURL_MULTI
>   static void process_curl_messages(void)
>   {
>   	int num_messages;
> @@ -266,7 +251,6 @@ static void process_curl_messages(void)
>   		curl_message = curl_multi_info_read(curlm, &num_messages);
>   	}
>   }
> -#endif
>   
>   static int http_options(const char *var, const char *value, void *cb)
>   {
> @@ -315,18 +299,14 @@ static int http_options(const char *var, const char *value, void *cb)
>   
>   	if (!strcmp("http.minsessions", var)) {
>   		min_curl_sessions = git_config_int(var, value);
> -#ifndef USE_CURL_MULTI
>   		if (min_curl_sessions > 1)
>   			min_curl_sessions = 1;
> -#endif
>   		return 0;
>   	}
> -#ifdef USE_CURL_MULTI
>   	if (!strcmp("http.maxrequests", var)) {
>   		max_requests = git_config_int(var, value);
>   		return 0;
>   	}
> -#endif
>   	if (!strcmp("http.lowspeedlimit", var)) {
>   		curl_low_speed_limit = (long)git_config_int(var, value);
>   		return 0;
> @@ -574,7 +554,7 @@ static void set_curl_keepalive(CURL *c)
>   	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
>   }
>   
> -#elif LIBCURL_VERSION_NUM >= 0x071000
> +#else
>   static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
>   {
>   	int ka = 1;
> @@ -595,12 +575,6 @@ static void set_curl_keepalive(CURL *c)
>   {
>   	curl_easy_setopt(c, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
>   }
> -
> -#else
> -static void set_curl_keepalive(CURL *c)
> -{
> -	/* not supported on older curl versions */
> -}
>   #endif
>   
>   static void redact_sensitive_header(struct strbuf *header)
> @@ -1121,7 +1095,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>   	no_pragma_header = curl_slist_append(http_copy_default_headers(),
>   		"Pragma:");
>   
> -#ifdef USE_CURL_MULTI
>   	{
>   		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
>   		if (http_max_requests != NULL)
> @@ -1131,7 +1104,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>   	curlm = curl_multi_init();
>   	if (!curlm)
>   		die("curl_multi_init failed");
> -#endif
>   
>   	if (getenv("GIT_SSL_NO_VERIFY"))
>   		curl_ssl_verify = 0;
> @@ -1154,10 +1126,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>   		curl_ssl_verify = 1;
>   
>   	curl_session_count = 0;
> -#ifdef USE_CURL_MULTI
>   	if (max_requests < 1)
>   		max_requests = DEFAULT_MAX_REQUESTS;
> -#endif
>   
>   	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
>   	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
> @@ -1201,9 +1171,7 @@ void http_cleanup(void)
>   	curl_easy_cleanup(curl_default);
>   #endif
>   
> -#ifdef USE_CURL_MULTI
>   	curl_multi_cleanup(curlm);
> -#endif
>   	curl_global_cleanup();
>   
>   	string_list_clear(&extra_http_headers, 0);
> @@ -1250,7 +1218,6 @@ struct active_request_slot *get_active_slot(void)
>   	struct active_request_slot *slot = active_queue_head;
>   	struct active_request_slot *newslot;
>   
> -#ifdef USE_CURL_MULTI
>   	int num_transfers;
>   
>   	/* Wait for a slot to open up if the queue is full */
> @@ -1259,7 +1226,6 @@ struct active_request_slot *get_active_slot(void)
>   		if (num_transfers < active_requests)
>   			process_curl_messages();
>   	}
> -#endif
>   
>   	while (slot != NULL && slot->in_use)
>   		slot = slot->next;
> @@ -1330,7 +1296,6 @@ struct active_request_slot *get_active_slot(void)
>   
>   int start_active_slot(struct active_request_slot *slot)
>   {
> -#ifdef USE_CURL_MULTI
>   	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
>   	int num_transfers;
>   
> @@ -1348,11 +1313,9 @@ int start_active_slot(struct active_request_slot *slot)
>   	 * something.
>   	 */
>   	curl_multi_perform(curlm, &num_transfers);
> -#endif
>   	return 1;
>   }
>   
> -#ifdef USE_CURL_MULTI
>   struct fill_chain {
>   	void *data;
>   	int (*fill)(void *);
> @@ -1411,11 +1374,9 @@ void step_active_slots(void)
>   		fill_active_slots();
>   	}
>   }
> -#endif
>   
>   void run_active_slot(struct active_request_slot *slot)
>   {
> -#ifdef USE_CURL_MULTI
>   	fd_set readfds;
>   	fd_set writefds;
>   	fd_set excfds;
> @@ -1428,7 +1389,6 @@ void run_active_slot(struct active_request_slot *slot)
>   		step_active_slots();
>   
>   		if (slot->in_use) {
> -#if LIBCURL_VERSION_NUM >= 0x070f04
>   			long curl_timeout;
>   			curl_multi_timeout(curlm, &curl_timeout);
>   			if (curl_timeout == 0) {
> @@ -1440,10 +1400,6 @@ void run_active_slot(struct active_request_slot *slot)
>   				select_timeout.tv_sec  =  curl_timeout / 1000;
>   				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
>   			}
> -#else
> -			select_timeout.tv_sec  = 0;
> -			select_timeout.tv_usec = 50000;
> -#endif
>   
>   			max_fd = -1;
>   			FD_ZERO(&readfds);
> @@ -1466,12 +1422,6 @@ void run_active_slot(struct active_request_slot *slot)
>   			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>   		}
>   	}
> -#else
> -	while (slot->in_use) {
> -		slot->curl_result = curl_easy_perform(slot->curl);
> -		finish_active_slot(slot);
> -	}
> -#endif
>   }
>   
>   static void release_active_slot(struct active_request_slot *slot)
> @@ -1485,9 +1435,7 @@ static void release_active_slot(struct active_request_slot *slot)
>   			curl_session_count--;
>   		}
>   	}
> -#ifdef USE_CURL_MULTI
>   	fill_active_slots();
> -#endif
>   }
>   
>   void finish_all_active_slots(void)
> @@ -1613,12 +1561,10 @@ static int handle_curl_result(struct slot_results *results)
>   	} else {
>   		if (results->http_connectcode == 407)
>   			credential_reject(&proxy_auth);
> -#if LIBCURL_VERSION_NUM >= 0x070c00
>   		if (!curl_errorstr[0])
>   			strlcpy(curl_errorstr,
>   				curl_easy_strerror(results->curl_result),
>   				sizeof(curl_errorstr));
> -#endif
>   		return HTTP_ERROR;
>   	}
>   }
> diff --git a/http.h b/http.h
> index d2f8cc56617..cb092622a73 100644
> --- a/http.h
> +++ b/http.h
> @@ -10,31 +10,12 @@
>   #include "remote.h"
>   #include "url.h"
>   
> -/*
> - * We detect based on the cURL version if multi-transfer is
> - * usable in this implementation and define this symbol accordingly.
> - * This shouldn't be set by the Makefile or by the user (e.g. via CFLAGS).
> - */
> -#undef USE_CURL_MULTI
> -
> -#if LIBCURL_VERSION_NUM >= 0x071000
> -#define USE_CURL_MULTI
>   #define DEFAULT_MAX_REQUESTS 5
> -#endif
> -
> -#if LIBCURL_VERSION_NUM >= 0x070c00
> -#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
> -						xrealloc, xstrdup, xcalloc)
> -#endif
>   
> -#if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
> +#if LIBCURL_VERSION_NUM == 0x071000
>   #define NO_CURL_EASY_DUPHANDLE
>   #endif
>   
> -#if LIBCURL_VERSION_NUM < 0x070c03
> -#define NO_CURL_IOCTL
> -#endif
> -
>   /*
>    * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
>    * and the constants were known as CURLFTPSSL_*
> @@ -72,9 +53,7 @@ struct buffer {
>   size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
>   size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
>   size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
> -#ifndef NO_CURL_IOCTL
>   curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
> -#endif
>   
>   /* Slot lifecycle functions */
>   struct active_request_slot *get_active_slot(void);
> @@ -91,11 +70,9 @@ void finish_all_active_slots(void);
>   int run_one_slot(struct active_request_slot *slot,
>   		 struct slot_results *results);
>   
> -#ifdef USE_CURL_MULTI
>   void fill_active_slots(void);
>   void add_fill_function(void *data, int (*fill)(void *));
>   void step_active_slots(void);
> -#endif
>   
>   void http_init(struct remote *remote, const char *url,
>   	       int proactive_auth);
> diff --git a/imap-send.c b/imap-send.c
> index a0540ba5cf4..49a5f8aa597 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1517,11 +1517,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>   	if (cred.username) {
>   		if (res == CURLE_OK)
>   			credential_approve(&cred);
> -#if LIBCURL_VERSION_NUM >= 0x070d01
>   		else if (res == CURLE_LOGIN_DENIED)
> -#else
> -		else
> -#endif
>   			credential_reject(&cred);
>   	}
>   
> diff --git a/remote-curl.c b/remote-curl.c
> index e738ae2c48a..09f09aeece3 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -706,7 +706,6 @@ static size_t rpc_out(void *ptr, size_t eltsize,
>   	return avail;
>   }
>   
> -#ifndef NO_CURL_IOCTL
>   static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
>   {
>   	struct rpc_state *rpc = clientp;
> @@ -727,7 +726,6 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
>   		return CURLIOE_UNKNOWNCMD;
>   	}
>   }
> -#endif
>   
>   struct check_pktline_state {
>   	char len_buf[4];
> @@ -946,10 +944,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
>   		rpc->initial_buffer = 1;
>   		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
>   		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
> -#ifndef NO_CURL_IOCTL
>   		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
>   		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
> -#endif
>   		if (options.verbosity > 1) {
>   			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
>   			fflush(stderr);
> 

