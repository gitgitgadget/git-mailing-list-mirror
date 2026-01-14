Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7E31ED7F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429442; cv=none; b=ek/QvbM3ABiDD+ft9gtNlQuDtcANynC9NwVVpBi3TZyqe4++40GFE6w7CIca+bcEb14onMrOZbzM/rPUPpoudDTRNyy49Bb3T0YedNJJgQ1jiNUH9Lx6XlrF0+FK2fdJ/5f1q/ojgaG63HBgUAxJD0gE739+WndqxC0oSYX0vqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429442; c=relaxed/simple;
	bh=g7lv3KQiBho+9IQtmTZuAMA14Oo64MUag2Clvb2rJfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md4c0XwcLs4wQ2u5pJfIRBhb7ZbC/bNAAdBLkYX5gPuDgb3fPjSB3BMYwMPZexdsP+fwVVJDO4yXhY+QDBhKWnmEH0+GwjXs9e5cziVvcSkhAFybFUWY1TGqK7pPTJHLTBus2051YFZt/T/2BVnaY9WuUTjRxoGiX3ty7WT7+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HcORGaFz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HcORGaFz"
Received: (qmail 42053 invoked by uid 109); 14 Jan 2026 22:23:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g7lv3KQiBho+9IQtmTZuAMA14Oo64MUag2Clvb2rJfo=; b=HcORGaFzKk/L/6ITkY4NESfzik8QHJx+KlNdIlyLnCHMKjr7CrdqcN4JnqXOvv4pLx+AfP4zXrCHCN5qq0RIIPtpJlcWbDNrnKXGV7u8tJUN00kzeM0KBvlOcXwX7x4gpmxBdQpnqm3qa9e4Tve7ZJ2Us31dO2mQ5OuhRHiPYaIXXJ0WWma9Rax3RuRHuk3DujCOf5CVrhYwBZaOIpZ+nke8BDPnQLvT/GtGJEVNPh71AJ/w3pNQ8X/1eovXt3M7VrlocYtFs/TYe+NKMR3y3Ssu5si3DwiJx0fxJKWJS9RQbnYEVTz9CIHOw6OrKprTmeuNwkLoKiak7Goq4hcIgA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 22:23:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71021 invoked by uid 111); 14 Jan 2026 22:23:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 17:23:54 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 17:23:51 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH] fsck: snapshot default refs before object walk
Message-ID: <20260114222351.GA1014423@coredump.intra.peff.net>
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
 <20260102054922.GA2580212@coredump.intra.peff.net>
 <CABPp-BGqiM8fmirgdqumRNfzWediC5v_uZ9qHjntTqPqABDhnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGqiM8fmirgdqumRNfzWediC5v_uZ9qHjntTqPqABDhnA@mail.gmail.com>

On Tue, Jan 06, 2026 at 03:36:57PM -0800, Elijah Newren wrote:

> >   Side note: I do not think I have ever run fsck with refs on the
> >   command-line. It is not like it saves you any time! Most of the
> >   expense comes from opening up and verifying the objects in the first
> >   step, not from looking at ref reachability.
> 
> Not to mention it produces spurious "dangling" object warnings,
> because while the objects might be reachable, they aren't necessarily
> reachable from the particular subset you specified on the command
> line.  I wonder if no one ever noticed that because it's such a
> useless mode; I only noticed it because you pointed out how Matthew
> and I overlooked races with command-line arguments.

Yep. It would be nice to get rid of it, but of course I worry about
missing some obscure use case that somebody relies on. Anyway, way out
of scope for this patch.

> > That did make me wonder a bit about the other fields in "struct
> > reference" (which your snapshot just throws away). But it looks like
> > fsck_handle_ref() only cares about the name and oid, so it is OK.
> 
> Junio suggested the same thing, although he also suggested we might
> want to snapshot some reflog information at the same time, which then
> wouldn't make sense to be using a struct reference.  Even though I'm
> not implementing per-reflog snapshotting, I left a comment in the code
> about it so I think it made sense to just create my own data structure
> with just the name and oid.

I do wonder how expensive it would be to just snapshot all of the
reflogs. It is a shame, because 99% of the time entry N will be
reachable from N+1 (and thus does not need to be stored), but we don't
know that until we traverse.

So we are potentially storing the oid of every reachable object in the
repository in memory as a snapshot. But...isn't that exactly what we'll
do anyway when we traverse, in the form of "struct object"?

Anyway, I can live with your timestamp-based hack for snapshotting the
reflogs.

> > There are a few other related interesting cases, too:
> >
> >   - We may use the index file for connectivity, as well. It suffers from
> >     the same race, and would benefit from a snapshot.
> 
> I left a couple TODO comments about this, so that those who are
> interested/motivated can extend the snapshotting further.
> 
> >   - In get_default_heads() we also look at worktree HEADs. Those have
> >     the same race (their normal refs we don't consider here, because
> >     they were already handled by the overall ref iteration).
> 
> I handled these in my newer version, since handling them is pretty
> similar to handling command line arguments.

Both sound like reasonable directions to me. I'll take a look at your
latest version.

-Peff
