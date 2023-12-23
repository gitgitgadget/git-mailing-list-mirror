Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9818F4E
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18694 invoked by uid 109); 23 Dec 2023 10:02:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Dec 2023 10:02:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11408 invoked by uid 111); 23 Dec 2023 10:02:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Dec 2023 05:02:30 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 23 Dec 2023 05:02:29 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
Message-ID: <20231223100229.GA2016274@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
 <ZYN-5H-2NNoRRpf-@google.com>
 <xmqqplz0p90k.fsf@gitster.g>
 <20231221084011.GB545870@coredump.intra.peff.net>
 <xmqqsf3vmqug.fsf@gitster.g>
 <20231221214550.GD1446091@coredump.intra.peff.net>
 <xmqqle9njjp3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle9njjp3.fsf@gitster.g>

On Thu, Dec 21, 2023 at 02:04:56PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right, that is the "gotcha" I mentioned in my other email. Though that
> > is the way it has behaved historically, my argument is that users are
> > unreasonable to expect it to work:
> >
> >   1. It is not consistent with the rest of Git commands.
> >
> >   2. It is inconsistent with respect to existing options (and is an
> >      accident waiting to happen when new options are added).
> >
> > So I'd consider it a bug-fix.
> 
> So the counter-proposal here is just to drop KEEP_UNKNOWN_OPT and
> deliberately break them^W^W^Wrealign their expectations?

Yes. :) But keep in mind we are un-breaking other people, like those who
typo:

  git sparse-checkout --sikp-checks

and don't see an error (instead, we make a garbage entry in the sparse
checkout file).

> I do not have much stake in sparse-checkout, so I am fine with that
> direction.  But I suspect other folks on the list would have users
> of their own who would rather loudly complain to them if we broke
> them ;-) 

Likewise, I have never used sparse-checkout myself, and I don't care
_that_ much. My interest is mostly in having various Git commands behave
consistently. This whole discussion started because the centralized
--end-of-options fix interacted badly with this unusual behavior.

-Peff
