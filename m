Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFEA1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 07:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeJZQWh (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:22:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:55420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725950AbeJZQWh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:22:37 -0400
Received: (qmail 945 invoked by uid 109); 26 Oct 2018 07:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Oct 2018 07:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26063 invoked by uid 111); 26 Oct 2018 07:45:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Oct 2018 03:45:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2018 03:46:38 -0400
Date:   Fri, 26 Oct 2018 03:46:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
Message-ID: <20181026074638.GA3119@sigill.intra.peff.net>
References: <20181023191758.15138-1-agruenba@redhat.com>
 <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
 <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
 <20181025104542.GA14455@sigill.intra.peff.net>
 <xmqqtvl9fv86.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvl9fv86.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 08:43:37AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > An easy test is:
> >
> >   $ git rev-list --no-walk --exclude='*' --all --all
> >   3289ca716320457af5d2dd550b716282ad22da11
> >   ...a bunch of other tip commits...
> >
> >   $ git rev-parse --exclude='*' --all --all
> >   [no output, but it should print those same tip commits]
> 
> I actually was hoping to see a test that contrasts "--all" (which
> lacks the alleged "clear exclude" bug) with another option that does
> have the "clear exclude", both used with rev-parse, i.e.
> 
>     $ git rev-parse --exclude='*' --glob='*' --glob='*'
>     ... all the ref tips ...
>     $ git rev-parse --exclude='*' --all --all
>     ... ought to be equivalent, but is empty due to the bug ...
> 
> would have been a good demonstration that shows what bug we are
> fixing d(and would have been a good test to accompany the patch.

Yeah, I agree that would be fine, too. I think there are two dimensions
in which to look at the problem, like so:

         rev-list  rev-parse
         --------  ---------
--glob    clears    clears
--all     clears    does not clear

Testing either the row or the column (or both) works for me. :)

-Peff
