Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC3179958
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483309; cv=none; b=ZL8Dha2lpV9ofHOG/56xOch5UljST+cvMN5cNvuTGCbrZ9fjBzOY4nIK3AN55TDnp5yFjcD3UfxswipX+7HSacfEiF+N8bXF6kBTBbWMy2rrsRy5MDMyKGvJzJBHFKbS99LYZniH3n1dHlV5NWEqX7Ou9PAY5ShvDob9Hsbr0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483309; c=relaxed/simple;
	bh=skpi7C5oIItQY+2jOaN9iVFkKEv84C+4I7KtFj8UQh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK/QW30jdOe/QaB3qKbMhrB5VJAO2NO34dTJUbYy7/BjyCL+FXUAGm0g5pcdTgAYTZjdLjmjJmwHnzuwyIv668E7zEi4mKm+ZN6XyWY4SSKJf+XywzNPYR831/vqyoYveO4YCc5vfiL2FzG6pQiISX1j6Q8asaf72acEbpxy2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=epE7CjBy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="epE7CjBy"
Received: (qmail 14562 invoked by uid 109); 13 Nov 2024 07:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=skpi7C5oIItQY+2jOaN9iVFkKEv84C+4I7KtFj8UQh4=; b=epE7CjByn99exwpWghRNre7SEPe9Bziw9BNT/pL44O+e18mPson3rluMuG5/9B2cfH4YBprUjFfCN4HIYogabC66lMyRVLIXyhQpQCCAvRcdT4+y6xdKcOcVvWyDZ0NwvK04aZ0XghZpUQbU1JR+brSRaq9mEhfPqwlhPEinKashuoUpv2ILxdRNgosdM1WohRVIVKOdSvzOijuIkTX/MUAAKeCTRbPfr2nCWYq8oxiKgUrq8p8z1Cna0kzHMZtUeFbH8tR9SCaorUZvUMijWorT6PS9LHUs0ekrdiF9MgwPZIq6izdK0RVwxrNvpAdNtiom3xYc+p0umV8ETxALmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Nov 2024 07:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10629 invoked by uid 111); 13 Nov 2024 07:35:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 02:35:05 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 02:35:00 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, hanyang.tony@bytedance.com,
	me@ttaylorr.com
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
Message-ID: <20241113073500.GA587228@coredump.intra.peff.net>
References: <cover.1729792911.git.jonathantanmy@google.com>
 <cover.1730491845.git.jonathantanmy@google.com>
 <1526a59e2d4ace2761fd8935c63350f0a41985c6.1730491845.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526a59e2d4ace2761fd8935c63350f0a41985c6.1730491845.git.jonathantanmy@google.com>

On Fri, Nov 01, 2024 at 01:11:47PM -0700, Jonathan Tan wrote:

> A subsequent commit will change the behavior of "git index-pack
> --promisor", which is exercised in "build pack index for an existing
> pack", causing the unclamped and clamped versions of the --window
> test to exhibit different behavior. Move the clamp test closer to the
> unclamped test that it references.

Hmm. The change in patch 4 broke another similar --window test I had in
a topic in flight. I can probably move it to match what you've done
here, but I feel like this may be papering over a bigger issue.

The reason these window tests are broken is that the earlier "build pack
index for an existing pack" is now finding and storing deltas in a new
pack when it does this:

  git index-pack --promisor=message test-3.pack &&

But that command is indexing a pack that is not even in the repository's
object store at all! Yet it triggers a call to pack-objects that repacks
within that object store.

Here's an even more extreme version. You do not need to have a
repository at all to run index-pack. So doing:

  mkdir /tmp/foo
  cd /tmp/foo
  cp /some/repo/.git/objects/pack/*.pack .
  for i in *.pack; do
    git index-pack -v --promisor=foo $i
  done

used to work, but with your patches will segfault (because the repo
pointer is NULL). Granted it's odd to pass --promisor when you are not
in a repo, but certainly we should never segfault.

So I think at the very least that index-pack should not try to modify
the repository's object database unless we are indexing a pack that is
within it, which would fix both of those issues.

I'd guess in the real world, we'd only pass that option when indexing
packs that we just fetched. But as a bystander to this feature, it feels
quite odd to me that index-pack, which I generally consider a "read
only" operation except for the index it was asked to write, would be
creating a new pack like this. I didn't follow the topic closely enough
to comment more intelligently, but would it be possible for the caller
of index-pack to trigger the repack as an independent step?

-Peff
