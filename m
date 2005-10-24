From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Sun, 23 Oct 2005 18:35:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz>
 <200510202137.22311.dtor_core@ameritech.net> <4358597A.6000306@catalyst.net.nz>
 <7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:36:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrG2-0001Qs-Ax
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVJXBf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVJXBf5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:35:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750849AbVJXBf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 21:35:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9O1ZjFC031179
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Oct 2005 18:35:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9O1Zhvq005544;
	Sun, 23 Oct 2005 18:35:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10519>



On Sun, 23 Oct 2005, Junio C Hamano wrote:
> 
> Even if we did that, we are still doing 3-way merge; git-merge
> framework may not mesh very well when we want to use something
> like codeville merge which is not based on 3-way.

Oh, the git merge is about a million times better than any silly weave 
merge with extra BonusPoints and MagicCapitalizedNames.

Why? Because if you want to be slow and careful, you can always just 
create the weave after-the-fact and do a weave merge.

And because well-behaved git merges as so fast, you can actually afford 
to so so.

There's nothing magic in a weave merge. It's just a trick. It doesn't need 
the files to be in weave format beforehand, even though people seem to 
believe that file formats go together with it.

If somebody thinks a weave merge is wonderful and fixes everything, I have 
to rain on their parade. You still need to manually fix real conflicts up, 
and regardless, what kind of merge you do has _nothing_ to do with how you 
maintain your files.

If you want to do a weave merge inside git, then the way to do that is to 
just create the weave on demand in the (rare) case where it's needed. We 
have all the history. You might even just do a "lazy weave", which just 
starts from the common parent, and ignores the history before that. 

Much cheaper that way, and arguably nicer (others will argue that you want 
to take history into account, to decide about undo's etc. It's a matter of 
taste). 

The thing is, automatic merging isn't all _that_ important. The thing that 
made BK wonderful at merging was that it had a wonderful tool for merging 
for when there were real clashes, which is where the _really_ nasty cases 
are. The actual automatic merge wasn't necessarily anything magical.

(Same went for applying diffs, btw. What made BK nice was "renametool". Of 
course, it was also what made me decide that tracking renames was the 
wrong thing to do in the first place, but if you make a CMS that does 
renames, you'd better have a "renametool").

And if you have a tool that helps you visually merge the _real_ clashes, 
it doesn't much matter if you are only half-way decent on the automatic 
ones. They'll be so trivial that nobody cares.

And it doesn't matter _how_ good your automatic merges are, there always 
_will_ be real clashes.

[ Side note. Think about this for a while. Git did three-way merges 
  pretty much since day one, but they only became _useful_ when we made it 
  easy to see the merge conflicts and fix them up. That's a fundamental
  lesson right there: you don't have to be perfect, you have to make it 
  easy for the user to fix up your imperfections. ]

So we should spend time on making it easy to see what the clash was, and 
on tools to help resolve them. Some random merge-strategy-of-the-day is 
just bling-bling. 

The reason people like merge strategies is that it's a nice area for some 
mental masturbation. You can create all these fancy examples. And then can 
ignore the fact that most real merge problems end up being two people 
changing the same code in different ways, that just need manual merging.

Don't get me wrong - if somebody does a nice automated merge for git, it's 
a good thing, but it's probably much more important to try to integrate 
something like xxdiff to a git workflow. And _that_ level is probably 
where you want to have special language-based coloring etc to further help 
things out.

So keep your eyes on the ball. And "automatic merge" isn't it.

		Linus
