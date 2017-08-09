Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9AA1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 12:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdHIMEh (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:04:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:33170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752472AbdHIMEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:04:35 -0400
Received: (qmail 2009 invoked by uid 109); 9 Aug 2017 12:04:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:04:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26539 invoked by uid 111); 9 Aug 2017 12:04:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:04:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:04:32 -0400
Date:   Wed, 9 Aug 2017 08:04:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170809120432.am77utnrnkh6mpgt@sigill.intra.peff.net>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
 <87bmnvktee.fsf@linux-m68k.org>
 <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
 <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
 <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
 <xmqqzibcqhy9.fsf@gitster.mtv.corp.google.com>
 <20170808072510.leb525df4hmbwcvo@sigill.intra.peff.net>
 <xmqqk22ec84i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk22ec84i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 09:54:53AM -0700, Junio C Hamano wrote:

> > For comparison, nothing older than curl 7.19.4 will work for building
> > Git since v2.12.0, as we added some unconditional uses of CURLPROTO_*
> > there. Nobody seems to have noticed or complained. I pointed this out a
> > few months ago[1] and suggested we clean up some of the more antiquated
> > #if blocks in http.c that don't even build. There was some complaint
> > that we should keep even these ancient versions working, but the
> > compile error is still in "master".
> >
> > So it's not clear to me that anybody cares about going that far back
> > (which is mid-2009), but I'd guess that 2013 might cause some problems.
> >
> > [1] https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/
> >     if you're curious (you were offline for a while at that time, I
> >     think).
> 
> Thanks for digging.  It would not help the issue on this thread at
> all.  While I agree with your conclusion in the quoted thread:
> 
>     I think it might be nice to declare a "too old" version, though,
>     just so we can stop adding _new_ ifdefs. Maybe 7.11.1 is that
>     version now, and in another few years we can bump to 7.16.0. :)
> 
> it appears that we silently declared it to 7.19.4 and found out that
> nobody complained, without us having to wait for a few years?

Yeah, I think the 7.19.4 breakage was discussed after I wrote that (and
after investigating, I think the 7.16.0 cutoff is probably pretty
reasonable even without that). I do think it's worth addressing. I just
sent a series:

  https://public-inbox.org/git/20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net/

-Peff
