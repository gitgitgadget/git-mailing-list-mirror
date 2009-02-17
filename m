From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: disallowing push to currently checked-out branch
Date: Tue, 17 Feb 2009 01:18:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902170112580.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com> <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302> <4999FFCE.3060605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:19:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZDg2-0007T4-Aa
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbZBQARi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbZBQARi
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:17:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:41324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750911AbZBQARh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:17:37 -0500
Received: (qmail invoked by alias); 17 Feb 2009 00:17:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 17 Feb 2009 01:17:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bJ8FGFa8b047UtHkCy0Qq29Mkq41gTTjfPm9SDi
	pFcG8F8+zysFiO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4999FFCE.3060605@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110266>

Hi,

On Tue, 17 Feb 2009, Sergio Callegari wrote:

> Johannes Schindelin wrote:
>
> > What you are suggesting, though, is that the _pusher_ detaches the 
> > HEAD.  So the _local_ user will never know.
>
> the only reason why the local user cannot know is precisely because "git 
> commit" does not complain if you call it from a detached head.

No, the only reason is that you sneakily detached the HEAD behind his 
back.  It is not possible in physical life -- at least not without the 
owner of the head noticing -- and it should not be possible with Git, 
either.

All this "we need more complaining" is just a fix up for a failed design.

> > > Btw, I am ignorant on this: is there some case where one wants and 
> > > has reasons to commit to a detached head before making a temporary 
> > > branch on it?
> >
> > Yes.  When you try fixups on a commit you just jumped to, for example.  
> > Or when bisecting.
> >
> > I often use the detached HEAD as kind of a stash during a bisect.  I 
> > try to fix it there, at the bad commit, and then cherry-pick HEAD@{1} 
> > into the branch after resetting the bisect.
>
> Interesting.  But it is sort of abusing the detached head thing, isn't 
> it? You use it as a temporary unnamed branch,

That is exactly what a detached HEAD is.

> > Of course, you assume there that it was only one push between 
> > detaching the HEAD and inspecting the mess.
>
> After the first push, the head is already detached, so pre_push_branch 
> does not get touched by the second, the third, the forth push, etc...

Oh, so the user should be really fscked for not realizing just how much 
happened in the meantime?

> > > Now, since before the push you were at the tip of that branch, to 
> > > know what happened it should be enough to ask the log (or the diff) 
> > > from pre_push_branch to HEAD. At the first user command that moves 
> > > HEAD, pre_push_branch should get deleted.
>
> > And you call that not much work?

That point is still valid.  If you have to do too much to make your idea 
work, if you have to bolt on this and that, it is a sure sign that the 
design is borked.

> > > Btw, what does happen now if you delete the branch the remote 
> > > worktree is on?
>
> I tried.  With current git 1.6.1.3, head remains pointing at a non 
> existent branch and git status thinks that you need to do your initial 
> commit. When you commit, the deleted branch is immediately recreated 
> from scratch and you loose the history that got you at that status.

As I remarked already, this is a bug that is actively being squashed.

Of course, you can go on and on and on with the detached HEAD ide, but so 
far you haven't convinced me that this is a sensible thing to do.

Ciao,
Dscho
