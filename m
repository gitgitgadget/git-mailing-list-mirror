Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF1C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 13:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjAPNZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 08:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAPNZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 08:25:13 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CBA1D906
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 05:25:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bk15so10579721ejb.9
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 05:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmn+VLnz5R0VEjUS5eKv5H8uHVzJ62zJ2m47vLsZjyI=;
        b=b86oxQRKoB1RyYPQAPXAB5LNjxL1Q2/PiO4VQ8D6WsGcyA0NSkIOevOwMEpDU2PVLd
         +qa2FPOlZA8Ht9G7BNtaGDLswkI+Hso1z6efPSRkH16V6dt8Loxs3u7kx8GxIrnPRw9s
         b6gs6EEcAV90L+CC5T7COKiuxrOfBikV5N27jifQiT9Ra1zSbpxyXUIMuytvXzJHVhB2
         rqy5hW8qbbhYeqf7uEQhUejKW8jkVrqgV8bYGMkKz63PK8GTEHrPmYTz5ZfAvcs6jqOj
         ehceCBd/UJtpVARAYlDbNxTQl8098DolkYrxYHzeKT4fVvAOlvFtKqg+Y1b+IbM5emX6
         ejEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmn+VLnz5R0VEjUS5eKv5H8uHVzJ62zJ2m47vLsZjyI=;
        b=RB5gDgRVZqQS5I7L8Ha0KxO67ALDdpgcXNs5Xb8QVDcR2eJopR7np0ewJjD5VM/mD8
         k7O2IkE/VDdbz8j+HQFIknka8uHfj51YfXJqhQH1FT38WXGjU1F7WhIWMYZh5yGKzCl7
         XH3LMRm8MBYv5Sx+duDaQFweFxmNdbcMOuLDYWNn9kZKzuNk4NISzFdO5SHu6ehwsy7j
         aBvhCtmOfUrAiHPnXRZrRNxXnZtgdEVYOBIAXPvT3N76gTlrsg7GT0luphwUj/sTjS88
         iHyXMDWeul/xNWKGDKCeUlnH52yWnTp3E5zaOJy5yj1zOi7ZhpJxDdO89zKdnOcP3GL7
         m2fw==
X-Gm-Message-State: AFqh2krYtkWdJceQrw2VOL6mGECxbh0uclNkNXYLaJJJwL0aaIrbp9Oe
        XX0K3Wvl8QazHzMERIXcxBHwfKg23tI=
X-Google-Smtp-Source: AMrXdXuEtW+CId2QZwc27d0A/+W3q9noZ97bhB5UqulD0K+X0xOCFChthjFU/ObCCNegr46zk//GBQ==
X-Received: by 2002:a17:907:98e3:b0:86f:d154:ef4f with SMTP id ke3-20020a17090798e300b0086fd154ef4fmr5177500ejc.28.1673875511107;
        Mon, 16 Jan 2023 05:25:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090631c100b007aea1dc1840sm11820508ejf.111.2023.01.16.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:25:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pHPU6-002UHK-01;
        Mon, 16 Jan 2023 14:25:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
Date:   Mon, 16 Jan 2023 14:06:50 +0100
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
Message-ID: <230116.86edruzk5m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 15 2023, Jeff King wrote:

> The CURLOPT_PROTOCOLS (and matching CURLOPT_REDIR_PROTOCOLS) flag was
> deprecated in curl 7.85.0, and using it generate compiler warnings as of
> curl 7.87.0. The path forward is to use CURLOPT_PROTOCOLS_STR, but we
> can't just do so unilaterally, as it was only introduced less than a
> year ago in 7.85.0.
>
> Until that version becomes ubiquitous, we have to either disable the
> deprecation warning or conditionally use the "STR" variant on newer
> versions of libcurl. This patch switches to the new variant, which is
> nice for two reasons:
>
>   - we don't have to worry that silencing curl's deprecation warnings
>     might cause us to miss other more useful ones
>
>   - we'd eventually want to move to the new variant anyway, so this gets
>     us set up (albeit with some extra ugly boilerplate for the
>     conditional)
>
> There are a lot of ways to split up the two cases. One way would be to
> abstract the storage type (strbuf versus a long), how to append
> (strbuf_addstr vs bitwise OR), how to initialize, which CURLOPT to use,
> and so on. But the resulting code looks pretty magical:
>
>   GIT_CURL_PROTOCOL_TYPE allowed = GIT_CURL_PROTOCOL_TYPE_INIT;
>   if (...http is allowed...)
> 	GIT_CURL_PROTOCOL_APPEND(&allowed, "http", CURLOPT_HTTP);
>
> and you end up with more "#define GIT_CURL_PROTOCOL_TYPE" macros than
> actual code.
>
> On the other end of the spectrum, we could just implement two separate
> functions, one that handles a string list and one that handles bits. But
> then we end up repeating our list of protocols (http, https, ftp, ftp).
>
> This patch takes the middle ground. The run-time code is always there to
> handle both types, and we just choose which one to feed to curl.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-curl-compat.h |  8 ++++++++
>  http.c            | 41 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index 56a83b6bbd..fd96b3cdff 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -126,4 +126,12 @@
>  #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
>  #endif
>  
> +/**
> + * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
> + * released in August 2022.
> + */
> +#if LIBCURL_VERSION_NUM >= 0x075500
> +#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
> +#endif
> +
>  #endif

