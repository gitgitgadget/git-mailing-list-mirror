Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2543C6A2
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9D448C
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 14:09:44 -0800 (PST)
Received: (qmail 15427 invoked by uid 109); 10 Nov 2023 22:09:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 22:09:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1071 invoked by uid 111); 10 Nov 2023 22:09:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 17:09:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 17:09:43 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <20231110220943.GJ2758295@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <xmqqedgyw6jv.fsf@gitster.g>
 <20231110215747.GG2758295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110215747.GG2758295@coredump.intra.peff.net>

On Fri, Nov 10, 2023 at 04:57:47PM -0500, Jeff King wrote:

> One of those patches calls out the truncating division issue, but to
> summarize: IMHO this is OK, as what we really want to know is "is it big
> enough that we can always ask for NR records of size ELEM", which
> division gives us. If we do want to be more precise, but also avoid
> die(), we'd need a variant of st_mult() that returns a boolean. I didn't
> think it was worth it for this case (but arguably it is something that
> would be useful to have in general).

Oh, and obviously there is another option here if we want to be more
careful but don't want to introduce an st_mult() variant: we can use "%"
to check for divisibility ourselves.

I don't think it's worth doing that in every individual size-check, but
maybe it would be in a central pair_chunk_expect().

-Peff
