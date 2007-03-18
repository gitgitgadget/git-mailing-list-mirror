From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sun, 18 Mar 2007 12:18:00 +0100
Message-ID: <20070318111800.GA15147@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx> <7vr6rnlyzt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 12:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HStP8-0008Mr-CF
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 12:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbXCRLSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 07:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbXCRLSJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 07:18:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:55886 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964790AbXCRLSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 07:18:08 -0400
Received: (qmail invoked by alias); 18 Mar 2007 11:18:06 -0000
X-Provags-ID: V01U2FsdGVkX1+k/VlJJYOknQHaFct8BA5KIG8ewXW2pYypvizGVI
	Esp+3oq9WT4vfg
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6rnlyzt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42490>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> >  * git init does not show the expansion of GIT_WORK_TREE to an
> >    absolute path, this might confuse the user
> 
> If the feature might confuse the user without extra output, it
> probably is confusing to begin with, with or without it, so one
> option might be to refuse relative path when running git-init.
> 
> However, as long as the expansion to absolute path is done
> correctly, I do not think there is any room for confusion.  Who
> would want a feature that lets you set work-tree to ../.., so
> that no matter where in the working tree you cd around, git
> assumes that the toplevel is two level up?  If you record the
> work tree location in the configuration, you would want it to be
> stable, and I do not think anybody would expect it be stored as
> relative.  So I thought having the printf() would be a good way
> for debugging the absolute expansion, but after that I do not
> think it is needed (but again, I may well be missing some issues
> you've thought about, so please tell me otherwise).

I really don't know what people would expect from git --work-tree=foo
init and therefore I thought it might help to tell them "core.worktree
= /path/to/foo".  For example one could think this would work (without
the message in brackets):

    ~/foo$ export GIT_DIR=`pwd`/repository.git
    ~/foo$ mkdir src
    ~/foo$ git --work-tree=src init
   [core.worktree = /home/user/foo/src]
    Initialized empty Git repository in /home/user/foo/repository.git/
    ~/foo$ cd ..; mv foo bar; cd bar
    ~/bar$ export GIT_DIR=`pwd`/repository.git

With the message in brackets it would be clear what breaks after
renaming the directory.

Note: git config core.worktree ../src fails after moving the working
tree because the value of core.worktree checked for validity.
Either run

    $ git --work-tree=. config [args]

or just do

    $ git --work-tree=src init

again in the new location and git-init will set core.worktree again.
