From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Clean up work-tree handling
Date: Wed, 1 Aug 2007 12:46:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011239090.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <Pine.LNX.4.64.0708010129530.14781@racer.site>
 <7v3az3deac.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 13:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGCfq-0001e8-Ir
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 13:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760746AbXHALrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 07:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760565AbXHALrP
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 07:47:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:54874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760280AbXHALrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 07:47:14 -0400
Received: (qmail invoked by alias); 01 Aug 2007 11:47:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 01 Aug 2007 13:47:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ilt1lVAZIvtxaV5ElWN2D6p3e+T7taMCvMR7lbj
	6zExo+S7sR/T3p
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3az3deac.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54430>

Hi,

On Tue, 31 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The old version of work-tree support was an unholy mess, barely readable,
> > and not to the point.
> >
> > For example, why do you have to provide a worktree, when it is not used?
> > As in "git status".  Now it works.
> > ...
> 
> Without continuing with negatives, let's try to define the new,
> corrected world order.
> 
> I do not think the following is exactly what your cleaned-up
> version tries to perform, but I am writing this down primarily
> to demonstrate the style and the level of detail I expect to
> accompany a clean-up patch like this.

After reading your description I sink into the ground in shame.  I really 
like the style this has, and agree that something as nice as this should 
have been there.

>  - is_inside_git_dir(): this returns true if the $cwd is the git
>    directory or its subdirectory. [IS THIS STILL NEEDED???]

Hmmm.

>  - is_inside_work_tree(): this returns true if the $cwd is
>    inside work tree (i.e. either at the toplevel of the work
>    tree or its subdirectory).  [NEEDSHELP: is .git in the usual
>    layout considered "is_inside_work_tree()"?  Should it?]

.git/ is not considered part of the work tree, even if it is _physically_ 
there.

> After writing the above down, it strikes me odd that we do not
> have a predicate that says "we know the work tree is there".
>
> If a command wants a work tree, and if you are outside the work
> tree, then is_inside_work_tree() returns false and
> get_git_work_tree() returns non NULL, so that is a good pair of
> interface that can be mixed and matched (e.g. you can chdir to
> the former to perform the whole tree operation, or refuse to
> perform, based on is_inside_work_tree being false, cwd relative
> operations).

Yes.  Builtins which need a working tree expect to start at the toplevel 
of the work tree (which I like to call "working directory", because it is 
described as such in the glossary AFAIR), and therefore they chdir() to 
the toplevel in any case.

I'll be running "master"+worktree+branch-newdir for the remainder of the 
1.5.3-rc period, to be sure that all works as intended.

Ciao,
Dscho
