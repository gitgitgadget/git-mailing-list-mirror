Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDE2E3715
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752640507; cv=none; b=TkqD0Fvz68C6fspJ4mY3MplVISip1WgzBg0hdIs+wnSKkxFwHScL4cxlN/vUtsGSOeNCZZmMZSMoh/SRVmIq6nEmznzoQOIzojjgRfzniuAkceIBVkHleTwT0tPH3vM4duQyzPKOAVyc1FgOJWA09udM8e69EVXvK4zcMvObtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752640507; c=relaxed/simple;
	bh=wybdrK+0Ki325wR8a18KYdtRrYU+mP95tlhjvTeVhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5yonyA3fweGMPFx6KhW6G8xhET5RSEBblqaJ2h4gGJZdxSW9e6rcSxEz6wI7nlZDb1BnwT2IEMeUPZWu0dtpDOip+f9pTzrAgqYNBltE0ZL7NGosX6uC33TLkmYZqJFfnMH5Nx04KBejbbSinAdwbCET2te9DDqBjSB+3nGulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I8N/4zoc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I8N/4zoc"
Received: (qmail 32664 invoked by uid 109); 16 Jul 2025 04:34:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wybdrK+0Ki325wR8a18KYdtRrYU+mP95tlhjvTeVhAE=; b=I8N/4zoc9sdP70LLk55vlyrs49jcJpfv0GevOL3uspem+PBEN9ObuCzXpLrhPiv5GVhbZznxbr5BZ0JRBbiwqQTjSLs/cT7q+RuO0DHWTc7W0+8y6KVTXW2nnit3w0BbUdQfQpS0lGmI2jQZ/OMO/SddY5SVUVyBTy9l2PGHYXn9H2rQjLkQaiZQhaIatyp3TX4tFouBiu/2rCsKpIsOOrJe3eSqHvTAywiHRN3FNwwJwW6Nz0QNjJhctxo9GhJvizLBlBcVwyMQEehoCk1JbDZ2XFDA4Dx+7iAEd6w7SgZyyphBspTqST5BdYtHOZ4P2K+3mVmZcvJkuQFmy9DWnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 04:34:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9094 invoked by uid 111); 16 Jul 2025 04:34:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 00:34:59 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 00:34:55 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] config: remove unneeded struct field
Message-ID: <20250716043455.GA1394788@coredump.intra.peff.net>
References: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>

On Tue, Jul 15, 2025 at 03:00:56PM +0100, Phillip Wood wrote:

> We could fix this by interning the "path" field as we do
> for the "filename" field but the "path" field is not actually
> needed. It is populated with a copy of the "path" field from "struct
> config_source". That field was added in d14d42440d8 (config: disallow
> relative include paths from blobs, 2014-02-19) to distinguish between
> relative include directives in files and those in blobs. However,
> since 1b8132d99d8 (i18n: config: unfold error messages marked for
> translation, 2016-07-28) we can differentiate these by looking at the
> "origin_type" field in "struct key_value_info". So let's remove the
> "path" members from "struct config_source" and "struct key_value_info"
> and instead use a combination of the "filename" and "origin_type"
> fields to determine the absolute path of relative includes.

Nicely explained. The interesting bit of the patch is here:

> @@ -173,14 +172,14 @@ static int handle_path_include(const struct key_value_info *kvi,
>  	if (!is_absolute_path(path)) {
>  		char *slash;
>  
> -		if (!kvi || !kvi->path) {
> +		if (!kvi || kvi->origin_type != CONFIG_ORIGIN_FILE) {
>  			ret = error(_("relative config includes must come from files"));
>  			goto cleanup;
>  		}

...which is where we no longer need the separate variable to make the
path/filename distinction.

Just playing devil's advocate, my big questions would be:

  - can filename ever be unexpectedly NULL, even if type is
    CONFIG_ORIGIN_FILE?

  - do we always set filename anywhere we would have set path?

It looks like it was usually set here:

> @@ -1036,7 +1034,6 @@ static void kvi_from_source(struct config_source *cs,
>  	out->origin_type = cs->origin_type;
>  	out->linenr = cs->linenr;
>  	out->scope = scope;
> -	out->path = cs->path;
>  }

and there we'd always set out->filename from cs->name (just outside of
the context shown here). And we do so with strintern() which would
segfault if cs->name were NULL, so I think we can always depend on it. ;)

>  static int do_config_from_file(config_fn_t fn,
>  			       const enum config_origin_type origin_type,
> -			       const char *name, const char *path, FILE *f,
> -			       void *data, enum config_scope scope,
> +			       const char *name, FILE *f, void *data,
> +			       enum config_scope scope,
>  			       const struct config_options *opts)
>  {
>  	struct config_source top = CONFIG_SOURCE_INIT;
>  	int ret;
>  
> +	if (origin_type == CONFIG_ORIGIN_FILE && (!name || !*name))
> +		BUG("missing filename for CONFIG_ORIGIN_FILE");
> +

OK and here we have a sanity check that our callers will always feed an
actual name. The main caller being...

> @@ -1891,7 +1890,7 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
>  	f = fopen_or_warn(filename, "r");
>  	if (f) {
>  		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
> -					  filename, f, data, scope, opts);
> +					  f, data, scope, opts);
>  		fclose(f);
>  	}
>  	return ret;

...this one. Which previously passed "filename" as both the "name" and
"path" fields, so they were always identical.

Makes sense, and the patch looks good to me. Thanks for finding it!

-Peff
