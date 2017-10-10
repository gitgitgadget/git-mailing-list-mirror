Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903621FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 08:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbdJJIg7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 04:36:59 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:45105 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbdJJIg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 04:36:56 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:51264 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e1q23-0003yM-4Z; Tue, 10 Oct 2017 04:36:55 -0400
Date:   Tue, 10 Oct 2017 04:36:53 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Theodore Ts'o <tytso@mit.edu>, Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <20171009175225.qn6a3j2th3dxjjn2@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1710100432220.16182@localhost.localdomain>
References: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net> <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain> <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain> <1507473160.8322.12.camel@mad-scientist.net> <20171008184046.uj7gcutddli54ic3@thunk.org> <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
 <20171008204227.f6wgaobosa6yn62g@thunk.org> <20171009175225.qn6a3j2th3dxjjn2@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 9 Oct 2017, Jeff King wrote:

> On Sun, Oct 08, 2017 at 04:42:27PM -0400, Theodore Ts'o wrote:
>
> > On Sun, Oct 08, 2017 at 03:44:14PM -0400, Robert P. J. Day wrote:
> > > >
> > > >     find <find args> | xargs git rm
> > > >
> > > > myself.
> > >
> > >   that's what i would have normally used until i learned about
> > > git's magical globbing capabilities, and i'm going to go back to
> > > using it, because git's magical globbing capabilities now scare
> > > me.
> >
> > Hmm, I wonder if the reason why git's magically globbing
> > capabilities even exist at all is for those poor benighted souls
> > on Windows, for which their shell (and associated utilities)
> > doesn't have advanced tools like "find" and "xargs"....
>
> One benefit of globbing with Git is that it restricts the matches
> only to tracked files. That matters a lot when you have a very broad
> glob (e.g., like you might use with "git grep") because it avoids
> looking at cruft like generated files (or even inside .git).

  ah, now *that* is a compelling rationale that justifies the
underlying weirdness. but it still doesn't explain the different
behaviour between:

  $ git rm -n 'Makefile*'
  $ git rm -n '*Makefile'

in the linux kernel source tree, the first form matches only the
single, top-level Makefile, while the second form gets *all* of them
recursively, even though those globs should be equivalent in terms of
matching all files named "Makefile".

  am i misunderstanding something?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
