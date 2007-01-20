From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Sat, 20 Jan 2007 21:07:06 +0100
Message-ID: <20070120200706.GC4684@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <200701191040.17476.jnareb@gmail.com> <20070120131716.GA4684@nan92-1-81-57-214-146.fbx.proxad.net> <200701202016.16333.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 21:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8MUu-0001zs-NN
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 21:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbXATUH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 15:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbXATUH3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 15:07:29 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:54225 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965366AbXATUH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 15:07:28 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 84CE9558E;
	Sat, 20 Jan 2007 21:07:26 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 507632013; Sat, 20 Jan 2007 21:07:06 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701202016.16333.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37287>

On Sat, Jan 20, 2007 at 08:16:15PM +0100, Jakub Narebski wrote:
> Yann Dirson wrote:
> > On Fri, Jan 19, 2007 at 10:40:16AM +0100, Jakub Narebski wrote:
> 
> >> First, "stg rebase" when on some git branch might mean rebase StGIT
> >> stack to head of current branch (because there were some git commits
> >> on top of this branch). So it would be "stg rebase [--onto <target>]";
> >> it would be command without non-option arg, but this arg would be
> >> optional.
> > 
> > I'm not sure I understand.  Since the "current StGIT stack" is the one
> > pointed to by HEAD, how do you specify, when HEAD points to the target
> > branch, which stack to rebase ?
> 
> Well, I haven't thought this through. I was thinking about situation
> where there are no applied patches, and some commits were done without
> StGIT (pure git), i.e. we had
> 
>                   ..1...2...3  <-- unapplied (deck) [ branch ]
>                  /
>     a---b---c---d   <-- HEAD [ branch ]
> 
> There were some git commits (for example fetch, or cherry-pick, or ...)
> 
> 
>                   ..1...2...3  <-- unapplied (deck) [ branch ]
>                  /
>     a---b---c---d---e---f   <-- HEAD [ branch ]
> 
> And after "stg rebase" I want to have:
> 
> 
>                           ..1...2...3  <-- unapplied (deck) [ branch ]
>                          /
>     a---b---c---d---e---f   <-- HEAD [ branch ]

So this what we typically currently get by using "stg pull
. branchname", when HEAD is the stack branch.

I can easily see that called as "stg rebase", with --to argument
defaulting to parent branch (as given by branch.<name>.merge) when the
HEAD is the stack branch.  That would be a neat replacement for "stg
pull . <name>".

Calling 'stg rebase' from the branch to rebase onto, however, can't
guess which stack to rebase - there are possibly many stacks forked
off your branch.  In that case, you will need to ask "stg rebase
<mystack>".

But this will mean that "stg rebase <mystack>" will have --to default
to HEAD, whereas "stg rebase" will have --to default to the stack's
parent branch.  Not sure, but that looks a bit inconsistent, and may
be confusing.  But probably we can implement things this way, and wait
for the user feedback to see if some restructuration is called,
post-1.0, when we move to subcommands.


> I'm not sure how should the above work with applied patches
> (non-empty stack), i.e. with the following:
> 
>                           ..3...4...5  <-- unapplied (deck) [ branch ]
>                          /
>     a---b---c---d-.-1-.-2   <-- HEAD [ branch ]
>                   \--v--/
> 
>                   (stack)  

As long as commits occured as children of 'd', 'rebase' will take care
of applied patches (it pops all patches first).

> Or for example git branch got rebased, and I want to move also deck
> (unapplied patches), because "git rebase" don't move them... unless
> this is not needed. Probably it is not needed.

This is a typical ouse for "stg rebase", it should just work.

Best regards,
-- 
Yann.
