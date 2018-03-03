Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDAC1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 07:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeCCHQQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 02:16:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:45466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750892AbeCCHQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 02:16:15 -0500
Received: (qmail 13855 invoked by uid 109); 3 Mar 2018 07:16:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 07:16:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3966 invoked by uid 111); 3 Mar 2018 07:17:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 02:17:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 02:16:13 -0500
Date:   Sat, 3 Mar 2018 02:16:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Damien =?utf-8?B?TWFyacOp?= <damien@dam.io>
Subject: Re: [PATCH v3] run-command: add hint when a hook is ignored
Message-ID: <20180303071613.GC17312@sigill.intra.peff.net>
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
 <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
 <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com>
 <xmqqmv4ymc7w.fsf@gitster.mtv.corp.google.com>
 <20180103083145.GA7049@sigill.intra.peff.net>
 <xmqqk1wwcd2w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1wwcd2w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 11:36:39AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The problem is that I was bisecting an unrelated change in old code, and
> > I built a commit which predates f98f8cbac0 (Ship sample hooks with .sample
> > suffix, 2008-06-24). That wrote a bare "update" file into templates/blt
> > (without the ".sample" suffix). After that, the cruft is forever in my
> > build directory until I "git clean -x".
> >
> > The t5523 script tries to run "git push --quiet" and make sure that it
> > produces no output, but with this setup it produces a round of "hint"
> > lines (actually, they come from receive-pack on the remote end but still
> > end up on stderr).
> >
> > So that raises a few interesting questions to me:
> >
> >   1. Should receive-pack generate these hints? They get propagated by
> >      the client, but there's a reasonable chance that the user can't
> >      actually fix the situation.
> 
> True.  The user could tell the server operator to rename them or
> remove them because they are not doing anything useful, but then
> as long as everybody knows they are not doing anything, it is OK
> to leave that sleeping dog lie, as they are not doing anything
> harmful anyway.
> 
> That brings us one step further back to question if the hints are
> useful in the first place, though ;-).

Yes, that last paragraph definitely crossed my mind. Do we have an
opinion on doing anything here? (E.g., declaring the hints not worth the
trouble and reverting them versus just living with it)?

-Peff
