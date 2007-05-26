From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t9107-git-svn-migrate.sh fails
Date: Sat, 26 May 2007 11:30:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705261123420.4648@racer.site>
References: <Pine.LNX.4.64.0705242315550.4648@racer.site> <20070526093534.GB12639@muzzle>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat May 26 12:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrtY5-0006Ua-Ma
	for gcvg-git@gmane.org; Sat, 26 May 2007 12:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbXEZKaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 06:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbXEZKaz
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 06:30:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:53450 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750837AbXEZKay (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 06:30:54 -0400
Received: (qmail invoked by alias); 26 May 2007 10:30:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 26 May 2007 12:30:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EgZ4m63REFbIvyZYFRisXkvBsHwXIZzAI1CNF2n
	u4iQUyJAQFLd4M
X-X-Sender: gene099@racer.site
In-Reply-To: <20070526093534.GB12639@muzzle>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48467>

Hi,

On Sat, 26 May 2007, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > I recently wanted to use git-svn, and installed the svn perl bindings. 
> > Since then, t9107 is failing:
> > 
> > -- snip --
> > [...]
> > Rebuilding .git/svn/git-svn/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6 
> > ...
> > r1 = b9b82a419abdbb54f51a41bc8a3118b28c791ac1
> > Done rebuilding 
> > .git/svn/git-svn/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> > diff --git 
> > a/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6 
> > b/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db
> > index d3f1b6e..01d8afd 100644
> > --- 
> > a/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> > +++ b/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db
> > @@ -1,2 +1 @@
> > -0000000000000000000000000000000000000000
> > -6aa651a66730888e854a8de54199d62ffa402739
> > +.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> > \ No newline at end of file
> > * FAIL 7: .rev_db auto-converted to .rev_db.UUID
> > 
> >                 git-svn fetch -i trunk &&
> > 		[...]
> > -- snap --
> > 
> > Usually I try to fix things like this myself, but I really have to get 
> > some dinner now. Besides, other people than me seem to be way more clever 
> > with perl code.
> 
> .git/svn/trunk/.rev_db should be
> a symlink to
> .git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> 
> I keep .rev_db around as a symlink for backwards compatibility in case
> the user wants to downgrade.
> 
> I'm running cmp(1) to compare the file and symlink.  Are you running
> diff2[1] replacements in your tree and it's not understanding symlinks?

D'oh!

Yes, I did a wholesale replacement of all cmp and diff invocations to 
git-diff.

Two thoughts:

	- why don't you check it with readlink?

	- git diff should really output something when a file is compared 
		to a symlink...

I guess the second is something for my TODO list.

> > Anybody knows how to fix this?
> 
> Works for me(TM).

Changing the check back to cmp make it work here, too.

> [1] - I think that's what you called it.  I have had trouble keeping
> up-to-date with git things lately.

Yep, I called it diff2. But we found out that we can DWIM git-diff to do 
it; if in doubt, just say "git diff --no-index".

Ciao,
Dscho
