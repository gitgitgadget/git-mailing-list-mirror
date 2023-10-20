Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E015EB6
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D98D49
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:23:08 -0700 (PDT)
Received: (qmail 15474 invoked by uid 109); 20 Oct 2023 10:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12846 invoked by uid 111); 20 Oct 2023 10:23:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:23:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:23:07 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] chunk-format: introduce `pair_chunk_expect()`
 convenience API
Message-ID: <20231020102307.GB2673857@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <cover.1697225110.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697225110.git.me@ttaylorr.com>

On Fri, Oct 13, 2023 at 03:25:12PM -0400, Taylor Blau wrote:

> While reviewing this series, I noticed a couple of spots that would be
> helped by having a convenience function that stores the start of a
> chunk in a designated location *after* checking that the chunk has the
> expected size.
> 
> I called this function `pair_chunk_expect()` and touched up seven spots
> that I think could benefit from having a convenience function like this.
> 
> This applies directly on top of 'jk/chunk-bounds'. Thanks in advance for
> your review!

I'm still a little skeptical of this approach, just because I think it
it discourages adding further checks. And in particular, I was planning
to add monotonicity checks to the midx OIDF chunk based on the
discussion in the earlier thread. And likewise, I think I probably
should have put the commit-graph checks into its OIDF reader, rather
than saving them for verify_commit_graph_lite(). That would match the
way we check the validity of the other chunks.

I haven't actually started writing those patches, though, so I'm not
sure of the full details yet.

-Peff
