Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255F81FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 05:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965052AbdJRF2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 01:28:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:56238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965034AbdJRF2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 01:28:48 -0400
Received: (qmail 9076 invoked by uid 109); 18 Oct 2017 05:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 05:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29437 invoked by uid 111); 18 Oct 2017 05:28:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 01:28:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 01:28:45 -0400
Date:   Wed, 18 Oct 2017 01:28:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171018052845.y54l6cd3dz64l5i4@sigill.intra.peff.net>
References: <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
 <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
 <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
 <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
 <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
 <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
 <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
 <xmqqvajenvce.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvajenvce.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 03:26:25PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> After pondering over it, I have a slight preference for that, too. But
> >> I'm also happy to hear more input.
> >
> > OK, so it seems we both have slight preference for the "peel back"
> > approach.  Adding Jonathan to Cc:
> 
> It was a bit more painful than necessary to make sure I have
> something that can be merged for 2.14.x maintenance track, but I
> think the topic is now in a reasonable shape, and I've merged it to
> 'next'.  On the first-parent chain from 'master' to 'pu', the merge
> of this topic is the very first one, and after reading it over once
> again, I think this is OK.

Hmm. I think you would just want the top two commits for maint-2.14
(reverting 136c8c8b8f and fixing up git-tag to check color config). But
of course you can't do a partial merge because they come on top of the
other dead-end/revert pair. You'd have to cherry-pick (and even then fix
up a few bits, like adding in the "add -p" test).

Though if we take all of jk/ui-color-always-to-auto-maint, and then do
the whole reversion on top of that, I think that should work. It just
doesn't look like that topic ever made it to "maint" (I see mention of a
jk/ref-filter-colors-fix-maint in the log for master, but there's no
such branch).

I started to prepare a patch directly on v2.14.2 just to see what it
would look like. The first one (the revert) is fine, but we then have to
fixup tag and for-each-ref. And since they don't have --color added by
the dead-end fixups, the tests get harder...

-Peff
