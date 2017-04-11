Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D670220970
	for <e@80x24.org>; Tue, 11 Apr 2017 12:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdDKMvD (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 08:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59923 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdDKMvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 08:51:01 -0400
Received: (qmail 2714 invoked by uid 109); 11 Apr 2017 12:50:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 12:50:57 +0000
Received: (qmail 1721 invoked by uid 111); 11 Apr 2017 12:51:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 08:51:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 08:50:54 -0400
Date:   Tue, 11 Apr 2017 08:50:54 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI/?= Bjarmason <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
Message-ID: <20170411125054.23ivvoyqj6y4suyo@sigill.intra.peff.net>
References: <20170410183120.oa5yqwvlrdzitqci@sigill.intra.peff.net>
 <1n4bn17.oag6uj12fkc2fM%lists@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1n4bn17.oag6uj12fkc2fM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 02:37:27PM +0200, Stefan Haller wrote:

> > I agree that probably makes the multiple-operation stuff go away, which
> > is nice. It does raise the question of when the integration point
> > happens, and how we handle alternate paths through which commits may
> > land in a local branch (e.g., if both you and upstream do a ff-merge of
> > a particular branch).
> 
> Are you talking about the case where the user doesn't say git pull, but
> instead says "git fetch && git merge --ff @{u}"? Just so that I
> understand the concern.

Yes, that (which is the main way that I merge changes). But also
what happens with:

  git merge origin/other-branch
  git rebase origin/master

I think we only care when origin/master has independently merged
other-branch, too. And even though we have taken its commits into
account, we would fail (because "both sides did the same thing" is
really out of scope for the concept of a lease). So that's OK.

-Peff
