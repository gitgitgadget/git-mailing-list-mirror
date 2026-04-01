Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281C32C924
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071867; cv=none; b=JSwykuMndyG/RUdfrt5CSsHed07CDLJbtMZlbKlstV1Exd7rmWg9+d0Z5Vr+VyQ3HqjFOOSpJEWpcq0gz0T36b+vb6QAoveWNK4H602kc/ZbE4d+RpSur5DXqFfu1sJnSIzhl0TLAebPkPpv6ume0H0tR+4zu5mxUCLn7ENgtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071867; c=relaxed/simple;
	bh=ySttVzUM9wFrsBZAb5q6cAEHR0elCXF3PmKDcWEoa1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfgeuGlNBMn8Fq2w+hfoKbA1J1IXC62b/rEgJuTKjMG9JMtGQu+jyN96QP7mGjijiA80YsuIuS6/yGInVwjefrj7fuQaU+hNeisy8BY5XjVcLdYITNUtBaURwBJ7J4MZ8pjjn/0O+dXiummvu3wrfJoTynoQB8nzg8oMEsDu5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EKgekFBb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EKgekFBb"
Received: (qmail 214593 invoked by uid 106); 1 Apr 2026 19:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ySttVzUM9wFrsBZAb5q6cAEHR0elCXF3PmKDcWEoa1U=; b=EKgekFBbIqHKcF5vzKiJciqnoa/TPQdTLlHpeqS7bpXkwyrsh0qbyejNsytrtx/Y+L5yWqDsdzBcfbCDCDw+knEJ+po2cfqWYpE4gzl1LZEpkJlr/qShDhmCJmf+QQOh5366ddscdym+SHrmV5caf9HLLcaL3gLT4s9H+Hbn4JTW6wPRR18WfxEGCV2lXkdN6zUAwfZop8kiYjwPCg3OvckhHsLb47PMLaIbC1XwYZJnEwa1c+zLQusXY5ZbDg4Wu6Gbg9X0vbYmhUu8s/wCfT1rNwmdLgV7XUC1DKGYM89bbrpUCkT0RKGNvves4M3mAyAfIlSKtXO9EErvwQxZ0g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Apr 2026 19:24:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 342795 invoked by uid 111); 1 Apr 2026 19:24:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2026 15:24:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Apr 2026 15:24:23 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 08/12] skip_prefix(): check const match between in and
 out params
Message-ID: <20260401192423.GA2905896@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235017.GH2328529@coredump.intra.peff.net>
 <14a417c6-fc80-4a7e-993d-57fff10896f8@gmail.com>
 <b77be594-83b4-4d9b-9f89-569f1f335d61@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77be594-83b4-4d9b-9f89-569f1f335d61@gmail.com>

On Wed, Apr 01, 2026 at 03:04:10PM +0100, Phillip Wood wrote:

> On 01/04/2026 14:17, Phillip Wood wrote:
> > On 01/04/2026 00:50, Jeff King wrote:
> > > 
> > > +/*
> > > + * Check that an out-parameter that is "at least as const as" a matching
> > > + * in-parameter. For example, skip_prefix() will return "out" that
> > > is a subset
> > > + * of "str". So:
> > > + *
> > > + *  const str, const out: ok
> > > + *  non-const str, const out: ok
> > > + *  non-const str, non-const out: ok
> > > + *  const str, non-const out: compile error
> > > + *
> > > + *  See the skip_prefix macro below for an example of use.
> > > + */
> > > +#define CONST_OUTPARAM(in, out) \
> > > +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
> > > +#define skip_prefix(str, prefix, out) \
> > > +    skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))
> > 
> > This is clever but it changes the behavior of skip_prefix() which is
> > documented as not touching out if it returns false.
> 
> Sorry, I've just realized we always take the other branch so this does not
> change the behavior and is in fact a nice solution to the problem.

Yeah, exactly. I was curious if the dead branch would be left in place,
but gcc seems to prune it even at -O0.

I also pondered whether:

  (*out = in,out)

might be a problem, but I think it is OK. The "," is a sequence point,
so it is well defined (of course we would never run this code anyway,
but if we have undefined behavior in the code at all, it may cause
confusing effects).

For reference, this is the more complicated one I came up with:

  /*
   * Note that builtin_types_compatible_p() counts "char" and "const
   * char" as the same type. So we deref and construct our own pointer
   * with const to find out it "x" is const, and then either compare
   * x and y exactly (if it is const, they must both be) or dereferenced
   * (which lets y be either const or not).
   */
  #define CONST_COMPATIBLE(x, y) \
          (__builtin_types_compatible_p(typeof(x), const typeof(*(x)) *) ? \
           __builtin_types_compatible_p(typeof(x), typeof(y)) : \
           __builtin_types_compatible_p(typeof(*(x)), typeof(*(y))))

I also tried using a gcc statement-expression and _Static_assert to get
a nicer message, like this:

  #define CONST_OUTPARAM(in, out, in_name, out_name) ({ \
          _Static_assert(CONST_COMPATIBLE((in),*(out)), \
                         in_name " is not const-compatible with " out_name); \
          (const typeof(*(in)) **)(out); \
  })
  #define skip_prefix(str, prefix, out) \
          skip_prefix(str, prefix, CONST_OUTPARAM((str), (out), #str, #out))

It does produce slightly nicer output:

  foo.c: In function ‘bad’:
  foo.c:8:9: error: static assertion failed: "my_in_var is not const-compatible with my_out_var"
      8 |         _Static_assert(CONST_COMPATIBLE((in),*(out)), \
        |         ^~~~~~~~~~~~~~
  foo.c:13:34: note: in expansion of macro ‘CONST_OUTPARAM’
     13 |         skip_prefix(str, prefix, CONST_OUTPARAM((str), (out), #str, #out))
        |                                  ^~~~~~~~~~~~~~
  foo.c:16:9: note: in expansion of macro ‘skip_prefix’
     16 |         skip_prefix(my_in_var, "foo", my_out_var);

but I don't think the extra complexity and portability headache is worth
it.

-Peff
