From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Making git disappear when talking about my code (was: Re: GIT
 vs Other: Need argument)
Date: Wed, 25 Apr 2007 15:44:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704251345220.28708@iabervon.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgnPx-00085K-Bg
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992993AbXDYTo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993006AbXDYToZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:44:25 -0400
Received: from iabervon.org ([66.92.72.58]:3924 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992999AbXDYToM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:44:12 -0400
Received: (qmail 23214 invoked by uid 1000); 25 Apr 2007 19:44:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2007 19:44:11 -0000
In-Reply-To: <87mz0w7g3j.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45552>

On Wed, 25 Apr 2007, Carl Worth wrote:

> On Mon, 23 Apr 2007 22:15:04 -0700, Junio C Hamano wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > > I'd personally be ok with a
> > >
> > > 	git clone --default=<branch> <url>
> ...
> > If Carl is also happy with the syntax, we can conclude this
> > discussion and:
> >
> >  (1) have that as an enhancement to git-clone;
> 
> I think it's a useful enhancement. It would let me at least document
> something like "tracking this project's stable branch" with a single
> command, which I think is useful. But I don't know that I would be
> totally happy yet. :-)
> 
> So please allow me to comment on the syntax a bit. Linus, you claimed
> that <url>#<branch> isn't "unixy" enough for your taste. What does
> that mean exactly? Is it that two logically independent things are
> crammed into a single argument instead of being passed as second
> arguments? Or something else?

Linus has stated a preference on the lkml for being told about branches in 
the syntax used for anonymous pulls: URL branchname.

That is, you say:

  Please pull from:
    git://server/path branch

And he cuts and pastes into the command line:

  git pull git://server/path branch

Now, this syntax isn't available for git-clone, because git-clone puts the 
optional directory to create after the URL. But, in an ideal world, this 
is how it would work; you could see a pull request, and just type "git 
some-command <paste>".

> Here's the reason I want both the URL and the branch to appear as a
> single string, (but I don't really care about the precise syntax). I
> really want to be able to say "see my branch at <string>" and have
> that <string> be a complete and self-contained description of the
> branch that can be used in several different ways including:
> 
> * Cloning a new repository to track that branch as the default
> 
> * Begin tracking that branch as a new branch within an existing
>   repository

Here, you probably need to specify what you want the new branch to be, 
because it will often be the case that the remote branch will be "master" 
in a repository with a long unrecognizable URL, and you need to be able to 
switch to and away from the branch in some sane way. On the other hand, 
the user will presumably never care too deeply about the remote, aside 
from that git remembers stuff appropriately. I say, use the hash of the 
URL as the name of the remote, and provide some shorthand for the tracking 
branch that would be merged by default into the current head, and you're 
set. I.e.:

git track new-name URL [branch]

creates and checks out a new branch "new-name" with the config:

[remote "hash of URL"]
	url = URL
	fetch = +refs/heads/*:refs/remotes/hash of URL/*
[branch "new-name"]
	remote = "hash of URL"
	merge = refs/heads/[branch]

When on this branch, you update with "git pull" (which already works, 
given this configuration). And there would just need to be a better way of 
doing "git log remotes/hash of URL/branch..HEAD", which should probably be 
something like "git log MERGE..HEAD", with MERGE being magic for the thing 
that tracks the current branch's "merge" setting.

Incidentally, I'm not seeing the case of wanting to track multiple 
branches from the same repository as nearly as likely for a novice as 
wanting to track multiple branches from different repositories. I think 
the likely order of being interested in things is:

1. The project's maintainer's repository, exactly one of maint, master, or 
   next.
2. Somebody else's repository for some interesting feature, master
3. Somebody else's repository for all interesting features, some branch
4. Repository from 3, additional branches
5. Maintainer's repository, multiple branches.

With the most common case for two tracking branches being master from two 
repositories, such that upstream branch names are most often useless for 
distinguishing anything.

	-Daniel
*This .sig left intentionally blank*
