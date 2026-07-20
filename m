Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D783D668C
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540549; cv=none; b=FtM+ar3Lxj54f6JQ3/DbZd7PJ3MVyMiJhX2ZSYtTBtwetBc6YSjLm1EwWLzysBST2ez3zW6vd4vS04w4UD1FOCof3gOZecR+BINSBjjRNyuo+DiOXG1mcPdRruUrkS7J6nXhG2SvvDmcELQCZ7E/cR/NyJopt1q4NQw8yNeKWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540549; c=relaxed/simple;
	bh=/SGdhPDFu4kGHXIQEANWsjFGVd8imD14vLp5Lnm26L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWvDqTDvRrnmnHpQSMgbsD/+2fwlNSdskNCyXd2B+NvNnzbebftwvcTUjnfn4AMiOn340ZWm8YfS5ro2XwvNEDW7FJT23K6bBT+GNNj+i7CiifH2KutkbVG65txXSVvrTAVwASj0sqjjur5B3Ee3z6cMbKtUBU8wrEsf+uBZCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dbpBoQ1X; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dbpBoQ1X"
Received: (qmail 82312 invoked by uid 106); 20 Jul 2026 09:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/SGdhPDFu4kGHXIQEANWsjFGVd8imD14vLp5Lnm26L0=; b=dbpBoQ1XD3m1RdOB6/ZEg3AWezLTy7XnUywxdq6JmQerggJXHiSp2M+MiO6eg70FWkDMsDKKLAtGHqri/VWlAjO+57tP1rGigN+EZgLko49M7S9GyT8Jsqe+I7R9N4N6oCpuMFb1lvO+Puxf+f4yapRhnf1X2di84DPkTZrOVjA61AAFdRGSJYPv5CS3E8LXZ8zQjAMs7WN6+d7EjbZKXhI+cz5yakJ9OgElVzUcI+HhPE8K6k+YKvnc4dsm8ohhip7w36K2n5s1YYpRvn8fpHoECzb9uERilwEG/8eBfrCOihSPJzx4BSqE+HSOPXIF40Fe7YeUgDy7/J9SkEar+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2026 09:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19853 invoked by uid 111); 20 Jul 2026 09:42:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2026 05:42:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 20 Jul 2026 05:42:18 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 3/4] last-modified: check pathspec against Bloom filter
 first
Message-ID: <20260720094218.GA681989@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-3-410418f18614@iotcl.com>
 <alq1Q55ezuN9ZI9j@com-79390>
 <20260718083757.GD22588@coredump.intra.peff.net>
 <alvulw2fk67duo8n@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alvulw2fk67duo8n@com-79390>

On Sat, Jul 18, 2026 at 04:22:31PM -0500, Taylor Blau wrote:

> I think that we could feasibly get rid of "d" in the output in this
> particular case within last-modified. As you note, the command is marked
> EXPERIMENTAL for a reason, after all ;-).
> 
> If we wanted to do that, it should be straightforward to do. I think the
> following (untested) patch would be sufficient:
> 
> --- 8< ---
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index adc7cd8c74..0f0c1d1d17 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -103,7 +103,7 @@ struct last_modified_callback_data {
>  };
> 
>  static void add_path_from_diff(struct diff_queue_struct *q,
> -			       struct diff_options *opt UNUSED, void *data)
> +			       struct diff_options *opt, void *data)
>  {
>  	struct last_modified *lm = data;
> 
> @@ -112,6 +112,11 @@ static void add_path_from_diff(struct diff_queue_struct *q,
>  		struct last_modified_entry *ent;
>  		const char *path = p->two->path;
> 
> +		if (!match_pathspec(opt->repo->index, &opt->pathspec, path,
> +				    strlen(path), 0, NULL,
> +				    S_ISDIR(p->two->mode)))
> +			continue;
> +

Yeah, that was exactly what I was thinking, but I wasn't sure if
match_pathspec() was the right tool. I mean, obviously it sounds like it
should be from the name, but I don't think it is actually what is used
in tree-diffs! There we have tree-walk.c:do_match() which does some
magic. And match_pathspec() is used more for dir.c callers.

I guess the two are supposed to be equivalent, or else we'd have weird
discrepancies between commands. So maybe just a weird existing oddity
that we don't need to worry about here.

There is one other interesting corner case here. If I do this in
git.git, for example:

  git last-modified -t Documentation/technical/

it shows an entry for Documentation/, which we both find weird. And the
patch above would remove that. But it also shows an entry for
Documentation/technical/, which _is_ within the pathspec and would still
be shown after the patch above. That's OK for the optimization we're
talking about (it would be part of the filter key), but I do find it
still a little funny. The invocation above, at least as we used to use
it as blame-tree at GitHub, is really about asking for the entries
inside that directory, not the directory itself.

Perhaps not worth worrying too much about, though. The caller can easily
ignore the extra entry.

> If, on the other hand, we wanted to retain "d" in the output (which I am
> inclined to suggest is a bad idea), we could keep a list of paths which
> are not covered by the given pathspec.

Yeah, your analysis here makes sense, but I agree that it is not worth
retaining "d". Besides reducing our ability to optimize, it is IMHO just
plain confusing to have in the output.

-Peff
