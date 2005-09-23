From: Petr Baudis <pasky@suse.cz>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Fri, 23 Sep 2005 11:57:42 +0200
Message-ID: <20050923095742.GC10255@pasky.or.cz>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz> <34462.10.10.10.28.1127417134.squirrel@linux1> <20050923091012.GA10255@pasky.or.cz> <7vslvwcelj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:58:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIkJU-0004Bj-6z
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVIWJ5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVIWJ5o
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:57:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:211 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750862AbVIWJ5n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 05:57:43 -0400
Received: (qmail 641 invoked by uid 2001); 23 Sep 2005 11:57:42 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslvwcelj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9174>

Dear diary, on Fri, Sep 23, 2005 at 11:34:16AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > 	* cg-fetch can do with symlinked object database
> 
> Do you mean ".git/object" in the repository you are fetching
> into is a symlink to somewhere, or something else?

Yes, exactly that. You get it by doing cg-clone -l /local/path.  O(1)
cloning, but it has its downsides and dangers which I tried to describe
in the cg-clone documentation.

> > 	* cg-fetch won't do useless fetches when we are already
> > 	  up-to-date
> 
> Care to explain?  Perhaps you are talking about rsync transport
> (in which case I would not be surprised)?

Just that if the reference pointer did not change, you don't try to pull
any objects. Speeds things up somewhat, and now it should always work
(well, cg-fetch has -f which makes it always try objects as well, in
case something went wrong anyway).

> > 	* I'm not sure if I could call git-fetch to do the initial
> > 	  fetch during clone
> 
>     $ git-init-db && git fetch http://kernel.org/pub/scm/git/git.git
> 
> should work.

Good.

> There is another minor "con", if you include git-clone in the
> discussion.  Over http transport, it refuses to run against a
> remote repository that does not have info/refs and info/packs,
> even if it is not packed.  I think cg-clone uses recursive wget
> for directory traversal and does not have to use them.

cg-clone just basically does cg-init && cg-fetch, and I'd really want to
keep it on that. So effectively, cg-clone over http just runs
git-http-fetch and trusts it to do the right thing (reasonably fast).

Recursive wget is used only for fetching tags (and it actually seems to
work nicely, when directory listing is enabled, obviously). Yes, I
should teach cg-fetch about info/refs too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
