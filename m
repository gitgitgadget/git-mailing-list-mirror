From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 18:57:38 -0400
Message-ID: <20060927225738.GC21839@spearce.org>
References: <20060927215612.GB21839@spearce.org> <20060927224651.26627.qmail@web51013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 00:58:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiLv-0006cg-BW
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 00:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030838AbWI0W5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031197AbWI0W5r
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 18:57:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:10946 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030838AbWI0W5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 18:57:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSiLK-0006Rd-J9; Wed, 27 Sep 2006 18:57:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4952B20FB28; Wed, 27 Sep 2006 18:57:38 -0400 (EDT)
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060927224651.26627.qmail@web51013.mail.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27943>

Matthew L Foster <mfoster167@yahoo.com> wrote:
> --- Shawn Pearce <spearce@spearce.org> wrote:
> 
> > Because of the potentical for clock skew even on a single system
> > you can't take much stock in a timestamp.  But with Git you can at
> > least completely trust the commit graph, provided that you trust
> > those who made commits before your own commit.  Of course this
> > trust is only possible because the commit graph cannot be altered
> > once a node has been added into it.
> > 
> > As such the commit graph is consistent between repositories (assuming
> > they have the same head commits), but the timestamps of the reflogs
> > within each will widely differ.  They could widely differ even on
> > the same system due to ntpd updating the clock at the exact wrong
> > moment for example.  :)
> 
> I am not arguing for git to try to achieve "exact" time just merely locally time consistent commit
> order. This might all just be a gitweb.cgi time display issue, it should be more impossible for a
> commit to appear as being made 2 days in the future and impossible for local time order to be out
> of sync with commit order. If each git repo used local time to track commits/merges you wouldn't
> have to worry if any remote git server's time was grossly misconfigured. Time doesn't need to be
> exact, all I am saying is each git repo should trust/prefer its local time rather than a remote
> git server's timestamp.

Git does has local time order, so long as the user doesn't screw
around with their clock.

Each time a commit gets made (or a merge gets performed) Git takes
the local system clock and dumps into the new commit as part of
the "committer" comment.  But as has been stated many times before
in this thread, this is no more trustworthy than the username and
email address also appearing in that "committer" line and its not
relied upon by Git.  Some interfaces may try to sort based on this
timestamp but only to help it break ties.  The dependency graph
always wins as that's always correct.

I have a Git repository from which I'm tracking an SVN repository.
Recently that SVN repository gave me "(no date)" as a datestamp.
Git converted that to Jan 1, 1970.  That commit has a parent and
has a child, both of which have sane timestamps.  But viewing this
in gitk or git log its obvious that the Jan 1, 1970 commit is in
the right position within the graph, it just has a timestamp that
I can't trust as its 36 years in the past.

There's nothing I can do about that timestamp.  It came from another
system that I have no control over.  But Git accurately recorded
what that other system provided it.  The "truth" here is that other
system provided a bogus timestamp.

-- 
Shawn.
