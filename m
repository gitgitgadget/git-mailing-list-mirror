Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57533C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3186C60F4C
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhHSJgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhHSJgl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 05:36:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A2C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:36:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g14so4943491pfm.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2TybyizBJUKHSXT67SHu00w9kkZzDWLe50SpsLWj/v0=;
        b=kfbxTYJu+RDMPEn7kGHbgCsz58XqqFE3qzWn0sP1m0YSIh8J1Ph56inbwlQYJR8Y9N
         NASY53MITB5srBEltjzbPh1PK3d+gyn2UT2Aj8Jd6ljugWwbkpweb1d0CUe/Wfx9yUkN
         WWNeNmdsXebdCj3tOzSl3Jc1rX6FO8EFM/3HqT7p+SxJxttjU3ByrrOrwNAGTgwJ/wsb
         RMr2ll1ZfGXqmUmE57ynL6IcSS9uVHqLMImSLOHBVhdwaLTujos7WZHvy/lDebb4KGS6
         Lf9QQ0XLLOdNdvB6FMQj71y+US80aR2MQHrZaFmUeMdyr/fyP03yVFjKBwq+UOONavfU
         cbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2TybyizBJUKHSXT67SHu00w9kkZzDWLe50SpsLWj/v0=;
        b=UeU1ws5qLGC6s77zhgB4WW3oUp3h4fARWocu1m1VTTo5jVaMkRg2609eKoabGGaIih
         XcnPtUfLf/YLACS9JPJA3yAAH3resMsgTWw4TnuoyIJQziaFfvo7W92aB5rYi/3xutFz
         CoxkGa0s6rGWkq4T2OkiwB7H/8qgJwovp6Ft2oK7ZHnZ/lbVmd0IFb7Aj1p0zKIIkMeE
         qJx5+B7uX5XlBZLYZ9oOjh6Nvn8SOA+q3uOxJv9i3jjxk/NCku8RwJ37oPYoFt6Y8TJe
         jEVLHedIqhAvR46U0f/jZXK8nay3r1tqRYgaxgq/8Bi2tcHQtdRNrKeIDEn+ZQ3BrJ6Y
         IhaQ==
X-Gm-Message-State: AOAM531hoUNBcrMMhcq7CrKzAmWTKDU9U9C/NiMMoolbSTR0Qf/KjUY8
        73IHxw/w6b03ndiHq7pDRZk=
X-Google-Smtp-Source: ABdhPJwarwG2WrthD0UUOPLB1rR8IXZuPyTnHf2dEh7v1LJ8ALoluDXUzfFrWw9iQyjLqptgSyJWGg==
X-Received: by 2002:a65:67d7:: with SMTP id b23mr13389939pgs.356.1629365764727;
        Thu, 19 Aug 2021 02:36:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-23.three.co.id. [180.214.233.23])
        by smtp.gmail.com with ESMTPSA id w18sm2594330pjg.50.2021.08.19.02.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 02:36:04 -0700 (PDT)
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
To:     Xia XiaoWen <haoyurenzhuxia@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <a097e447-28e7-d991-ac99-ce1ffdb3ead4@gmail.com>
Date:   Thu, 19 Aug 2021 16:36:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/21 16.14, Xia XiaoWen wrote:
> Sometimes need to limit the receive speed of git `clone/fetch`
> because of the limited network bandwidth, otherwise will prevent
> other applications from using the network normally.
> 
I mean "In some situations it is preferable to limit receiving speed of 
git clone/fetch due to network bandwidth constraint, otherwise other 
applications performance will suffer from degraded network performance.".

> Add `http.maxReceiveSpeed` to limit `git-receive-pack` receiving
> speed, Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` eivironment
> variable.
> 
s/eivironment/environment/

> The default is unlimited, same if the value is 0 or negative. The
> default unit is Bytes/s, common unit suffixes of k, m, or g are supported.
> 

Wouldn't it make sense for negative speed? Why don't just return error 
if negative speed is set?

> this configuration is valid for `clone`, `fetch`, `pull` commands of the
> https protocol, and only supports libcurl 7.15.5 and above.
> ---
>   http.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/http.c b/http.c
> index 8119247149..12030cf3bc 100644
> --- a/http.c
> +++ b/http.c
> @@ -83,6 +83,9 @@ static const char *ssl_pinnedkey;
>   static const char *ssl_cainfo;
>   static long curl_low_speed_limit = -1;
>   static long curl_low_speed_time = -1;
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +static ssize_t curl_max_receive_speed = -1;
> +#endif
>   static int curl_ftp_no_epsv;
>   static const char *curl_http_proxy;
>   static const char *http_proxy_authmethod;
> @@ -361,7 +364,12 @@ static int http_options(const char *var, const char *value, void *cb)
>   		curl_low_speed_time = (long)git_config_int(var, value);
>   		return 0;
>   	}
> -
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	if (!strcmp("http.maxreceivespeed", var)) {
> +		curl_max_receive_speed = git_config_ssize_t(var, value);
> +		return 0;
> +	}
> +#endif
>   	if (!strcmp("http.noepsv", var)) {
>   		curl_ftp_no_epsv = git_config_bool(var, value);
>   		return 0;
> @@ -974,6 +982,12 @@ static CURL *get_curl_handle(void)
>   				 curl_low_speed_time);
>   	}
>   
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	if (curl_max_receive_speed > 0)
> +		curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
> +				 curl_max_receive_speed);
> +#endif
> +
>   	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
>   #if LIBCURL_VERSION_NUM >= 0x071301
>   	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> @@ -1105,6 +1119,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>   {
>   	char *low_speed_limit;
>   	char *low_speed_time;
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	char *max_receive_speed;
> +#endif
>   	char *normalized_url;
>   	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
>   
> @@ -1196,6 +1213,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>   	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
>   	if (low_speed_time != NULL)
>   		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	max_receive_speed = getenv("GIT_HTTP_MAX_RECEIVE_SPEED");
> +	if (max_receive_speed && !git_parse_ssize_t(max_receive_speed, &curl_max_receive_speed))
> +		warning("failed to parse GIT_HTTP_MAX_RECEIVE_SPEED: %s", max_receive_speed);
> +#endif
>   
>   	if (curl_ssl_verify == -1)
>   		curl_ssl_verify = 1;
> 

Why is there boilerplate #if #endif block for libcurl 7.15.5?

-- 
An old man doll... just what I always wanted! - Clara
