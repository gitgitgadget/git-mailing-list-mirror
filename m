From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Cogito] Various bugs
Date: Tue, 7 Feb 2006 07:53:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602070751410.3854@g5.osdl.org>
References: <20060131041318.GC30744@diku.dk> <20060207003643.GJ31278@pasky.or.cz>
 <7vfymw3oym.fsf@assigned-by-dhcp.cox.net> <20060207021006.GM31278@pasky.or.cz>
 <7v8xsn50rf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 16:55:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6VAS-0005Va-Dj
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 16:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWBGPyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 10:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWBGPyI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 10:54:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965144AbWBGPyH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 10:54:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k17FrxDZ023023
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Feb 2006 07:53:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k17FrvUS002747;
	Tue, 7 Feb 2006 07:53:58 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsn50rf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15696>



On Mon, 6 Feb 2006, Junio C Hamano wrote:
> 
> It depends on what you expect, but it meets _my_ expectation:
> 
>     $ GIT_AUTHOR_NAME='' git-commit-tree $(git-write-tree) </dev/null
>     Committing initial tree a2b59c3848164a2c9c3c75fbaadccaed9485da92
>     ef90563fa278735af367e7606ea7eb2559121ca7
>     $ git-cat-file commit ef90563fa278735af367e7606ea7eb2559121ca7
>     tree a2b59c3848164a2c9c3c75fbaadccaed9485da92
>     author  <junkio@cox.net> 1139281078 -0800
>     committer Junio C Hamano <junkio@cox.net> 1139281078 -0800
> 
> That is, the user said GIT_AUTHOR_NAME is empty, so he gets a
> commit with an empty author name.

Yes. That said, we should probably disallow that in git-commit-tree (and 
let the user fix it up some way).

> get_ident() in ident.c does this. getenv("GIT_AUTHOR_NAME") and
> friends are passed to it, and git_default_* are takenfrom gecos.
> It might match some peoples' expectation (but not mine) if we
> did this instead.

No, don't use the default name.

An empty GIT_AUTHOR_NAME should _not_ mean that we use the default name 
(which is usually the committer), because rather than meaning "default", 
it most likely means "buggy import script". 

I'd rather have an email import of mine say that it cannot commit, than 
have it put "Linus Torvalds" in the author line (and some random email).

			Linus
