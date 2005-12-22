From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 16:09:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221603490.18668@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> 
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>  <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vek465cev.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com> 
 <Pine.LNX.4.63.0512221227190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0512220638j382252b5l24e1c6b261165bd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 16:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpS4o-0001Um-CL
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 16:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVLVPJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 10:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVLVPJq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 10:09:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1512 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751055AbVLVPJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 10:09:46 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2056513FCD9; Thu, 22 Dec 2005 16:09:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0346F9E38A; Thu, 22 Dec 2005 16:09:45 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E1EB99E231; Thu, 22 Dec 2005 16:09:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9427013FCBB; Thu, 22 Dec 2005 16:09:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512220638j382252b5l24e1c6b261165bd6@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13949>

Hi,

On Thu, 22 Dec 2005, Alex Riesen wrote:

> On 12/22/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > What would shell.umask do? Be set only when git-shell is called? Then you
> > better have the policy to access that particular repository *only* via
> > git-shell. Voila, it is the same effect as of core.umask.
> 
> I mean it to be set only when git-shell called, but with explicit semantics
> ("for git-shell only").

But if somebody writes to the same repository with another umask, say 
0022, you have problems. Example:

- I push -- via ssh/bash -- to the repository. The ref refs/heads/bruchpilot
  is updated (mode: 0644).

- My colleague pushes -- via ssh/git-shell -- to the repository. When she
  tries to write refs/heads/bruchpilot, it fails, even if she set the 
  correct umask.

See what I mean? It makes no sense to allow different umasks on the 
repository.

> > What would shared.umask do? Be set only when writing to GIT_DIR? This is a
> > major task, since you have to find out which writes are to the working
> > directory, which ones go to GIT_DIR.
> 
> shared.mask = shell.mask. Just a name to express what it is for

You do mean different umasks for different access methods, don't you? See 
above why I don't think that makes sense.

Ciao,
Dscho
