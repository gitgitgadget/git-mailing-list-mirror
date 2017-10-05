Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2C82036B
	for <e@80x24.org>; Thu,  5 Oct 2017 10:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdJEKGS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:06:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:33362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751412AbdJEKGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:06:17 -0400
Received: (qmail 16774 invoked by uid 109); 5 Oct 2017 10:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 10:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25955 invoked by uid 111); 5 Oct 2017 10:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 06:06:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 06:06:15 -0400
Date:   Thu, 5 Oct 2017 06:06:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171005100615.khtsy4snduarin2i@sigill.intra.peff.net>
References: <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
 <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
 <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
 <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
 <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
 <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
 <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
 <xmqqpoa4h5y7.fsf@gitster.mtv.corp.google.com>
 <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
 <xmqqr2ujfwia.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2ujfwia.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 11:59:57AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's what I came up with on the "color.ui=always is nonsense that we
> > should not offer" front. The number of patches may be a little daunting,
> > but most of them are just removing cases of "git -c color.ui=always"
> > from the tests.
> >
> >   [01/12]: test-terminal: set TERM=vt100
> >   [02/12]: t4015: prefer --color to -c color.diff=always
> >   [03/12]: t4015: use --color with --color-moved
> >   [04/12]: t3701: use test-terminal to collect color output
> >   [05/12]: t7508: use test_terminal for color output
> >   [06/12]: t7502: use diff.noprefix for --verbose test
> >   [07/12]: t6006: drop "always" color config tests
> >   [08/12]: t3203: drop "always" color test
> >   [09/12]: t7301: use test_terminal to check color
> >   [10/12]: t3205: use --color instead of color.branch=always
> >   [11/12]: provide --color option for all ref-filter users
> >   [12/12]: color: make "always" the same as "auto" in config
> 
> I'm shuffling these so that everything except 03/12 and 09/12 goes
> on top of jk/ref-filter-colors (to be merged later for v2.14.x) to
> create jk/ui-color-always-to-auto-maint branch.

Thanks, I was so busy slogging through the set of broken tests that I
didn't even think that some of the cases would not be available on
maint.  Sorry to create work for you in untangling it.

> Another branch jk/ui-color-always-to-auto would fork from 'master'
> and have 03/12 and 09/12 (with a tweak to use vt100 explicitly, as
> we lack 01/12 at that point) applied, and then merge the above one.
> And then queuing another one that drops "env TERM=vt100" tweak added
> to 09/12 would bring us to the same state as applying your 12 patches
> directly on top.  That will cook in 'next' down to 'master' to make
> sure we do not regress in 2.15.

I eyeballed what you pushed out, and it all looks good to me (looks like
you did that final tweak as part of the merge of the two branches).

-Peff
