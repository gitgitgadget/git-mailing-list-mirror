Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD2820365
	for <e@80x24.org>; Tue,  3 Oct 2017 08:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdJCIpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 04:45:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751128AbdJCIpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 04:45:08 -0400
Received: (qmail 14852 invoked by uid 109); 3 Oct 2017 08:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 08:45:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5912 invoked by uid 111); 3 Oct 2017 08:45:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 04:45:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 04:45:06 -0400
Date:   Tue, 3 Oct 2017 04:45:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
 <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
 <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
 <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
 <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 05:34:40PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree it's not quite the same thing, and I agree the problem was made
> > much worse by 4c7f1819b.  But I still think color.ui=always is
> > inherently a foot-gun, and in either case it is the user that sets it
> > that is harmed (and they are the ones who have the power to fix it).
> 
> Yeah, but it is inherently a foot-gun only for those who write
> scripts around porcelain commands, which are expected to honor
> color.ui=always.  If you write a script using the plumbing commands
> because you did not want to get broken by color.ui=always, and then
> your script gets broken because plumbing commands you relied on
> suddenly start paying attention to color.ui---is that the user's
> fault who used color.ui?

Note that I'm arguing that it's a foot-gun even without scripts in the
picture at all. Forget about plumbing versus porcelain. If you set
color.ui to "always", you're going to get unexpected and confusing
results from time to time.

> The end-users have the power to work the breakage around by not
> using "always".  The script writers have the power to work the
> breakage around with "--no-color".  But these are workarounds that
> shouldn't have been needed in the first place, no?

To be clear, I don't think script writers should work around it at all.
It is either the fault of the user for having a broken config, or Git
for allowing such a broken config (and after having studied the
documentation, I think Git really is not helping here; nobody should
ever use "always", but the documentation introduces it as the most
obvious option to choose).

-Peff
