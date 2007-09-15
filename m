From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 03:51:44 -0400
Message-ID: <20070915075144.GB3099@spearce.org>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com> <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com> <7vk5qtd3le.fsf@gitster.siamese.dyndns.org> <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com> <20070915025129.GY3099@spearce.org> <20070915073845.GB3782@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Scott Dobrovodsky <brian@pontech.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWSRV-0000eM-EJ
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbXIOHvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbXIOHvu
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:51:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36490 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbXIOHvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:51:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWSRM-0007Se-EW; Sat, 15 Sep 2007 03:51:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A1F320FBAE; Sat, 15 Sep 2007 03:51:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070915073845.GB3782@efreet.light.src>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58230>

Jan Hudec <bulb@ucw.cz> wrote:
> On Fri, Sep 14, 2007 at 22:51:29 -0400, Shawn O. Pearce wrote:
> > It isn't unreasonable to want Git to save uncommitted work for the
> > current branch and then you switch to another, ending up with a
> > clean working directory when you finally get there.  Today we have
> > git-stash to help you with this, but I'm thinking maybe we want to
> > connect git-checkout with it?
> 
> I think it would be reasonable if it just forced you to decide about it. That
> is reading the documentation, checkout only switches branches if the merge of
> each modified file is trivial and only does 3-way merge if it got -m option.
> 
> It might be reasonable to requre that option for all cases, where there are
> local changes and the branches don't point to the same commit and without it,
> checkout should say something like:
> 
>   Cannot switch branches, because the tree is modified. You can apply the
>   modifications to the target branch by using -m option

The thing there is `git checkout` by default does a switch only
if the merge is really trivial.  In such cases its probably sane
to carry the changes with you to the new branch/parent commit.
At worst you can safely carry them right back.  Or stash them.
But -m does a three-way file merge, which isn't trivial, and can
result in conflicts.

So I know that myself and Junio both rely on the default behavior
to tell us if a switch is even a good idea right now, or if we
should stash the changes and *then* do the switch.  Because if you
do the switch with -m and there are conflicts you are up a creek
with no paddle... and there's a mighty big water fall coming up
in 3 feet... 2 feet... oh crap!

Making -m the only way to switch with dirty state is not a feature.
Its a regression.

-- 
Shawn.
