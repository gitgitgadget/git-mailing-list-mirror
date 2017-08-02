Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98CA20899
	for <e@80x24.org>; Wed,  2 Aug 2017 23:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdHBXLR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 19:11:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:56346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751073AbdHBXLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 19:11:17 -0400
Received: (qmail 7391 invoked by uid 109); 2 Aug 2017 23:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 23:11:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14510 invoked by uid 111); 2 Aug 2017 23:11:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 19:11:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 19:11:15 -0400
Date:   Wed, 2 Aug 2017 19:11:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] revision: add rev_input_given flag
Message-ID: <20170802231114.oqf5ms47mccpjwhp@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
 <20170802222527.mnn7e6hlyevsgk7a@sigill.intra.peff.net>
 <xmqqd18dr3rj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd18dr3rj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 03:41:52PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Normally a caller that invokes setup_revisions() has to
> > check rev.pending to see if anything was actually queued for
> > the traversal. But they can't tell the difference between
> > two cases:
> >
> >   1. The user gave us no tip from which to start a
> >      traversal.
> >
> >   2. The user tried to give us tips via --glob, --all, etc,
> >      but their patterns ended up being empty.
> >
> > Let's set a flag in the rev_info struct that callers can use
> > to tell the difference.  We can set this from the
> > init_all_refs_cb() function.  That's a little funny because
> > it's not exactly about initializing the "cb" struct itself.
> > But that function is the common setup place for doing
> > pattern traversals that is used by --glob, --all, etc.
> 
> ...and "--bisect", which is an oddball so we probably do not have to
> care.  I didn't check if there is a fallout on that codepath.

Yeah, I saw that one and figured it should probably as "input given".
There's also "--reflog" and "--indexed-objects", which aren't covered
here. I'm not sure if anybody really cares (you'd generally use them
with "--all" anyway), so I left them out for now.

-Peff
