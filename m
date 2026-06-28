Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B371A0BF3
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635791; cv=none; b=srevkl2duQL5T3qYKhycwJIebhZurJQgxPsqGflzjN5CmYQwLPt3dQqlXkCsUVs5INLZgcTU+YR1xX2UaoagRgwSXVQ7E7RHKAHxQ219kkqPnjqgb7tHa5O8MCCFZO7J/1cVuRLDVkugva0ceZHIJto9rjmluqw6Bm6XO37gCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635791; c=relaxed/simple;
	bh=A3ROuY0SRFxDvxr6XArlmlDNkp/tHegAfuRepSCIAeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxuaPoIC6kt/VL8ZvXE3NtE1Ns9G62uKjcVn1zLWXeEmFTFqGgg6nO+ADtf1ZOOYfmtI00fMoS25cf2oq3YUfWwQyFtxACvxTSHtFLAJa7C3R9/eUseFUfMOYjaIHvtg8wWgUvb2Q9txKHUftOAXriPbq2we9XduxuwLbbPQtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BFnC3Xgk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BFnC3Xgk"
Received: (qmail 52435 invoked by uid 106); 28 Jun 2026 08:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=A3ROuY0SRFxDvxr6XArlmlDNkp/tHegAfuRepSCIAeI=; b=BFnC3XgkDbF6aeiqaWRMMBSDUnPF8yxdh0shlNzj5Qvs8WhxYtcxo+JK2/m4qRtZlX38mWklU37Jyx9ZLwBw76OiOzqelEIUQ7YsBtStHfI5I+WYCRHR7dvX2Z8Tjrkg/CAed4jjR6AeMXX2rmgibx2oslgBj0aV2mxEN/RkKKjKV/EsfptM1DlXiIhhNlp2vFiu9awm/DbnJJxMBjcR6yyRtWjZlywr7Wv+fPTfj3odS3yJK1s+8BmEjI0f8NXcMzkp8xmHYNidAXP+02kOXcyZ/IA4HFMyywA+R1Hzp6pb2hQZaZAVYbhrnPhlaZdGdutQpmqCQSiGxGkgc6awMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 08:36:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111717 invoked by uid 111); 28 Jun 2026 08:36:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 04:36:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 04:36:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260628083628.GB3594700@coredump.intra.peff.net>
References: <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
 <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
 <xmqqa4sog1e9.fsf@gitster.g>
 <20260621172432.GA2206349@coredump.intra.peff.net>
 <20260621174518.GB2206349@coredump.intra.peff.net>
 <xmqqfr2f7iay.fsf@gitster.g>
 <20260621212805.GB2297179@coredump.intra.peff.net>
 <xmqqik7a4vhp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik7a4vhp.fsf@gitster.g>

On Mon, Jun 22, 2026 at 05:20:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, though that implies comparing the index and file mtimes with
> > nanosecond precision.  We have that precision stored (at least
> > when the system supports it) but I'm not sure if that comparison would
> > run afoul of the reasons USE_NSEC was not the default in the first
> > place.
> >
> > I guess not? The problem there is that the nanosecond portion would
> > sometimes get wiped if the entry was dropped from the kernel's in-memory
> > cache. And then stat-matching would not work. But if we are talking
> > about strictly asking "is this mtime later than that mtime", then I
> > think the worst case is that we fall back to the current behavior.
> 
> Right, and you are right to point out that for the purpose of
> comparing mtimes of files' and the index file, this would make it
> unworkable.  I can imagine that a file and the index may have been
> written within the same millisecond but we can tell that the former
> slightly earlier than the latter (or the other way around) with
> nanoseconds resolution, then only one of the two lose the sub millisecond
> resolution but not the other due to its in-core inode evicted out of
> the cache.  Depending on which one survives (and keeps a non-zero
> sub millisecond part), they can compare differently.

Hmm, yeah. I was thinking there might be some mitigating factor because
we're comparing stat information that is stored in the index, and not
against a fresh stat() call. But that's not true.

We are using stat() information stored in the index from a file that was
written in the same second as that index (otherwise we do not care about
nanoseconds at all). But the index does not store its own mtime. At the
time of reading, we will fstat() it fresh, so we may see the truncated
mtime value.

In that case we'd always see the index as older than it really is. Which
I think does fail in the favorable direction for us (we assume the
too-new file is possibly racy and err on the side of caution).

But I don't think it rules out seeing the truncation in the other
direction. The original index write would have to be done in the same
second that the tracked file is written (because we only care about
nanoseconds when that is true). So it implies that the tracked file was
written, had its inode evicted, and then was re-read from disk all in
the same second that the index is being written, and the index inode
itself is never evicted. That seems unlikely but not impossible.

Anyway, it's all sufficiently scary that I think it should stay
conditional on USE_NSEC. I do suspect that USE_NSEC is safe at least on
Linux these days (see my response to Patrick elsewhere).

-Peff
