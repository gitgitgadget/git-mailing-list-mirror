Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B231F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 04:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdAZE7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 23:59:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:45113 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbdAZE7j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 23:59:39 -0500
Received: (qmail 1695 invoked by uid 109); 26 Jan 2017 04:59:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 04:59:39 +0000
Received: (qmail 20248 invoked by uid 111); 26 Jan 2017 04:59:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 23:59:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 23:59:36 -0500
Date:   Wed, 25 Jan 2017 23:59:36 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Hammant <paul@hammant.org>
Cc:     git@vger.kernel.org
Subject: Re: sparse checkout - weird behavior
Message-ID: <20170126045936.wyleenuwunhrvbn2@sigill.intra.peff.net>
References: <CA+298Ujx2wH2WnoYiOaWKoneBrF_E5VUXXSMqecGgNLYS0Wemg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+298Ujx2wH2WnoYiOaWKoneBrF_E5VUXXSMqecGgNLYS0Wemg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 10:21:19PM -0500, Paul Hammant wrote:

> Related bug (maybe the same). Reproduction:
> 
>   $ git clone git@github.com:jekyll/jekyll.git --no-checkout
>   Cloning into 'jekyll'...
>   remote: Counting objects: 41331, done.
>   remote: Compressing objects: 100% (5/5), done.
>   remote: Total 41331 (delta 0), reused 0 (delta 0), pack-reused 41326
>   Receiving objects: 100% (41331/41331), 11.91 MiB | 9.15 MiB/s, done.
>   Resolving deltas: 100% (26530/26530), done.
>   $ cd jekyll
>   $ git config core.sparsecheckout true
>   $ echo 'CONDUCT.markdown' > .git/info/sparse-checkout
>   $ echo 'Gemfile' >> .git/info/sparse-checkout
>   $ echo 'Rakefile' >> .git/info/sparse-checkout
>   $ echo 'appveyor.yml' >> .git/info/sparse-checkout
>   $ git checkout --
>   Your branch is up-to-date with 'origin/master'.
>   $ ls
>   CONDUCT.markdown Gemfile Rakefile appveyor.yml lib
> 
> I was not expecting to see 'lib' in the resulting file list

Yep, I think this is the same problem. Inside lib, you get only
"lib/theme_template/Gemfile", because it matches your unanchored
pattern. Using "/Gemfile" in the sparse-checkout file fixes it.

-Peff
