Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39AE1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 23:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdB0Xda (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 18:33:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:35266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbdB0Xd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 18:33:29 -0500
Received: (qmail 32068 invoked by uid 109); 27 Feb 2017 21:46:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 21:46:42 +0000
Received: (qmail 20480 invoked by uid 111); 27 Feb 2017 21:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 16:46:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 16:46:40 -0500
Date:   Mon, 27 Feb 2017 16:46:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
Message-ID: <20170227214640.h2qi5znay76szm35@sigill.intra.peff.net>
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
 <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
 <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net>
 <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com>
 <xmqqefyjnwat.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefyjnwat.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 01:44:26PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ...  I suspect that calling interpret_empty_at() from
> > that function is fundamentally flawed.  The "@" end user types never
> > means refs/heads/HEAD, and HEAD@{either reflog or -1} would not mean
> > anything that should be taken as a branch_name, either.  
> 
> The latter should read "HEAD@{either reflog or -1 or 'upstream'}"
> 
> Or do we make HEAD@{upstream} to mean "deref HEAD to learn the
> current branch name and then take its upstream"?  If so @@{upstream}
> might logically make sense, but I do not see why @{upstream} without
> HEAD or @ is not sufficient to begin with, so...

Yes, HEAD@{upstream} and @@{upstream} are both resolved to the actual
branch name. I also was puzzled whether there was any real use over just
@{upstream}. But it does work, and if you had a script which looked for,
say, $branch@{upstream}, you'd probably want branch=HEAD to keep
working.

The "branch=@" case I am less sympathetic to, as it was mainly supposed
to be a command-line convenience. But it _does_ work now.

-Peff
