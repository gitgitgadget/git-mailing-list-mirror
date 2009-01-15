From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 17:04:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151658060.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net> <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
 <496F4BF0.6020805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUjH-0001O6-SX
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758729AbZAOQEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758607AbZAOQEG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:04:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:46260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758161AbZAOQEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:04:04 -0500
Received: (qmail invoked by alias); 15 Jan 2009 16:04:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 15 Jan 2009 17:04:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JbXt5xOlJ+Sv6tlPLSxRMYp6f+9gfzaLIfpnwg5
	EBRMeIWcNu6XH3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496F4BF0.6020805@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105847>

Hi,

On Thu, 15 Jan 2009, Michael J Gruber wrote:

> I'm not sure what -p is supposed to do:
> 
> A) Should it preserve all merge commits which it would need to rewrite?
> That is lot to ask. Previous behaviour (intended or not) seemed to be to
> do nothing in this case where the merge connects master and work.
> 
> B) Should it preserve only merges in side branches? I seem to mean by
> that branches where the parents are on work and other branches but not
> on master.

The intention was this:

	$ git rebase -p master

would need to rewrite _all_ commits that are in "master..".  All of them, 
including the merge commits.

The fact that I implemented it as "-i -p" is only due to technical 
reasons; I know (ahem, now I should put that into the past tense) the code 
base pretty well.

An additional shortcut was to avoid rewriting commits when they did not 
need rewriting.  IOW if the commit-to-pick has only parents that were 
_not_ rewritten, we can avoid cherry-picking or merging, and just reset 
--hard <original commit>.

There was a problem, though; for some reason, the code as I did it fscked 
up the order of the commits when -p was specified.  Therefore, rewritten 
commits had the wrong parents.

I thought it should be easy to fix, but then I got a job that I actually 
like, so my Git time budget was tremendously reduced.

> > The more I think about it, I think it's possible I broke it with the 
> > introduction of the "noop".
> 
> It certainly worked after the noop introduction before the r-i-p series, 
> but not any more after.

Umm... which rebase -i -p series do you mean?  "noop" was introduced 
pretty recently if my Alzheimered brain does not fool me.

Ciao,
Dscho
