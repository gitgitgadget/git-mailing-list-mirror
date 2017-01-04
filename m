Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0422092F
	for <e@80x24.org>; Wed,  4 Jan 2017 01:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967229AbdADBX5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:23:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:34918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753304AbdADBXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:23:53 -0500
Received: (qmail 13011 invoked by uid 109); 4 Jan 2017 01:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 01:23:21 +0000
Received: (qmail 28458 invoked by uid 111); 4 Jan 2017 01:24:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Jan 2017 20:24:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2017 20:23:18 -0500
Date:   Tue, 3 Jan 2017 20:23:18 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20170104012318.262o5743ne2u7rwc@sigill.intra.peff.net>
References: <20161229192908.32633-1-sbeller@google.com>
 <xmqqh95j60uh.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ5F46UzeNeVYQV1EKEEa6+az-Pe_jrT+wZF9X6b34CGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ5F46UzeNeVYQV1EKEEa6+az-Pe_jrT+wZF9X6b34CGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 10:15:38AM -0800, Stefan Beller wrote:

> > I take that the new "BUG" thing tells the Git developers that no
> > sane codepath should throw an pathspec_item that satisfies the
> > condition of the if() statement for non-submodules?
> 
> If we want to keep the semantics of the assert around, then we
> have to have a blank statement if the submodule error message
> is not triggered.
> 
> I assume if we print this BUG, then there is an actual bug.

Right. I think this isn't a new "BUG", but rather a loosening of an
existing one. IOW, two things are going on here:

  1. Switch assert() to die("BUG") to give a more readable message.

  2. Take one of the cases where we hit a BUG and turn it into a normal
     "there was something wrong with the input" message.

If I understand the submodule case correctly, then (2) is reasonable.
The user gave a bogus pathspec that crosses the submodule boundary.

I've no idea if there are other cases that could ever hit the remaining
BUG, but it seems like a good defensive measure to leave it in. If
somebody hits it, then we can investigate their case.

-Peff
