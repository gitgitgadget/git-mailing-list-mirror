From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 23 Aug 2005 18:23:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508231731370.23242@iabervon.org>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
 <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain>
 <20050821094059.GA5453@fanta> <Pine.LNX.4.63.0508221707520.23242@iabervon.org>
 <tnxvf1wd24m.fsf@arm.com> <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
 <20050823212305.GA5936@fanta>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 00:22:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7h89-0001WK-8S
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVHWWU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVHWWU0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:20:26 -0400
Received: from iabervon.org ([66.92.72.58]:37903 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932470AbVHWWUZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 18:20:25 -0400
Received: (qmail 15926 invoked by uid 1000); 23 Aug 2005 18:23:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 18:23:57 -0400
To: Jan Veldeman <jan.veldeman@gmail.com>
In-Reply-To: <20050823212305.GA5936@fanta>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7680>

On Tue, 23 Aug 2005, Jan Veldeman wrote:

> Daniel Barkalow wrote:
>
> > On Tue, 23 Aug 2005, Catalin Marinas wrote:
> >
> > Something is legitimate as a parent if someone took that commit and did
> > something to it to get the new commit. The operation which caused the
> > change is not specified. But you only want to include it if anyone cares
> > about the parent.
>
> This is indeed what I thought a parent should be used for. As an adition,
> I'll try to explain why I would sometimes want to care about some parents:
>
> I want to track a mailine tree, but have quite a few changes, which shoudn't
> be commited to the mainline immediately (let's call it my development tree).
> This is why I would use stgit. But I would also want to colaborate with
> other developers on this development tree, so I sometimes want to make
> updates available of this development tree to the others. This is where
> current stgit falls short. To easily share this development tree, I want
> some history (not all, only the ones I choose) of this development tree
> included, so that the other developers can easily follow my development.
>
> The parents which should be visible to the outside, will always be versions
> of my development tree, which I have previously pushed out. My way of
> working would become:
> * make changes, all over the place, using stgit
> * still make changes (none of these gets tracked, intermittent versions are
>   lost)
> * having a good day: changes looks good, I want to push this out:
>   * push my tree out
>   * stgit-free (which makes the pushed out commits, the new parents of my
>     stgit patches)
> * restart from top

I'm not sure how applicable to this situation stgit really is; I see stgit
as optimized for the case of a patch set which is basically done, where
you want to keep it applicable to the mainline as the mainline advances.

For your application, I'd just have a git branch full of various stuff,
and then generate clean commits by branching mainline, diffing development
against it, cutting the diff down to just what I want to push, and
applying that. Then the clean patch goes into stgit.

> [...]
> > This also depends on how exactly freeze is used; if you use it before
> > commiting a modification to the patch without rebasing, you get:
> >
> > old-top -> new-top
> >       ^    ^
> >        \  /
> >       bottom
> >
> > bottom to old-top is the old patch
> > bottom to new-top is the new patch
> > old-top to new-top is the change to the patch
> >
> > Then you want to keep new-top as a parent for rebasings until one of these
> > is frozen. These links are not interesting to look at, but preserve the
> > path to the old-top:new-top change, which is interesting.
>
> my proposal does something like this, but a little more: not only does it
> keep track of the link between old-top and new-top, it also keeps track of
> the links between old-patch-in-between and new-patch-in-between.
> (This makes sense when the top is being removed or reordered)

I was thinking of this as being the top and bottom commits for a single
tracked patch, not as a whole series. I think patches lower wouldn't be
affected, and patches higher would see this as a rebase.

	-Daniel
*This .sig left intentionally blank*
