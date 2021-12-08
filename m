Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6730FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhLHTQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:16:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:46898 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231775AbhLHTQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:16:03 -0500
Received: (qmail 10988 invoked by uid 109); 8 Dec 2021 19:12:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 19:12:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5600 invoked by uid 111); 8 Dec 2021 19:12:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Dec 2021 14:12:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Dec 2021 14:12:29 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Fwd: coverity problems in reftable code
Message-ID: <YbEDnfZgeQZp6JJj@coredump.intra.peff.net>
References: <YarO3nkrutmWF7nb@coredump.intra.peff.net>
 <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
 <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
 <YbAOZMxGDELhgfut@coredump.intra.peff.net>
 <YbAmANn6t9S5qKWA@coredump.intra.peff.net>
 <CAFQ2z_NUCj00981oQiswaYTK6iJ=HuPjNGP46tLL-RGL2xHbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_NUCj00981oQiswaYTK6iJ=HuPjNGP46tLL-RGL2xHbEw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 11:50:16AM +0100, Han-Wen Nienhuys wrote:

> > Summary is below, but I'm not sure it's that useful without the whole
> > code flow. The unreachable-code one seems just wrong. We can get there
> > via the "goto done" in the BLOCK_TYPE_LOG conditional, it looks like.
> 
> they're all valid. There is a shadowed variable in the unreachable code one.

Ah, good catch. Yes, that is definitely the problem.

> > The first FORWARD_NULL doesn't look obvious to me from the code. But it
> > triggers a segfault running "test-tool reftable". (It didn't immediately
> > for me on Linux, but Windows CI shows it, and compiling with ASan on
> > Linux does too).
> 
> yeah, that must be the problem on windows too. The 3rd test case
> passes NULL into memcmp() with a 0 length.

Ah, makes sense. I didn't look closely, but that would explain perfectly
why it fails on some platforms but not others.

> I've folded in your patch and fixed the issues.

Thanks!

-Peff
