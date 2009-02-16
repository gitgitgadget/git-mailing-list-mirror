From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 21:09:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:15:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZAo0-0005Xl-5e
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbZBPVNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbZBPVNi
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:13:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:35648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750777AbZBPVNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:13:37 -0500
Received: (qmail invoked by alias); 16 Feb 2009 20:09:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 16 Feb 2009 21:09:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SjJYJnJtSvJ6TBmzd0ikYErVuOn/1KLx0bTdyJA
	Mhf8lm23mmYAi7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4999BD54.8090805@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110244>

Hi,

On Mon, 16 Feb 2009, Sergio Callegari wrote:

> Johannes Schindelin wrote:
> > Wrong.  It cries out loud when you detach, not when you commit to a 
> > detached HEAD.  For good reason: Already at the second commit it would 
> > stop being funny.
>
> Right, I was wrong in expecting complaints. But... if it cried out at 
> the first commit, for many people there would probably not be a second. 

What you are suggesting, though, is that the _pusher_ detaches the HEAD.  
So the _local_ user will never know.

> Btw, I am ignorant on this: is there some case where one wants and has 
> reasons to commit to a detached head before making a temporary branch on 
> it?

Yes.  When you try fixups on a commit you just jumped to, for example.  Or 
when bisecting.

I often use the detached HEAD as kind of a stash during a bisect.  I try 
to fix it there, at the bad commit, and then cherry-pick HEAD@{1} into 
the branch after resetting the bisect.

> > > Furthermore, one could do just a bit more than detaching, namely 
> > > store the fact that head got detached and the name of the branch 
> > > where the head was. With this, when the unconscious user types git 
> > > status or git commit the system could alert him that head got 
> > > detached because someone updated the branch behind his shoulders 
> > > from remote...
> >
> > And of course, you need a way to show the user all the updates the branch
> > went through while the HEAD was detached, so that the user has a chance of
> > understanding what happened in the meantime.
> >
> > So much additional work, just to fix up the shortcomings of the 
> > 'detach' paradigm?  I take it as a clear mark of a not-so-elegant 
> > design.
>   
> Well not that much additional work...
> 
> when you push to the checked out branch, head gets detached and branch name
> (say /ref/heads/master) gets stored (say in .git/pre_push_branch).
> when you run status or commit, you realize that there is a pre_push_branch and
> you give the warning, saying what the pre_push_branch was.

Of course, you assume there that it was only one push between detaching 
the HEAD and inspecting the mess.

> Now, since before the push you were at the tip of that branch, to know 
> what happened it should be enough to ask the log (or the diff) from 
> pre_push_branch to HEAD. At the first user command that moves HEAD, 
> pre_push_branch should get deleted.

And you call that not much work?

> Btw, what does happen now if you delete the branch the remote worktree 
> is on?

See the related discussion of receive.denyDeleteCurrent.

Ciao,
Dscho
