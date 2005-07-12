From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 20:49:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 05:49:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBlz-0004XE-4r
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVGLDtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVGLDtV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:49:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262312AbVGLDtU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 23:49:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C3nFjA018992
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 20:49:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C3nEZE019986;
	Mon, 11 Jul 2005 20:49:14 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Linus Torvalds wrote:
> On Mon, 11 Jul 2005, Marc Singer wrote:
> > 
> > From my POV, what I want is a branch with the tag v2.6.12 as the basis
> > of the branch.  I'm guessing that -b means "make me a branch and call
> > it this".
> 
> Yup. That would be the interface.
> 
> >  # git checkout -b BRANCH_NAME [TAG]
> > 
> > If the TAG is omitted, the branch is made from the current HEAD or
> > some other reasonable point defined by the current working directory.
> 
> That would be the most natural thing that would fall out of this kind of 
> interface.

Ok, done. 

Now, if you try to do

	git checkout v2.6.12

git will complain with

	git checkout: you need to specify a new branch name

and some day (when I can get my act together and have man-pages that 
work), there would even be documentation for the "-b" flag to specify the 
branch name. And indeed, if you only specify the branch name, it will 
just create it and switch to it from the current HEAD.

So while there are no docs, the checkin comment hopefully says it all:

		Linus
---
commit 91dcdfd3b5331d955cfb60edf8930f1b5c142905
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Mon Jul 11 20:44:20 2005 -0700

    Make "git checkout" create new branches on demand

    In particular, if we check out something that isn't an old branch, it
    now requires a new branch-name to check the thing out into.

    So, for example:

        git checkout -b my-branch v2.6.12

    will create the new branch "my-branch", and start it at v2.6.12, while

        git checkout master

    will just switch back to the master branch.

    Of course, if you want to create a new branch "my-branch" and _not_
    check it out, you could have done so with just

        git-rev-parse v2.6.12^0 > .git/refs/heads/my-branch

    which I think I will codify as "git branch".
