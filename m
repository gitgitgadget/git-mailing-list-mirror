Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439611713
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078593; cv=none; b=tt7pX34k8EvCICC3+4ntRKIN3FKQFUXEqdKahCr34C0VvyKY1gHXhCOCQwmwQ7Xsmg80huAI7ZKWw3JgJKv4zp6+A4jvGW27oBgKNI6hRw3h+ocNbJMuON99Glh4Uq6Tf2L0vlZ2KDV9H6o/zBVfgfi7LUiMcHHCgGEqwdOnv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078593; c=relaxed/simple;
	bh=bStUHICnhZPMlGdS+VX9In0NgUMD2MBrLbi/J2X/vU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqWTHUm1w3XqrRZ0VJEabkYCe9vg8B1JiMe8s8gOpreuZWcyRWbUPOSQa3EGpyrPPcXLzZBqIstdDxrCMIRu1BpKshOcdkxP/mXCsu1pFimHs8VTP445Z/C2gGx9NKxAu/S6UgkrpYFPdtFRW5T0G0yY6p7lgxGvc1nJKknHoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WDmhFcjA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WDmhFcjA"
Received: (qmail 217455 invoked by uid 109); 5 Sep 2025 13:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=bStUHICnhZPMlGdS+VX9In0NgUMD2MBrLbi/J2X/vU8=; b=WDmhFcjAmKClVH+JrwmH9jOHxmkCx2IV/W0+elVfucHPdAlNKHWlhdp+fGhEZ37Gxso7GYcAqhKKqSFuxFbmVb4rz70P+JPKhRIoJXV6eNSLxqc5+z3VLEmVoC+A3un0J+sUFsAtB3DExmwBWkvH062tGOh3Zlspr3xruYJITOn6KF2Q2UQhFijsprekyg7JP2iIUzZUVzQ7EWPrhxbG3iepFfr7zLX2xwD79l3HnpoOOy9rKzUNmEDGumdVjLlt1V5s3wZdfJYuoI4VhkcEV2J6EWkus5xL6Tc0Sxp+LD7uSl1kZckImuK1yzU7EpFIrliEvqs4ED+7KvxcgVtIqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Sep 2025 13:23:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 374746 invoked by uid 111); 5 Sep 2025 13:23:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Sep 2025 09:23:09 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Sep 2025 09:23:09 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
Message-ID: <20250905132309.GC596956@coredump.intra.peff.net>
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net>
 <xmqqjz2d7t2q.fsf@gitster.g>
 <8f831259-7372-4357-b059-cc21f7a04864@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f831259-7372-4357-b059-cc21f7a04864@gmail.com>

On Fri, Sep 05, 2025 at 02:02:39AM +0200, ノウラ | Flare wrote:

> > +    if (!s) return;
> 
> However, I agree with Peff. After calling alloc_state_free_and_null(&foo)
> Having foo == NULL is an expected behavior, especially since the function
> Is designed to free the memory and null out the caller’s pointer using
> A double pointer ensuring the helper is idempotent
> 
> So, calling it again on the same pointer is safe because it simply
> no-ops if the memory is already freed
> 
> Regarding the sanity check, it should be:
> 
> + if (!*s) return;

With the correction in your follow-up that this should be:

  if (!*s_) return;

I agree that is the right thing. But it is equivalent to:

  if (!s) return;

since we'll have just assigned "s". Which one to choose is purely a
matter of style. Using "*s_" perhaps makes it more clear that we are
sanity-checking the input (and could happen even before we assign "s").
Using "s" is consistent with the rest of the function in working with
the more direct pointer value. I am happy with either.

> The reasoning is the following:
> 
> => s is the double pointer (the address of the caller’s pointer)
> => *s is the actual pointer to the memory we want to free
> 
> Thus, we check !*s to allow the function to safely handle already-NULL
> pointers
> But if we instead checked !s then we would be testing whether the caller
> passed
> A NULL double pointer which is a programmer error
> So silently returning on !s would hide a bug

I think this is wrong. "s" is the value we would have allocated from
alloc_state_new(), and what we are actually interested in freeing. We
only see the double-pointer "s_" because we want to modify the caller's
containing pointer.

The FREE_AND_NULL() macro does not itself have this same confusion
because it _is_ a macro. So it is expanded in the caller's context and
does not need the extra layer of indirection.

I do not think this is a good idea, because it obscures things further
for people who are accustomed to C idioms, but one could imagine a more
general macro like:

  #define FREE_AND_NULL_WITH(p, fn) do { fn(p); (p) = NULL; } while (0)
  #define FREE_AND_NULL(p) FREE_AND_NULL_WITH(p, free)

and then you could do:

  FREE_AND_NULL_WITH(o->blob_state, alloc_state_free);

where alloc_state_free() would only receive the single pointer "s", and
would free it but not assign NULL.

-Peff
