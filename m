Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4961F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbcHASHM (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:07:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:52658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753949AbcHASHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:07:10 -0400
Received: (qmail 9484 invoked by uid 102); 1 Aug 2016 18:07:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:07:10 -0400
Received: (qmail 15570 invoked by uid 107); 1 Aug 2016 18:07:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:07:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 14:07:07 -0400
Date:	Mon, 1 Aug 2016 14:07:07 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
Message-ID: <20160801180707.rw6drvk5dsgy6joi@sigill.intra.peff.net>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
 <CACsJy8AEFFTnGw01mTBrZu8QnUWmQav7bhZUyw7o91ph7DUwaA@mail.gmail.com>
 <20160801175216.payv2zrc3mkvkbmz@sigill.intra.peff.net>
 <CACsJy8CLNtbAvRxVtX_9qZ0cahce7cFfk=wh78Wm99Qf5B8HRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CLNtbAvRxVtX_9qZ0cahce7cFfk=wh78Wm99Qf5B8HRw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 08:01:13PM +0200, Duy Nguyen wrote:

> > If you are interested, I suggest you read the thread linked earlier:
> >
> >   https://public-inbox.org/git/52D87A79.6060600%40rawbw.com/T/#u
> >
> > which discusses this and other issues. But basically, I think you cannot
> > really solve this without getting intimate with each pager (which people
> > seemed not to want to do).
> 
> Cooking pager specifics in git does sound bad. But it does not have to
> be that way. What if we delegate the decision whether to color or not
> to a script (e.g. by setting color.ui= "script <path to the script>")?
> The script has all the info (env variables, uname, user preference...)
> and can make a better decision than 'is stdout a tty?'. It's not about
> out of the box experience, more towards customization (without
> fragmenting .gitconfig files too much).

It sounds like we are solving two separate problems.

I was mostly concerned with the out-of-the-box experience. E.g., you
build git and run "git log" and it prints out gibberish, either because
of your $PAGER or your $LESS settings (which you might have set years
ago).

For more advanced usage like yours, I'd shove any personal logic into a
wrapper around your pager script.  I think the particular decision you
want, though, is related to color.pager, which is outside that scope.
I'm not sure exactly what your setup looks like, but I wonder if it
would be served by better config support (i.e., why do you need a script
to dynamically look at your pager and see if color.pager should be
turned on; can't you configure both at the same time?).

-Peff
