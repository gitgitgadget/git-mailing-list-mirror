Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184A3358AF
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028601; cv=none; b=jYOOTay44rVgAhs25c1LmDG/mtsWQ/iDXSQ8GcEXxYLL4+nfovYyF3znWSs30UMOrCFclf2/P7tOkTPy4ZYFMuzJ+djkVcuDrBfVpzL0NiLPf7MRwYtfrWLBXIgq8P8HkUkkvyIg7+RgeUbd30H0a7S/eL8IvpGVYKNiCOsnETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028601; c=relaxed/simple;
	bh=ngR8KoPsUpOG/jnHYb6rHJ6RJft861yE+FuFqWzY9jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwkdnWt+eDdbiH5IobuqtIn48/3Zlkdaw59AgtcS74YSNwlGjUWTW0qnM9+F9iBWmcO4tIQ7Qelpiref6996Qo5nLUFLudxMcjnXzUvaR7YfVKLm09TWQiSZTqhTJSe+5BVRWJBep+A+JgC9Iym/LmQF4z2rhy2ECnZoUGVvJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SPhVBB0M; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SPhVBB0M"
Received: (qmail 123640 invoked by uid 109); 21 Jan 2026 20:49:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ngR8KoPsUpOG/jnHYb6rHJ6RJft861yE+FuFqWzY9jM=; b=SPhVBB0MYliCZzgzsoaRSCmvlLiCbLlvyJnmy7oiKF6C5FMim03kTpK3pPq3iY3KH7/1Q2eHFVIWKX0DDpZrpYDUjEZvLF+jg/Uq4ZYu4TnSjcZp0dFiILCXVurOY9SWcOLGriE8KsajdpfgsNywZIcRJXEmxp1SL/wzngcTfTOsbsvHShxHaQ9gjBB2YkyCFow+99Wv4aMQcz/Ys9FsJDVKJ+IK6rCaTOOs5d3tunskCxJB7iMYUaBrIY+yf+ZTyKpLEQv3uET5NAM+IYXx+1CtOCEdYvFOK9cP5AjYIV6IAW7M2T7q/rc+NlxlqAODZYFgznaBI9lsVwVlp3fMeQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 20:49:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210325 invoked by uid 111); 21 Jan 2026 20:50:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 15:50:00 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 15:49:57 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Re: Memory leak
Message-ID: <20260121204957.GA747866@coredump.intra.peff.net>
References: <20260120094957.28855-1-haraldnordgren@gmail.com>
 <20260120132202.1655-1-haraldnordgren@gmail.com>
 <xmqq7btcx8pc.fsf@gitster.g>
 <xmqqh5seu7jz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5seu7jz.fsf@gitster.g>

On Wed, Jan 21, 2026 at 10:47:28AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Harald Nordgren <haraldnordgren@gmail.com> writes:
> >
> >> My bad, it does fix it! I think I applied your patch incorrectly the first
> >> time around.
> >
> > I've queued your v26 on top of a merge of Peff's leakfix patches
> > into 'master'.  It hopefully will appear in today's pushout.
> >
> > Thanks, both.
> 
> So are we all happy with v26 of the topic?

It addresses my main concern, which was having a way to turn it off. ;)
(And I see it is not even changed by default now).

One thing that puzzled me a bit is that the show_divergence_advice flag
is only respected for "use git pull if you want to integrate..." hint
and not other advice. But that was true even before these patches. It
feels funny to me that it is treated differently than the other advice.
But I think we can ignore that for the purposes of this topic. If
anything it is a defect in b6f3da5132 (wt-status: don't show divergence
advice when committing, 2023-07-12), which perhaps should have covered
more code paths.

Other than that, I did not see anything wrong from my (admittedly pretty
cursory) read.

-Peff
