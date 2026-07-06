Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF17FC0A
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783298072; cv=none; b=byBtO0kMt9j25gXG15MWyR1pK9jl8cPCaGu4H29oMtuy2n7pcfus0zQMdDarWGssjI3gtYGTeKXaqzHvzBdVYOPLdTh0U76WnIu1+JtvErnqm5rI/InX0tZ7RBF9y88xnCRVMUvuJ47rcwV5wcBr0hIuWl+yWarmh1cr06Qa86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783298072; c=relaxed/simple;
	bh=U+jLxptQPIUqAdpv7o7Mn9SLvWBZh+baaHn71fvXHSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4amzu5OBpggVVZhnqp5wNal3gWnYdkWGhBEw6SP9m8I1TVzv4h1ZnoJRp2vjVYXeejFyYRYLl1Bkmiu7UKQOxL2FNLcCgGx6XrVvD8cNKJ7BOfuVhfqyFqCwEwss8g+8crbOn0uw1CcLKd69H+7cz5B3q//FXTRu6w18NCYe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SzsxHWCR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SzsxHWCR"
Received: (qmail 2486 invoked by uid 106); 6 Jul 2026 00:34:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=U+jLxptQPIUqAdpv7o7Mn9SLvWBZh+baaHn71fvXHSI=; b=SzsxHWCRB9HIaaij/lpLRWIvcbcB2jGcByGvdUZ4Y441CCubyPNH3pFjDO8VlKsPbt0m0cIiwVcTo9wWqGSVRq4jeL3FTJUZPAK2irzSZB8TpYgLBEG1U9rCPzujWDmAgzRKnTgH2e4HyvshJ0myfve/GGWdl/GQmhHCiynau3K+5VMlCBZfoj7ecnkSBTeQpeJT7zXp2eJfXYeBnKdFN4nh38tfTUbYpWXJzAKNFG9bLM51DOpyrCv4wMcXPzAF4OYtoCi0RmRpnsIqsKxW+w2AsvlFBxZwqhJC2DJS7HT7WvHIp8TPx5tPQcgy9eaeenaT+/4Jho8f5XQ9zBzW6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2026 00:34:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3885 invoked by uid 111); 6 Jul 2026 00:34:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Jul 2026 20:34:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Jul 2026 20:34:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <20260706003429.GD2301945@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
 <akTS_rPV7JaGHKRq@pks.im>
 <20260701084733.GA814472@coredump.intra.peff.net>
 <akTXYoY7mSQUM33P@pks.im>
 <20260702085821.GC481298@coredump.intra.peff.net>
 <akY4u02vdBkVqs7m@pks.im>
 <xmqqjyrbhkf8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjyrbhkf8.fsf@gitster.g>

On Fri, Jul 03, 2026 at 01:45:15PM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Likewise I find the dual clang/gcc jobs to be overkill. Compiling with
> >> both is useful, as they have different warnings. But have we ever seen a
> >> case where running the tests showed a different result with different
> >> compilers?
> >
> > Not that I'd know of. As you say, I think it makes sense to use
> > different compilers in general. But I don't really think we need to have
> > this as a full "compiler x tests" matrix.
> 
> Very true.  Different configurations with TEST-vars are great
> combination to test, but we are not in the business of hunting bugs
> in clang/gcc so we long as they compile (instead of warning "hey,
> that construct gives you undefined behaviour"), we shouldn't have to
> run the test suite with the same configuration for both.

I don't care about finding bugs in clang vs gcc. I'm more concerned with
a case where we have undefined behavior, both compile it fine, but the
bad behavior is revealed in the tests only by one of them.

I can think offhand of only one case where I saw that happen[1]. IIRC it
had to do with integer sizes being passed to a variadic function. But it
also changed behavior within the same compiler using different
optimization levels. So it feels like kind of a scattershot way of
trying to flush out UB, and we are probably better off with UBSan and
friends.

-Peff

[1] I mentioned it in:

      https://lore.kernel.org/git/20251130134625.GA199421@coredump.intra.peff.net/

    but didn't give enough details for it to be useful here. I mention
    it merely as the only anecdote I could call to mind. :)
