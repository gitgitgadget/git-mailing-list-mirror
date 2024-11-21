Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0282890
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179981; cv=none; b=MtA91TEHd1ChWGzQ04FJ4aRnPzHIqWorI8275Ko6fYxySPqDOHIFZreofpUuFw4SIlszjKu/+cc7BWCI2jjQNQiKGpaFI1H3fEwWrcw78fFgJ/whtNzES335ehpvl0BM+2Kx+hjAL3ub//iBL7WjXwrL+//y2JgvaI6bN/doGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179981; c=relaxed/simple;
	bh=ZFz5y+UfPr3JLohl2KUPo9ZJ+tHP7FFZfLR4qd29ojA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soPl3W7eIlretscT9PvKHL31nAVIexU2wNc5y/VKFMJA6OqCYgDgQ6R1nKpBxipUtgfKdZ+oKyL0QkLiXTuY5kSWiQfdlPL7ZDO+33iHl+i07dJqE+ESeMoykI0wi3NK3JpWqNBXaEd8sJ3ejZ5NsjV9pUuXCTAV9g5NvEdk0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SRT63mnB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SRT63mnB"
Received: (qmail 30098 invoked by uid 109); 21 Nov 2024 09:06:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZFz5y+UfPr3JLohl2KUPo9ZJ+tHP7FFZfLR4qd29ojA=; b=SRT63mnBEbkfuWLEJmkPMyQmKwAyjb5yO3mHgCzG8sCmAZguNmuAylxtEqOZi4VYtWI+8IqdRMBNy9Hky88xXzhPMfOtyMLzogc9mS5gLlt4GuU8+psHMScwvC4S44a6NynNduPXI34k82p0N6yZO8EtbViHFubvepcrjRu0AAK3ItfgUqY7Vhbk0YAJcPxXy6p8LchHy1efzPyq+AJXdI35G8zEF4K1tIGatyDRytByQK1x7XljAwxfHpwk+4vfkaDsRUgZ9nn3HYO5nVk/6+jFqtVKVaJCWk94NNMptK0jKis5TCuXi415V+J6UzVOCkcX+k9vN1kgZMmrHEwKJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 09:06:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22505 invoked by uid 111); 21 Nov 2024 09:06:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 04:06:21 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 04:06:15 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v7 7/9] config: make `delta_base_cache_limit` a
 non-global variable
Message-ID: <20241121090615.GA602681@coredump.intra.peff.net>
References: <cover.1731323350.git.karthik.188@gmail.com>
 <1bdc34f4d8161a3b70f21124cb857908e4fac53c.1731323350.git.karthik.188@gmail.com>
 <Zz5oSqu8IlWbZHvr@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz5oSqu8IlWbZHvr@nand.local>

On Wed, Nov 20, 2024 at 05:52:58PM -0500, Taylor Blau wrote:

> On Mon, Nov 11, 2024 at 12:14:07PM +0100, Karthik Nayak wrote:
> > @@ -1697,6 +1701,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
> >  	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
> >  	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
> >  	int base_from_cache = 0;
> > +	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
> > +
> > +	repo_config_get_ulong(r, "core.deltabasecachelimit", &delta_base_cache_limit);
> >
> >  	write_pack_access_log(p, obj_offset);
> >
> 
> Hmm. This repo_config_get_ulong() call will look for the configset entry
> in a hashmap which is faster than parsing the configuration file from
> scratch every time, but still expensive for my taste in a function as
> hot as unpack_entry().
> 
> Should this also go in the_repository->settings instead? That way we
> have a single field access instead of a hashmap lookup (with multiple
> layers of function calls between us and the actual lookup).

Good catch. I missed this one when making a similar argument for the
packed_git variables.

-Peff
