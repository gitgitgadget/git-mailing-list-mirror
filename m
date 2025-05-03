Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D612FF69
	for <git@vger.kernel.org>; Sat,  3 May 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746287372; cv=none; b=sG3fuxK9E+bq2VIL6g3F1iCN9d5ZX16NrwUI3WO5h1bLd6yv4qZJpUrCn5O4j/fUnGv7KQ6BreLo3+erOPKoDdvhSGQnkPB22NSlJSfTfrebV1YqLs7wVL7wI/67clXFNDrGijnS2LRh2RdzLoXSqI4a2Yvf7DLZkM0JmLweEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746287372; c=relaxed/simple;
	bh=yX7hqZt5mhs186s0NO3FwLYGPZDV0wFLwOXrlS0dZVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wikmm39Kd8BVtWpub/evn/xk7VqlpTx4DwHO0NVSmp3Cbz/adJ2wYRYBNsT4O8cPB3VPs19AEYmzYuXV8IetaDbgUUaKOxKWN5nRwxQKePeSnyR3ezqG2Ykbrmsy5tVAFWWopf0ikBLsjFnJ4nM48DqivAbPvzLuLoGk7AL/7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OXWu+P2S; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OXWu+P2S"
Received: (qmail 10646 invoked by uid 109); 3 May 2025 15:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yX7hqZt5mhs186s0NO3FwLYGPZDV0wFLwOXrlS0dZVk=; b=OXWu+P2SVS6l0FVs3g+owsngyLOX7rQX/uJrGoVm0dSbILHVb6WNOg7M2VvvjEzTxbcETjzYQwKI7vda7lI/rtrxQ0HS+jgN5LXmBoCjGSSa5IGjlkh0gox9iO23rv8U6n0RXtz1HxRQekyP+7Qm0uIMTGcdNh7UD3H7zr/Ma3bjsOYLDYWQg6TneLIxKtq+ueqf3G3PRkaCYnWeV8m5BQnKNT7qzwq7JBy3If942U+V2+CuvvYVcfqVo/z6s/EZHmslMQW5FXqVMgryWU1yx3/JuogiKmhiHwxZ6/QLRD2dmEeXFpo8SoB6bgzeIPMUW+rn6nmFVoBCorc4MTfuNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 May 2025 15:49:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5489 invoked by uid 111); 3 May 2025 15:49:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 May 2025 11:49:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 3 May 2025 11:49:28 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <20250503154928.GA3412@coredump.intra.peff.net>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
 <20250503133158.GA4450@coredump.intra.peff.net>
 <aBYvMjtGjzEhKg4s@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBYvMjtGjzEhKg4s@ArchLinux>

On Sat, May 03, 2025 at 10:58:58PM +0800, shejialuo wrote:

> > PS I notice that this same function reads the whole packed-refs file
> >    into a strbuf. That may be a problem, as they can grow pretty big in
> >    extreme cases (e.g., GitHub's fork networks easily got into the
> >    gigabytes, as it was every ref of every fork). We usually mmap it.
> >    Not related to this discussion, but just something I noticed while
> >    reading the function.
> 
> Peff, thanks for notifying me. I want to know more background.
> Initially, the reason why I don't use `mmap` is that when checking the
> ref consistency, we usually don't need to share the "packed-refs"
> content for multiple processes via `mmap`.

You're not sharing with other processes running fsck, but you'd be
sharing the memory with all of the other processes using that
packed-refs file for normal lookups.

But even if it's shared with nobody, reading it all into memory is
strictly worse than just mmap (since the data is getting copied into the
new allocation).

> I don't know how Github executes "git fsck" for the forked repositories.
> Is there any regular tasks for "git fsck"? And would "packed-refs" file
> be shared for all these repositories?

I don't know offhand how often GitHub runs fsck in an automated way
these days. Or even how big packed-refs files get, for that matter.

The specific case I'm thinking of for GitHub is that each fork network
has a master "network.git" repo that stores the objects for all of the
forks (which point to it via their objects/info/alternates files).  That
network.git repo doesn't technically need to have all of the refs all
the time, but in practice it wants to know about them for reachability
during repacking, etc.

So it has something like "refs/remotes/<fork_id>/heads/master", and so
on, copying the whole refs/* namespace of each fork. If you look at,
say, torvalds/linux, the refs data for a single fork is probably ~30k or
so (based on looking at what's in a clone). And there are ~55k forks. So
that's around 1.5G. Not a deal-breaker to allocate (keeping in mind they
have pretty beefy systems), but enough that mmap is probably better.

I'm also sure that's not the worst case. It has a lot of forks but the
ref namespace is not that huge compared to some other projects (and it's
the product of the two that is the problem).

> If above is the case, I agree that we should reuse the logic of
> "load_contents" to enhance. But I don't know whether we need to do this
> in the first place.

I think you can skip the stat validity bits. In theory you can also skip
the mmap_strategy stuff, but I guess it might mean that "fsck" could
block other writers on Windows temporarily (though we wouldn't plan to
hold it open long, the way the normal reader does).

The other gotcha is that the result won't be NUL-terminated, but it
looks like the helper functions already take an "eof" pointer to avoid
looking past the end of what was read.

-Peff
