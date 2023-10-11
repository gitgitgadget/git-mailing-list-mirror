Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBECDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjJKXJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjJKXJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:09:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B59D
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:09:28 -0700 (PDT)
Received: (qmail 20502 invoked by uid 109); 11 Oct 2023 23:09:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:09:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11212 invoked by uid 111); 11 Oct 2023 23:09:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:09:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:09:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/20] midx: enforce chunk alignment on reading
Message-ID: <20231011230927.GJ518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210523.GH3282181@coredump.intra.peff.net>
 <ZSa4tfG2NyM1s9Jz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSa4tfG2NyM1s9Jz@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 11:01:09AM -0400, Taylor Blau wrote:

> On Mon, Oct 09, 2023 at 05:05:23PM -0400, Jeff King wrote:
> > @@ -120,6 +121,11 @@ int read_table_of_contents(struct chunkfile *cf,
> >  			error(_("terminating chunk id appears earlier than expected"));
> >  			return 1;
> >  		}
> > +		if (chunk_offset % expected_alignment != 0) {
> 
> Oops, I missed this in my first read. I'm definitely nit-picking here,
> but this should probably be:
> 
>     if (chunk_offset % expected_alignment)
> 
> without the trailing "!= 0".
> 
> I don't have a strong preference here, since we are doing a comparison
> of an arithmetic operation against an (un-)expected value. But I think
> the CodingGuidelines would technically call this out of style...

I suppose so, but somehow I consider the subtlety of "%" to merit the
more explicit comparison (versus something like "if (foo)"). Grepping
for "if (.* %)' seems to show some of both.

-Peff
