Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001C82018B
	for <e@80x24.org>; Mon, 27 Jun 2016 19:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbcF0Tvm (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:51:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:33666 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752187AbcF0Tvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:51:41 -0400
Received: (qmail 5011 invoked by uid 102); 27 Jun 2016 19:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:51:40 -0400
Received: (qmail 12936 invoked by uid 107); 27 Jun 2016 19:51:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:51:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:51:38 -0400
Date:	Mon, 27 Jun 2016 15:51:38 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627195138.GA15147@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
 <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
 <20160627191720.GE9594@sigill.intra.peff.net>
 <CAGZ79kZWfGJG=qHtdpuLvQY5XK5P3L0UW7RJ=9ui=PgX+AjErQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZWfGJG=qHtdpuLvQY5XK5P3L0UW7RJ=9ui=PgX+AjErQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 12:43:32PM -0700, Stefan Beller wrote:

> There are a few issues:
> 
>     1) How did you spot the bug? ("Experience/Logical thinking" is the hand
>       wavy answer, but if you had a list like
>       [ ] check for mem leak
>       [ ] check for futureproof design
>       [ ] check for failure modes (What if a syscall fails?")
>       [ ] ... List is not complete, but has some made up points

I use the hand-wavy approach to reviews, and I'm pretty sure that's how
I saw your bug (just thinking about what the code would do, how I would
write it, and then noticing a discrepancy).

I suspect a checklist could make things more thorough, but I think it
can also discourage deep thinking. Ideally we have some reviewers who
are checklist-oriented looking for those sorts of details and some who
are not.

>     2) I used to send out only "done"s, i.e. when I already fixed the
>     issue, instead of acknowledging the problem and postponing the fix
>     for later.  I'll revert to that.

Yes, I tend to use the review thread as a todo list, and do a single
session where I read over all of the review mails again (even if I've
read and responded to them already), fixing or adjusting the code. Sort
of a human version of the automated tool I described. :)

> > Of course, none of that would have helped my comment, which was in a
> > "PS" several emails deep in a discussion thread. ;)
> 
> Maybe a "P.S." would get its own point in the todo list not associated
> with code?  Then it would still be on the radar.

Yes, there are definitely design points that are not about a specific
part of the code, and you would want to somehow represent them in your
todo list.

There is a danger, though, of having a bunch of false positives added to
your list: tangent discussion that distracts you from the actual review.
And I think the bug here being in a PS is less relevant than being
buried amidst other discussion. That made it hard for a tool _or_ a
human to find.

-Peff
