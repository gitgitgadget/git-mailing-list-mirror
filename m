From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 20:20:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
 <20060526193325.d2a530a4.tihirvon@gmail.com> <20060526163829.GB10488@pasky.or.cz>
 <1148697382.5599.1.camel@dv> <20060527025750.GM11941@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, Timo Hirvonen <tihirvon@gmail.com>,
	Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 05:23:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjpP2-0000qU-Tg
	for gcvg-git@gmane.org; Sat, 27 May 2006 05:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWE0DXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 23:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWE0DXj
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 23:23:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751780AbWE0DXj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 23:23:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4R3KF2g019446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 May 2006 20:20:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4R3KEWR028516;
	Fri, 26 May 2006 20:20:14 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060527025750.GM11941@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20832>



On Sat, 27 May 2006, Petr Baudis wrote:
> 
> ~/.gitrc might get useful for actually doing what ~/.cvsrc or ~/.cgrc
> does, that is providing default options for git commands. ~/.gitconfig
> would just give you per-user defaults for the repository config file.

I don't think the two are necessarily any different.

I do think that
 (a) we might as well use the same syntax. There's no point in having 
     different syntax for the files, even if they end up having slightly 
     different usage.
 (b) a "user-wide" config file would tend to have different things in it 
     than a per-repository one, but some of the things it would have in it 
     are the things that we currently put in the per-repository one. 
     Notably exactly the "user.name" and "user.email" values.
 (c) having a user- (and perhaps a system-) wide config file would make 
     some things that we do not _yet_ support in the .git/config file 
     format more natural, but that doesn't necessarily mean that having 
     them on a per-repo basis would be wrong either.

As an example of (c), let's say that somebody wants to use the CVS aliases 
with git. They've used cvs for years, and as a result their brain has 
atrophied, and they have a really hard time teaching their fingers to 
write "git commit" when they want to write "cvs ci".

So they would do "alias cvs git" in a desperate attempt to save themselves 
from CVS, and then add

	[alias "co"]
		cmd = commit -a

to their .gitrc file. Now, the only thing we'd need to do is to teach 
"git.c" to parse that simple "alias.$1.command" variable, and that really 
sounds pretty damn easy, no?

And that really does make more sense in a user-wide ".gitrc" file. But at 
the same time, there's really no reason to _disallow_ it from the 
repo-private .git/config file either. For example, you could do

	[alias "publish"]
		cmd = push public.site.com:/pub/scm/my-public-repo

and that is somethign that actually makes sense as a per-repository 
command alias, so that "git publish" does the right thing for just _that_ 
repository.

So I would argue that yes, ".gitrc" makes sense, and no, we shouldn't have 
a separate ".gitrc" and ".gitconfig", because I think what we really would 
want is a way to do default .git/config entries, and that it is _also_ a 
very natural way to add some things that we don't do yet.

			Linus

PS. I really like my [alias "cmd"] idea. _All_ my ideas are great, of 
course, but this one seems even better than some others. No?
