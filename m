From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Mon, 22 Jan 2007 22:58:41 +0000
Message-ID: <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
References: <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
	 <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	 <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	 <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
	 <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com>
	 <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 23:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H987j-00058D-0Z
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 23:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbXAVW6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 17:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXAVW6o
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 17:58:44 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:60660 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbXAVW6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 17:58:43 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1048234nze
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 14:58:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RID+qxnbU4B/AIBkJhU8ZkSGL2O64WQIX3uZmmYX1uK39xIZQE/MV82wX8GG5gr4rL8g9fxlrUpAngM6DSmqzLTjO58C/0mdu8V4LjcPf9VJibWMSygYd92JPuizAOFOY0O6fWvcYqViMeErZG1W4+m8XcZJ1poAHF0AiAV4ssg=
Received: by 10.65.103.17 with SMTP id f17mr8516151qbm.1169506721627;
        Mon, 22 Jan 2007 14:58:41 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Mon, 22 Jan 2007 14:58:41 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37466>

On 22/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Mon, Jan 22, 2007 at 05:54:29PM +0000, Catalin Marinas wrote:
> > Currently, in the StGIT terminology stack and branch are about the
> > same. If you want to move to a different stack, just use the "stg
> > branch" command.
>
> I think you missed the point.  StGIT stacks are usually forked off
> another branch.  As I understand it, Jakub talks about standard
> rebasing, ie. moving the stack base from its current parent branch to
> a new one.

StGIT stacks are a series of volatile commits (commits) at the top of
a branch. The idea when I started writing this tool was that a series
of applied patches would lead to the head of the current branch. The
branch and stack are tightly coupled and you cannot simply change the
parent branch the stack is based on (not from a technical point but
rather from conception one).

> > A stack is just a branch with stgit-specific metadata.
>
> I would rather say that an StGIT stacks uses a branch, but the stack
> is not the branch - eg, unapplied patches do not belong to the branch.

The unapplied patches can have any commit as a parent, either in the
direct history of the current branch or in any other branch, there is
no restriction here. They get in line with the current branch's head
during the push operation.

> Indeed I was thinking about that today, and thought that maybe it
> would make sense not to use a head ref (and thus not using a real
> branch), which would minimize the risk of someone committing by error
> (and thus minimize the need to use "assimilate"), since porcelainish
> commit tools would then refuse to commit there.

But isn't this what Quilt already does (i.e. a different mechanism for
patches, on top of any SCM)?

One of the base ideas of StGIT is that the top patch represents the
head of the current branch and that the patches applied on the stack
always form the recent history of the current branch. I added the
commit command to have a way to freeze this state into the current
branch and no longer manage them with StGIT.

> > What you'd probably want is a way to import patches from a different
> > branch/stack onto the newly checked out branch.
>
> Sometimes you just want to throw out an obsolete branch and move your
> stack to a new baseline.  That said, being able to duplicate a stack
> (and possibly rebasing it afterwards) would be useful as well.

You have 'branch --clone' (or --rename if you just want a different
name) and now 'rebase'. As I said, the idea of moving the stack
(patches) on top of a different branch should be done as an import (or
multiple cherry-pick or clone), otherwise we loose the coupling
between branches and stacks.

> > > Although usually you have separate branch as StGIT stack "base", and
> > > you can simply rebase git branch, then do
> > >
> > >   $ stg rebase
>
> Oh, I think I understand - he probably uses "base" to refer to what I
> call "parent branch", and not to the refs/bases/<branch> reference...

The ref/bases/<branch> is not used much in StGIT. I initially added it
as a way to see the base of a stack in gitk but that's probably the
only usecase.

-- 
Catalin
