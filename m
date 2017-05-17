Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816DC2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbdEQCFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:05:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdEQCFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:05:37 -0400
Received: (qmail 24641 invoked by uid 109); 17 May 2017 02:05:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 02:05:37 +0000
Received: (qmail 2511 invoked by uid 111); 17 May 2017 02:06:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 22:06:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 22:05:35 -0400
Date:   Tue, 16 May 2017 22:05:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate and partially work around a
 gitattributes problem
Message-ID: <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
 <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
 <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
 <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 10:38:36AM +0900, Junio C Hamano wrote:

> > -			add_pending_object(revs, a_obj, this);
> > -			add_pending_object(revs, b_obj, next);
> > +			add_pending_object_with_path(revs, a_obj, this,
> > +						     oc.mode,
> > +						     oc.path[0] ? oc.path : NULL);
> > +			add_pending_object_with_path(revs, b_obj, next,
> > +						     oc2.mode,
> > +						     oc2.path[0] ? oc2.path : NULL);
> 
> The fix is surprisingly simple, and I think it definitely goes in
> the right direction.
> 
> Somehow, it bothers me to be forced to view (a_obj, this, from_sha1,
> oc) vs (b_obj, next, sha1, oc2) as a sensibly corresponding pair of
> tuples, but that is not something your introduction of "oc2"
> started, so I won't complain ;-).

Yes, in my polishing I switched this out at least "oc_a" and "oc_b" so
we could be sure they match correctly. I think this whole "dotdot"
conditional could be pulled out to its own function, and probably
consistently use "a" and "b" for the endpoints. I'll see what
refactoring I can do to make it more readable.

-Peff
