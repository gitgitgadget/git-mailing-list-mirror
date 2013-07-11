From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: add support for http.<url>.* settings
Date: Thu, 11 Jul 2013 12:26:47 -0700
Message-ID: <7vd2qorj7s.fsf@alter.siamese.dyndns.org>
References: <26507a43bd82855050b90f6a2b9d01bd@f74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 21:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxMW1-00007f-6O
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 21:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3GKT0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 15:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab3GKT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 15:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AEB52F629;
	Thu, 11 Jul 2013 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/cecpfv+qsDsq3dKS8qZTfpZCyA=; b=h/j8RF
	cMQy9YIfccv0sfh7oc9w4dKGHX1+Z62bM4TmhEuqQZkuPC31pnmfBZVxnZueCefl
	bkv/nYlmhpyv/aJsnqzkWk67malriHURznLDND/C4OcJIS7drGOvduQUUB5OsTba
	TGY1bVjMMV/l86/yObI8YNqe3Hip9lD5ood/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAU0Q14aH08JPGUZfEyui0rwEUOPOv1I
	2ozdfUnVKKi7ZNe1Nww62Z/yfJME8zhEbqCVM8VSyiGiUV7gVsnZa12dpS8BFklO
	ZVLGaZrwyZF/DKCOLXgMG4wulJup19aRwNhzKUI6sml4cS+gMcPHbFjnz12PunNT
	pQb/ehaFzq4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B98E2F627;
	Thu, 11 Jul 2013 19:26:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B63852F61D;
	Thu, 11 Jul 2013 19:26:48 +0000 (UTC)
In-Reply-To: <26507a43bd82855050b90f6a2b9d01bd@f74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Thu, 11 Jul 2013 09:47:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4DBA99A-EA5F-11E2-932E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230127>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Longer matches take precedence over shorter matches with
> environment variable settings taking precedence over all.

OK.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b4d4887..3731a3a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1531,6 +1531,17 @@ http.useragent::
>  	of common USER_AGENT strings (but not including those like git/1.7.1).
>  	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
>  
> +http.<url>.*::
> +	Any of the http.* options above can be applied selectively to some urls.
> +	For example "http.https://example.com.useragent" would set the user
> +	agent only for https connections to example.com.  The <url> value
> +	matches a url if it is an exact match or a prefix of the url matching
> +	at a '/' boundary.  Longer <url> matches take precedence over shorter
> +	ones with the environment variable settings taking precedence over all.
> +	Note that <url> must match the url exactly (other than possibly being a
> +	prefix).  This means any user, password and/or port setting that appears
> +	in a url must also appear in <url> to have a successful match.
> +

OK.

> diff --git a/http.c b/http.c
> index 2d086ae..68dc789 100644
> --- a/http.c
> +++ b/http.c
> @@ -30,6 +30,34 @@ static CURL *curl_default;
>  
>  char curl_errorstr[CURL_ERROR_SIZE];
>  
> +enum http_option_type {
> +	opt_post_buffer = 0,
> +	opt_min_sessions,
> +#ifdef USE_CURL_MULTI
> +	opt_max_requests,
> +#endif
> +	opt_ssl_verify,
> +	opt_ssl_try,
> +	opt_ssl_cert,
> +#if LIBCURL_VERSION_NUM >= 0x070903
> +	opt_ssl_key,
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070908
> +	opt_ssl_capath,
> +#endif
> +	opt_ssl_cainfo,
> +	opt_low_speed,
> +	opt_low_time,
> +	opt_no_epsv,
> +	opt_http_proxy,
> +	opt_cookie_file,
> +	opt_user_agent,
> +	opt_passwd_req,
> +	opt_max
> +};
> +
> +static int http_option_maxlen[opt_max];

I understand that this is to keep track of the length of the longest
one that has matched (hence the current candidate).  The name "maxlen"
captures the "longest" part, but "has matched" is somehow lost.

