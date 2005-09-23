From: Petr Baudis <pasky@suse.cz>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Fri, 23 Sep 2005 02:28:44 +0200
Message-ID: <20050923002844.GO21019@pasky.or.cz>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org> <7vu0genlc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org> <20050921.172849.103555057.davem@davemloft.net> <46a038f905092118464b98e149@mail.gmail.com> <Pine.LNX.4.58.0509211902010.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 02:29:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIbQo-0008Gc-Ru
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 02:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVIWA2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVIWA2r
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 20:28:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19085 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751239AbVIWA2q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 20:28:46 -0400
Received: (qmail 20788 invoked by uid 2001); 23 Sep 2005 02:28:44 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509211902010.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9155>

Dear diary, on Thu, Sep 22, 2005 at 04:10:08AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> But cogito at least _used_ to have some special logic for moving patches
> forward.

Yes, but it is used only in case of fast-forward commits.

> git-resolve-script never had that - it only ever did the per-file
> three-way merge, and refused to touch dirty state except for the
> "everything stays the same" case.
> 
> Oh. I'm looking at the current cg-merge thing, and I think I see the
> problem: it's doing
> 
> 	git-checkout-index -f -u -a
> 
> at the end. That's not only unnecessary, since it uses the "-u" flag to 
> "git-read-tree", but it will force an overwrite of the working tree, and 
> is thus actively incorrect.
> 
> Pasky?

Oops. How brown-paper-bag-ish. Thanks for pointing this out, that was
obviously horribly wrong, and it was indeed apparently happily trashing
all the local changes. I've removed it, and added proper handling for
cases when conflicts arise from merge over a tree with local changes -
that was troublesome since cg-commit after resolving the conflicts would
commit the local changes too. It won't anymore, and cg-status will mark
those files appropriately. Woohoo.

I've also added a rather elaborate regression testing for cg-merge, so I
hope that will help catch any future breakages. Hmm, I have to say that
while I find writing those tests incredibly boring and annoying, it is
pretty nice when I already have them. ;-)

This fix alone is worthy a release, so I'll do one tomorrow.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
