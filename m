Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532D91F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdAYT7C (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:59:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:44707 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbdAYT67 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:58:59 -0500
Received: (qmail 30628 invoked by uid 109); 25 Jan 2017 19:58:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 19:58:49 +0000
Received: (qmail 15222 invoked by uid 111); 25 Jan 2017 19:58:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 14:58:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 14:58:47 -0500
Date:   Wed, 25 Jan 2017 14:58:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/12] receive-pack: treat namespace .have lines like
 alternates
Message-ID: <20170125195847.j6gy6vl5bm4liynp@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net>
 <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 11:51:17AM -0800, Junio C Hamano wrote:

> This is an unrelated tangent, but there may want to be a knob to
> make the code return here without even showing, to make the
> advertisement even smaller and also to stop miniscule information
> leakage?  If the namespaced multiple projects are totally unrelated
> (i.e. "My sysadmin gave me a write access only to this single
> directory, so I am using the namespace feature to host these three
> projects that have nothing to do with each other"), showing objects
> of other namespaces will buy us nothing and the user is better off
> without this code showing these refs as ".have".

Yeah, I'd agree it's a potential issue. And I definitely do the same
with alternates (in my case it isn't "they're not relevant" as much as
"they are too big, and the optimization backfires").

I don't use namespaces myself[1], though, so I'd prefer to leave that to
somebody who has that itch, and could think it through better.

-Peff

[1] They _seem_ like they'd be a good fit for the way GitHub uses
    alternates, but since they're only implemented for fetch/push,
    they're only a small part of the story. Plus the ref storage has
    traditionally been a scaling bottleneck for us, so it's nice for
    each fork to have its own ref storage for operations that just touch
    that fork.
