Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BB420357
	for <e@80x24.org>; Fri, 14 Jul 2017 22:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdGNWnQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 18:43:16 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38478 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdGNWnP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 18:43:15 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dW9Ij-0000eG-Q9; Sat, 15 Jul 2017 07:43:09 +0900
Date:   Sat, 15 Jul 2017 07:43:09 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?iso-8859-15?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170714224309.7p4a4vuuv3k2cdjg@glandium.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
 <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
 <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
 <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 09:11:33AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Oh, absolutely.
> >
> > Here is another possible test balloon, that may actually be useful
> > as an example.  I think there is a topic in flight that touches this
> > array, unfortunately, so I probably would find another one that is
> > more stable for a real follow-up patch to the one from Peff.
> 
> And here it is.
> 
> As to other things that we currently not allow in our codebase that
> newer compilers can grok, here is what *I* think.  It is *not* meant
> to be an exhaustive "what's new in C99 that is not in C89? what is
> the final verdict on each of them?":
> 
>  - There were occasional cases where we wished if variable-length
>    arrays, flexible array members and variadic macros were available
>    in our codebase during the course of this project.  We would
>    probably want to add a similar test baloon patch for each of
>    them to this series that is currently two-patch long.

FWIW, variadic macros have subtle implementation differences that can
cause problems.
For instance, MSVC only supports ##__VA_ARGS__ by way of
ignoring ## somehow, but has the default behavior of dropping the comma
when __VA_ARGS__ is empty, which means , __VA_ARGS__ *without* ## has a
different behavior.
See also https://connect.microsoft.com/VisualStudio/feedback/details/380090/variadic-macro-replacement

Mike
