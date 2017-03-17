Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3183520951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdCQX67 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:58:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:46329 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbdCQX66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:58:58 -0400
Received: (qmail 5683 invoked by uid 109); 17 Mar 2017 22:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 22:58:51 +0000
Received: (qmail 7757 invoked by uid 111); 17 Mar 2017 22:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 18:59:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 18:58:48 -0400
Date:   Fri, 17 Mar 2017 18:58:48 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fix build with no thread support
Message-ID: <20170317225847.g5776lntj7d5ni3v@sigill.intra.peff.net>
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
 <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
 <20170317184701.GB110341@google.com>
 <20170317223741.qwfh2zw37y3jbeev@sigill.intra.peff.net>
 <20170317224232.GE63813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317224232.GE63813@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 03:42:32PM -0700, Brandon Williams wrote:

> > > I didn't take a close look at it but this would seem to indicate that we
> > > don't worry to much about systems without pthreads support.  Just food
> > > for thought.
> > 
> > Hmm. We used to. What version did you test? Everything passes for me at
> > 0281e487f^ (after that it fails to build). So AFAICT v2.12.0 is the
> > first release which does not work with NO_PTHREADS.
> > 
> > -Peff
> 
> The version I ran tests on was what the master branch was pointing to a
> day or so ago:
> 
> v2.12.0-264-gd6db3f216

Ah, OK. I couldn't get such a recent version to build with NO_PTHREADS,
but I assume you mean after applying your two patches.

v2.11.0 is fine, but v2.12.0 with your patches shows the problem.
Bisecting (and applying the patches when necessary) points to my
46df6906f (execv_dashed_external: wait for child on signal death,
2017-01-06).

-Peff
