Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB90211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 15:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfAKPfo (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 10:35:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:33778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728632AbfAKPfo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 10:35:44 -0500
Received: (qmail 31833 invoked by uid 109); 11 Jan 2019 15:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 15:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10413 invoked by uid 111); 11 Jan 2019 15:35:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 10:35:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 10:35:42 -0500
Date:   Fri, 11 Jan 2019 10:35:42 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Make "git log --count" work like "git rev-list"
Message-ID: <20190111153541.GC16754@sigill.intra.peff.net>
References: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
 <20190109195428.GA12645@sigill.intra.peff.net>
 <xmqq5zuw17g8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zuw17g8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 02:19:51PM -0800, Junio C Hamano wrote:

> > I know "--follow" is a bit hacky in general, but I think there are other
> > cases where log_tree_diff() may decide not to show a commit (maybe
> > without --root, though I guess that's the default these days).
> >
> > I dunno. Certainly respecting "--count" even for the simple cases is an
> > improvement over the status quo. Maybe it would be enough to give a
> > warning in the manpage that it may not work with exotic options.
> 
> Hmph, perhaps.  I wonder if it is easy enough to redirect the entire
> codeflow to that of rev-list when we see --count in cmd_log().

Interesting idea. I think it might end up creating weird inconsistencies
for other cases, though (e.g., log respecting config like log.showroot
that rev-list does not).

I suppose it depends on whether we want to advertise that "log --count"
is just a convenience wrapper for "rev-list --count". Personally, that
sounds hacky to me. I'd expect "log --count <options>" to give the same
answer as "log --oneline <options> | wc -l".

-Peff
