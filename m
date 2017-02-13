Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D421FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbdBMV1i (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:27:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:54497 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752886AbdBMV1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:27:36 -0500
Received: (qmail 7013 invoked by uid 109); 13 Feb 2017 21:27:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 21:27:36 +0000
Received: (qmail 26570 invoked by uid 111); 13 Feb 2017 21:27:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 16:27:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 16:27:34 -0500
Date:   Mon, 13 Feb 2017 16:27:34 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     hIpPy <hippy2981@gmail.com>, git@vger.kernel.org
Subject: Re: Incorrect pipe for git log graph when using --name-status option
Message-ID: <20170213212734.howisucqqhusbglc@sigill.intra.peff.net>
References: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
 <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com>
 <CAM_JFCwN+o54mJ1XJ3rSKnXgPx3wt_i=fd8ZSGpcL-fSegQ=Ow@mail.gmail.com>
 <20170213211653.x3huwmzprvmm3yxj@sigill.intra.peff.net>
 <xmqq37fhdc27.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37fhdc27.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 01:18:40PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the problem is specifically related to the "terminator" versus
> > "separator" semantics. Try:
> >
> >   git log --graph --name-status --pretty=format:%h
> >
> > versus:
> >
> >   git log --graph --name-status --pretty=tformat:%h
> >
> > The latter works fine. The problem seems to happen with all diff
> > formats, so I think the issue is that git is not aggressive enough about
> > inserting the newline at the right spot when using separator mode.
> 
> I guess that is one of the reasons why we made --format=%h a synonym
> to --pretty=tformat:%h and not --pretty=format:%h ;-)

Yeah. I have never found "--pretty=format" to do what I want versus
tformat. I wish we could just get rid of it, but I think it is likely to
be used as a plumbing interface.

So I think there probably _is_ a bug in it to be fixed, but my immediate
response is "don't ever use --pretty=format:".

-Peff
