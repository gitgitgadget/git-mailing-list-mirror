From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Tue, 23 Jan 2007 08:49:45 +0100
Message-ID: <20070123074945.GB4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net> <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com> <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 08:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9GQK-0006xz-Af
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 08:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbXAWHu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 02:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXAWHu2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 02:50:28 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:35443 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932867AbXAWHu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 02:50:27 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7D071436CF;
	Tue, 23 Jan 2007 08:50:23 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A5B851F07B; Tue, 23 Jan 2007 08:49:45 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37487>

On Mon, Jan 22, 2007 at 10:58:41PM +0000, Catalin Marinas wrote:
> On 22/01/07, Yann Dirson <ydirson@altern.org> wrote:
> >On Mon, Jan 22, 2007 at 05:54:29PM +0000, Catalin Marinas wrote:
> >> Currently, in the StGIT terminology stack and branch are about the
> >> same. If you want to move to a different stack, just use the "stg
> >> branch" command.
> >
> >I think you missed the point.  StGIT stacks are usually forked off
> >another branch.  As I understand it, Jakub talks about standard
> >rebasing, ie. moving the stack base from its current parent branch to
> >a new one.
> 
> StGIT stacks are a series of volatile commits (commits) at the top of
> a branch. The idea when I started writing this tool was that a series
> of applied patches would lead to the head of the current branch. The
> branch and stack are tightly coupled and you cannot simply change the
> parent branch the stack is based on (not from a technical point but
> rather from conception one).

Well, that's now allowed by "rebase".

> >> A stack is just a branch with stgit-specific metadata.
> >
> >I would rather say that an StGIT stacks uses a branch, but the stack
> >is not the branch - eg, unapplied patches do not belong to the branch.
> 
> The unapplied patches can have any commit as a parent, either in the
> direct history of the current branch or in any other branch, there is
> no restriction here. They get in line with the current branch's head
> during the push operation.

Right.  I'm just emphasizing that, since they are (even temporarily)
not part of the GIT branch from a GIT point of view, but part of the
stack, the 2 concepts, while closely linked, are not strict subsets of
each other.  Rather, they share some common points, but neither would
be parent of the other in a class hierarchy.

> >Indeed I was thinking about that today, and thought that maybe it
> >would make sense not to use a head ref (and thus not using a real
> >branch), which would minimize the risk of someone committing by error
> >(and thus minimize the need to use "assimilate"), since porcelainish
> >commit tools would then refuse to commit there.
> 
> But isn't this what Quilt already does (i.e. a different mechanism for
> patches, on top of any SCM)?

I'm not sure wat you mean here.  I'm only talking of StGIT and the GIT
world here.

> One of the base ideas of StGIT is that the top patch represents the
> head of the current branch and that the patches applied on the stack
> always form the recent history of the current branch.

I'm not willing to change the concept.  I'm just wondering whether
using a non-head reference (eg. stacks/<name> or stacks/<name>/top)
would not be better.  For this we may need to consider using detached
HEAD support from 1.5.0, but I'm just thinking loudly, I have not
looked at what that thing provides exactly yet.

> I added the commit command to have a way to freeze this state into
> the current branch and no longer manage them with StGIT.


> >> What you'd probably want is a way to import patches from a different
> >> branch/stack onto the newly checked out branch.
> >
> >Sometimes you just want to throw out an obsolete branch and move your
> >stack to a new baseline.  That said, being able to duplicate a stack
> >(and possibly rebasing it afterwards) would be useful as well.
> 
> You have 'branch --clone' (or --rename if you just want a different
> name) and now 'rebase'.

D'oh.  I was probably expecting "stack --clone" or something :)

> As I said, the idea of moving the stack (patches) on top of a
> different branch should be done as an import (or multiple
> cherry-pick or clone), otherwise we loose the coupling between
> branches and stacks.

I'll have to think more about that - I'm not sure I get you point.  By
moving/cloning we keep (or could keep) the patches' history.  By
importing we cannot do that.

Best regards,
-- 
Yann.
