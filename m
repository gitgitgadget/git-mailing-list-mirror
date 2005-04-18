From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 13:15:25 +0200
Message-ID: <20050418111525.GN1461@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 13:12:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNUAW-0006ic-HL
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 13:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVDRLPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 07:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVDRLPr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 07:15:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3748 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262032AbVDRLP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 07:15:29 -0400
Received: (qmail 2288 invoked by uid 2001); 18 Apr 2005 11:15:25 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050418102332.A21081@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 11:23:32AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Ok, I just tried pulling your tree into the tree you pulled from, and
> got this:
> 
> Tree change: e7905b2f22eb5d5308c9122b9c06c2d02473dd4f ee423ea56280512778a5961ee58a785a73acb7d1
> ...
> *100644->100644 blob    46f0a3caae02b4bb8f903d7ac86456aa0c37954b->ba4afd7956173b6f89eb6b0b9ad23b392d5c0aee      arch/arm/kernel/process.c
> *100644->100644 blob    4a36fa7192e11df36f5e0928b064239dabe1e305->ec0bc8f315ab5d78a4220e176e7aee76d52d1c74      arch/arm/kernel/traps.c
> *100644->100644 blob    311d19ee00208faf02359f9e7c5394577a40f253->bf923a953703c6ca0c88eac3b2850cf07b838996      arch/arm/lib/changebit.S
> *100644->100644 blob    c07afa31695654e6489ec59c3f837183b325e9da->41f89b3a393d5af939f04f63c5bf4991b2bf6599      arch/arm/lib/clearbit.S
> ...
> Tracked branch, applying changes...
> Merging e7905b2f22eb5d5308c9122b9c06c2d02473dd4f -> ee423ea56280512778a5961ee58a785a73acb7d1
>         to df4449813c900973841d0fa5a9e9bc7186956e1e...
> COPYING: needs update
> CREDITS: needs update
> Documentation/00-INDEX: needs update
> Documentation/BK-usage/00-INDEX: needs update
> ...
> patching file arch/arm/kernel/process.c
> Reversed (or previously applied) patch detected!  Skipping patch.
> 2 out of 2 hunks ignored -- saving rejects to file arch/arm/kernel/process.c.rejpatching file arch/arm/kernel/traps.c
> Reversed (or previously applied) patch detected!  Skipping patch.
> 3 out of 3 hunks ignored -- saving rejects to file arch/arm/kernel/traps.c.rej
> patching file arch/arm/lib/changebit.S
> Reversed (or previously applied) patch detected!  Skipping patch.
> 2 out of 2 hunks ignored -- saving rejects to file arch/arm/lib/changebit.S.rej
> patching file arch/arm/lib/clearbit.S
> Reversed (or previously applied) patch detected!  Skipping patch.
> 2 out of 2 hunks ignored -- saving rejects to file arch/arm/lib/clearbit.S.rej
> 
> so obviously git pull isn't able to indentify what's already in the
> local repository.

For unknown reason, patch sucks at this, even if I pass it

-N  or  --forward
  Ignore patches that seem to be reversed or already applied.  See also -R.

:-(

git merge does not use the in-GIT merging capabilities yet.

Could you do

	merge-base $(tree-id ee423ea56280512778a5961ee58a785a73acb7d1) \
		$(tree-id df4449813c900973841d0fa5a9e9bc7186956e1e)

and check if it returns e7905b2f22eb5d5308c9122b9c06c2d02473dd4f, please?
I guess it won't. So you could try to wipe the -b "$orig_head" from
gitmerge.sh invocation in gitpull.sh.

> Interestingly, the files listed above as having rejects are excluded
> from the list of "needs update".  And I don't know why git is staying
> that these files need updating, because they haven't changed since
> they were initially checked out.

Because it is checking out only the files which changed (pass -a to git
merge to check out everything; I will probably make git pull take a -m
argument which will take merge arguments ;). And then it does
update-cache --refresh which complains about missing files. :/

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
