Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85901131E23
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122682; cv=none; b=JQl6qB3ow4PRYGxzdUFB/67KTFDsL3JUDLsKK7fIqJ1yakhqXkB2ia5InxjBfi8D1hBBoptqXzEytsjrLiT3QzKsBmk1TaJPve4xFHuKoNC7+jGELrWEkIWwf0cJTZFAEdtmi3V1ivr7ISZ8irM6KhUp+s6EvLtfBKUo3sB9lJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122682; c=relaxed/simple;
	bh=BOtUQAZKsY3SXnrXid7bETLnGN+3FP0mG+6mZ+kwO2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6vJVDKVu0/6a0h5Xy9Q0MAa9y6du7TJNItOGHZmg7xmQMHYPn0FzjN+AEO22QryhFseD8E0jJ5zHsWNLymXZo2fNaN5cJaLZocBUW7K1cbcaW0RQJQ33H6/t91QqOknFNglGGMOZy9HhWfUmzBX/nRBXSOpE6lwH3kOgrZ9Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7302 invoked by uid 109); 24 Jan 2024 18:57:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jan 2024 18:57:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29634 invoked by uid 111); 24 Jan 2024 18:57:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jan 2024 13:57:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Jan 2024 13:57:54 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
	=?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>,
	git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
Message-ID: <20240124185754.GA21980@coredump.intra.peff.net>
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
 <20240122213410.GA811766@coredump.intra.peff.net>
 <xmqq1qa9rqji.fsf@gitster.g>
 <20240122215954.GA813833@coredump.intra.peff.net>
 <CABPp-BHcdn3+mbPJk8LZvMjPWZ4s-xdUyevrMbgbT4yQpJ_umA@mail.gmail.com>
 <xmqqjznyhd90.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjznyhd90.fsf@gitster.g>

On Wed, Jan 24, 2024 at 09:06:51AM -0800, Junio C Hamano wrote:

> ------ >8 ----------- >8 ----------- >8 ----------- >8 ------
> Subject: ls-files: avoid the verb "deprecate" for individual options
> 
> When e750951e74f updated the documentation to give greater
> visibility to the --exclude-standard option, it marked the
> `--exclude-per-directory` option as "deprecated".  While it
> technically is correct that being deprecated does not necessarily
> mean it is planned to be removed later, it seems to cause confusion
> to readers, especially when we merely mean
> 
>     The option Y can be used to achieve the same thing as the option
>     X, so to those of you who aren't familiar with either X or Y, we
>     would recommend to use Y.
> 
> This is especially true for `--exclude-standard` vs the combination
> of more granular `--exclude-from` and `--exclude-per-directory`
> options.  It is true that one common combination of the granular
> options can be obtained by just giving the former, but that does not
> necessarily mean a more granular control is not necessary.
> 
> State why we recommend looking at `--exclude-standard` when we do so
> in the description of `--exclude-per-directory`, instead of saying
> that the option is deprecated.  Also, spell out the recipe to emulate
> what `--exclude-standard` does, so that the users can give it minute
> tweaks (like "not reading the global exclusion file from core.excludes").

This perfectly sums up the situation from my viewpoint. And I think the
changes you suggest not only remove the confusion over the term, they
lay out the possible options for the user much better.

The patch looks good to me, modulo one minor comment:

> diff --git c/Documentation/git-ls-files.txt w/Documentation/git-ls-files.txt
> index f65a8cd91d..93a0111cfb 100644
> --- c/Documentation/git-ls-files.txt
> +++ w/Documentation/git-ls-files.txt
> @@ -119,8 +119,10 @@ OPTIONS
>  
>  --exclude-per-directory=<file>::
>  	Read additional exclude patterns that apply only to the
> -	directory and its subdirectories in <file>.  Deprecated; use
> -	--exclude-standard instead.
> +	directory and its subdirectories in <file>.  If you are
> +	trying to emulate the way how Porcelain commands work,
> +	using the `--exclude-standard` instead is easier and more
> +	thorough.

As a native English speaker, the phrasing here is awkward to me. I'd
probably say "...emulate the way that Porcelain commands work". Or
alternatively, "emulate how Porcelain commands work".

-Peff
