Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF2620248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCNAJR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:09:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:49982 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbfCNAJR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:09:17 -0400
Received: (qmail 30521 invoked by uid 109); 14 Mar 2019 00:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:09:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17625 invoked by uid 111); 14 Mar 2019 00:08:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:08:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:07:59 -0400
Date:   Wed, 13 Mar 2019 20:07:59 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
Message-ID: <20190314000759.GB31968@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
 <87k1h2bvpb.fsf@evledraar.gmail.com>
 <20190313163516.GA26045@sigill.intra.peff.net>
 <20190313165320.GA717@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903132327500.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903132327500.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 11:40:54PM +0100, Johannes Schindelin wrote:

> > > +	shift
> > > +	test -z "$*" ||
> > > +	echo "exec $0 $*" >>$GIT_REBASE_TODO
> > 
> > And here we do the same thing. That second redirection is unnecessary.
> 
> It is actually not unnecessary, but to the contrary quite necessary to
> achieve the intended effect: with this command, we append an `exec` line
> to the todo list that is guaranteed to be executed after the `pick`
> command that we added earlier.

Ah, right, I was totally misreading it. We are not execing _now_, but
rather appending an exec. And that explains my confusion about
recursion.

So your nice explanation below has gone to waste, because I have just
now understood what is going on. ;)

I agree that what you have here is probably the simplest way of
demonstrating the issue.

-Peff
