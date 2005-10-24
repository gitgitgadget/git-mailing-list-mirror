From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 08:04:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510240743310.10477@g5.osdl.org>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz>
 <200510202137.22311.dtor_core@ameritech.net> <4358597A.6000306@catalyst.net.nz>
 <7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
 <20051024075431.GY30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 17:10:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU3t6-0006zp-GE
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 17:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVJXPFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVJXPFV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 11:05:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751075AbVJXPFU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 11:05:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9OF4xFC028516
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Oct 2005 08:05:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9OF4wbl026653;
	Mon, 24 Oct 2005 08:04:58 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051024075431.GY30889@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10543>



On Mon, 24 Oct 2005, Petr Baudis wrote:
> > 
> > Why? Because if you want to be slow and careful, you can always just 
> > create the weave after-the-fact and do a weave merge.
> 
> This doesn't make sense. Those silly weave merges only describe what to
> do with the weave to do the merge, not how you got the weave in the
> first place.

Do you think a weave is something magical that happens because the SCM 
keeps the files as a weave?

No.

The weave is _not_ a "a priori" thing. The only primary thing is the 
history of the file contents. Even a weave-based system will always create 
the weave out of the history - it just happens to also save the file in 
that woven format.

So if you have the history, you can always just re-create the weave. It's 
not rocket science. SCCS has been around for how many decades now?

And the thing is, because git does NOT keep the files in weave format, it 
can do the _normal_ case of a merge (same contents, never mind how they 
get there) much faster than anything else. The same-file merges are so 
unusual as to be unimportant - if it then takes a bit longer to handle 
them because you want to use a weave, hey, you're still ahead.

> The *primary* reason for new merge strategies is not reducing number
> of conflicts, but actually being able to force a conflict at places
> where it isn't crystal-clear what the resolution should be (but not
> conflicting where it should be clear), and especially at places where
> the three-way merge *silently* gets it *wrong* without throwing any
> conflicts. And weren't it you who wanted a conservative merge strategy
> which wouldn't ever do that?

A three-way merge is plenty conservative for me.

Any merge will always get some case wrong, exactly the same way any merge 
will always get some that require fixing up, even if a human might say 
"that's a stupid merge". Two patches add the same thing to different 
places (an unsorted array of PCI ID's or whatever), and pretty much any 
merge ever will silently "mismerge" it as far as a human is concerned. 
From a _technical_ point it was correct. In practice, it wasn't.

So when I say "conservative", I don't mean "can never mis-merge", because 
such a thing doesn't exist. No, "conservative" means that it seldom does 
it in practice, and that when it happens, you can at least understand why 
it happened.

A simple strategy that makes people understand what happened is often much 
better than a more complex one. And you should never underestimate the 
importance of peoples _expectations_. A three-way merge has a _huge_ 
advantage in that absolutely tons of people are used to what it does: even 
when they don't necessarily "understand" the merge (they never cared), if 
they've worked with CVS they've seen them before.

Don't get me wrong - a weave merge is pretty damn conservative too. I'm 
not down on weave merges, I just don't think that the difference is that 
huge in practice - the difference between a three-way merge and a weave 
merge is much smaller than the advantage of a good graphical tool and a 
good workflow.

That's really my argument here: automated merges aren't the end-all. I 
realize that a lot of SCM people think that three-way merges are old and 
boring and stupid, but the fact is, sometimes the old ways aren't the best 
ways, but sometimes they are old just because they are good enough.

		Linus
