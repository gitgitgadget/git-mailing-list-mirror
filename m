Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B5120401
	for <e@80x24.org>; Wed, 21 Jun 2017 16:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFUQ1D (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 12:27:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:47600 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751116AbdFUQ1C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 12:27:02 -0400
Received: (qmail 27301 invoked by uid 109); 21 Jun 2017 16:00:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 16:00:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24426 invoked by uid 111); 21 Jun 2017 16:00:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 12:00:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 12:00:18 -0400
Date:   Wed, 21 Jun 2017 12:00:18 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why 10k remotes? Was: Re: [RFC/PATCH 0/5] remote: eliminate
 remote->{fetch,push}_refspec and lazy parsing of refspecs
Message-ID: <20170621160018.dysakibspeiv3gqr@sigill.intra.peff.net>
References: <CAM0VKjnfVuVnUfnfCceD-QfUdj=6sWTdBDXkj9jZujqMJqdAQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjnfVuVnUfnfCceD-QfUdj=6sWTdBDXkj9jZujqMJqdAQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 02:21:19AM +0200, SZEDER Gábor wrote:

>   Such an all-forks-in-one repo allows me to run e.g. 'git log --all
>   -p master.. relevant.c' and then search its output for changes in
>   interesting functions (thankfully function names are included in
>   hunk headers; alas line log doesn't work with --all).  Occasionally
>   this unearths some treasures: other people's commits and branches
>   scratching the same itch that I was about to scratch, or at least
>   solving part of my problem and I can build on top of them.)

OK, that's indeed an interesting use case.

> > Now instead we
> > pass the refspecs directly to fetch whenever move objects between the
> > storage repos. They were the same for every remote anyway (and I'd guess
> > that is true, too, of your 10k remotes).
> 
> I do have different fetch refspecs for every remote, i.e. the repo
> 'github.com/user/repo' has '+refs/heads/*:refs/forks/user/repo/*'.

Right, ours have different refspecs, too. But they can be generated
programatically. So we just do:

  git fetch ../$id +refs/*:refs/forks/$id/*

without bothering to have a configured remote.

-Peff
