From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 12:42:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301233270.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
 <42C4419C.7000309@timesys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 21:37:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do4qS-0003g9-2u
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 21:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVF3Tnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVF3Tli
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 15:41:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262987AbVF3Tkk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 15:40:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UJeOjA018379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 12:40:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UJeMw5027667;
	Thu, 30 Jun 2005 12:40:23 -0700
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <42C4419C.7000309@timesys.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Mike Taht wrote:
> 
> >    However, I don't know what the rules for acceptable mirroring 
> >    approaches are, and it's entirely possible (nay, probable) that an ssh
> >    connection from the "master" ain't it. It would be good to know what 
> >    (of any) would be acceptable solutions..
> 
> Flute, perhaps
> 
> http://www.atm.tut.fi/mad/

Well, I was hoping for something that has git knowledge, since there are 
issues like updating objects in the right order. 

So "git-send-pack" is nice in many ways: it allows you to update any 
number of branches (in particular, it allows you to update just a _subset_ 
of the branches, which is nice if you have a shared central repository, 
and some people have write permissions to some branches but not to 
others), but it also allows for efficient unpacking on the receiver side 
in a way no "general-purpose" mirror program can really match.

However, that requires the receiver to run a git-aware unpacker (in this
case git-receive-pack). I'm hoping that would be acceptable, I'm just
wondering what kind of safety concerns I'd need to make sure of in order
to make people comfortable running a special receiver program.

So the current approach is very flexible: if the pusher has ssh access, he
can do it. Safe, secure, and no new security issues. And since the only
programs the receiver has to be able to run is two git programs
(git-receive-pack will run git-unpack-objects), maybe it would be ok to
even have "git-receive-pack" as the shell for the receiver side, so that
you don't actually give the mirrorer any shell access at all. But it's
still "push-based" in the sense that it's kernel.org that is doing the
pushing, and that may simply not be acceptable.

			Linus
