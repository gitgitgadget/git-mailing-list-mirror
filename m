From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 20:36:58 -0400
Message-ID: <20060928003658.GB22593@spearce.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <451AB122.9020600@gmail.com> <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927233639.GE21839@spearce.org> <451B0F59.6070901@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 02:37:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjtx-0006hY-3R
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031292AbWI1AhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031290AbWI1AhQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:37:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:29646 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1031292AbWI1AhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:37:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSjtS-0005BA-FT; Wed, 27 Sep 2006 20:36:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C3BD520FB28; Wed, 27 Sep 2006 20:36:58 -0400 (EDT)
To: Rogan Dawes <lists@dawes.za.net>
Content-Disposition: inline
In-Reply-To: <451B0F59.6070901@dawes.za.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27958>

Rogan Dawes <lists@dawes.za.net> wrote:
> Shawn Pearce wrote:
> 
> >
> > - Higher level projects should drive subprojects.
> >
> >   Higher level projects tend to be composed of specific revisions or
> >   specific generations of subprojects.
> >
> >   Part of the content of the higher level project is just what
> >   those subproject specifications are and how those subprojects
> >   should appear in a working directory.
> >
> 
> >
> >I used the term "generation of subprojects" as not everyone wants
> >to bind their root project to a specific revision of a subproject.
> >Indeed that may not be entirely practical.  Instead just a particular
> >lineage of development (e.g. "Version 1.0" vs. "Version 1.2")
> >may be all that is needed.
> >
> 
> Does it not make sense that a commit of the higher level project should 
> include the contents of its subprojects at that particular moment in time?

If the subproject is a Git repository we can simply record a commit
SHA1 or a tag SHA1 and assuming we can locate the objects for that
repository in the future we can fully recover that subproject.
No subtree tracking necessary.

If the subproject is an SVN repository we can simply record
the branch/tag path and the specific revision number and fully
recover that subproject, assuming we have access to the central
SVN repository.  If we don't or we are concerned about that then we
would want to use git-svn/git-svnimport to mirror the SVN repository
and treat it as a proper Git subproject.

If the subproject is a Monotone or Darcs project I believe we could
also store some small token for a unique directory state of that
subproject and recover that from Monotone or Darcs without importing
the entire subproject into Git.  If you don't trust Monotone or Darcs
then maybe you should be importing/mirroring that project into Git.
At which point its a proper Git subproject.

If the subproject is CVS then you either need to trust the CVS
tag or import the tree into Git.  If you are going to import the
tree into Git then you might as well just treat the subproject as
a proper Git subproject and use some sort of CVS import or mirror
to keep that in sync.

Etc...

My basic point here is that a subproject already has its own SCM
and if its not Git you probably either are going to convert it to
Git via a Git bridge (git-svn anyone?) or you are going to keep it
in its "native" SCM as you probably don't want to incur the disk
costs of storing it twice (once in its native SCM and once in Git).

So subtree tracking is probably unncessary.

-- 
Shawn.
