Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D21553A7
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207157; cv=none; b=XCuNTvVZituqV9iVPd4Lk+OCaF8SCTcuJXPyV+VJxMT2jWR0hdlFfDpsrILiFerL0dBJitn2AvB5LRgpwEgtMcnisoaUQUOdmizf2Wix5eYP4aZfm9IaPr14MEVwTcJbKL9pabkhFpl9HOuA18I3z0uPBZmmCUczT07qiFg/YxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207157; c=relaxed/simple;
	bh=EALvrIXe+eLVooq6EfJi/bucIlxqepB1BknwLCXCF2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/dAEGGSIYm3FuPu0N42KDzvI0cJMb0RjmDs83hAx0xOOLMHb9mio4Pkfd+MPrI6WJp9EiR5YiMaXxf+3cmPAt+XWIAtM8fowuYQMWYZ/8nqJhIC+JytYHFCSpBJ7vPlnoeh8RX8i+ZmnHZDQCdIXFV0BePXzPuQIdFzW3DcHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30889 invoked by uid 109); 15 Apr 2024 18:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Apr 2024 18:45:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22544 invoked by uid 111); 15 Apr 2024 18:45:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Apr 2024 14:45:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Apr 2024 14:45:52 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: increase command size limit
Message-ID: <20240415184552.GA1709228@coredump.intra.peff.net>
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
 <ZhwV6CmcC8zeSJ-7@tapette.crustytoothpaste.net>
 <xmqqil0impy3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqil0impy3.fsf@gitster.g>

On Mon, Apr 15, 2024 at 11:38:28AM -0700, Junio C Hamano wrote:

> > I'm curious, is there a particular problem that you (or someone else)
> > ran into that caused you to make this change?  I agree it seems prudent
> > in general, but if there's a particular real-world broken case that this
> > hits (e.g., mailbox names in a given language), I think the commit
> > message would be a great place to mention this real-world impact, which
> > would lend support to your argument that this is a valuable change to
> > make.
> 
> I personally am not curious about real-world problem in this case,
> but I won't stop you asking ;-)
> 
> I view this more about code simplification.  We no longer need a
> custom nfvasprintf() helper nobody else cares about, leaving the
> resulting code easier to read.
> 
> Will queue but will wait for a day or two to see if René wants to
> add clarification to the proposed commit log message before merging
> it to 'next'.

Yeah, as the suggested-by person, I can affirm that this is not
something I saw in real life. I agree the primary motivation is the code
simplification, and dropping a pointless limit is the bonus. I'd
probably have written it in that style, but I'm OK either way.

-Peff
