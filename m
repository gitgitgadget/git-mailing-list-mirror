Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841491F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfHZT4g (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:56:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727504AbfHZT4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:56:36 -0400
Received: (qmail 7954 invoked by uid 109); 26 Aug 2019 19:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 19:56:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23287 invoked by uid 111); 26 Aug 2019 19:57:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 15:57:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 15:56:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
Message-ID: <20190826195634.GA27762@sigill.intra.peff.net>
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
 <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 01:23:59PM -0700, Junio C Hamano wrote:

> I do not want a discussion to begin with a Devil's Advocate
> response, but anyway...
> 
> Are we planning to go to all batteries included approach?  I have a
> feeling that there are other tools (hello, "git imerge") that
> equally deserve attention by Git users; are we in the business of
> absorbing them all?  How big a project will our tree become, and how
> much more activity would have to be haneld by the readership of the
> Git mailing list?
> 
> I'd rather see us shed non-core tools we already have (e.g. git-svn,
> cvs import/export) out of git.git and have them as independent
> projects.  But that may be just me.

I like the general line of thinking here, but let me Devil's Advocate
your Devil's Advocate:

  - having separate repos and release schedules means that the
    dependency changes need to be coordinated. E.g., if a feature in
    git-filter-repo needs a new feature in git-core, then the feature
    needs to land in git-core first, then filter-repo needs to decide
    how to handle older versions. Whereas in the same repo, they can
    generally assume to move forward atomically.

  - some of the non-core stuff helps test coverage for the core parts of
    the system. E.g., what bugs might we find in fast-import that are
    only triggered by the filter-repo test suite? Similarly, the
    scripted tools in git.git often serve as canaries for
    backwards-incompatible changes to the plumbing.

    Something like the meta-git.git that Stolee proposed would help with
    that. But then we may end up dealing with other people's messes,
    which is one of the things we'd try to avoid with such a split.

-Peff
