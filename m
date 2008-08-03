From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Sun, 3 Aug 2008 16:36:19 -0700
Message-ID: <20080803233619.GC5435@hand.yhbt.net>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness> <20080803224852.GC3006@untitled> <alpine.DEB.1.00.0808040113150.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:38:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPn9b-0001aN-1j
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758897AbYHCXgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758880AbYHCXgV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:36:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50083 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758840AbYHCXgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:36:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 015B32DC01B;
	Sun,  3 Aug 2008 16:36:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808040113150.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91293>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sun, 3 Aug 2008, Eric Wong wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > The main concern I have is to get the semantics right: AFAICT 
> > > svn:externals has _no notion_ of "what is current".  It just _always_ 
> > > fetches the HEAD.  Even if you check out an ancient revision in the 
> > > "superproject".
> > 
> > Based on my limited understanding, peg revisions are only needed in SVN 
> > because of the cost of traversing history to DTRT.  git-svn should be 
> > able to just use the -r<rev> syntax that has always been supported 
> > without needing peg revisions.
> 
> I was talking about the svn -> git direction.

Likewise.

> And Git does not peg revisions because of the cost of traversing history 
> to DTRT.

I was saying SVN uses peg revisions because of the cost.
Also, there may be a misunderstanding as to what peg revisions are (in SVN)
and how they relate to git.

Here's an example svn:external definition with a peg revision:

  -r 1234 http://foo/bar.c@5233

"@5233" is the peg revision, and (as I understand it, just a hint) and
"-r 1234" is the actual revision we want from SVN (and what git-svn
should fetch).  Confusing?  Yes.

> Git pegs revisions of submodules, because it is the right thing to do.  
> Subversion just got it wrong to begin with.  After all, we are going 
> through a lot to make defined revisions, and we do not want to throw that 
> out by allowing an unversioned submodule.

Yes, most repositories I've seen don't even use "-r 1234" (which has
always been supported by SVN).  This is the problem git will have to
deal with.

> So, importing a svn:external with git-svn has to undo that error somehow 
> (which might be helped by the linearity of subversion, but might be tricky 
> because of possible clock skews between the two subversion repositories).

Yes.  This is why I'm leaning towards /not/ using git submodules for this
because svn:externals are rarely defined with -r <revno>.

-- 
Eric Wong
