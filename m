Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF04D208E9
	for <e@80x24.org>; Fri, 27 Jul 2018 08:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeG0KBc (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 06:01:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:60844 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729420AbeG0KBc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 06:01:32 -0400
Received: (qmail 16035 invoked by uid 109); 27 Jul 2018 08:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Jul 2018 08:40:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23933 invoked by uid 111); 27 Jul 2018 08:40:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 27 Jul 2018 04:40:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2018 04:40:40 -0400
Date:   Fri, 27 Jul 2018 04:40:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tejun Heo <tj@kernel.org>, git@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] name_rev: add support for --cherry-picks
Message-ID: <20180727084039.GB11932@sigill.intra.peff.net>
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
 <20180726143930.GW1934745@devbig577.frc2.facebook.com>
 <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
 <20180726153714.GX1934745@devbig577.frc2.facebook.com>
 <xmqqr2jpq0s1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2jpq0s1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 12:01:34PM -0700, Junio C Hamano wrote:

> Tejun Heo <tj@kernel.org> writes:
> 
> > I should have explained the use case better.
> 
> No, you did not need to.  I was not saying the feature is not useful.
> I was only saying that "explain where in the history X sits" command
> (i.e. "name-rev X" and "describe X") did not look like a good place
> to have that feature.

Just brainstorming a few reasons you might not want it tied to name-rev:

 - the set of names might be distinct from the set of commits you'd want
   to traverse.  For instance, you might want to use "name-rev --tags",
   but find cherry-picks even on untagged branches (e.g., "--all").

 - instead of naming commits, you might want to see the information as
   you are viewing git-log output ("by the way, this was cherry-picked
   elsewhere, too")

So I kind of wonder if it would be more useful to have a command which
incrementally updates a git-notes tree to hold the mapping, and then
learn to consult it in various places. "git log --notes=reverse-cherry"
would show it, though it might be worth teaching the notes-display code
that certain types of notes contain object ids (so it would be
interesting to recursively show their notes, or format them nicely,
etc).

I dunno. That is perhaps over-engineering. But it feels like
"reverse-map the cherry-picks" is orthogonal to the idea of name-rev.

-Peff
