Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34D7C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 02:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE12F60FD7
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 02:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhJLCKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:10:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhJLCKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 22:10:02 -0400
Received: (qmail 30254 invoked by uid 109); 12 Oct 2021 02:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 02:08:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30956 invoked by uid 111); 12 Oct 2021 02:08:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 22:08:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 22:08:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rob Browning <rlb@defaultvalue.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] signature-format.txt: add space to fix gpgsig
 continuation line
Message-ID: <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net>
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
 <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
 <xmqq4k9ncopr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k9ncopr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 01:04:48PM -0700, Junio C Hamano wrote:

> > The patch is quite subtle to read, of course. :) But more importantly,
> > it is subtle for somebody reading the documentation to notice. Perhaps
> > it's worth calling it out explicitly? E.g., squashing in something like:
> > ...
> > -  (content is preceded by a space)
> > +  (content is preceded by a space; note that this includes the
> > +   "empty" line between the GnuPG header and signature, which
> > +   consists of a single space).
> >  - example: commit with subject `signed commit`
> 
> To those who are reading on paper or on terminal, the difference
> will not be even seen.  It only can be _found_ if you are in an
> editor or a pager and explicitly look for a trailing whitespace (or
> told your tool to highlight such for you).

Yeah, I was hoping that calling it out explicitly would help to serve
that purpose, even if they can't see it. But it's still pretty subtle.

I did consider annotating it more directly in the example, but I was
worried it would end up being syntactically confusing, because we don't
have a well-known convention for marking "end of line". But the example
you showed:

> I wonder if we can have some typesetting convention for this part of
> the documentation.  Perhaps something like
> 
>     In the following example, the end of line that ends with a
>     whitespace letter is highlighted with a "$" sign; if you are
>     trying to recreate these example by hand, do not cut and paste
>     them---they are there primarily to highlight extra whitespace at
>     the end of some lines.
> 
> before a displayed material like this:
> 
>   committer C O Mitter <committer@example.com> 1465981137 +0000
>   gpgsig -----BEGIN PGP SIGNATURE-----
>    Version: GnuPG v1
>    $
>    iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
>    HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
>    DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
> 
> perhaps?

...coupled with the explanation you gave is not too bad. I had thought
to maybe do something like:

   gpgsig -----BEGIN PGP SIGNATURE-----
   _Version: GnuPG v1
   _
   _iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
   _HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
   _DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA

but that is pretty ugly. I like yours much better.

-Peff
