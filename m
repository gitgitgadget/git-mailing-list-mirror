From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Core GIT] Long-term cherrypicking
Date: Thu, 22 Sep 2005 00:19:31 +0200
Message-ID: <20050921221931.GC10575@pasky.or.cz>
References: <20050921164015.GC21971@pasky.or.cz> <7vzmq6p2an.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 00:20:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EICwI-0000oi-Nr
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 00:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVIUWTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVIUWTh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 18:19:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14226 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964912AbVIUWTh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 18:19:37 -0400
Received: (qmail 581 invoked by uid 2001); 22 Sep 2005 00:19:33 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmq6p2an.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9084>

Dear diary, on Wed, Sep 21, 2005 at 10:57:04PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> You solved this by 'git cherry' to go
> beyond M, which is a valid workaround, but then the problem
> becomes how to find where to stop.

When forking your branch, record that in a tag. When running git-cherry
with the tag as base, take the earliest cherrypick found and find the
LCA of the two corresponding commits. Reset the tag to that.

> I am assuming the reason this is a cherry-pick problem is
> because S does not necessarily send everything out, and whenever
> S does 'format-patch L' to generate a list of patches, only a
> subset of them is actually sent out.  If that is the case, how
> about maintaining another branch T on the S side, which is
> private to S?

That is not the case, this is a cherry-pick problem since L dropped some
of the patches (if the git's definition of "cherry-pick problem" isn't
something different to what I'd expect)...

> T starts out as the same commit as the head of L.  Whenever S
> has merge-worthy commits, run 'git-cherry-pick' to copy them
> over to T, and 'format-patch L' is run in T, not in S, to
> generate patches to be sent out.
> 
> T being a private tree allows you to rebase every once in a
> while to L [*3*], so that already applied patches are dropped
> from it.

...nevertheless your solution still seems to apply and sounds good to
me, thanks. I wonder why this didn't occur to me. :-) Perhaps it could
be noted in the tutorial?

The disadvantage is that this seems as a lot of work. You have to
explicitly cherry-pick each commit, and the fact that you have a
floating (continuously rebased) tree means that you can conveniently
keep it only on just one machine. [*1*]

The advantage is that it is easy to "forget" commits which were dropped
altogether or applied modified. You could put together some filter and
grep -v, but that's ugly and doesn't scale.

Well, I guess that if you are going to do this all, it really gets
visible that this rebasing stuff is really quite an ugly hack and that
you are probably much better off with something like StGIT. ;-)

> [Footnote]
> 
> *1* I am assuming that merge M would not be made any more
> difficult by having A and A' on both sides.  Is it a problem in
> practice?

That's something Karsten Keil would be more qualified to reply to, but
unfortunately you removed him from the Cc list. ;-)


*1* I find the fast-forward restriction more and more annoying in this
context, actually, and I'm seriously considering dropping it from Cogito
altogether. GIT seems to care a lot about it, but Cogito doesn't so far,
it would only have problems fast-forwarding your master to catch up with
the branch you are merging, trying to do a tree merge instead. But

	if old_ref == master then master = new_ref

would solve that. Can it ever really hurt?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
