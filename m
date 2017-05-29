Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0101FD09
	for <e@80x24.org>; Mon, 29 May 2017 04:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdE2E6z (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 00:58:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:59205 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbdE2E6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 00:58:55 -0400
Received: (qmail 30606 invoked by uid 109); 29 May 2017 04:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 04:58:51 +0000
Received: (qmail 13540 invoked by uid 111); 29 May 2017 04:59:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 00:59:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 May 2017 00:58:44 -0400
Date:   Mon, 29 May 2017 00:58:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Andreas Heiduk <asheiduk@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: filter-branch does not require re-export of vars
Message-ID: <20170529045843.ynbsfrwnefoyxwrm@sigill.intra.peff.net>
References: <20170526173654.4238-1-asheiduk@gmail.com>
 <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
 <CAJZjrdVjeeHUN_biza-MA9iqP5Y5CO3DkLaGG-Bq1w5oo5tW_g@mail.gmail.com>
 <xmqqa85w8eym.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa85w8eym.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 01:27:45PM +0900, Junio C Hamano wrote:

> Samuel Lijin <sxlijin@gmail.com> writes:
> 
> >> However, I think POSIX mandates the behavior you'd expect. And the only
> >> shell I know that misbehaves in this way is Solaris /bin/sh, which we
> >> have already declared too broken to support.
> >
> > Off-topic, but where is this explicitly documented?
> 
> One link I had readily available was
> 
>   https://public-inbox.org/git/7vei5qtnc5.fsf@alter.siamese.dyndns.org/
> 
> but there may be older discussions that were the actual process of
> our officially having "written its /bin/sh off as broken and
> unusable" if you dig further in the list archive.

Ah, I had taken Samuel's question as "where is the POSIX behavior
documented". :)

The link above is a good explanation of the $() problem on Solaris. It
also doesn't do ${parameter#word}. I couldn't find a specific moment of
outlawing that /bin/sh, but there are several mentions of problems with
it going back to the beginning. Here's one from 2007:

  http://public-inbox.org/git/7vabt9sasl.fsf@assigned-by-dhcp.cox.net/

We had already given up on it by then.

I don't think there's anything in CodingGuidelines (though t/README does
call it "broken"), though it explicitly endorses $(), which rules out
Solaris /bin/sh.

I think we found in the last year or two that there are some old
versions of ksh that don't like our scripts (definitely ksh88, and maybe
ksh93?). Some light reading for the curious:

  http://public-inbox.org/git/CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com/

  http://public-inbox.org/git/CALR6jEjWjJA0X2qXsxqObqc_yxrgX87LYf8cmJ0MmJFF6PkmTQ@mail.gmail.com/

  http://public-inbox.org/git/xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com/

The problems are around backslash-escaping, signal exit codes, and
doubled parentheses. There are some patches, but I think we decided not
to pursue it (I couldn't find that exact decision, but it's referenced
later on).

-Peff