Can we have a better name here please, or at least a comment to
clarify what this variable keeps track of.

>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
> @@ -141,34 +169,99 @@ static void process_curl_messages(void)
>  }
>  #endif
>  
> +static int http_options_url_match_prefix(const char *url, const char *url_prefix)
> +{
> +	/*
> +	 * url_prefix matches url if url_prefix is an exact match for url or it
> +	 * is a prefix of url and the match ends on a path component boundary.
> +	 * url_prefix is considered to have an implicit '/' on the end for
> +	 * matching purposes if it does not already and it is shorter than url.
> +	 * the return value is the length of the match in characters (excluding
> +	 * any final '/') or 0 for no match.
> +	 */
> +	size_t url_len, url_prefix_len = strlen(url_prefix);
> +	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
> +		return 0;

Should "url=http://git.or.xz/git" match "url_prefix=http://git.or.xz/git/"?

> +	url_len = strlen(url);
> +	if (url_len == url_prefix_len || url[url_prefix_len - 1] == '/' || url[url_prefix_len] == '/')
> +		return url[url_prefix_len - 1] == '/' ? url_prefix_len - 1 : url_prefix_len;

Overlong lines that are somewhat hard to read.

> +	return 0;
> +}
> +
>  static int http_options(const char *var, const char *value, void *cb)
>  {
> -	if (!strcmp("http.sslverify", var)) {
> +/*
> + * Macro to ignore matches with a match length less than previously seen
> + * for the same option type and to remember the largest match length seen so
> + * far for each option type
> + */
> +#define CHECK_MATCHLEN(opt) \
> +	if (http_option_maxlen[opt] > matchlen) return 0; \
> +	else http_option_maxlen[opt] = matchlen

Avoid defining a macro _inside_ a function.  Also if you can make it
a static function, that would be much easier to read.

> +
> +	const char *url = (const char *)cb;
> +	const char *key, *dot;
> +	int matchlen = 0;

> +	key = skip_prefix(var, "http.");
> +	if (!key)
> +		return git_default_config(var, value, cb);
> +
> +	/*
> +	 * If the part following the leading "http." contains a '.' then check
> +	 * to see if the part between "http." and the last '.' is a match to
> +	 * url.  if it's not then ignore the setting.  Otherwise set key to
> +	 * point to the option which is the final part after the final '.' and
> +	 * use key in subsequent comparisons to determine the option type.
> +	 */
> +	dot = strrchr(key, '.');
> +	if (dot) {
> +		char *config_url = xmemdupz(key, dot - key);
> +		matchlen = http_options_url_match_prefix(url, config_url);
> +		free(config_url);

Yikes.  http_options_url_match_prefix() could take a counted string
to config_url to avoind this repeated allocation and deallocation,
no?

> +		if (!matchlen)
> +			return 0;
> +		key = dot + 1;
> +	}
> +
> +	if (!strcmp("sslverify", key)) {
> +		CHECK_MATCHLEN(opt_ssl_verify);
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
>  	}
> -	if (!strcmp("http.sslcert", var))
> +	if (!strcmp("sslcert", key)) {
> +		CHECK_MATCHLEN(opt_ssl_cert);
>  		return git_config_string(&ssl_cert, var, value);
> +	}
>  #if LIBCURL_VERSION_NUM >= 0x070903
> -	if (!strcmp("http.sslkey", var))
> +	if (!strcmp("sslkey", key)) {
> +		CHECK_MATCHLEN(opt_ssl_key);
>  		return git_config_string(&ssl_key, var, value);
> +	}
>  #endif
>  #if LIBCURL_VERSION_NUM >= 0x070908
> -	if (!strcmp("http.sslcapath", var))
> +	if (!strcmp("sslcapath", key)) {
> +		CHECK_MATCHLEN(opt_ssl_capath);
>  		return git_config_string(&ssl_capath, var, value);
> +	}
>  #endif
> -	if (!strcmp("http.sslcainfo", var))
> +	if (!strcmp("sslcainfo", key)) {
> +		CHECK_MATCHLEN(opt_ssl_cainfo);
>  		return git_config_string(&ssl_cainfo, var, value);
> -	if (!strcmp("http.sslcertpasswordprotected", var)) {
> +	}
> +	if (!strcmp("sslcertpasswordprotected", key)) {
> +		CHECK_MATCHLEN(opt_passwd_req);
>  		if (git_config_bool(var, value))
>  			ssl_cert_password_required = 1;
>  		return 0;
>  	}
> -	if (!strcmp("http.ssltry", var)) {
> +	if (!strcmp("ssltry", key)) {
> +		CHECK_MATCHLEN(opt_ssl_try);
>  		curl_ssl_try = git_config_bool(var, value);
>  		return 0;
>  	}
> -	if (!strcmp("http.minsessions", var)) {
> +	if (!strcmp("minsessions", key)) {
> +		CHECK_MATCHLEN(opt_min_sessions);
>  		min_curl_sessions = git_config_int(var, value);
>  #ifndef USE_CURL_MULTI
>  		if (min_curl_sessions > 1)
> @@ -177,42 +270,55 @@ static int http_options(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  #ifdef USE_CURL_MULTI
> -	if (!strcmp("http.maxrequests", var)) {
> +	if (!strcmp("maxrequests", key)) {
> +		CHECK_MATCHLEN(opt_max_requests);
>  		max_requests = git_config_int(var, value);
>  		return 0;
>  	}
>  #endif
> -	if (!strcmp("http.lowspeedlimit", var)) {
> +	if (!strcmp("lowspeedlimit", key)) {
> +		CHECK_MATCHLEN(opt_low_speed);
>  		curl_low_speed_limit = (long)git_config_int(var, value);
>  		return 0;
>  	}
> -	if (!strcmp("http.lowspeedtime", var)) {
> +	if (!strcmp("lowspeedtime", key)) {
> +		CHECK_MATCHLEN(opt_low_time);
>  		curl_low_speed_time = (long)git_config_int(var, value);
>  		return 0;
>  	}
>  
> -	if (!strcmp("http.noepsv", var)) {
> +	if (!strcmp("noepsv", key)) {
> +		CHECK_MATCHLEN(opt_no_epsv);
>  		curl_ftp_no_epsv = git_config_bool(var, value);
>  		return 0;
>  	}
> -	if (!strcmp("http.proxy", var))
> +	if (!strcmp("proxy", key)) {
> +		CHECK_MATCHLEN(opt_http_proxy);
>  		return git_config_string(&curl_http_proxy, var, value);
> +	}
>  
> -	if (!strcmp("http.cookiefile", var))
> +	if (!strcmp("cookiefile", key)) {
> +		CHECK_MATCHLEN(opt_cookie_file);
>  		return git_config_string(&curl_cookie_file, var, value);
> +	}
>  
> -	if (!strcmp("http.postbuffer", var)) {
> +	if (!strcmp("postbuffer", key)) {
> +		CHECK_MATCHLEN(opt_post_buffer);
>  		http_post_buffer = git_config_int(var, value);
>  		if (http_post_buffer < LARGE_PACKET_MAX)
>  			http_post_buffer = LARGE_PACKET_MAX;
>  		return 0;
>  	}
>  
> -	if (!strcmp("http.useragent", var))
> +	if (!strcmp("useragent", key)) {
> +		CHECK_MATCHLEN(opt_user_agent);
>  		return git_config_string(&user_agent, var, value);
> +	}
>  
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
> +
> +#undef CHECKLEN
>  }
>  
>  static void init_curl_http_auth(CURL *result)
> @@ -344,7 +450,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	http_is_verbose = 0;
>  
> -	git_config(http_options, NULL);
> +	git_config(http_options, (void *)url);
>  
>  	curl_global_init(CURL_GLOBAL_ALL);
