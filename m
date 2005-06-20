From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 20:09:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506192002240.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org> 
 <2cfc403205061817181e4d6d5e@mail.gmail.com>  <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
  <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org> 
 <2cfc403205061903155a6090db@mail.gmail.com>  <2cfc40320506190741409f3a5@mail.gmail.com>
  <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org> <2cfc4032050619125537dee354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 05:02:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkCXw-0002CA-D4
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 05:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFTDHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 23:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFTDHr
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 23:07:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbVFTDHm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 23:07:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5K37djA028870
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Jun 2005 20:07:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5K37cEp006264;
	Sun, 19 Jun 2005 20:07:39 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050619125537dee354@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, Jon Seymour wrote:
>
> Yep, ok, so the node you are looking for is one that can reach as
> close to half of the rest of the graph as possible - that's what you
> mean by half-way reachability. If the graph was N nodes deep (no
> fan-out) that would be the literal middle. If it was N nodes wide
> (e.g. fanout N), there is no good node and you basically have to test
> everything since one test doesn't imply anything about the other N-1
> nodes.

Exactly.

> A typical commit graph is worse than O(log2 N) by a factor that is
> determined by some measure of the parallel branching in the graph.

Yes. In many cases it's ok to have parallellism, and the fact that any 
normal merges will always be two-way (ie there's never a commit in 
practice that has a very high fan-in), I do believe that you normally get 
pretty close to that O(log2N) behaviour. In fact, your numbers seemed to 
say that we're normally within 10% of it.

> I presume  you mean O(N^3)?

Yup again.

> Will you accept a patch that can reduce the worst case cost to some
> lower order? I have a hunch (conceivably wrong, of course) that it can
> be done in O(N).

Well, it depends on how nasty it ends up being. I thought my stupid
algorithm would suck horribly, but considering that it can trivially
bisect all of the git history so far in basically zero time, it doesn't
seem to be that bad. You're more likely to have problems with having to
bring in all the commits from disk in the cold-cache case than you are to
have problems with the current algorithm performance.

Even at O(N^3) it shouldn't be too nasty even if some crazy person tried
to bisect a years worth of development (which really isn't very reasonable
behaviour anyway, it's just not sensible to not try a few standard
releases in between first).

			Linus
