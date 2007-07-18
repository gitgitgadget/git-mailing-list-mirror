From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 22:54:42 -0400
Message-ID: <20070718025442.GX32566@spearce.org>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk> <20070717212103.11950.10363.julian@quantumfyre.co.uk> <20070718015138.GR32566@spearce.org> <46a038f90707171932m67c51388jb2304f0b1873e3a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 04:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAzgs-0001Ij-Sn
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 04:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbXGRCyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 22:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXGRCyv
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 22:54:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49473 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbXGRCyu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 22:54:50 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAzgS-000641-5j; Tue, 17 Jul 2007 22:54:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E4C320FBAE; Tue, 17 Jul 2007 22:54:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46a038f90707171932m67c51388jb2304f0b1873e3a6@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52823>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 7/17/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >  Applying git-gui: Handle git versions of the form n.n.n.GIT
> >
> 
> I'm far from an authority on things TCL, but I don't think this patch
> should be merged as is.

Too late, already applied and pushed.  ;-)

> Julian is reporting it as a "fixes my symptom"
> patch, and that's barely what it does.
> 
> The regex should be more liberal, imho. With this superficial fix:

I think we are now cleaning up the Git version as best we can:

  regsub -- {-dirty$} $_git_version {} _git_version
  regsub {\.[0-9]+\.g[0-9a-f]+$} $_git_version {} _git_version
  regsub {\.rc[0-9]+$} $_git_version {} _git_version
  regsub {\.GIT$} $_git_version {} _git_version

The first fixes the -dirty build problem.  The second drops off
the extra information that git-describe throws into the mix when
it generates output for a non-tagged commit.  The third kills the
rc* component if this is a release candidate.  Note that the rc*
killer must come after the git-describe killer, as the rc* part is
actually in the real tag.  The last one fixes the weird case where
the user has somehow bungled his git software distribution so it
cannot generate a git version via git-describe *and* they have no
`version` file in the source code directory.  Such people really
should fix their git.  But anyway we do support it now.

> - Builds from a repo with a nonstandard (local) tagname tagname  have
> a broken git gui

This I cannot do anything about, other than maybe to warn the user
that they are about to run with a version of Git that we cannot
verify and hence we have no idea if git-gui will work correctly,
or fall flat on its face.

I'll add in a confirmation dialog for this case.  That way the
user can make the decision.  User always knows best.

-- 
Shawn.
