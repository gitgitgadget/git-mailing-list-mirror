Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCBF2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbdBOVcZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:32:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:55998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbdBOVcY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:32:24 -0500
Received: (qmail 23240 invoked by uid 109); 15 Feb 2017 21:32:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:32:24 +0000
Received: (qmail 17686 invoked by uid 111); 15 Feb 2017 21:32:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:32:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:32:22 -0500
Date:   Wed, 15 Feb 2017 16:32:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
Message-ID: <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 12, 2017 at 05:37:30PM +0100, Jáchym Barvínek wrote:

> Hello, I would like to report what I consider a bug in git, I hope I'm
> doing it the right way.
> I was trying to run `git pull` in  my repository and got the following
> error: "git pull
> Your configuration specifies to merge with the ref 'refs/heads/master'
> from the remote, but no such ref was fetched."

It sounds like writing FETCH_HEAD failed, and git-pull became
confused that the ref wasn't fetched.

> Which was very confusing to me, I found some answers to what might be the cause
> but none was the right one. The actual cause was that the filesystem
> had no more free space.
> When I cleaned the space, `git pull` then gave the expected answer
> ("Already up-to-date.").
> I think the message is confusing and git should be able to report to
> the user that the cause
> is full disk.

If FETCH_HEAD failed to write because of a full disk (or any other
reason), then the right thing is for "git fetch" to write an error to
stderr, and git-pull should not continue the operation at all.

If we're not doing that, then that is certainly a bug.

-Peff
