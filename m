Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B81EBFF7
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498627; cv=none; b=XMQk9LGjVoV2Ih3UHU3A6ONh29TtuvxO/9bbik4i/vwRHZCFPYkE7PJ/dWRIbiqyiTv9SBkEaZ2sp9dTLu4IKbHHS629MBnvnZMc4HviTXU4+IqL4zndzBHajyWaVnlm4rtIveZIGiCq8zZVEq5iCAQFyvcTBjBrtAg14iyCEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498627; c=relaxed/simple;
	bh=+sFe3I2Xexl43GeJjAGUPsLANyy5nfexFdYlQX+J7TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5MVxttcbidu0QjdXDgpMql2gnHp4J9bpOpX6hgucUS00NA9EJw9V011OntxUv0xxHThFw9KDBz7bAJSyvplqrxBJOxPJqZzMLY6yEQgtWc1t2Y3MK15BP8EE4UXShD9/tMWjc89gJ1pPaH9gBQdXbH5S6ZjbDQk6cxcwUMahtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N/HFN96u; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N/HFN96u"
Received: (qmail 20977 invoked by uid 109); 1 Apr 2025 09:10:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+sFe3I2Xexl43GeJjAGUPsLANyy5nfexFdYlQX+J7TA=; b=N/HFN96u7nlYzsALJZ5KYWe+HcRE/WgdBPcFod99yv1EwkD9vHbPQPLb3AHQsN8jQEJb5oEVzGjmboztDxf1E6qH6ey7Dv8WMGtD1WYujJNKmDqM5t3bgbHat82qGqTeaqekbuR7JZ0mKN07zJLJBD/EgZW1W6ivNBpvbN/5abhSMuUvyjtiR4ATnEhDGFz6py57zsyaPcfLNwnFE/FY3hKX0mGob+bgtv1uhOIRyInOzn7LEdVEQnWjqI3VBEp8WmZAq7HyIha0IvcR8WzUCUatDoOtXfpN1pBjvAOowT1xToTFEh9lsaESx7wcgoZo/BNCwYDvUKk/U4e69TsEwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Apr 2025 09:10:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16610 invoked by uid 111); 1 Apr 2025 09:10:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Apr 2025 05:10:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Apr 2025 05:10:20 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] http.c: introduce `set_long_from_env()` for
 convenience
Message-ID: <20250401091020.GA21089@coredump.intra.peff.net>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
 <2e39a78e87edaf8f9842e510d05047dce647f4af.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e39a78e87edaf8f9842e510d05047dce647f4af.1742423021.git.me@ttaylorr.com>

On Wed, Mar 19, 2025 at 06:23:50PM -0400, Taylor Blau wrote:

> +static void set_long_from_env(long *var, const char *envname)
> +{
> +	const char *val = getenv(envname);
> +	if (val) {
> +		long tmp;
> +		char *endp;
> +		int saved_errno = errno;
> +
> +		errno = 0;
> +		tmp = strtol(val, &endp, 10);
> +
> +		if (errno)
> +			warning_errno(_("failed to parse %s"), envname);
> +		else if (*endp || endp == val)
> +			warning(_("failed to parse %s"), envname);
> +		else
> +			*var = tmp;
> +
> +		errno = saved_errno;
> +	}
> +}

If we are going to add error checking, should it be reusing the existing
code in parse.[ch]? As a bonus, that would support units like "K" (which
could perhaps be useful for LOW_SPEED_LIMIT).

We'd need to extend that code for "long" (it has wrappers for "int" and
"unsigned long", but not "long). But that seems like a good thing
overall. Something like:

diff --git a/http.c b/http.c
index 0c9a872809..a40e45e9cb 100644
--- a/http.c
+++ b/http.c
@@ -1256,10 +1256,15 @@ static void set_from_env(char **var, const char *envname)
 	}
 }
 
+static void set_long_from_env(long *var, const char *envname)
+{
+	const char *val = getenv(envname);
+	if (val && !git_parse_long(val, var))
+		warning(_("failed to parse %s"), envname);
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
-	char *low_speed_limit;
-	char *low_speed_time;
 	char *normalized_url;
 	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 
@@ -1338,12 +1343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
 
-	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
-	if (low_speed_limit)
-		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
-	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
-	if (low_speed_time)
-		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
+	set_long_from_env(&curl_low_speed_limit, "GIT_HTTP_LOW_SPEED_LIMIT");
+	set_long_from_env(&curl_low_speed_time, "GIT_HTTP_LOW_SPEED_TIME");
 
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
diff --git a/parse.c b/parse.c
index 7a60a4f816..4d9758132e 100644
--- a/parse.c
+++ b/parse.c
@@ -116,6 +116,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
+int git_parse_long(const char *value, long *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(long)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_ssize_t(const char *value, ssize_t *ret)
 {
 	intmax_t tmp;
diff --git a/parse.h b/parse.h
index 6bb9a54d9a..0e536536a2 100644
--- a/parse.h
+++ b/parse.h
@@ -4,6 +4,7 @@
 int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+int git_parse_long(const char *, long *);
 int git_parse_int(const char *value, int *ret);
 int git_parse_int64(const char *value, int64_t *ret);
 int git_parse_double(const char *value, double *ret);

You could even add git_env_long() to match the existing git_env_ulong(),
although:

  - that family of functions calls die() on error, rather than warning

  - the calling convention is a bit different; it always assigns the
    result, but takes a default value. So you'd need to pass in the
    existing value, which is a little awkward:

      curl_low_speed_limit = git_env_long("GIT_HTTP_LOW_SPEED_LIMIT",
				          curl_low_speed_limit);

-Peff
