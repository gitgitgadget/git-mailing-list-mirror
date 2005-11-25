From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 14:11:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511251400570.13959@g5.osdl.org>
References: <20051123142303.GJ22568@schottelius.org>
 <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org>
 <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org>
 <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org> <20051125195121.GG16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	Git ML <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 25 23:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EflnU-0006Ad-66
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 23:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKYWLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 17:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVKYWLo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 17:11:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751485AbVKYWLo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 17:11:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAPMBSnO022555
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 25 Nov 2005 14:11:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAPMBMRA018536;
	Fri, 25 Nov 2005 14:11:24 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051125195121.GG16995@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12752>



On Fri, 25 Nov 2005, Ryan Anderson wrote:
> 
> Can something like this sequence do it?

Nope, I don't think that should matter. Also, that doesn't seem to match 
what Nico & co are doing, but that's hard to tell.. 

A merge result should be totally independent of the index file(s) 
involved.

A dirty index file can cause a merge to _fail_, in that git may refuse to 
do the merge at all because of the index not matching the original branch, 
but a successful automated merge should never have any dependencies on 
what happens to be in the index at the time the merge was done.

So you can think of a merge as being totally specified by the trees 
involved, unless we have some bug, of course. I can't think of any.

Now, what _can_ happen (I think) is that if a merge is a failure (and 
there, a dirty index can certainly be the _cause_ of that failure), then 
when you fix it up and commit, there's some mix-up at _that_ stage.

For example, let's say that you had a dirty tree or something, and then 
the merge failed, and you didn't see anything wrong, so you just end up 
doing a "git commit". At _that_ point, what you had in the index matters 
very much, of course, since the index is what will be committed.

> I think that's the situation where I've personally managed to lose
> and/or revert some changes.

Hmm.. Can you elaborate?

(Side note: all my commentary is purely about the "raw git" interfaces. I 
don't know what cogito may do on top of it).

		Linus
