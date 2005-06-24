From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 12:00:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241153180.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
 <20050624064101.GB14292@pasky.ji.cz> <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 20:57:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DltLw-0001on-HR
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 20:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbVFXTCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 15:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVFXTCp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 15:02:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbVFXTBj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 15:01:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OIwSjA025438
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 11:58:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OIwRZv005920;
	Fri, 24 Jun 2005 11:58:28 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Matthias Urlichs wrote:
> 
> Well, I don't. Main reason: It's simply a lot faster to create+switch to a
> branch locally for doing independent work, than to hardlink the whole
> Linux directory tree into a clone tree.
> 
> Having one tree also simpifies the "what do I have that's not merged yet"
> question -- just call "gitk $(cat .git/refs/heads/*)". ;-)

Actually, I think that gets close to another real advantage of branches:  
that is also what allows you to edit things that failed a merge.

For example, let's say that a merge fail. You've got the HEAD and the
MERGE_HEAD, but a file type conflict (like a symlink that has turned into
a directory) or something like that means that you can't resolve them
sanely at all.

So this is merge problem where you can't just do a three-way merge and fix 
up the result and commit: you have to fix things up before you can even 
really do the merge. This is when switching to the MERGE_HEAD thing and 
fixing it up there, committing it, and then doing the merge with the 
original HEAD and the new MERGE_HEAD is really convenient.

(No, the scripts don't help you in cases like this, and we don't do the
MERGE_HEAD as a real branch right now, but the point is that we _can_, and
that this is more than an efficiency issue, it's a fundamental issue of
working with multiple end-points together. You _could_ clone the other 
head into a totally new repository, fix it there, and then try the merge 
anew, but now you're working around a limitation, not just doing 
something slower).

I still think you can go a bit too far on your branch usage (ie Jeff), but 
hey, what's the difference between three branches and fifty, really?

(I'm kidding. The difference between three and fifty is how well you can 
keep track of them in your head, but maybe Jeff just has a bigger head 
than most people do. Jeff, do people go "Boy, you've got a big head" the 
first time they meet you?)

			Linus
