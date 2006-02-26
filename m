From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach the "git" command to handle some commands internally
Date: Sun, 26 Feb 2006 15:22:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261518110.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602261225500.22647@g5.osdl.org>
 <7vbqwt7m3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>,
	Michal Ostrowski <mostrows@watson.ibm.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:23:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVEV-0006Bx-Cv
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 00:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWBZXXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 18:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWBZXXQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 18:23:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932265AbWBZXXP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 18:23:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QNMiDZ017753
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 15:22:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1QNMg7e029382;
	Sun, 26 Feb 2006 15:22:43 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqwt7m3t.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16805>



On Sun, 26 Feb 2006, Junio C Hamano wrote:
> 
> > There's one other change: the search order for external programs is 
> > modified slightly, so that the first entry remains GIT_EXEC_DIR, but the 
> > second entry is the same directory as the git wrapper itself was executed 
> > out of - if we can figure it out from argv[0], of course.
> 
> I am not sure about this part, though.

Well, what it means is that _if_ you install all your "git" binaries in 
some directory that is not in your patch and is not GIT_EXEC_DIR, they 
will still magically work, assuming you don't do something strange.

IOW, you can do things like

	alias git=/opt/my-git/git

and all the "git" commands will automatically work fine, even if you 
didn't know at compile time where you would install them, and you didn't 
set GIT_EXEC_DIR at run-time. It will still first look in GIT_EXEC_DIR, 
but if that fails, it will take the git commands from /opt/my-git/ instead 
of from /usr/bin or whatever.

It seemed a nice thing to try to make the git wrapper execute whatever git 
version it was installed with, rather than depend on PATH.

But hey, it's only a couple of lines out of the whole thing, so you can 
certainly skip it (remove the

	if (exec_path)
		prepend_path(exec_path)

lines to disable it).

		Linus
