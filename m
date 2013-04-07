From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 19:21:12 +0100
Message-ID: <20130407182112.GJ2222@serenity.lan>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
 <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
 <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan>
 <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
 <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan>
 <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOuDX-0000Ex-Ic
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934226Ab3DGSVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:21:22 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48821 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934221Ab3DGSVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:21:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3D2CA6064AA;
	Sun,  7 Apr 2013 19:21:21 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swonaccqdfdE; Sun,  7 Apr 2013 19:21:20 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id BBDC76064EA;
	Sun,  7 Apr 2013 19:21:14 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220354>

On Sun, Apr 07, 2013 at 11:37:02PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > On Sun, Apr 07, 2013 at 10:52:50PM +0530, Ramkumar Ramachandra wrote:
> >> Sure, I'll write it out for you from an end-user perspective:
> >
> > To play Devil's Advocate for a bit...
> 
> Yes!
> 
> >> 0. Great UI/UX.  No more cd-to-toplevel, and a beautiful set of native
> >> commands that are consistent with the overall design of git-core.
> >> Which means: clone (to put something in an unstaged place), add (to
> >> stage), and commit (to commit the change).  There's now exactly one
> >> place in your worktree (which is represented as one file in git; think
> >> of it a sort of symlink)  to look in for all the information.  git
> >> cat-link <link> to figure out its parameters, git edit-link to edit
> >> its parameters: no more "find the matching pwd in .gitmodules in
> >> toplevel".  To remove a submodule, just git rm.  And git mv works!
> >
> > Presumably now without .git/config support, so I can't override the
> > checked-in settings without my own custom branch.  Even carrying a dirty
> > working tree seems problematic here since a checked-out link object is a
> > directory, which can't have information like the remote URL in it.
> 
> Sure you can have a dirty worktree.  It's just like .gitmodules:
> there's zero difference but for the fact that .gitmodules is
> accessible directly via your filesystem, while links are not.

I can't see how this gets me a dirty working tree.  Since the link needs
to be stored somewhere, I assume it's in the index; so I can have staged
changes, but not unstaged changes.

> >> 1. True floating submodules.  You can have a submodule checked out at
> >> `master` or `v3.1`: no more detached HEADs in submodules unless you
> >> want fixed submodules.  No additional cruft required to do the
> >> floating: the information is native, in a link object.
> >
> > Can't I do that now with "submodule.<name>.branch" and "git submodule
> > update --remote --rebase" and friends?
> 
> Yes, but that is not true floating: you shouldn't have to be sorry and
> rebase.  In new-style submodules, they're first class citizens (ie.
> true): you can just replace the SHA-1 with a ref in the link.

But what happens if I make any changes on top?  With --rebase and
--merge I can specify exactly what I want to happen (and obviously if I
don't have any changes then whichever I choose simply sets my branch to
the upstream ref).

> >> 2. Initializing a nested submodule without having to initialize the
> >> outer one: no more repo XML nonsense.  And it's composable: you don't
> >> need to put the information about all submodules in one central place.
> >
> > How does this interact when there is the following structure:
> >
> >     super
> >     `-- sub
> >         `-- subsub   (specified by sub)
> >
> > and subsub is specified as a submodule in *both* super and sub but with
> > different settings.  Do I get different behaviour depending on $PWD?
> 
> This is a very fringe case that I haven't thought about.  I don't know
> how it will behave: I haven't built it yet (and don't have the entire
> implementation in my head yet).
> 
> >> 3. Ability to have very many large submodule repositories without the
> >> performance hit.  It makes sense to block stat() from going through
> >> when you have floating submodules.  This means that many levels of
> >> nesting are very easily possible.
> >
> > Can't I already control this to some degree?  Certainly the following
> > commands take different amounts of time to run:
> >
> >     git status
> >     git -c status.submodulesummary=true status
> 
> You can't control the most fundamental thing, stat(): this is the
> primary killer of performance on a large worktree.  There is currently
> no way to block stat(): new-style submodules offers a way to configure
> which submodules to block the stat() on.

So it would be something like per-submodule --untracked-files and
--ignore-submodules settings?  I can see that being useful.
