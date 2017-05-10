Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634D72018D
	for <e@80x24.org>; Wed, 10 May 2017 04:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdEJEgt (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 00:36:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:48588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbdEJEgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 00:36:49 -0400
Received: (qmail 15006 invoked by uid 109); 10 May 2017 04:36:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 04:36:49 +0000
Received: (qmail 32076 invoked by uid 111); 10 May 2017 04:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 00:37:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 May 2017 00:36:46 -0400
Date:   Wed, 10 May 2017 00:36:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
Message-ID: <20170510043646.seh73ejdperb2ym7@sigill.intra.peff.net>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
 <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705091244420.146734@virtualbox>
 <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net>
 <xmqq8tm51wch.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tm51wch.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 07:47:26AM +0900, Junio C Hamano wrote:

> > Yes, the script predates the invention of worktrees by several years. I
> > have occasionally played with worktrees, but don't use them extensively
> > (I'd usually use them for a one-off change, and then remove the
> > worktree).
> 
> I check out a different Meta/ at the top-level of my working tree
> when working on Git, but I do use an equivalent of "worktree" to
> have separate build areas for four integration branches.  It is
> trivial to check out Meta/ just once to the primary working tree and
> symlink it to others ;-)

Yeah, I guess I'd need to do that, too, if I used worktrees extensively.
I think the specific problem with the rebase script is just that it
expects to be able to checkout all the branches.

> One thing that struck me odd about your "rebase" script was that it
> didn't seem to have a special provision to handle a topic that
> builds on another topic. I saw toposort, but is that sufficient?

It topo-sorts so that a single run rebases everything (otherwise you may
need to run N times, where N is the deepest dependency chain). But it
also uses reflogs to try to find the fork point when the upstream topic
has been rebased.

The logic is in find_base(). Once upon a time it used "git pull
--rebase", but there were some complications. These days I think it
could probably use "rebase --fork-point", but I just never got around to
testing it.

-Peff
