Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F57D1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 10:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdFJKVa (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 06:21:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:37628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbdFJKV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 06:21:29 -0400
Received: (qmail 10544 invoked by uid 109); 10 Jun 2017 10:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 10:21:28 +0000
Received: (qmail 30443 invoked by uid 111); 10 Jun 2017 10:21:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:21:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 06:21:27 -0400
Date:   Sat, 10 Jun 2017 06:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
Message-ID: <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
 <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
 <1497084241.8531.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1497084241.8531.2.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 02:14:01PM +0530, Kaartic Sivaraam wrote:

> > Does this break "git commit", or is the update limited to "git
> > status"?
> This does seem to be breaking 'git commit' as it seems to be using the
> output of 'git status'. This change results in the following commit
> template for the initial commit,
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> # On branch master
> #
> # Waiting for initial commit
> #
> # Changes to be committed:
> #       new file:   test-file
> #
> 
> Looks odd. Not sure how to fix this. Maybe on of the alternatives have
> to be considered. "Your current branch does not have any commits" seems
> a good one.

We could also add an option to "struct wt_status" to differentiate the
two cases.

I had forgotten completely that this would affect git-commit. And that
explains the "Initial commit" text in the first place. This output
originated as the git-commit template message, and only later was moved
into the git-status command. And in the context of making a commit,
saying "This is the initial commit" makes a lot of sense.

And it probably does mean we want separate messages for status and
commit. One is "if you were to make a commit, it would be the first".
The other is "you are making the first commit".

-Peff
