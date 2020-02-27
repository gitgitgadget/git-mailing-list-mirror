Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F5DC4BA2D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED0A2468F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 18:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ufHpDBJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgB0Sb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:31:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59594 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgB0Sb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 13:31:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A1A5C0656;
        Thu, 27 Feb 2020 13:31:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oPp013bE6JITUNbPGNCtiWqowT0=; b=ufHpDB
        JrzuiF6+s33UEunrzRbPetCuzBd8WK5WeuIe6TOubm6AzzC+pQ1FC0hVDJyMithp
        JySO7HkSkBt5XDmslqoVv3l8V0JJ5yqq9G1MkRf5JBKpghlu5IqxYKn5QcoqRt20
        HpM8jsXbZ4oWW91ESx4N4Lw28WXrf7JG5aVFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hWl6OQFzo97cK4qR7mUJIwzdjQsqvzBi
        bZ27GVtTP5URvK6xMaahPqtpwSn0UdnuYRJqdcGG9AuQ72rXQX/67ODJ2r/Ohv/E
        VCLkhkggHz+NIclhptSb2FoSFHHocj09VmoIMBpKvblni8rJpRFZ43CVfeeQcsDM
        +d8MCJ5twU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21895C0655;
        Thu, 27 Feb 2020 13:31:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 478BAC0654;
        Thu, 27 Feb 2020 13:31:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jorge <JALopezSilva@gmail.com>
Subject: Re: [PATCH v2 1/2] http: add client cert for HTTPS proxies.
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
        <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
        <a5d980e7501b1e0ab6f20a97136cd3a58427a139.1582759438.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 10:31:48 -0800
In-Reply-To: <a5d980e7501b1e0ab6f20a97136cd3a58427a139.1582759438.git.gitgitgadget@gmail.com>
        (Jorge Lopez Silva via GitGitGadget's message of "Wed, 26 Feb 2020
        23:23:57 +0000")
Message-ID: <xmqqftevg9uz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BDD93A8-598F-11EA-9840-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +#if LIBCURL_VERSION_NUM >= 0x073400
> +static const char *http_proxy_ssl_cert;
> +static const char *http_proxy_ssl_key;
> +static const char *http_proxy_ssl_keypasswd;
> +#endif
> +static const char *http_proxy_ssl_ca_info;
> +
>  static struct {
>  	const char *name;
>  	long curlauth_param;
> @@ -365,6 +373,20 @@ static int http_options(const char *var, const char *value, void *cb)
>  	if (!strcmp("http.proxyauthmethod", var))
>  		return git_config_string(&http_proxy_authmethod, var, value);
>  
> +#if LIBCURL_VERSION_NUM >= 0x073400
> +	if (!strcmp("http.proxycert", var))
> +		return git_config_string(&http_proxy_ssl_cert, var, value);
> +
> +	if (!strcmp("http.proxykey", var))
> +		return git_config_string(&http_proxy_ssl_key, var, value);
> +
> +	if (!strcmp("http.proxykeypass", var))
> +		return git_config_string(&http_proxy_ssl_keypasswd, var, value);
> +
> +	if (!strcmp("http.proxycainfo", var))
> +		return git_config_string(&http_proxy_ssl_ca_info, var, value);
> +#endif

You may copy around your ~/.gitconfig to multiple hosts, some may
have newer and others may have older versions of libcurl, so it
would be OK for a version of Git built with older libcurl to at
least see and parse configurations meant for newer one, if only
to ignore and discard.

The only two effects these #if/#endif have are (1) they save a tiny
bit of memory, code and runtime cycle on an older platform and (2)
they make the resuting code ugly and harder to read.  I do not think
that the tradeoff is worth it.

>  	if (!strcmp("http.cookiefile", var))
>  		return git_config_pathname(&curl_cookie_file, var, value);
>  	if (!strcmp("http.savecookies", var)) {
> @@ -924,8 +946,14 @@ static CURL *get_curl_handle(void)
>  #if LIBCURL_VERSION_NUM >= 0x073400
>  		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
>  #endif
> -	} else if (ssl_cainfo != NULL)
> -		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
> +	} else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
> +		if (ssl_cainfo != NULL)
> +			curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
> +#if LIBCURL_VERSION_NUM >= 0x073400
> +		if (http_proxy_ssl_ca_info != NULL)
> +			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
> +#endif
> +	}

On this codepath, unlike the config and variable definitions,
#if/#endif is absolutely necessary.

In any case, the code around here is messy, but it is mostly due to
the fact that the existing #if/#endif with if/elseif/... cascade was
messy.  The general idea is

 * We want to honor ssl_cainfo and http_proxy_ssl_ca_info, and use
   CAINFO when set, but

 * When http_schannel_use_ssl_cainfo is not in effect and
   http_ssl_backend is schannel, ssl_cainfo/http_proxy_ssl_ca_info
   business is completely skipped, and these two CAINFO are cleared
   instead.

I do not know if the above is the best code structure to express
that, but at least the way this patch adds code is the least noisy,
I guess.

> @@ -1018,9 +1046,19 @@ static CURL *get_curl_handle(void)
>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
>  #endif
>  #if LIBCURL_VERSION_NUM >= 0x073400
> -		else if (starts_with(curl_http_proxy, "https"))
> -			curl_easy_setopt(result,
> -				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> +		else if (starts_with(curl_http_proxy, "https")) {
> +			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> +
> +			if (http_proxy_ssl_cert != NULL)
> +				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
> +
> +			if (http_proxy_ssl_key != NULL)
> +				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
> +
> +			if (http_proxy_ssl_keypasswd != NULL)
> +				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_keypasswd);

This part is more or less straight-forward.

This is a minor tangent, but I see many "var != NULL" instances used
as the condition to if statements, which we tend to frown upon
(instead just say "if (var) ...").  I know there are already many in
the existing code in this file, but this patch is making it even
worse.

> +		}
>  #endif
>  		if (strstr(curl_http_proxy, "://"))
>  			credential_from_url(&proxy_auth, curl_http_proxy);
