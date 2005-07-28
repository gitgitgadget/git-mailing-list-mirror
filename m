From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 14:08:07 +0200
Message-ID: <20050728120806.GA2391@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 14:10:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy7CA-0008NO-Ug
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 14:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVG1MIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVG1MIU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 08:08:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19979 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261432AbVG1MIP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 08:08:15 -0400
Received: (qmail 3233 invoked by uid 2001); 28 Jul 2005 12:08:07 -0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 27, 2005 at 02:58:42PM CEST, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> told me that...
> Hi,

Hello,

> if I clone a remote head other than master via Cogito with
> 
> 	cg-clone host:path#remoteHead,
> 
> work on this branch, and try to push back my changes with
> 
> 	cg-push,
> 
> I get the error
> 
> 	"pushing to a different head not supported yet".
> 
> As far as I can see, there is no support in core GIT to make this ever work 
> (at least with get-send-packs), as "git-send-pack" only updates a set of 
> heads with the same name both locally and remote.

Yes. It sucks. :-)

> I suppose the best would be to always keep the same head names in cloned 
> repositories - it seems to be easier to handle for users. Perhaps the only 
> exception would be "master", as one probably would like to pull masters of 
> different remote repositories into a local one (without really working on 
> them).

I think that would be quite confusing. I mean, you added a remote "bar"
branch under name "foo" by cg-branch-add, but suddenly, branch "bar"
appears as well. Worse if you already have a different branch "bar".

> Thus, what about the following: Each time a remote head other than master is 
> cloned, a head with the same name is created locally which is an alias to the 
> local master. This way, cg-push almost works out of the box. Following patch 
> implements this behavior.

See above. I would much rather see more flexible git-send-pack. Junio,
what about changing its [heads]* parameter e.g. to
[remotehead[:localhead]]* ?

Dear diary, on Thu, Jul 28, 2005 at 03:32:01AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > As far as I can see, there is no support in core GIT to make this ever work 
> > (at least with get-send-packs), as "git-send-pack" only updates a set of 
> > heads with the same name both locally and remote.
> 
> Yes, it is my understanding that "clone" means to literally
> clone, not "pull into an empty repository with renamed head
> names", to the core GIT.  I do not speak for Pasky, but Cogito's
> "clone" seems to have a bit different semantics (which I suspect
> is more friendly to the users in many situations).

cg-clone serves only for initializing the repository from a remote
source initially.

> Similarly, "push" to the core GIT (that is what git-send-pack is
> about) means performing a subset of "clone" in reverse.  This is
> primarily to synchronise two repositories owned by a single
> person.

cg-push aims to serve as a general pushing mechanism, which should work
properly even if multiple people push to a single repository.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
