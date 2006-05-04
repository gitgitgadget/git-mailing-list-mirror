From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2
Date: Thu, 4 May 2006 14:33:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 04 23:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FblS3-0006yG-Hi
	for gcvg-git@gmane.org; Thu, 04 May 2006 23:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWEDVdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 17:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWEDVdc
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 17:33:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030329AbWEDVdc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 17:33:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k44LXLtH002643
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 May 2006 14:33:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k44LXK7i017518;
	Thu, 4 May 2006 14:33:20 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605041627310.6713@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19578>



On Thu, 4 May 2006, Daniel Barkalow wrote:
> 
> I think it shouldn't be on fetch, though; I think a "git remote" command 
> for describing, creating, and modifying remotes would be better, since you 
> also sometimes want to add a "Push:" line.

I don't think this is wrong, but I think it's more important to try to 
decide on how we want to represent this information first, and stabilize 
that.

I realize that git has gotten a lot more porcelainish over time, but at 
the same time, now you're really starting to argue about syntax that 
really ends up being often a feature of the development environment. If 
you did development using an IDE that knows about git, I think the 
"remote" information ends up being not necessarily a git command at all, 
but really an interface in the IDE.

I'm actually growing pretty fond of the config file interfaces that Dscho 
is pushing. I really like the idea of "git pull" doing different things 
depending on which branch is active at the time, because different 
branches really can have different sources they come from.

Always pulling from the same default source seems wrong, and having to 
remember whose source some branch is associated with is just not all that 
user-friendly, but perhaps more importantly, it's also going to result in 
people making mistakes, pulling from the wrong branch (because they didn't 
think about where they were), and then having strange merges that they 
might not notice were wrong until it's too late and they pushed the result 
out.

So Johannes' patches seem to move into that direction, and having it all 
in the config file actually seems to be quite readable.

And that, in turn, may mean that a lot of porcelains really only care 
about that syntax, and then they may update the config file any way they 
please (whether by hand, or by using "git repo-config" or by using "git 
remote").

So I'd argue that (a) yes, we do want to have the "proto porcelain" that 
sets remote branch information without the user having to know the magic 
"git repo-config" incantation, or know which file in .git/remotes/ to 
edit, but that (b) it's even more important to try to decide on what the 
remote description format _is_.

I personally have just two preferences:

 - I'd like each branch I'm on to have a "default source" for pulling (and 
   _maybe_ for pushing too). I'd like to just say "git pull", and it would 
   automatically select the appropriate thing to pull from.

 - maybe the same per-branch thing for "push", but more importantly for 
   me, I like to push to multiple destinations, and I'd like the 
   description format to be sane. I think it may already be sane in the 
   form it is in now (supporting both config file _and_ .git/remotes/ 
   formats), I'd just like us to decide on exactly what the meaning is, 
   and hopefully get to the point where we can tell porcelain how to use 
   that meaning to their advantage (and not change it)

Others may disagree, or (equally importantly), may have additional 
preferences. We should try to find something that works for everybody, and 
that is easy to work with.

		Linus
