Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E51DF26E
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760076519; cv=none; b=h+3pdw4wNBS4y5plxZLTqXzEugW1xQaJ5mNMUu5y+aUSXDtffKafdVCxcDzYB1sb5dL+GFJfoB6fbUSJ3SvwepJC9FdEEb5HbuQRESwZrV8plvqgGSsLUWR8YynT1KD/KNqXdd3fjnQbrhg86ttabGjTCX2i7nzsBfuQ/qfQbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760076519; c=relaxed/simple;
	bh=yx/C5VnjKEmsN5e2GtzVpzhBtwvyPQNG6zzywuBL7Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVNIS4x9d+ue8Mqtc5M05gx3J/s3UqeuWRDrul5RC+en+CDOpwfN9Hd/prEiriDhpFdhBRtmftKVH7DqVOJK0OjfoSiYG9iZopqnzwHpYCNtRt8tWJpfgkpbIa1zGDGRYZu6Z6mlWSCQXHoRXxMdqr2z3ejUBgsJAFSnlIMrsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RcgEGW/Y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RcgEGW/Y"
Received: (qmail 182351 invoked by uid 109); 10 Oct 2025 06:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yx/C5VnjKEmsN5e2GtzVpzhBtwvyPQNG6zzywuBL7Sk=; b=RcgEGW/YYjseE/rhp/GtlfKYYAPTk6IX07/RjyffpGTPFAXCY7Lf+Q+TMgLrNop8b570dlUEdHiDuz9ISm6ak5hzQjjwDrOr5bS+4NE6JJQS51vm4dClCRV0j6EwsDjcB3QIFizYuZYLt8wgZics3Z0kPu63KgHGvAv8QX3p5kfb4kbGansIZ7xCbkNcG0EdcEQkrmaxEay3WZeTLGGGZY7muRLDz1rBNAHBlqBKVX7dOagqEGV6HaFLZfzwHLNP4w7fjoyyjKrrtHf8E0KN9/eybiK8RTDdTP1KkrZ8Fd6xTyRROAve5MafWP2p6xACvJ1V7tLl1ukD9ol/R3yy8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 06:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283485 invoked by uid 111); 10 Oct 2025 06:08:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 02:08:37 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 02:08:36 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 19/49] repack: remove 'existing_packs' API from the
 builtin
Message-ID: <20251010060836.GG1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:23PM -0400, Taylor Blau wrote:

> --- a/repack.h
> +++ b/repack.h
> @@ -2,6 +2,7 @@
>  #define REPACK_H
>  
>  #include "list-objects-filter-options.h"
> +#include "string-list.h"
>  
>  struct pack_objects_args {
>  	char *window;
> @@ -31,4 +32,38 @@ void pack_objects_args_release(struct pack_objects_args *args);
>  void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
>  				  const char *base_name);
>  
> +struct repository;
> +struct packed_git;
> +
> +struct existing_packs {
> +	struct repository *repo;
> +	struct string_list kept_packs;
> +	struct string_list non_kept_packs;
> +	struct string_list cruft_packs;
> +};

Earlier, I saw remove_redundant_pack() got namespaced with a "repack_"
prefix. Which I think makes sense, since it's a pretty generic name and
the symbol now has global visibility. But none of this existing_packs
stuff got the same treatment.

I don't know how much it matters. I certainly have no plans to call
something existing_packs elsewhere in the code, but I do wonder if the
naming should make it more clear this is all repack-related.

-Peff
