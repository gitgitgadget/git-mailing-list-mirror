From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merging
Date: Fri, 17 Jun 2005 11:50:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
References: <20050617133440.GI6957@suse.de> <Pine.LNX.4.58.0506170937260.8487@ppc970.osdl.org>
 <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org>
 <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org>
 <20050617183914.GX6957@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 17 20:47:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjLri-00052i-8p
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 20:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVFQSve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVFQSuZ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 14:50:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262057AbVFQSsk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 14:48:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5HImYjA004584
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 17 Jun 2005 11:48:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5HImXFi017079;
	Fri, 17 Jun 2005 11:48:34 -0700
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <20050617183914.GX6957@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.110 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ Git mailing list cc'd, since this is a general question that maybe 
  others have wondered about ]

On Fri, 17 Jun 2005, Jens Axboe wrote:
> 
> btw (and forgive me for just asking you), what is the canonical way to
> kill a branch in case you want to redo it? right now I have a block tree
> with a bunch of brances, and I would like to redo one of the branches
> because I forgot to add the signed-off-by entries in there.

You can just simply remove the .git/refs/heads/branch-name file (obviously 
after having made sure that ".git/HEAD" points to something else), and 
then you can run "git prune", which will remove all objects that aren't 
referenced (directly or indirectly) by anything in ".git/refs/**".

Be very very careful, though. "git prune" is a dangerous script, since it
will remove objects from the object store. If you had something that you
don't have a proper reference for, or if you give "git prune" a list of
references manually and it's not complete, "git prune" will happily remove
objects that you didn't mean for it to remove.

The "git prune" script is really trivial, you can see for yourself what 
"git-prune-script" does.

NOTE! It's entirely possible to not actually delete the old branch, but 
just rename it, and use it as a reference while you build up the new 
branch with the same contents (but maybe different commit log messages, or 
maybe just re-ordering the commits in the new version). To rename a 
branch, just rename the ".git/refs/heads/<branch-name>" file to something 
else.

So you may decide to remove (and prune) the old branch only after you've 
re-created a new version of it, for example. That way you can use git 
itself to extract the contents of the branch you want to re-do, which is 
often easier.

Btw, if you have a recent version of "gitk" instealled, you can do

	gitk $(ls .git/revs/heads)

and you'll get a full graphical view of _all_ your branches, which can be 
very instructive.

		Linus
