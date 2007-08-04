From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 16:01:55 +0200
Message-ID: <85ejijgzzg.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:02:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKCt-0004mN-VD
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759156AbXHDOB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758353AbXHDOB7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:01:59 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:59454 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757432AbXHDOB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 10:01:58 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 032F032F2AF;
	Sat,  4 Aug 2007 16:01:57 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id E017628EE1C;
	Sat,  4 Aug 2007 16:01:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A2ED13027E5;
	Sat,  4 Aug 2007 16:01:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0551E1C4F932; Sat,  4 Aug 2007 16:01:56 +0200 (CEST)
In-Reply-To: <20070804092933.aaec6d52.seanlkml@sympatico.ca> (Sean's message of "Sat\, 4 Aug 2007 09\:29\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54849>

Sean <seanlkml@sympatico.ca> writes:

> David Kastrup <dak@gnu.org> wrote:
>
>> A local branch is one with a local branch head.  In contrast,
>> checking out a remote branch, while possible, leaves one with a
>> detached head.
>
> Yes.
>
>> "remote-tracking" basically means that git-pull will update the
>> branch according to changes in the remote repository.
>
> To be clear, it's the job of git-fetch to update remote-tracking
> branches with any changes found in the remote repository.  Git-pull
> runs git-fetch and then runs a git-merge to update the
> currently-checked-out branch.
>
> When this happens, git-merge must decide which
> remote-tracking-branch to merge into the currently checked out local
> branch.  You can set which remote-tracking-branch will be selected
> in this situation with the --track option.
>
> So assuming a remote-repo has two branches "master" and "branchX":
>
>    git clone remote-repo
>
> will give us two remote-branch (AKA remote-tracking-branches) of
> "origin/master" and "origin/branchX".  So:
>
>    git branch --track mylocalbranch origin/branchX
>    git checkout mylocalbranch

So --track does not set up a tracking branch, but makes a local
_following_ branch _refer_ to a tracking branch.

What happens with

    git checkout origin/branchX
    git branch --track mylocalbranch
    git checkout mylocalbranch

?  What if after the checkout (which leads to a detached head) I check
in a few things, and then decide to name the branch and set it up as
following a remote tracking branch?  Instead of using git-branch for
setting up the following, do I have to explicitly add the respective
"remote" line (which does not specify a remote, but a remote tracking
branch) into, uh, where?

> No, a local branch is never a remote-tracking branch; even when
> created with a --track option.  The --track option has muddied the
> terminology waters a bit and you're not the first to be confused by
> it.  The --track selects a branch from the repo to merge by default.

Well, GOOD.  I have already come to the conclusion that the "--track"
option, like the "remote" configuration recorded by it have the main
purpose of confusing people and should not be confused with setting up
a remote tracking branch, or referring to a remote branch.

> A remote branch and a remote-tracking branch are the same thing.
> Strictly speaking a local branch is never a remote-tracking-branch
> although the "--track" option makes that harder to explain.

You bet.

>> So the terminology seems fuzzy at the moment, and my attempt to
>> clear it up might not be the preferred way of doing it.
>
> Yeah, the documentation could use some fine tuning.

It is much too fine-tuned already.  I think that first option names
and config file options need to get some coarse-tuning where one does
not have to split hairs and ignore the meaning of terms in order to
understand them.

I have now "following" or "automerge" local branches which are set up
to follow a "remote tracking" branch.  Presumably, if I do

git-branch -b new-branch --track remote-branch

then I get a following branch set up which follows/automerges a remote
tracking branch.  So far so good.  What do I get with

git-branch -b another-new-branch --track new-branch

Does this follow/automerges with new-branch?  Does this
follow/automerge with remote-branch?

What if I do

git-checkout remote-branch
git-branch -b new-branch --track

Does this follow anything?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
