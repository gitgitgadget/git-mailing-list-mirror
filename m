Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE4CC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D548613E3
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhEGWUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 18:20:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:47692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGWUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 18:20:05 -0400
Received: (qmail 3516 invoked by uid 109); 7 May 2021 22:19:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 22:19:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4373 invoked by uid 111); 7 May 2021 22:19:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 18:19:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 18:19:03 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 08:25:36PM +0000, brian m. carlson wrote:

> > So completely migrating to Asciidoctor can eliminate xmlto requirement
> > for generating manpage.
> > 
> > What do you think about above?
> 
> I didn't do this because it makes things very complicated in the
> Makefile and my goal was to minimize the needed changes and divergence.
> I'm not opposed to someone else doing it, but I expect it will be a
> bunch of work.

Yeah. In the period where we support both asciidoc and asciidoctor,
using the same flow for both (even if it's suboptimal for asciidoctor)
kept the complexity down.

I _thought_ the original asciidoc was marked as deprecated /
unmaintained at some point. But it does seem to have gotten a few
releases in the last year (it looks like maybe the python 2 version was
EOL, but somebody decided to make the effort to port it to python 3?).

But I wouldn't be at all sad to just standardize on asciidoctor. I think
we're at parity in terms of the output (thanks to lots of work from you
and Martin over the past couple of years), and I've generally found it
nicer to work with.

The only downside is that it may be available in fewer places (though
I'd think that python vs ruby is not so different). IMHO it's OK to be
aggressive about the doc toolchain requirements, because the fallback is
always grabbing the preformatted roff or HTML pages that were generated
on a different system.

-Peff
