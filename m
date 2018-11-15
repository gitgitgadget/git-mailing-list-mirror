Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7D21F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 12:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKOWtD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 17:49:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:40506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728699AbeKOWtD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 17:49:03 -0500
Received: (qmail 24987 invoked by uid 109); 15 Nov 2018 12:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 12:41:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15345 invoked by uid 111); 15 Nov 2018 12:40:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 07:40:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 07:41:20 -0500
Date:   Thu, 15 Nov 2018 07:41:20 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing
 repositories
Message-ID: <20181115124119.GA25562@sigill.intra.peff.net>
References: <pull.73.git.gitgitgadget@gmail.com>
 <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com>
 <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet>
 <20181114213851.GA2960@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811151329150.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811151329150.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 01:29:58PM +0100, Johannes Schindelin wrote:

> > Do we actually care where the templates are? I thought the point was to
> > override for the built Git to use the built templates instead of the
> > installed one. For an installed Git, shouldn't we not be overriding the
> > templates at all? I.e.:
> > 
> >   if test -n "$GIT_TEST_INSTALLED"
> >   then
> > 	"$GIT_TEST_INSTALLED/git" init
> >   else
> > 	"$GIT_ExEC_PATH/git" init --template="$GIT_BUILD_DIR/templates/blt"
> >   fi >&3 2>&4
> > 
> > (That's all leaving aside the question of whether we ought to be using a
> > clean template dir instead of this).
> 
> I fear that that might buy us a ton of trouble. Just like we override the
> system config, we should override the templates.

Yes, it might. I guess it just seems plausible to me that somebody would
expect GIT_TEST_INSTALLED to be as close to the installed experience as
possible. I dunno. I do not use it myself.

At any rate, my point was that for GIT_TEST_INSTALLED, either:

  1. We can use a known-clean set of templates (either our local
     templates/blt, or an even-cleaner empty set).

or

  2. We do not need to specify any template, and it will just use
     whatever it came installed with.

And in either case, we do not have to worry about asking it "where are
your templates?".

-Peff
