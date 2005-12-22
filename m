From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 15:37:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA9BE6.7000601@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 15:37:31 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpRZN-0006LF-3T
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 15:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVLVOhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 09:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVLVOhV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 09:37:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6879 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965168AbVLVOhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 09:37:19 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68AFF13FC6B; Thu, 22 Dec 2005 15:37:18 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 471539E38E; Thu, 22 Dec 2005 15:37:18 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 30C209E37D; Thu, 22 Dec 2005 15:37:18 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2651513FC6B; Thu, 22 Dec 2005 15:37:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43AA9BE6.7000601@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13947>

Hi,

On Thu, 22 Dec 2005, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > 
> > Okay, so there you are. You have a write-shared repository with the HEAD
> > checked out. Somebody wants to push to that with different credentials than
> > the user who checked out the files. Do you plainly deny updating the current
> > HEAD?
> > 
> > If you do, then you better give the pushing user (pun intended) a way to
> > update the checked out files. You can do this by (tadaah) setting the umask
> > to 0002 also for working files.
> > 
> 
> Ahh. Sorry. We use this method a lot, really, but always only for running gitk
> and archaeology tools to check newly pushed changes, so the write-shared repo
> is only write-shared for remote users, and the local one never does a commit.
> It's perhaps a bit of a weird setup, but it lets you get an overview faster
> than gitweb and works well enough with samba. Noted should be that having the
> repo checked out is merely a convenience thing to let one browse the files at
> leisure. People know to do
> 	git checkout -f HEAD
> 
> whenever they want to dig around.

Better to do this with a post-update hook, right? You can't forget to 
checkout this way. *Plus* you can make sure the umask is correct in the 
hook.

> > Yes, we could find out exactly where writes happen inside GIT_DIR and plug
> > in shared.umask which is only applied in these cases, but I am totally
> > unconvinced that this is worth the hassle. In my cases, I am perfectly
> > helped by a umask which is respected throughout git, and the patch is simple
> > enough to be reviewed in 5 minutes.
> > 
> 
> But adding
> 
> 	umask 002
> 
> to /etc/bashrc would do exactly the same thing, so why have it a setting for
> the repository only? In my experience, most servers used for hosting git repos
> host *lots* of them (look at master.kernel.org), so a server-wide setting
> really makes much more sense. If the server admin can't be bothered you can
> always change $HOME/.bashrc.

In my very special setup, it is a server on which you have your personal 
files, too. So, setting umask = 0002 globally is not an option.

Furthermore, it just feels wrong to set an option outside of git which is 
meant *only* for git usage.

> So long as people remember that .bash_profile isn't read for non-interactive
> shells this should do nicely. If they can't remember that they won't remember
> adding the setting to the repository either.

Problem is, what if one of your users is a tcsh zealot? Or simply forgot 
to set it. Trouble in China. Also, I simply can not memorize what startup 
script gets called when.

Ciao,
Dscho
