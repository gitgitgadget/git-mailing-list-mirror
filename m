Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39348202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 02:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbdJQCpn (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 22:45:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752981AbdJQCpm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 22:45:42 -0400
Received: (qmail 26838 invoked by uid 109); 17 Oct 2017 02:45:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 02:45:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19725 invoked by uid 111); 17 Oct 2017 02:45:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 22:45:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 22:45:40 -0400
Date:   Mon, 16 Oct 2017 22:45:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joris Valette <joris.valette@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
Message-ID: <20171017024540.erccnanmvz6t2aue@sigill.intra.peff.net>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
 <87zi8sxvkg.fsf@linux-m68k.org>
 <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
 <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
 <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
 <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
 <xmqqk1zur2yp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1zur2yp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 10:13:34AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Alternatively, I suppose we could just always escape in
> > add--interactive. I'm trying to think of a case where somebody would
> > really want their diffFilter to see the raw bytes (or vice versa, to
> > show raw bytes produced by their filter), but I'm having trouble coming
> > up with one.
> 
> Your patch below only implements the "tame the raw bytes that come
> out of their filter", which is quite agreeable.

Yes. I think that is probably OK, especially given that we continue to
allow terminal escapes (certainly some filters would want to use colors;
I don't know if any would want to use more exotic control codes).

> > I can't help but feel this is the tip of a larger iceberg, though. E.g.,
> > what about characters outside of the terminal's correct encoding? Or
> > broken UTF-8 characters?
> 
> Hmph.  If you use it as a "built-in" that is a fallback for
> diffFilter, i.e. use it only when the end user does not have one,
> then users can override whatever wrong thing the built-in logic does
> so... ;-)

Yes, and maybe that is the best way to do it. It just seems like it is
opening a can of worms about exactly which things should be filtered and
how.

I also wondered if people would be annoyed that by using a filter, they
don't get the benefit of the escaping, unless their filter implements it
separately on top (and the original purpose of the filter option was for
things like diff-highlight and diff-so-fancy, which do not do such
escaping).

-Peff
