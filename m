Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733C01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 00:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeGTBjr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 21:39:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727615AbeGTBjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 21:39:47 -0400
Received: (qmail 18162 invoked by uid 109); 20 Jul 2018 00:54:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 00:54:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18584 invoked by uid 111); 20 Jul 2018 00:54:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 20:54:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 20:54:04 -0400
Date:   Thu, 19 Jul 2018 20:54:04 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720005404.GA2179@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <CAGZ79ka1yHb-485xc-sAK5iVkeyWJq4Q2g-7jzEgHuVUWLBXKg@mail.gmail.com>
 <20180719213222.GB13151@sigill.intra.peff.net>
 <CAGZ79kaqgF5zNC0X5+EnuPhYiaav9JiSsgeXF=deryS3sKYq2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaqgF5zNC0X5+EnuPhYiaav9JiSsgeXF=deryS3sKYq2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 02:47:35PM -0700, Stefan Beller wrote:

> > But that may be overly paranoid.  Once upon a time there was some rules
> > lawyering around CodingGuidelines, but I think that was successfully
> > shut down and hasn't reared its head for several years.
> 
> Heh; My preference would be to keep docs as short and concise as
> possible (and lawyering sounds like "verbosity is a feature" :-P) but
> still giving advice on controversial (i.e. not enforced by a machine in
> a deterministic fashion) things such as having braces around one
> statement for example or leaving them out.

I think we literally had somebody say "I don't have to abide by this in
a review because it wasn't in CodingGuidelines." But then, that is
perhaps indicative of other problems.

> So maybe I would have rather asked, why we start out with these two
> functions. And you seem to call them "obviously bad", and you take both
> of them because they need to be handled differently due to the variadic macros.
> (And those two are "obviously worse" than strcat, as they are used more often.
> But strcat, being on MS ban list[1], would do just as fine)

Ooh, strcat is another one that should be added.

I actually thought about splitting it into three commits (introduce
mechanism, then one per function), but it felt like stringing it out.
You are probably right, though, that each function deserves its own
explanation. And the commit message is already quite long.

> >   We'll include strcpy() and sprintf() in the initial list of banned
> >   functions. While these _can_ be used carefully by surrounding them
> >   with extra code, there's no inherent check that the size of the
> >   destination buffer is big enough, it's very easy to overflow the
> >   buffer.
> 
> Sounds good to me, maybe even add "We've had problems with that
> in the past, see 'git log -S strcpy'", but that may be too much again.

Actually, that's a good point. We've had actual bugs due strcpy(). I can
similarly point to bad uses of strcat().

I think I have sufficient fodder for a re-roll along these lines
(assuming we like the idea at all; Junio seemed to have some
reservations, but I'll reply there separately).

-Peff
