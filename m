Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D0F1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdAYSv4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:51:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:44637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbdAYSvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:51:55 -0500
Received: (qmail 25984 invoked by uid 109); 25 Jan 2017 18:51:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:51:55 +0000
Received: (qmail 14308 invoked by uid 111); 25 Jan 2017 18:51:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 13:51:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 13:51:53 -0500
Date:   Wed, 25 Jan 2017 13:51:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation
 based on GNU's qsort_r(1)
Message-ID: <20170125185153.obqwxiniyz2omxsi@sigill.intra.peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de>
 <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com>
 <4e416167-2a33-0943-5738-79b4da5f2c11@web.de>
 <20170124203949.46lbmiyj26xx4hrk@sigill.intra.peff.net>
 <f41e5053-ee24-060f-0fb9-b257b3ba35a0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f41e5053-ee24-060f-0fb9-b257b3ba35a0@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 07:43:01PM +0100, René Scharfe wrote:

> We could track processor time spent and memory allocated in QSORT_S and the
> whole program and show a warning at the end if one of the two exceeded, say,
> 5% of the total, asking nicely to send it to our mailing list.  Would
> something like this be useful for other functions or metrics as well?  Would
> it be too impolite to use users as telemetry transports?

Frankly, that sounds a bit overboard to me. If people want to profile
there are profiling tools. If we want users to profile on their systems
and send results to us, I think I'd rather give them instructions or a
wrapper script for doing so.

> If we find such cases then we'd better fix them for all platforms, e.g. by
> importing timsort, no?

Yes, as long as they are strict improvements. I can't think of a case
where some sorting behavior is a matter of opinion, and they'd prefer
Git behave like the rest of their system rather than like Git on other
systems[1].

-Peff

[1] I wonder the same about regex implementations. I generally consider
    our GNU regex fallback to be a strict improvement over system
    versions, at least in terms of features. But I was interested to see
    recently that musl implements pcre-style "\x" as an extension, but
    it _doesn't_ do REG_STARTEND. So it's at tradeoff. They have to use
    the fallback on newer versions of git (to get REG_STARTEND), but
    that means the rest of their system understands "\x" but Git does
    not.
