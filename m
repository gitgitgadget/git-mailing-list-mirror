Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2787207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034842AbcIZRXy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:23:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:48181 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030192AbcIZRXy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:23:54 -0400
Received: (qmail 5349 invoked by uid 109); 26 Sep 2016 17:23:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 17:23:53 +0000
Received: (qmail 6434 invoked by uid 111); 26 Sep 2016 17:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:24:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 13:23:50 -0400
Date:   Mon, 26 Sep 2016 13:23:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 04/10] get_short_sha1: peel tags when looking for treeish
Message-ID: <20160926172350.ikqfnanrrj5oepmq@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926115947.hksmtkqp3i4tfftx@sigill.intra.peff.net>
 <xmqq7f9yvbwn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f9yvbwn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 09:55:20AM -0700, Junio C Hamano wrote:

> > Instead, we can use parse_object(). Note that this is the
> > same fix done by 94d75d1 (get_short_sha1(): correctly
> > disambiguate type-limited abbreviation, 2013-07-01), but
> > that commit fixed only the committish disambiguator, and
> > left the bug in the treeish one.
> 
> Can you share your secret tool you use to find this kind of thing?
> Yes, the patch from that commit does look very similar to what we
> see in this patch, but I'd love to see "I am fixing an incorrect
> call to lookup-object by replacing it with parse-object; has there
> been a similar fix?" automated ;-)

I wish there was an answer besides "persistence and patience". I was
just finishing up the commit message for the final patch, and noticed
that the tag was not present in the second example output, which happens
to use the tree-ish syntax. And I noticed it was doubly weird that the
same bug did not show up in the test scripts, which look for
committishes. That made me peek at the implementation, and from there it
was an easy `git blame` away.

-Peff
