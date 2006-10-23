From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 15:44:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca>
 <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com>
 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 00:44:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8Ws-0004Fu-Mi
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWJWWoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWJWWoU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:44:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750968AbWJWWoT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 18:44:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NMiEaX012046
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 15:44:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NMiDx1009480;
	Mon, 23 Oct 2006 15:44:14 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061023222131.GB17019@over-yonder.net>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29895>



On Mon, 23 Oct 2006, Matthew D. Fuller wrote:

> On Mon, Oct 23, 2006 at 10:29:53AM -0700 I heard the voice of
> Linus Torvalds, and lo! it spake thus:
> > 
> > I already briought this up once, and I suspect that the bzr people
> > simply DID NOT UNDERSTAND the question:
> > 
> >  - how do you do the git equivalent of "gitk --all"
> 
> I for one simply DO NOT UNDERSTAND the question, because I don't know
> what that is or what I'd be trying to accomplish by doing it.  The
> documentation helpfully tells me that it's something undocumented.

gitk (and all other logging functions) can take as its argument a set of 
arbitrary revision expressions.

That means, for example, that you can give it a list of branches and tags, 
and it will generate the combined log for all of them. "--all" is just 
shorthand for that, but it's really just a special case of the generic 
facility.

This is _invaluable_ when you want to actually look at how the branches 
are related. The whole _point_ of having branches is that they tend to 
have common state.

For example, let's say that you have a branch called "development", and a 
branch called "experimental", and a branch called "mainline". Now, 
_obviously_ all of these are related, but if you want to see how, what 
would you do?

In git, one natural thing would be, for example, to do

	gitk development experimental ^mainline

(where instead of "gitk" you can use any of the history listing 
things - gitk is just the visually more clear one) which will show you 
what exists in the branches "development" and "experimental", but it will 
_subtract_ out anything in "mainline" (which is sensible - you may want to 
see _just_ the stuff that is getting worked on - and the stuff in mainline 
is thus uninteresting).

See? When you visualize multiple branches together, HAVING PER-BRANCH 
REVISION NUMBERS IS INSANE! Yet, clearly, it's a valid and interesting 
operation to do.

An equally interesting thing to ask is: I've got two branches, show me the 
differences between them, but not the stuff in common. Again, very simple. 
In git, you'd literally just write

	gitk a...b

(where "..." is "symmetric difference"). Or, if you want to see what is in 
"a" but _not_ in "b", you'd do

	gitk b..a

(now ".." is regular set difference, and the above is really identical to 
the "a ^b" syntax).

And trust me, these are all very valid things to do, even though you're 
talking about different branches.

Try it out. 

> > For example, how long does it take to do an arbitrary "undo" (ie
> > forcing a branch to an earlier state) [...]
> 
> I don't understand the thrust of this, either.  As I understand the
> operation you're talking about, it doesn't have anything to do with a
> branch; you'd just be whipping the working tree around to different
> versions.  That should be O(diff) on any modern VCS.

No. If you "undo", you'd undo the whole history too. And if you undo to a 
point that was on a branch, you'd have to re-write _all_ the revision 
ID's.

> I consider it a _technical_ sign of a way of thinking about branches I
> prefer   8-}

Quite frankly, I just don't think you understand what it means.

			Linus
