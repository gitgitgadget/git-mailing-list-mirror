From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Upstream merging and conflicts (was Re: Using cvs2git to track an external CVS project)
Date: Thu, 9 Jun 2005 23:03:21 +1200
Message-ID: <46a038f9050609040333f808d6@mail.gmail.com>
References: <46a038f905060105358e24723@mail.gmail.com>
	 <1117631266.26067.40.camel@imp.csi.cam.ac.uk>
	 <46a038f905060213104d9ad96f@mail.gmail.com>
	 <46a038f9050602135971ece082@mail.gmail.com>
	 <Pine.LNX.4.58.0506080828240.2286@ppc970.osdl.org>
	 <46a038f905060815096382636a@mail.gmail.com>
	 <Pine.LNX.4.58.0506081918050.2286@ppc970.osdl.org>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 09 13:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgKl3-0003br-M3
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 12:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVFILDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 07:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVFILDc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 07:03:32 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:9259 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262345AbVFILDV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 07:03:21 -0400
Received: by rproxy.gmail.com with SMTP id i8so94855rne
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 04:03:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bh0VDWShx93XSHwWU3m8snpKTy5VsMWNY/ZK3hiPmTsNfNU6EKMwz0I9RMsSzBPqaROs8q6jc7YoUcIjAH2/4HkvQsAN8j4SC2wZpHVprg1a3KXyaDHHY3vKyfVq5ZHi2w6GneMO56U6gGTC6AX6CnRlftYkvqwiurh3snaKFQs=
Received: by 10.38.14.54 with SMTP id 54mr249153rnn;
        Thu, 09 Jun 2005 04:03:21 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Thu, 9 Jun 2005 04:03:21 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506081918050.2286@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/9/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Well, it's done, and it's now "much easier" in the sense that anything
> that doesn't have metadata changes should be picked up pretty trivially by
> the three-way merge thing.
> 
> But if you move things around, then you'd need to have a merge that is
> aware of movement, ie something much more sophisticated than just 3way
> merge.

I've followed the discussion and it's really good. I'll be playing
with the code on a cvs2git import I'm doing.

Two questions:
 - Is there a way to ask "what is the patchlog that you'll merge if I
ask you to merge from X"?
 - When an "automatic" merge happens, is there anything that
identifies commit with the commit that is being merged if the trees
are not identical? Is there a way to do that

What I am thinking of doing is having a perl (or bash?) script that
looks  at the changelog of two branches since they last converged,
looks at each commit and makes an educated guess of what patches are
in both and /facilitates/ extracting a patch the remote branch and
applying it locally with the same commit msg.

There are no promises on the guess -- it has to be reviewed & checked
-- but I find that is always true when trading patches across
branches. A lightweight, best-effort script to help someone who is
going to backport some patches from HEAD to the stable branch.

> > > It's true that you can't skip patches, since a merge is always
> > > all-or-nothing, and the global history really requires that (in a very
> > > fundamental way). However, you _can_ merge from the HEAD, and then say
> > > "that patch is no longer relevant in this tree", and remove it. Then
> > > you'll never need to worry about that patch any more, because you've
> > > merged it and in your merged result, it no longer exists).
> >
> > I had that strategy in my back-pocket already, but it doesn't sound right.
> 
> With global history, you really don't end up having much choice.
> 
> The alternative is to have per-file history, which sucks pretty bad

I don't quite follow you on why the per-file or per-tree worldview
affects this. Not very important though ;)

> My gut feel is that it should be possible to have a hybrid system that
> handles both the solid "crystalline" phase (aka git) and the "gas" phase
> (aka free-lowing patches) and have them integrate with each other well.
> That's kind of the way the kernel works, with people using quilt as a way
> to capture the patches in between.

Absolutement. For most projects I suspect that the gas (fluid?) phase
can be quite simple. In fact, simple is better.

> My read is that this analogy arch and darcs try to avoid the really solid
> crystalline phase entirely and end up being amorphous. You can probably
> have that too, but on the other hand it's fairly easy to merge between two
> "crystallized" repositories and be totally unambigious about what the
> result is, but if there's a lot of the amorpous stuff going on, it's not
> clear any more.

After a while, and a few thousand patches since you "branched",
patch-based SCMs don't help converge. At no point can they recognized
that 2 trees have converged and that the patch track becomes
irrelevant.

> > > Whether the kernel model is applicable to anything else, I dunno.
> >
> > I don't know either -- but I'm sure the toolset around git can support
> > a range of dev models. I don't think any other project has such a
> > large pool and strong convergence dynamics as the kernel. But git and
> > its tools and practices can be (I'm hoping) quite flexible to support
> > a range of dev models.
> 
> Hey, I obviously think you're right. Using git gives good ways of
> communicating the core infrastructure between two (or more) groups, while
> then internally within the group they may use loser patch-tracking systems
> that don't have the same kind of convergence requirements (but which you
> don't need for a "small" set of patches anyway, where "small" can
> obviously be hundreds of internal patches).

Interesting concept -- git as the head branch where everyone converges
while perhaps using other tools. Still... looser patch tracking
strategies can be based on git primitives, like some kind of commit
identity that travels with the merges, perhaps not to be used by git
but as a hooking point for naive patch tracking. But I suspect it may
be anathema to the git philosophy ;-)

cheers,


martin
