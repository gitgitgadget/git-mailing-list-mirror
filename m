From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 15:38:38 +0200
Message-ID: <85k5sbh129.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804120243.GB9716@coredump.intra.peff.net>
	<85tzrfh3yg.fsf@lola.goethe.zz>
	<8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Lars Hjemli" <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHJq9-0007KM-LW
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 15:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761612AbXHDNim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 09:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758956AbXHDNim
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 09:38:42 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:58871 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757956AbXHDNil (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 09:38:41 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 53AB21F5228;
	Sat,  4 Aug 2007 15:38:40 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 32E4223D2E4;
	Sat,  4 Aug 2007 15:38:40 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id F3D6430ABD9;
	Sat,  4 Aug 2007 15:38:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 184C31C4F932; Sat,  4 Aug 2007 15:38:38 +0200 (CEST)
In-Reply-To: <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com> (Lars Hjemli's message of "Sat\, 4 Aug 2007 15\:07\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54846>

"Lars Hjemli" <lh@elementstorage.no> writes:

> On 8/4/07, David Kastrup <dak@gnu.org> wrote:
>> Now I think that I basically have no chance figuring this out on my
>> own sufficiently well to be able to improve the documentation.
>
> Remote-tracking branch:
>   A local copy of a branch in another repository. This kind of branch
>   cannot be updated by 'git-commit' but only by 'git-fetch' (hence
>   indirectly by 'git-pull' and 'git-remote update'). If you try to
>   'git-checkout' a remote-tracking branch, you will get a detached HEAD.
>
> Local branch:
>   A branch to which you may commit changes. Optionally, the branch can be
>   configured to "follow" one of your remote-tracking branches. This means
>   that a 'git-pull' without arguments (when your local branch is checked
>   out), will automatically 'git-fetch' and then 'git-merge' the remote-
>   tracking branch.

Does that mean that specifying "--track" to git-checkout or git-branch
never creates a remote-tracking branch?

> Example:
>
> Your local branch 'master' is setup to "follow"
> 'refs/remotes/origin/master'.

So --track/--no-track are actually supposed to be --follow and
--no-follow?

> So if you do this:
>
> $ git checkout master
> $ git pull
>
> Then the 'git pull'-command will do this:
>
> $ git fetch -f origin master:remotes/origin/master

This is then tracking?

> $ git merge remotes/origin/master

And this is then following?

> The magic setup that makes this happen is the following lines in .git/config:
>
> [remote "origin"]
Namely: a remote-tracking branch "origin"

>         url = git://git.kernel.org/pub/scm/git/git.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>
> [branch "master"]
>         remote = origin

Namely: follow the remote tracking branch origin?

>         merge = refs/heads/master
>
>
> Was this helpful?

So we have remote tracking branches, and we have local branches
following remote tracking branches, and "--track" and "--no-track"
create local branches following or not following a remote tracking
branch?  And have nothing whatsoever to do with tracking or not
tracking a remove branch?

Talk about misleading option names here.

Then in man git-branch we have:

	In its second form, a new branch named <branchname> will be
	created. It will start out with a head equal to the one
	given as <start-point>. If no <start-point> is given, the
	branch will be created with a head equal to that of the
	currently checked out branch.

	When a local branch is started off a remote branch, git can
	setup the branch so that git-pull(1) will appropriately
	merge from that remote branch. If this behavior is desired,
	it is possible to make it the default using the global
	branch.autosetupmerge configuration flag. Otherwise, it can
	be chosen per-branch using the --track and --no-track
	options.

What does "remote branch" in this context mean?  A local branch
following a remote tracked branch?  A remote tracked branch (which by
definition can't be checked out as a branch, since that leads to a
detached head)?  What does "start off" mean in this context?  If I
can't check out a remote branch, I can't start off on it, can I?

Does "--track" mean that the new branch will copy any "remote" lines
which incidentally don't point to remote branches as their name would
suggest, but rather to remote tracking branches?  And we want to have
the relation to the remote tracking branch preserved, not to the
actual remote branch?

I don't get it.  Really.  No chance.  There are fine distinction lines
in the git terminology, it would appear, and those lines are freely
ignored in naming options and configuration parameters.  And the
manual pages themselves are not overly concerned about explaining
those distinctions either.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
