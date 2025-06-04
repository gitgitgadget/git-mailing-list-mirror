Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844520E030
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065802; cv=none; b=HZReojSzKmP44SbRv+GIbTYByTgyZzILDNWKYa9FdAywPfML8E7ZK62FrK4xjXhUC/afm9SWOU3aH8OO5VHTswlVj7M0+5IaYhSYT/txJgirM86Br3nFhVQLGGuZqWNmuirBsjFAQs/KPx+PXT6GfZKyQZzkju/OZU7P0RgyqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065802; c=relaxed/simple;
	bh=lqwF5iQ177IeBlVBNJr4P4XjN0Q4UtJ5F9TEhZ7aobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4LREnjAFnfdr0HIgx8IWsz6/1U/8PMmazyeNp0HIRvUT5mmqwYUNhWJEJaVGrumpyohsZUcEQJu8OwRw/x8OlHt6iaJJ795g/2dlCr1ywo/+GIxLovpXonpTMyth6stTwMbI6j3K2JeWjG5bHlcEZXUPYErJlrnfMrm9zZEM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U0vL5js4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U0vL5js4"
Received: (qmail 13596 invoked by uid 109); 4 Jun 2025 19:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lqwF5iQ177IeBlVBNJr4P4XjN0Q4UtJ5F9TEhZ7aobo=; b=U0vL5js44nMzZsKpEF/SubcqKk4yxXiVjoDdwG+USmdHkA5JKGDqCewJ0ahj2KAL9aL45+HLIGJ+BaA8Qk23jbWvrdbkk+paTC2EQNel4xWa0Mxpbw6ydgVOSUgSIxlpIYT+PE9qjjO6IougHgLj+ffX2xWvXmq3q/CgUHCI/aK5GL2zh6YyOGwykaCnNC//O4Dt4rAdgDpJfc3kcQixWZvmDRUoGMShJZ1G1E76fXCq55DLz9RuY9qLI0XQHbZXtPY0zpry1c48ZPujKySqwKtkR7K4APdvK7RB/d86KLURIwxhwq9f/a5uf5wgAzXrW2oqyzjDvKYUaG858jZtAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 19:36:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12863 invoked by uid 111); 4 Jun 2025 19:36:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 15:36:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 15:36:31 -0400
From: Jeff King <peff@peff.net>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/3] cat-file: add %(objectmode) atom
Message-ID: <20250604193631.GA1500045@coredump.intra.peff.net>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
 <1ff39aa3c6e613137edde9e05321a7df5c165e99.1748890555.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ff39aa3c6e613137edde9e05321a7df5c165e99.1748890555.git.gitgitgadget@gmail.com>

On Mon, Jun 02, 2025 at 06:55:54PM +0000, Victoria Dye via GitGitGadget wrote:

> Add a formatting atom, used with the --batch-check/--batch-command options,
> that prints the octal representation of the object mode if a given revision
> includes that information, e.g. one that follows the format
> <tree-ish>:<path>. If the mode information does not exist, an empty string
> is printed instead.

Overall, this looks good to me. I have a few small comments below,
though I'm not sure if they merit a re-roll or not.

> @@ -345,6 +347,9 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
>  		else
>  			strbuf_addstr(sb,
>  				      oid_to_hex(&data->delta_base_oid));
> +	} else if (is_atom("objectmode", atom, len)) {
> +		if (!data->mark_query && !(S_IFINVALID == data->mode))
> +			strbuf_addf(sb, "%06o", data->mode);
>  	} else
>  		return 0;
>  	return 1;

Looking at this hunk raised a few questions. Fortunately with answers. ;)

First, in other parts of this if/else chain, when mark_query is set we
need to perform some action (usually setting up the object_info
pointers). But we _don't_ need to do that here, since we get the mode
info "for free" from get_oid_with_context(). Good.

Second, how do we reliably get S_IFINVALID? We can see that the
expand_data struct is now initialized with it:

> +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }

But that seems like it would be a bug, since we only initialize it once,
in batch_objects():

> @@ -866,7 +872,7 @@ static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf input = STRBUF_INIT;
>  	struct strbuf output = STRBUF_INIT;
> -	struct expand_data data;
> +	struct expand_data data = EXPAND_DATA_INIT;
>  	int save_warning;
>  	int retval = 0;
>  
> @@ -875,7 +881,6 @@ static int batch_objects(struct batch_options *opt)
>  	 * object_info to be handed to oid_object_info_extended for each
>  	 * object.
>  	 */
> -	memset(&data, 0, sizeof(data));
>  	data.mark_query = 1;
>  	expand_format(&output,
>  		      opt->format ? opt->format : DEFAULT_FORMAT,
>  
>  static int is_atom(const char *atom, const char *s, int slen)
>  {

...and then call batch_one_object() over and over. So at first glance,
doing this:

  (echo HEAD:Makefile; echo HEAD) |
  git cat-file --batch-check='%(objectmode)'

would let the mode from the first object bleed over into the second. But
that doesn't happen, because we overwrite expand_data.mode for each
object unconditionally, here:

> @@ -613,6 +618,7 @@ static void batch_one_object(const char *obj_name,
>  		goto out;
>  	}
>  
> +	data->mode = ctx.mode;
>  	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
>  
>  out:

And there we are relying on ctx.mode, which we get from
get_oid_with_context(), which always falls back to S_IFINVALID if no
mode is available. Good.

But I think that means that the value set in EXPAND_DATA_INIT is never
used, and we could continue to zero-initialize the struct with memset?

That said, it's probably OK to err on the side of over-initializing. The
worst case is probably somebody later reading the code being confused
about the importance of the line. And at best it may prevent a future
code path from unexpectedly reading a funny value.


And on to the third question. In the non-batch code path of
cat_one_file(), we do:

          if (obj_context.mode == S_IFINVALID)
                  obj_context.mode = 0100644;

which made me wonder if we should be harmonizing our behavior. But that
mode is used only for passing to filter_object() and textconv_object().
Neither of which really care about the mode, and this is mostly just
saying "eh, do your regular thing as if it were a blob we found at
--path". I suspect we could get the same effect by just passing a
hard-coded 100644 to those functions, but probably not worth changing
now (and certainly very orthogonal to your patch). But the important
thing is we do not really need to worry about being consistent with this
line. Good.

-Peff