Thanks, I hadn't had time to comment on this yet, but was wondering what
this had to do with "CI" or "DEVEDEVELOPER_CFLAGS", the "CI" just seems
to be "where we happened to spot this", and as has been noted this is
also an issue without DEVELOPER_CFLAGS, we just happen to have -Werror
there.

But this is the right direction, and the reason we have git-curl-compat.h.

> diff --git a/http.c b/http.c
> index ca0fe80ddb..e529ebc993 100644
> --- a/http.c
> +++ b/http.c
> @@ -764,18 +764,29 @@ void setup_curl_trace(CURL *handle)
>  	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
>  }
>  
> -static long get_curl_allowed_protocols(int from_user)
> +static void proto_list_append(struct strbuf *list_str, const char *proto_str,
> +			      long *list_bits, long proto_bits)
> +{
> +	*list_bits |= proto_bits;
> +	if (list_str) {
> +		if (list_str->len)
> +			strbuf_addch(list_str, ',');
> +		strbuf_addstr(list_str, proto_str);
> +	}
> +}

Nit: It would be nice (especially in this even smaller function) to
carry forward the name the parent get_curl_allowed_protocols() uses,
i.e. just "list", not "list_str", ditto "proto" rather than "proto_str".

> +#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
> +	{
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		get_curl_allowed_protocols(0, &buf);
> +		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, buf.buf);
> +		strbuf_reset(&buf);
> +
> +		get_curl_allowed_protocols(-1, &buf);
> +		curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, buf.buf);
> +		strbuf_release(&buf);
> +	}
> +#else
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> -			 get_curl_allowed_protocols(0));
> +			 get_curl_allowed_protocols(0, NULL));
>  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> -			 get_curl_allowed_protocols(-1));
> +			 get_curl_allowed_protocols(-1, NULL));
> +#endif
> +
>  	if (getenv("GIT_CURL_VERBOSE"))
>  		http_trace_curl_no_data();
>  	setup_curl_trace(result);

I wonder if it isn't better to avoid conditionally compiled code here if
we can avoid it, i.e. just define GIT_* dummy fallbacks, and only use
these if GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR is true. I.e. something
like the below squashed in.

diff --git a/git-curl-compat.h b/git-curl-compat.h
index fd96b3cdffd..3bc6e151ca7 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -130,8 +130,13 @@
  * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
  * released in August 2022.
  */
-#if LIBCURL_VERSION_NUM >= 0x075500
-#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
+#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR (LIBCURL_VERSION_NUM >= 0x075500)
+#if GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+#define GIT_CURLOPT_REDIR_PROTOCOLS_STR CURLOPT_REDIR_PROTOCOLS_STR 
+#define GIT_CURLOPT_PROTOCOLS_STR CURLOPT_PROTOCOLS_STR
+#else
+#define GIT_CURLOPT_REDIR_PROTOCOLS_STR 0
+#define GIT_CURLOPT_PROTOCOLS_STR 0
 #endif
 
 #endif
diff --git a/http.c b/http.c
index e529ebc993d..3224e897f02 100644
--- a/http.c
+++ b/http.c
@@ -933,24 +933,22 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
 
-#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
-	{
+	if (GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR) {
 		struct strbuf buf = STRBUF_INIT;
 
 		get_curl_allowed_protocols(0, &buf);
-		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, buf.buf);
+		curl_easy_setopt(result, GIT_CURLOPT_REDIR_PROTOCOLS_STR, buf.buf);
 		strbuf_reset(&buf);
 
 		get_curl_allowed_protocols(-1, &buf);
-		curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, buf.buf);
+		curl_easy_setopt(result, GIT_CURLOPT_PROTOCOLS_STR, buf.buf);
 		strbuf_release(&buf);
+	} else {
+		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
+				 get_curl_allowed_protocols(0, NULL));
+		curl_easy_setopt(result, CURLOPT_PROTOCOLS,
+				 get_curl_allowed_protocols(-1, NULL));
 	}
-#else
-	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
-			 get_curl_allowed_protocols(0, NULL));
-	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
-			 get_curl_allowed_protocols(-1, NULL));
-#endif
 
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
