Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628991F404
	for <e@80x24.org>; Tue, 26 Dec 2017 18:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdLZSEl (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 13:04:41 -0500
Received: from imap.thunk.org ([74.207.234.97]:56086 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdLZSEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 13:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NSD/pzz9pNpIbGwU21vkgA7RiJbXhH58wA0gk7memhg=; b=LrB02wvUFtCgKv/D30YN5YF48y
        Cji6UE70xJON3OasydjN225MhJ3gQNISvppZsVwp+Iq69PZrXwar0DgDnC+t+l20svzR0I2C4ISZi
        AMJIVYh97/f/3CNQ0dC3o1anpAki7PyAYNT3kKDHpH4FZyLz5m/Sq4Jtw9owkF5o6aUU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1eTtaf-0007RD-IE; Tue, 26 Dec 2017 18:04:37 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 71EB9C00644; Tue, 26 Dec 2017 13:04:36 -0500 (EST)
Date:   Tue, 26 Dec 2017 13:04:36 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226180436.GA28565@thunk.org>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 06:16:40PM -0700, Carl Baldwin wrote:
> At this point, you might wonder why I'm not proposing to simply add a
> "change-id" to the commit object. The short answer is that the
> "change-id" Gerrit uses in the commit messages cannot stand on its own.
> It depends on data stored on the server which maintains a relationship
> of commits to a review number and a linear ordering of commits within
> the review (hopefully I'm not over simplifying this). The "replaces"
> reference is an attempt to make something which can stand on its own. I
> don't think we need to solve the problem of where to keep comments at
> this point.

I strongly disagree, and one way to see that is by doing a real-life
experiment.  If you take a look at a gerrit change that, which in my
experience can have up to ten or twelve revisions, and strip out the
comments, so all you get to look at it is half-dozen or more
revisions.  How useful is it *really*?  How does it get used in
practice?  What development problem does it help to solve?

And when you say that it is a bug that the Gerrit Change-Id does not
stand alone, consider that it can also be a *feature*.  If you keep
all of this in the main repo, the number of commits can easily grow by
an order of magnitude.  And these are commits that you have to keep
forever, which means it slows down every subsequent git clone, git gc
operation, git tag --contains search, etc.

So what are the benefits, and what are the costs?  If the benefits
were huge, then perhaps it would be worthwhile.  But if you lose a
huge amount of the value because you are missing the *why* between the
half-dozen to dozen past revisions of the commit, then is it really
worth it to adopt that particular workflow?

It seems to me your argument is contrasting a "replaces" pointer
versus the github PR.  But compared to the Gerrit solution, I don't
think the "replaces" pointer proposal is as robust or as featureful.
Also, please keep in mind that just because it's in core git doesn't
guarantee that Github will support it.  As far as I know github has
zero support notes, for example.

						- Ted
