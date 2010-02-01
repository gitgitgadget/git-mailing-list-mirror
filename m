From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 18:25:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011809140.1681@xanadu.home>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:25:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc5eG-0001xY-8f
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 00:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab0BAXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 18:25:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42967 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab0BAXZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 18:25:34 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX6005ORRQKYRF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 18:25:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ron1-6F8B85.14520801022010@news.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138657>

On Mon, 1 Feb 2010, Ron Garret wrote:

> In article <87aavsu9b3.fsf@osv.gnss.ru>, Sergei Organov <osv@javad.com> 
> wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > > Steve Diver <squelch2@googlemail.com> writes:
> > 
> > [...]
> > 
> > > If read carefully (some may argue that it does not need a very careful
> > > reading to get it, though), this hints that "detached HEAD" state is a
> > > substitute for using a temporary branch, but it may not be strong
> > > enough.
> > 
> > For my rather fresh eye it looks more like unnamed (anonymous?) branch
> > than a temporary one. Doesn't detached HEAD behave exactly like a
> > regular HEAD but pointing to the tip of an unnamed branch?
> 
> I strongly concur with this.
> 
> And as long as I'm weighing in, it would also help to prevent confusion 
> if it were made clear that this unnamed branch doesn't actually come 
> into existence unless and until you do a commit.

Nope.  Creating a commit doesn't create any branch.  A commit creation 
merely adds a new node in the history graph, and links it to the commit 
that was the current one before that commit operation.  If HEAD is 
_attached_ to a branch then the branch pointer is also updated to point 
to that new commit.  If HEAD is _detached_ then no branch is updated and 
HEAD simply carries a direct reference to that new commit.

At a later time you can:

1) Create a new branch pointer which default value is the commit pointed to
   by HEAD.  This is true whether or not HEAD is detached, but in this 
   case this is an interesting property.

2) Move HEAD somewhere else by performing a checkout.  If HEAD was 
   detached then its last position is simply forgotten and those 
   commits that were performed while HEAD was detached, if any, are 
   simply left dangling and eventually garbage collected.  If however a 
   new branch pointer was created in (1) then those commits won't be 
   dangling.

In any case, a detached HEAD is not only a temporary branch, it is also 
a volatile branch.  And in the Git model, it is simply not a branch at 
all.  Hence the 2 states for HEAD: either detached, or attached to a 
branch pointer.


Nicolas
