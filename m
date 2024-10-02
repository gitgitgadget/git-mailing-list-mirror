Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B61C9EC1
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912080; cv=none; b=Psk6J60BJfaD8OtwIYalabYjngdtrVR2Ts69aSbBKYzXsKMlTn8QX8z0cgWpvuJpsX0Ls5pnRaw7O9tI3vkUrzszgVHndJBd5Tb2DeS3kwTo7pAwoNnvcrEe1KtzjL3ZEXr/h/z+Idzz+ZyHdeNsUsWYzGxq5v6TmJHVFkzWu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912080; c=relaxed/simple;
	bh=jBrB131szfjIvLFt705Uj7/DYFgAs0IfUWweJEUHxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhVzmSTm1+V5MdY0RU76qLChersPW/6ItMNsS/Od7HMU+ayvBqlZCq68IdSzaFRN1i6IE0zzPhxlIsMmo8BwBMrzX68NNQmwMCUXy3UtniO0y6YremV5dU3/jRh27mhgZFox7U+xQt7W9qQEkOvgZy0lD3B0I0tXC79Al5eBysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NVE/hEYK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NVE/hEYK"
Received: (qmail 10703 invoked by uid 109); 2 Oct 2024 23:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jBrB131szfjIvLFt705Uj7/DYFgAs0IfUWweJEUHxD0=; b=NVE/hEYK/luybzz9L+qHNzEi9V3C7Z+GVEMZVnvH5I92h1CagIsU28CYHnQ6qV8NoH7T7eRtgnK+E5mXc5AbWVe8iJHjeIqLqFufxFfMGdckL4oSEeDkIhB/yna8RyNXnTUx1pmoQBX+nQ0qogaYvRQAQl6DqJfoDpBEauemjVLl2ukdThDqDabgj0lrfwK+atKlRq5ZKK1/JKnqRpNMThLvdMmrsRl4/VapYgCiBsCcFS9LSD4buYGW12cSbsgZNo9jQtdkJIhtvQGpqREqUUBihcj6muo6ORgaNrqMifRD0TLcQjFjEE6y8hqkQqioLy7zwVB7hoKf5q8W8ZqPMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Oct 2024 23:34:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10653 invoked by uid 111); 2 Oct 2024 23:34:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 19:34:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 19:34:36 -0400
From: Jeff King <peff@peff.net>
To: Eric Wong <e@80x24.org>
Cc: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
Subject: Re: Linking topic merges to mailing list threads
Message-ID: <20241002233436.GA3455554@coredump.intra.peff.net>
References: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
 <20241002225057.M796260@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002225057.M796260@dcvr>

On Wed, Oct 02, 2024 at 10:50:57PM +0000, Eric Wong wrote:

> Emily Shaffer <nasamuffin@google.com> wrote:
> > Hi all,
> > 
> > We've been wanting to gather metrics on Git's code review process -
> > how long it takes from first contact on list to merge, how many
> > iterations are needed, time between iterations, etc. One missing link
> > is the actual merge time in `next` and `master` - a human can infer
> > the link between the patch and the mailing list thread, but it's more
> > challenging for a script to do it.
> 
> Searching by commit titles as a phrase against email subject (`s:')
> can probably make it easy w/o having to look up amlog or explicitly
> keep track of human-unmemorizable metadata such as Message-IDs.

I do that a lot myself, but it sometimes get tripped up when people put
patches inline, like:

  > blah blah blah

  Yes, good idea. Maybe like this:

  -- >8 --
  foo: frobnicate the bar

  Etc...

In that case you have to do an actual body search. I usually find these
with phrase searches in the body text (I'm usually using notmuch, not
public-inbox, but I think the same would be true). Of course it may also
find more false positives, but usually they're from the same thread
anyway.

Very occasionally somebody posts a patch snippet and Junio writes a
commit message that never even hits the list, but that's pretty rare
these days. :)

-Peff
