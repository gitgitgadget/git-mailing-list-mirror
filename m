From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 12:35:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221227190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> 
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>  <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vek465cev.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 12:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpOj3-0007OQ-Od
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 12:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVLVLfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 06:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLVLfF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 06:35:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4519 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932216AbVLVLfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 06:35:04 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1B10813FD5D; Thu, 22 Dec 2005 12:35:03 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F25939E38A; Thu, 22 Dec 2005 12:35:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DEC599E231; Thu, 22 Dec 2005 12:35:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A7EEB13FD69; Thu, 22 Dec 2005 12:35:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13944>

Hi,

On Thu, 22 Dec 2005, Alex Riesen wrote:

> On 12/21/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > >     [core]
> > > >             umask = 0002
> > So, I tend to say: use core.umask only in shared setups (in which you
> > should not checkout files unless you know exactly what you are doing).
> 
> May be "shell.umask" or "shared.umask" ?

What would shell.umask do? Be set only when git-shell is called? Then you 
better have the policy to access that particular repository *only* via 
git-shell. Voila, it is the same effect as of core.umask.

What would shared.umask do? Be set only when writing to GIT_DIR? This is a 
major task, since you have to find out which writes are to the working 
directory, which ones go to GIT_DIR.

And you have to workout a policy (as I just answered in this thread) how 
to deal with a checked out HEAD where you can't write to the working 
directory (or at least modify the checked out files).

The sanest way I can think of is either to disallow checkout, or to make 
the files writable to the group. Both methods do fine with core.umask.

Now that I think of it: A third possibility is to disallow pushing to the 
checked out HEAD. Is this desirable? I think not. The user who works in 
the working directory exclusively would have to keep track of the 
pushed ref herself, instead of the user who pushed the ref. Sounds silly 
to me.

Hth,
Dscho
