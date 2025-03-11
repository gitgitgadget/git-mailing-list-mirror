Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DA1EB182
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734373; cv=none; b=PcV6qvklIwlyDWrGj3q3JsXZjGE8bE55vaPG7GfvMkUMdcnPCV+6U8Ia8fGn4l42TjzKoD+ibx8OWgsUhzcgrVQjlXfjbrxxjFI0807IpgQVH9LB15pclaVeo5MUuuVK6+ZuNFOc2X6rEI9juOptq7SsrzU5TfoO5IWA4iY6d9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734373; c=relaxed/simple;
	bh=7RGSXaz9DIzs3u1L4j5k6EtVnaQ+KW8qgj94rApx/2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3t6eaOxNc9/PO1RDmtpeMrw/PgKzMNwpDSwO44eZBtJVvSp2eioCMhJP/3H3FttyE4ezsupo/6JhKOBPPVwX7WHksZXXgggzvYPTCKy5b/5g/atMObbNXyU1GtmieyfVKVwr9XuTKe49ylqrgmttjPQ6uy1ZyrC5TuSVawf5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bLhk1+yq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bLhk1+yq"
Received: (qmail 4510 invoked by uid 109); 11 Mar 2025 23:06:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7RGSXaz9DIzs3u1L4j5k6EtVnaQ+KW8qgj94rApx/2Q=; b=bLhk1+yqa9cj5x16PVWjO5W3V6eFR3/eE4bTSL9b8cwJmSXyI0hlxLZ8vB1RkcF4HgsF+sczQJO3+NmTazj214M7j1jn5FWUGDVLHCkHceov9e7Zqmi7EhUrD8MCsXBl7C9vvtCSQBODT9sCZuJUYGmpgMl5sXeGRHL9sJ1pEv1Hvyn+x/LGHzRuouMMN5HQuQ+0BB7aL9k6oeEGbPVXw8djDgPpf1gp7KgPPEaJ4OzPFNz697js29Ho5LBVEHDLV8KGEsRtrR2YMCnQdtL85S0oqdn+t9zgqSIg5evdmvu8XRVRKzhMRAcepBsdss9aqFFz0zZNVPWiK8PHCKgSNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Mar 2025 23:06:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20406 invoked by uid 111); 11 Mar 2025 23:06:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Mar 2025 19:06:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Mar 2025 19:06:01 -0400
From: Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is
 missing
Message-ID: <20250311230601.GA72712@coredump.intra.peff.net>
References: <20250310074053.1886097-1-christian.couder@gmail.com>
 <20250311152413.1059343-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311152413.1059343-1-christian.couder@gmail.com>

On Tue, Mar 11, 2025 at 04:24:13PM +0100, Christian Couder wrote:

> Using strvec_push() to push `NULL` into a 'strvec' results in a
> segfault, because `xstrdup(NULL)` crashes.
> 
> So when an URL is missing from the config, let's push an empty string
> instead of `NULL` into the 'strvec' that stores URLs.

Is a configured remote with out a url key really a missing url, though?
In other contexts it defaults to the name of the remote. E.g.:

  # make a repo so "foo" is a valid url
  git init foo
  git -C foo commit --allow-empty bar

  # configure a fetch refspec, but no url!
  git init
  git config remote.foo.fetch '+refs/heads/*:refs/remotes/foo/*'

  # now fetching will use the configured refspec with a url of "foo"
  git fetch foo

  # and git-remote will report it, along with its url
  git remote ;# shows "foo"
  git remote --get-url foo ;# also shows "foo"

This is obviously a weird thing to be doing, so I admit I don't really
care all that much. But it feels like the most natural thing is just:

diff --git a/promisor-remote.c b/promisor-remote.c
index 6a0a61382f..761eb1dbd5 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -327,7 +327,7 @@ static void promisor_info_vecs(struct repository *repo,
 		char *url_key = xstrfmt("remote.%s.url", r->name);
 
 		strvec_push(names, r->name);
-		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
+		strvec_push(urls, git_config_get_string(url_key, &url) ? r->name : url);
 
 		free(url);
 		free(url_key);

> We could have modified strvec_push() to behave like
> strvec_push_nodup() and accept `NULL`, but it's not clear that it's
> the right thing to do for the strvec API. 'strvec' is a kind of NULL
> terminated array that is designed to be compatible with 'argv'
> variables used on the command line. So we might want to disallow
> pushing any `NULL` in it instead.
> 
> It's also not clear if `xstrdup(NULL)` should crash or BUG or just
> return NULL.

We have xstrdup_or_null() for the latter suggestion. There was some
light discussion at the time about having xstrdup(NULL) handle this
automatically:

  https://lore.kernel.org/git/20150112231231.GA4023@peff.net/

but it was mostly negative. I don't think anybody really dug into the
thought experiment beyond a general "it might propagate NULL places you
wouldn't expect" vibe, though.

For the same reason I'd be a little hesitant to bless NULLs inside
strvec structures. I think "nodup" allowing them is mostly an unintended
consequence.

> For all these reasons, let's just focus on fixing the issue in
> "promisor-remote.c" and let's leave improving the strvec API and/or
> xstrdup() for a future effort.

This part I certainly agree with. ;)

>  	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> -		char *url;
> +		char *url = NULL;
> +		const char *url_pushed = "";
>  		char *url_key = xstrfmt("remote.%s.url", r->name);
>  
> +		if (!git_config_get_string(url_key, &url) && url)
> +			url_pushed = url;
> +
>  		strvec_push(names, r->name);
> -		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
> +		strvec_push(urls, url_pushed);
>  
>  		free(url);

Probably not super important, but while reading this I noticed that
using git_config_get_string_tmp() would make the memory management a
little simpler (since you do not need to free "url", you are free to
point it to at the empty string and do not need a separate url_pushed).

-Peff
