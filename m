From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Wed, 28 Oct 2015 09:51:12 -0700
Message-ID: <xmqqsi4vkkcf.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-2-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 17:51:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrTwX-00038a-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 17:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbJ1QvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 12:51:17 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159AbbJ1QvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 12:51:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3193D23780;
	Wed, 28 Oct 2015 12:51:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0nFtoo1oPcoJRJ/kDa89xmwboFs=; b=f9qv9y
	AaVeJ3dxCS46tfpsfNVwiRJZkGGbAvDXFnPtVr8fHjPTAvPkFuk9v6jJfecklquf
	9V5+3g1RVKmstnjl+i5ui0CL4BjWCcJHtUuSEN32jJiwuitqiVa0JYbvrfiRpumW
	jGQQclZinpBY8WMg/ayjzHTA831qZICiwTWII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ek1F7vQmWA8TMpmeL6H1PVPu81ofIrUy
	ST39BZ89WQJxGQK5kChIx16Y+arCno1V2dpEdOCaVS3tjgzp9WJKU2cdG7Iz7Pda
	zq1/3ewdPzqQmy5mNE8ZSSQIuMgkl0b24vdhBtXJVc2O9DkhQAqlRRi1C/j4vnHe
	WUn+QxamsIU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29B4A2377F;
	Wed, 28 Oct 2015 12:51:14 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 934DD2377E;
	Wed, 28 Oct 2015 12:51:13 -0400 (EDT)
In-Reply-To: <1446025245-10128-2-git-send-email-k.franke@science-computing.de>
	(Knut Franke's message of "Wed, 28 Oct 2015 10:40:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19347DA0-7D94-11E5-910F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280376>

Knut Franke <k.franke@science-computing.de> writes:

> CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
> with a 307 redirect to an error page instead of a 407 listing supported
> authentication methods. Therefore, allow the authentication method to be set
> using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
> variables http.proxyAuthmethod and remote.<name>.proxyAuthmethod (in analogy
> to http.proxy and remote.<name>.proxy).
>
> The following values are supported:
>
> * anyauth (default)
> * basic
> * digest
> * negotiate
> * ntlm
>
> Signed-off-by: Knut Franke <k.franke@science-computing.de>
> ---

Thanks.

> +http.proxyAuthmethod::
> +	Set the method with which to authenticate against the HTTP proxy. This only
> +    takes effect if the configured proxy URI contains a user name part (i.e. is
> +    of the form 'user@host' or 'user@host:port'). This can be overridden on a
> +    per-remote basis; see `remote.<name>.proxyAuthmethod`. Both can be
> +    overridden by the 'GIT_HTTP_PROXY_AUTHMETHOD' environment variable.
> +    Possible values are:

I see inconsistent indentation here.  Indent with a tab, like you
did your first line, consistently up to this point, perhaps?

> @@ -2390,6 +2413,11 @@ remote.<name>.proxy::
>  	the proxy to use for that remote.  Set to the empty string to
>  	disable proxying for that remote.
>  
> +remote.<name>.proxyAuthmethod::
> +    For remotes that require curl (http, https and ftp), the method to use for
> +    authenticating against the proxy in use (probably set in
> +    `remote.<name>.proxy`). See `http.proxyAuthmethod`.
> +

Likewise (match the style of the surrounding paragraphs).

> diff --git a/http.c b/http.c
> index 7da76ed..4756bab 100644
> --- a/http.c
> +++ b/http.c
> @@ -63,6 +63,22 @@ static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
> +static const char *http_proxy_authmethod = NULL;
> +static struct {
> +	const char *name;
> +	long curlauth_param;
> +} http_proxy_authmethods[] = {

Perhaps call this "proxy_authmethod[]"?  We won't be talking about
any other kinds of proxy authentication method in http.c file, and a
long name like this makes the line unnecessarily long in a nested
loop like you added to init_curl_proxy_auth().

> +	{ "basic", CURLAUTH_BASIC },
> +	{ "digest", CURLAUTH_DIGEST },
> +	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
> +	{ "ntlm", CURLAUTH_NTLM },
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +	{ "anyauth", CURLAUTH_ANY },
> +#endif
> +	// CURLAUTH_DIGEST_IE has no corresponding command-line option in
> +	// curl(1) and is not included in CURLAUTH_ANY, so we leave it out
> +	// here, too
> +};

Please do not use // C++ comments.

> @@ -305,6 +324,37 @@ static void init_curl_http_auth(CURL *result)
>  #endif
>  }
>  
> +static void copy_from_env(const char **var, const char *envname)
> +{
> +	const char *val = getenv(envname);
> +	if (val)
> +		*var = xstrdup(val);
> +}
> +
> +static void init_curl_proxy_auth(CURL *result)
> +{
> +	copy_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");

Unless this helper is used regularly from many other places, is use
makes it harder to follow the flow of the logic, as it does not
offer clear and obvious abstraction, especially with the name
"copy_from_env()".  I was forced to look at the implementation to
see what happens when the environment variable does not exist to
make sure the right thing happens (i.e. http_proxy_authmethod is
unchanged).

> +	if (http_proxy_authmethod) {
> +		int i;
> +		for (i = 0; i < ARRAY_SIZE(http_proxy_authmethods); i++) {
> +			if (!strcmp(http_proxy_authmethod, http_proxy_authmethods[i].name)) {
> +				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
> +						http_proxy_authmethods[i].curlauth_param);
> +				break;
> +			}
> +		}
> +		if (i == ARRAY_SIZE(http_proxy_authmethods)) {
> +			warning("unsupported proxy authentication method %s: using default",
> +			      http_proxy_authmethod);
> +		}
> +	}
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +	else
> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +#endif
> +}

This patch should take what 1c2dbf20 (http: support curl < 7.10.7,
2015-02-03) wanted to do into account.  Having the configuration
variable or the environment variable defined by itself, while
running a Git built with old cURL, shouldn't trigger any warning,
but the entire function should perhaps be ifdefed out or something?

Personally I find it a bit surprising that somebody still cares
about such an old version (7.10.7 is listed on 15 Aug 2003 in the
CHANGES file), but there apparently are happy users.  Let's not
knowingly break them.

> @@ -466,9 +516,7 @@ static CURL *get_curl_handle(void)
>  	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  	}
> -#if LIBCURL_VERSION_NUM >= 0x070a07
> -	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> -#endif
> +	init_curl_proxy_auth(result);

Thanks.
