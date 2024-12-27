Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658213D518
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735335464; cv=none; b=adCxG1qS/+es677nWb9FPMbZsoU0uEWZ+sR3zJOXQoTgC23WjeW7Y8HhmJKNPOb1EUEACSOFvHTpOyR892AUtJx848ITtl4QlbCucneERfP+2oTs2SC2TrGr2qkLknjpZq2WK1qk7XV2BSHnBasqJjYTTvo8ObS2dIjXQRJqcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735335464; c=relaxed/simple;
	bh=0+nsEP9JuSkXml2kd80vWOYQpmXieSUkkcnqLJRfoV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebZYIJyz3udaywJxH8xhvj9gJIHJxJQN1CaOnwEpu/ri1m1YcJ5mSGXr6B5Dx2Lqgn41ypLdTZFPPewZZcGHuJIoA/XvczYpS+8YHdKkyluELaU6PeOEniT0BW7nBweQEHJQPZ5nzhYEM+Oc5xh6CLENbqkhJa+5w01D0VzbdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hvJUsukO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hvJUsukO"
Received: (qmail 11880 invoked by uid 109); 27 Dec 2024 21:37:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0+nsEP9JuSkXml2kd80vWOYQpmXieSUkkcnqLJRfoV4=; b=hvJUsukO1LPqEOvRom2mAqW793SQF8UJAqRNmLdftLmqmU2t6Iq1PFAGYZWpS+auUFO4WJBVW0v5q7e3MBgbKs6HudwevY3Ha1J8qghzZjRvifzT6sw10PbXakG6dap92wcCRj0ljWP7NKi4GqIKmK8oHJDoMVmIkA9P63HJHiJ8Ar/zywic0dbqU74GfaH97sBuoIvkERrVV4PFybE2lJx4+noMbxyrjLbtuqNWhck+DrF+5bVOC0tBVxfsqsnFd3hPd308JSCe+SdLahXE0kU0C4XHZ/I5bSuxFTdG6cv7svJAN4B2X7UUMKz45FxdhYzdPQgCwbFJbRtAP5HzMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Dec 2024 21:37:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18880 invoked by uid 111); 27 Dec 2024 21:37:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Dec 2024 16:37:30 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Dec 2024 16:37:29 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
Message-ID: <20241227213729.GA796141@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c7kubx8.fsf@gitster.g>

On Fri, Dec 27, 2024 at 12:08:03PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Error: shallow.c:537:32: comparison of integer expressions of different signedness:
> > 'unsigned int' and 'int' [-Werror=sign-compare]
> >
> >     537 |  if (!info->pool_count || size > info->end - info->free) {
> >
> > I didn't dig deeper than this.
> 
> What we want to express seems to be:
> 
>     If the region between "end" and "free" is smaller than the
>     required "size" then we are in trouble.
> 
> which can be said more naturally with
> 
>     If the region of size "size" starting at "free" pointer overruns the
>     "end" pointer, we are in trouble.
> 
> So perhaps something like this would help?  We are no longer making
> a comparison between two integers with this rewrite.
> 
>  shallow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/shallow.c w/shallow.c
> index b8fcfbef0f..b54244ffa9 100644
> --- c/shallow.c
> +++ w/shallow.c
> @@ -534,7 +534,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
>  	unsigned nr = DIV_ROUND_UP(info->nr_bits, 32);
>  	unsigned size = nr * sizeof(uint32_t);
>  	void *p;
> -	if (!info->pool_count || size > info->end - info->free) {
> +	if (!info->pool_count || info->end < info->free + size) {
>  		if (size > POOL_SIZE)
>  			BUG("pool size too small for %d in paint_alloc()",
>  			    size);

I doubt it is a practical problem in this instance, but as a general
rule, I think bounds checks like this should avoid using addition
because it can lead to overflow. In this code, imagine that the free
pool was allocated near the end of the address space, but somebody asked
for a very large "size", causing the addition to wrap around.

I think even without that overflow this might be undefined behavior,
because "info->free + size" is forming a pointer that may be outside the
allocated array.

So as a general rule, bounds comparisons like this should be formulated
as "how much free space do we have" compared to "how much are we asking
for". And there "info->end - info->free" is the right way to ask the
first half of that question.

Now where it gets weird with -Wsign-compare is that the pointer
difference is giving us a signed value. Which makes sense in the general
case (you could ask for "info->free - info->end", for example). But we
know that it will always be non-negative because we know that info->free
is <= info->end, coming from earlier in the same allocation.

I doubt there is a way to tell the compiler that (or that a compiler
could even switch to an unsigned ptrdiff type if it knew that). But I
wonder if there is a generalized helper we can devise that would avoid
simply casting here. I guess that could be a checked cast like:

  static inline size_t ptrdiff_to_size(ptrdiff_t v)
  {
	if (v < 0)
		BUG("surprising negative value: %"PRIdMAX, v);
	return (size_t)v;
  }

or even:

  static inline bool has_space(const void *vs, const void *ve, size_t want)
  {
	const char *s = vs, e = ve;
	return want <= ptrdiff_to_size(ve - vs);
  }

I don't love hiding basic things like this behind macros or inlines. But
allocation and bounds comparisons do have gotchas (especially against an
adversary that can try to create pathological situations). Maybe it's worth
having an easy way to do them safely without having to think about each
one. I dunno.

-Peff
