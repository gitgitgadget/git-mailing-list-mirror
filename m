From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 03:16:27 -0400
Message-ID: <20061018071627.GC4678@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <20061018011147.GN20017@pasky.or.cz> <vpqlknem8bi.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 09:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga5fP-00082J-Ri
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 09:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWJRHQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 03:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWJRHQk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 03:16:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8174 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750900AbWJRHQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 03:16:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Ga5fH-0000A0-07; Wed, 18 Oct 2006 03:16:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 49D3720E42A; Wed, 18 Oct 2006 03:16:27 -0400 (EDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Disposition: inline
In-Reply-To: <vpqlknem8bi.fsf@ecrins.imag.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29199>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > The origin branch is considered readonly (though Git does
> > not enforce it) and only mirrors the branch in the remote repository.
> 
> By curiosity, what happens if you accidentally commit to it?

It will quietly accept the commit.

Later when you attempt to run `git fetch` to download any changes
from the remote repository to your local origin branch the fetch
command will fail as it won't be a strict fast-forward due to
there being changes in origin which aren't in the remote repository
being downloaded.

The user can force those changes to be thrown away with `git fetch
--force`, though they probably would want to first examine the
branch with `git log origin` to see what commits (if any) should
be saved, and either extract them to patches for reapplication or
create a holder branch via `git branch holder origin` to allow them
to later merge the holder branch (or parts thereof) after the fetch
has forced origin to match the remote repository.

So in short by default Git stops and tells the user something fishy
is going on, but the error message isn't obvious about what that
is and how they can resolve it easily.

There has been discussion about marking these branches that we
know the user fetches into as read-only, to prevent `git commit`
from actually committing to such a branch (we also have the same
case with the special bisect branch), but I don't think anyone has
stepped forward with the complete implementation of that yet.

Like anything I think people get used to the idea that those branches
are strictly for fetching and shouldn't be used for anything else.
There's really no reason to checkout a fetched into branch anyway;
temporary branches are less than 1 second away with
`git checkout -b tmp origin` (for example).

-- 
Shawn.
