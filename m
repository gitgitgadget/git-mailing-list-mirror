Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAA41F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCFXE0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:04:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:49530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932078AbeCFXEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:04:25 -0500
Received: (qmail 17082 invoked by uid 109); 6 Mar 2018 23:04:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 23:04:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10257 invoked by uid 111); 6 Mar 2018 23:05:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 18:05:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Mar 2018 00:04:21 +0100
Date:   Wed, 7 Mar 2018 00:04:21 +0100
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: git-scm.com update
Message-ID: <20180306230419.GA1373@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last year I reported on the state of the git-scm.com website:

  https://public-inbox.org/git/20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net/

There was a little bit of public discussion, and I privately got
approximately one zillion offers to host the site or otherwise help with
it. Thank you to everybody who responded.

Here's an update on what happened since then:

 - we now have a small group of maintainers able to triage incoming bug
   reports and patches, and generate some fixes. Thanks especially to
   Jean-Noël Avila, Pedro Rijo, and Samuel Lijin for their work over the
   past year.

 - we resolved most of the performance issues. These were partly due to
   some inefficient database queries, but mostly it was resolved with
   lots and lots of caching.

   The main problem, it turned out, is just that we get a _lot_ of hits.
   Like 5-6 million requests per day (that's individual HTTP requests;
   analytics report that we get close to 200,000 unique visitors on any
   given weekday).

   Details on the caching are in the architecture document below.

 - the site remains a rails app. This is probably overkill, but it was
   the path of least resistance to keep it one. Converting to a static
   site would require at least some grunt-work, but also figuring out
   some solution for the site-wide search. There's no immediate plan to
   move to anything else.

 - previously the site was being paid for by GitHub (and was tied to
   GitHub's Heroku account). We could have continued that indefinitely,
   but I wanted to move it to a community-owned account. That happened
   (details in the architecture document).

   Rather than ask for money from GitHub or elsewhere to cover hosting
   costs (which would have been easy -- we had quite a few offers!), I
   instead approached the companies whose services we're using to host
   the site and asked for direct sponsorship. Every one of them was
   happy to oblige, and Heroku in particular was helpful with migrating
   the site to the new account. So we're currently receiving free
   service from Heroku, Cloudflare, and Bonsai.

 - I've written up a few documents about how the site is organized. One
   higher-level page on the site for bug reporters, etc:

     https://github.com/git/git-scm.com/pull/1172/files

   and one more detailed architecture document:

     https://github.com/git/git-scm.com/blob/master/ARCHITECTURE.md

So at this point I think the site is in reasonably good shape going
forward. One of the long-standing issues is that the design is not very
responsive, and looks bad on phones and tablets. Jason Long, who did
much of the original site design, is working on a visual refresh that
should fix this and update some of the messier and outdated parts of the
CSS and related tooling. The plan is to have the refresh running
alongside the production site soon, so that we can gather feedback and
iterate from there.

-Peff
