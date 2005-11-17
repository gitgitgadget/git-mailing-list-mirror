From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Thu, 17 Nov 2005 08:23:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com> 
 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org> <cda58cb80511170236p4a7e2baay@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 17:30:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmXo-0005Y0-Cw
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVKQQXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVKQQXP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:23:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932395AbVKQQXO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 11:23:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHGN8nO018918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 08:23:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHGN7RT028278;
	Thu, 17 Nov 2005 08:23:08 -0800
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511170236p4a7e2baay@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12129>



On Thu, 17 Nov 2005, Franck wrote:
> 
> Sorry, I forget to tell that I have already tried what you suggested
> at first (except that I did not do a 'git repack -a -d') but it didn't
> work out (and that the reason why I tried the "kill father object"
> thing).

If that didn't work, then you can't kill the father object: it will not 
only just get rid of one single object, but it will make fsck unhappy that 
your tree is incomplete.

What you probably _can_ do is to find whatever top-most commit you want 
(say, the v2.6.0 commit), and use grafting to make that have no parents. 
Then you can do git-prune to get rid of everything under it.

> Since I forgot the repack thing, I retried again, and it did
> last more than 4 hours to cpmplete all git commands.

Sounds like the original archive was fully unpacked. That really does get 
very very slow after a while.

>		 After that I run
> gitk --all to check that all old branch's objects have been removed
> but I can see all of them.

Note that if the branches are still there, git prune won't do anything to 
them (and git repack will pack them all). You need to remove the branches 
_first_, so that git repack and prune sees that their objects aren't 
needed.

But yes, if the tree is actually based on some full CVS history and really 
goes back all the way to 1995, then you can't prune it (since all branches 
are actually part of the history from the very top), and you'd need to 
graft away part of it like above.

		Linus
