Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381E3CD8B1
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169823; cv=none; b=mI+mC49VTDoFWopUQoUZgzGGyA8JJlRUu3q22VHWQrq/DvYIjHNUXVN40nOimJIC2CfuxTqz1CQC9WfpnbR8AthcHqbMyTu5EzY94igwhNBQVBQ9WQ3p+0aowV2i+kIZu46Z4G8T75nvi2RRDg6Glash6AT51/z6WQ4Vh0chSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169823; c=relaxed/simple;
	bh=YwJ4UuDRqGPUdr8WsEzJdJEXF8/zbEZd6pcjgRQxROk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPcmM1QYzcM46rM42R6+R5XmNPFc0ialdzguaMuPz4OVkcMwcIOy86LX/95GC+myBFGYRMG/KkTZyj6gKKdAEiBhIU5bMVvE4uvLy2pNDMG9RMJGnOejK7L8qymQU89BI7PcEQCpCOzaMXV9vp6neFjXt8P/fIjuiCMUW1f1Eig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D8TTm9Rh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D8TTm9Rh"
Received: (qmail 63621 invoked by uid 106); 10 Mar 2026 19:10:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YwJ4UuDRqGPUdr8WsEzJdJEXF8/zbEZd6pcjgRQxROk=; b=D8TTm9RhUWvPCEx6aafwfhH4stmSks4b0KZt4KOG3DYIw4nLbLEvwrrA66CGC2gbkIHkioHLt9QpfFFqP5djaxtgDyg81ut3ial42DuNi/7dOhb/QMhMfGpg8GfBWYZw1XIZFlF6fQXloNInNciMuiy0MHzYqUR12nD0fH5saHwrBBdoTvUoBhSfJZj42qlrg0X+Q5M56WBQVEIwTujuG88ynYjx4B/D+pLb8+CO02jHxDs7JuD8pEiQPjwe9+wwRjAxtzSudKUcLqkaje8myhxuzUUh1JZxM26T9tUhw9zTYvrvqwAgveJ4irskGKbhW2osgrL6GWcCV0rtlR2+Tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Mar 2026 19:10:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 476165 invoked by uid 111); 10 Mar 2026 19:10:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2026 15:10:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Mar 2026 15:10:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v5 0/4] http: add support for HTTP 429 rate limit retries
Message-ID: <20260310191019.GA589481@coredump.intra.peff.net>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
 <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
 <xmqq5x7nknrd.fsf@gitster.g>
 <xmqq4imo1sse.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4imo1sse.fsf@gitster.g>

On Mon, Mar 09, 2026 at 04:34:25PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> Changes since v4:
> >>
> >>  * fix only strbuf_attach() calls which don't need reallocation
> >>  * remove patch, which enforces strbuf_attach() contract via BUG()
> >> ...
> >> Vaidas Pilkauskas (4):
> >>   strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
> >>   strbuf_attach: fix call sites to pass correct alloc
> >>   remote-curl: introduce show_http_message_fatal() helper
> >
> > These three patches looked quite reasonable to me.
> >
> >>   http: add support for HTTP 429 rate limit retries
> >
> > I'd feel comfortable to see somebody more familiar with the HTTP
> > transport code base to take a look at this step before we declare
> > victory.
> 
> Any volunteers?

Sorry, I'm way underwater on things I could/should be reviewing, and
this one was quite non-trivial. ;)

I just left some comments. A lot of it was about how to more cleanly
integrate with the http code (which I admit is a mess, especially with
respect to which "layer" things should happen at). Some of that may be
debatable, though I hope we can make things a bit cleaner.

But I think there may be a logic error in how http_request_recoverable()
loops, which certainly needs to be fixed.

-Peff
