Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B971F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391490AbeIVD2j (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:28:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:55496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390726AbeIVD2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:28:39 -0400
Received: (qmail 3579 invoked by uid 109); 21 Sep 2018 21:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 21:37:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8545 invoked by uid 111); 21 Sep 2018 21:37:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 17:37:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 17:37:53 -0400
Date:   Fri, 21 Sep 2018 17:37:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180921213753.GA11177@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 02:14:17PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > +core.alternateRefsPrefixes::
> > +	When listing references from an alternate, list only references that begin
> > +	with the given prefix. Prefixes match as if they were given as arguments to
> > +	linkgit:git-for-each-ref[1]. To list multiple prefixes, separate them with
> > +	whitespace. If `core.alternateRefsCommand` is set, setting
> > +	`core.alternateRefsPrefixes` has no effect.
> 
> We do not allow anything elaborate like "refs/tags/release-*" but we
> still allow "refs/tags/" and "refs/heads/" by listing them together,
> and because these are only prefixes, whitespace is a reasonable list
> separator as they cannot appear anywhere in a refname.  OK.
> 
> Why is this "core"?  I thought this was more about receive-pack;
> even if this is going to be extended to upload-pack's negotiation,
> "core" is way too wide a hierarchy.  We have "transport.*" for
> things like this, no?

There's no extension necessary; these should already affect upload-pack
as well. I agree transport.* would cover both upload-pack and
receive-pack. If we extend it to check_everything_connected(), would it
make sense as part of transport.*, too?

I dunno. I guess I could see an argument either way.

If we do add "rev-list --alternate-refs", that pushes it even further
away from transport.*, though.

-Peff
