Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6AE20986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbcJDS2G (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:28:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52255 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754065AbcJDS2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:28:05 -0400
Received: (qmail 8832 invoked by uid 109); 4 Oct 2016 18:28:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 18:28:04 +0000
Received: (qmail 8395 invoked by uid 111); 4 Oct 2016 18:28:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 14:28:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 14:28:01 -0400
Date:   Tue, 4 Oct 2016 14:28:01 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] push: change submodule default to check
Message-ID: <20161004182801.j3fdpewybatmibpo@sigill.intra.peff.net>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
 <20161004164036.6584-1-sbeller@google.com>
 <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
 <CAGZ79kaKOjqLBsNVSmudzLUCkOJf_CsFGE8OZZHsTmuXCfiVeg@mail.gmail.com>
 <20161004175449.gn5cw6wcbvloqkzj@sigill.intra.peff.net>
 <xmqq7f9ouh1t.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYQsXxzXihtzC70Oj29RAe=8+nuJeUWNmbF17C75xbEag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYQsXxzXihtzC70Oj29RAe=8+nuJeUWNmbF17C75xbEag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 11:08:33AM -0700, Stefan Beller wrote:

> On Tue, Oct 4, 2016 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> >> Actually, I like that a bit better. It would not cover the case where
> >> you have not actually checked out any of the submodules (or at least not
> >> called "submodule init", I guess?). But arguably that is a sign that the
> >> auto-recurse behavior should not be kicking in anyway.
> >
> > Yeah, the "no init, no recursion" line of thought is very sensible.
> > I like it.
> 
> Bear in mind that "submodule init" only fuzzes around with .git/config.
> It doesn't touch .git/modules (i.e. cloning/fetching), that is to be done
> with the update command.
> 
> So if we also want to cover the case of init'd submodules, but not
> cloned/checked out submodules, we'd rather want to consult .git/config
> whether there is any submodule.* option set, though that seems more
> expensive than just checking for files inside the modules directory.

Consulting .git/config is fine, I think. It's not like we don't read it
(sometimes multiple times!) during the normal course of the program
anyway. It's just a question of whether it makes more sense for the
heuristic to kick in after "init", or only after "update". I don't know
enough to have an opinion.

-Peff
