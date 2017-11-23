Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E3E20954
	for <e@80x24.org>; Thu, 23 Nov 2017 05:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750724AbdKWFAM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 00:00:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:38382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750707AbdKWFAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 00:00:12 -0500
Received: (qmail 19938 invoked by uid 109); 23 Nov 2017 05:00:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Nov 2017 05:00:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6952 invoked by uid 111); 23 Nov 2017 05:00:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 23 Nov 2017 00:00:28 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Nov 2017 00:00:09 -0500
Date:   Thu, 23 Nov 2017 00:00:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171123050009.GA22218@sigill>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
 <20171122232814.GH11671@aiede.mtv.corp.google.com>
 <20171122233905.GC8577@sigill>
 <20171122234532.GI11671@aiede.mtv.corp.google.com>
 <20171122235851.GE8577@sigill>
 <20171123000839.GL11671@aiede.mtv.corp.google.com>
 <xmqqefopsrk0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefopsrk0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 10:38:07AM +0900, Junio C Hamano wrote:

> > FWIW I think we've done fine at using assert so far.  But if I
> > understand correctly, the point of this series is to stop having to
> > worry about it.
> 
> I recalled that there was at least one, and "log -Sassert" piped to
> "less" that looks for "/^[ ^I]*assert\(" caught me one recent one.
> 
>     08414938 ("mailinfo.c: move side-effects outside of assert", 2016-12-19)

Thanks, I forgot about that one. There's some discussion about NDEBUG in
the surrounding thread if anybody is interested:

  https://public-inbox.org/git/900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0/

(but it's long and there's really no resolution, so you may want to skip
it).

> Even though I do not personally mind
> 
> 	assert(flags & EXPECTED_BIT);
> 	assert(remaining_doshes == 0);
> 
> left as a reminder primarily for coders, we can do just as well do
> so with
> 
> 	if (remaining_doshes != 0)
> 		BUG("the gostak did not distim all doshes???");

Yeah, agreed. The reason I do not mind the assert() form is that if you
have nothing useful to say in the BUG() sentence, it's a bit more
compact.

> So I am fine if we want to move to reduce the use of assert()s or
> get rid of them.  I personally prefer (like Peff, if I am not
> mistaken) an explicit use of the usual control structure, as it is
> easy to follow.

To clarify my position, I think BUG_ON(cond, msg) from this series
provides basically no value over "if (cond) BUG(msg)". But I could see
value in "BUG_ON(cond)" that allows the compact form but doesn't respect
NDEBUG.

-Peff
