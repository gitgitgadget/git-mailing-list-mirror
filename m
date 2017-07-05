Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6F2202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbdGEVb7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 17:31:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:60458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753246AbdGEVbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 17:31:48 -0400
Received: (qmail 22707 invoked by uid 109); 5 Jul 2017 21:31:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 21:31:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10617 invoked by uid 111); 5 Jul 2017 21:31:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 17:31:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 17:31:35 -0400
Date:   Wed, 5 Jul 2017 17:31:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 5/6] rev-list: check reflog_info before showing usage
Message-ID: <20170705213135.wlijd5kum5lyh752@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080655.giw6wjsblepcf5aw@sigill.intra.peff.net>
 <xmqqd19eiwpk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd19eiwpk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2017 at 11:07:35AM -0700, Junio C Hamano wrote:

> > This is actually the main "gotcha" I'm worried about with this series.
> > I'm not sure if any other code would care about seeing the pending items
> > in revs->commits. I still think the series is the right direction; if
> > there is such a place, we'd want to teach it to handle reflog walking in
> > a similar way, too.
> 
> Ah, very good thinking---when I was following along your drafts to
> bypass the revs.commits queue for reflog walking, I didn't think of
> this one.  
> 
> Perhaps "!revs.commits && reflog_walk_empty(revs.reflog_info)" may
> want to become a macro "walk_finished(&revs)" or something to
> replace existing !revs.commits that is not accompanied by the check
> on .reflog_info field?

Yeah, I had the same thought. But I don't think it's really worth adding
a helper if we don't end up with another call-site. So I was stalling to
see if that happened.

(And just for reference in case we do end up adding it, it's not so much
walk_finished() as walk_empty_in_the_first_place()).

-Peff
