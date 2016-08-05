Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EA61F859
	for <e@80x24.org>; Fri,  5 Aug 2016 11:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbcHEL7j (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 07:59:39 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:57316 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934333AbcHEL7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 07:59:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 9207746324A;
	Fri,  5 Aug 2016 12:59:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fHyECOOM8No; Fri,  5 Aug 2016 12:59:32 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id E2BC4463009;
	Fri,  5 Aug 2016 12:59:31 +0100 (BST)
Date:	Fri, 5 Aug 2016 12:59:11 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	dborowitz@google.com, Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160805115911.GA4787@salo>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 09:42:18AM -0700, Stefan Beller wrote:
> On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >> If we were to change our workflows drastically, I'd propose to
> >> go a way[1] similar to notedb in Gerrit, or git-series,
> >
> > Gerrit is a huge, non-distributed system. Complex, too. If we change the
> > patch submission process, we should make things *easier*, not *harder*. So
> > I think Gerrit is pretty much out of the question.
> 
> I did not propose to use Gerrit or git-series or git appraise.
> 
> However whenever I see these projects talking to each other, the talk focuses on
> a "unified review storage format" pretty often, which would make them compatible
> with each other. So then I could choose git-series, while you could go with
> git appraise (although that is written in go, so maybe too fancy already ;)
> Or there could be another new program written in C that follows the "review
> format".

This "unified review storage format" really does seem to be the missing
piece. The tool I've been working on for the past year (git-candidate)
was initially aimed at contrib[1], and was written in perl solely
to satisfy contrib rules. It would have been python otherwise.

The feedback from that thread[1], was that while git-candidate itself
seemed interesting it would be unreasonable to bless a particular
tool's format. So it seems to me that even if git-series had been
written in perl rather than rust it could have expected a similar
response to that of git-candidate, possibly.

As Stefan says, if we're able to establish a standard for storing
review data in git then it doesn't really matter what the tools are written in.

For what it's worth my possibly quite shoddy attempt at a library
implementing a possible review format for git[2] is written in perl,
mostly to satisfy contrib requirements.

> >
> > Even requiring every contributor to register with GitHub would be too much
> > of a limitation, I would wager.
> >
> > And when I said I have zero interest in tools that use the "latest and
> > greatest language", I was hinting at git-series. Rust may be a fine and
> > wonderful language. Implementing git-series in Rust, however, immediately
> > limited the potential engagement with developers dramatically.

Ironically contrib's language requirements actually raised the bar for me
because it meant that I had to learn perl.

> >
> > Additionally, I would like to point out that defining a way to store
> > reviews in Git is not necessarily improving the way our code contribution
> > process works. If you want to record the discussions revolving around the
> > code, I think public-inbox already does a pretty good job at that.

I agree, and must apologise if this response has been too off topic,
in any case I hope at least some of it was useful to someone.

Hope this helps,
Richard Ipsum

[1]: http://www.mail-archive.com/git%40vger.kernel.org/msg80972.html
[2]: https://bitbucket.org/richardipsum/perl-notedb
