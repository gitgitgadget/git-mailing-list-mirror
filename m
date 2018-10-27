Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6037E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeJ0QA7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:00:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:56992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728212AbeJ0QA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:00:59 -0400
Received: (qmail 25401 invoked by uid 109); 27 Oct 2018 07:20:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:20:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4554 invoked by uid 111); 27 Oct 2018 07:20:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:20:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:20:57 -0400
Date:   Sat, 27 Oct 2018 03:20:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
Message-ID: <20181027072056.GA26545@sigill.intra.peff.net>
References: <20181023191758.15138-1-agruenba@redhat.com>
 <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
 <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
 <20181025104542.GA14455@sigill.intra.peff.net>
 <xmqqtvl9fv86.fsf@gitster-ct.c.googlers.com>
 <20181026074638.GA3119@sigill.intra.peff.net>
 <xmqq5zxnc17b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zxnc17b.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 04:12:40PM +0900, Junio C Hamano wrote:

> > Yeah, I agree that would be fine, too. I think there are two dimensions
> > in which to look at the problem, like so:
> >
> >          rev-list  rev-parse
> >          --------  ---------
> > --glob    clears    clears
> > --all     clears    does not clear
> >
> > Testing either the row or the column (or both) works for me. :)
> 
> OK, so let's not leave this loose end untied.  This may be good
> enough to squash in.
> [...]
> +test_expect_success 'rev-parse --branches clears --exclude' '
> +	compare rev-parse "--exclude=* --branches --branches" "--branches"
> +'
> +
> +test_expect_success 'rev-parse --tags clears --exclude' '
> +	compare rev-parse "--exclude=* --tags --tags" "--tags"
> +'
> +
> +test_expect_success 'rev-parse --all clears --exclude' '
> +	compare rev-parse "--exclude=* --all --all" "--all"
> +'

Yes, this looks good to me. In theory a more intricate test might catch
other kinds of bugs (e.g., a more limited exclude and making sure it was
applied correctly in each place), but I don't think it's really worth
the effort.

-Peff
