Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339A520986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbcJDVsz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:48:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:52445 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbcJDVsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:48:54 -0400
Received: (qmail 22724 invoked by uid 109); 4 Oct 2016 21:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 21:48:54 +0000
Received: (qmail 11090 invoked by uid 111); 4 Oct 2016 21:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:49:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 17:48:51 -0400
Date:   Tue, 4 Oct 2016 17:48:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 13/18] fill_sha1_file: write "boring" characters
Message-ID: <20161004214851.n2ycxotg6wcdkxch@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net>
 <CA+P7+xpOxoRBDZGF_CU1Q-SYiQZtMx2vuwQKS0og864awZod5g@mail.gmail.com>
 <xmqqbmyzss6z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmyzss6z.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:46:44PM -0700, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> >> This function forms a sha1 as "xx/yyyy...", but skips over
> >> the slot for the slash rather than writing it, leaving it to
> >> the caller to do so. It also does not bother to put in a
> >> trailing NUL, even though every caller would want it (we're
> >> forming a path which by definition is not a directory, so
> >> the only thing to do with it is feed it to a system call).
> >>
> >> Let's make the lives of our callers easier by just writing
> >> out the internal "/" and the NUL.
> >> ...
> >
> > I think this makes a lot more sense than making the callers have to do this.
> 
> The cost of fill function having to do the same thing repeatedly is
> negligible, so I am OK with the result, but for fairness, this was
> not "make the callers do this extra thing", but was "the caller can
> prepare these unchanging parts just once, and the fill function that
> is repeatedly run does not have to."

Yeah, perhaps "does not bother" in the commit message is not entirely
fair. But it really does feel like quite a premature optimization to
skip the writing of one "/" in the middle of the string, especially as
it impacts the interface.

-Peff
