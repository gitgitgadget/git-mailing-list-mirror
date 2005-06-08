From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Upstream merging and conflicts (was Re: Using cvs2git to track an external CVS project)
Date: Thu, 9 Jun 2005 10:09:07 +1200
Message-ID: <46a038f905060815096382636a@mail.gmail.com>
References: <46a038f905060105358e24723@mail.gmail.com>
	 <1117631266.26067.40.camel@imp.csi.cam.ac.uk>
	 <46a038f905060213104d9ad96f@mail.gmail.com>
	 <46a038f9050602135971ece082@mail.gmail.com>
	 <Pine.LNX.4.58.0506080828240.2286@ppc970.osdl.org>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 09 00:06:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg8gG-0001Ej-Mi
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 00:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVFHWJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 18:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVFHWJg
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 18:09:36 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:10605 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262121AbVFHWJM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 18:09:12 -0400
Received: by rproxy.gmail.com with SMTP id i8so416805rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 15:09:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dt7DwRTqrT06Xh06TmtCYYlW/GdxkMtssqVfvUQJGaIeRdFjv+9a9iLQUcOBRGFivGfJ/mX5gyU4KKUWxd3OP6OuaGrTbErik4pvUG18Fw9FwHXda5eSoF9uVyhfspQn5NJjhl3ZE7YBwm1mlncb2i9OJ8Iv5cZaTNBsummf1Dk=
Received: by 10.38.97.66 with SMTP id u66mr3912057rnb;
        Wed, 08 Jun 2005 15:09:07 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Wed, 8 Jun 2005 15:09:07 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506080828240.2286@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/9/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Yes, and right now that "manual" part is actualyl fairly high. I'll fix
> that thing up (today, I hope), making nontrivial merges much easier.

Wow -- I'll be tracking your tree closely then ;-)

> It's true that you can't skip patches, since a merge is always
> all-or-nothing, and the global history really requires that (in a very
> fundamental way). However, you _can_ merge from the HEAD, and then say
> "that patch is no longer relevant in this tree", and remove it. Then
> you'll never need to worry about that patch any more, because you've
> merged it and in your merged result, it no longer exists).

I had that strategy in my back-pocket already, but it doesn't sound right. 

> That said, I don't claim that this is what you always want to do. In fact,
> we have this exact issue in the kernel, and I think it's a great thing to
> use a combination of a patch-based system _and_ git. You use git for the
> "core", you use the patch-based system for the more fluid stuff. In the
> case of the kernel, the patch-based system that seems to be used the most
> is "quilt", but that's a detail. The big issue is that git is simply part
> of a bigger process:

Sounds like I'll be reading up on quilt then. I guess that's what I
was looking for...

> Yes. I think this is fundamental. "git" needs to converge. It's how git
> works. git also "crystallizes" the history and makes it unbreakable.
> Both of these things are _wonderful_ for what they mean, but both of these
> fundamental issues are _horrible_ for other reasons.

Fair enough -- and actually I'm not convinced it's a horrible thing.
Having worked with forever-diverging tools like Arch, I can appreciate
the value of crystallizing and identifying when you've converged --
and rebasing all steps forward on the fact that you've converged. This
is huge.

A patch-based workflow is needed in the periphery of HEAD -- but
patch-based tools fail to see when they've converged. What I am
salivating about is the idea of some basic patch smarts based on
git/cogito that I can use to track things in simplistic scenarios.
Right now as soon as I'm one patch "off" all of git support breaks
down and it's really hard to keep merging forward. Unless I merge &
reverse as discussed.

> So I don't think that you should necessarily think of git as "the" souce
> control management in the big picture. 

Yup. And quilt or other tools in the periphery. Something like the
git-aware darcs (which I haven't looked at yet).

> So I don't think any development effort that is big enough necessarily
> wants to use git as the _only_ way of doing development and merging stuff.
> The kernel certainly does not. Not now, and not in the long run.

Agreed. I'm happy to roll out some custom perl scripts around git (or
extend cogito a bit) if git can expose some stable holding points for
external tools to try and do some lightweight patch tracking.

> Whether the kernel model is applicable to anything else, I dunno.

I don't know either -- but I'm sure the toolset around git can support
a range of dev models. I don't think any other project has such a
large pool and strong convergence dynamics as the kernel. But git and
its tools and practices can be (I'm hoping) quite flexible to support
a range of dev models.

cheers,


martin
