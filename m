From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 22:02:40 +0100
Organization: At home
Message-ID: <epobn1$jv8$1@sea.gmane.org>
References: <87odognuhl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 22:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC06u-0006Ss-Qp
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 22:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXA3VBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXA3VBp
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 16:01:45 -0500
Received: from main.gmane.org ([80.91.229.2]:57494 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXA3VBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 16:01:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HC06h-0001Ik-Hy
	for git@vger.kernel.org; Tue, 30 Jan 2007 22:01:35 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 22:01:35 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 22:01:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38204>

Carl Worth wrote:

> The things I haven't liked in the above are:
> 
>       1. The doubled-up "branch:branch" thing in git-fetch, which
>            just plain looks awkward. Yes, it's common for "git pull"
>            to fetch something and not store it in any branch, but it
>            seems that it could ask for that behavior explicitly and we
>            could make "fetch URL branch" act as "fetch URL
>            branch:branch".

If youd don't mind fetching more, you can ask just to do "git fetch".
 
But, currently:

  * A parameter <ref> without a colon is equivalent to
    <ref>: when pulling/fetching, so it merges <ref> into the current
    branch without storing the remote branch anywhere locally

I don't think it would be bad if we changed <ref> to mean <ref>:<ref>
and require <ref>: to pull without storing remote branch anywhere locally;
the problem is that we probably want <ref>:<remote>/<ref>.

An alternative would be to tag a fix, and as to do the following

  $ git fetch origin tag proposed-fix

>       2. The "-b build" thing in git-checkout. Worse than just
>            looking awkward, this causes a real problem, since my
>            git-fetch instructions only work the first time, (if they
>            follow them later they're going to run into "branch build
>            already exists"). Detached head in 1.5 should help here,
>            but see below.

An alternative would be to have some branch used only to bring
working directory to given state, by using "git reset --hard <ref>"
while being on it.

E.g.

  $ git checkout build
  $ git reset --hard proposed-fix

(assuming that 'build' branch was created earlier).

>       3. The separation between how to clone and how to fetch into
>            an existing repository is annoying. What I'd really like to
>            do is just publish something like:
> 
>               git://git.project.org/~cworth/project proposed-fix
> 
>          and allow users to just cut-and-paste that to commands as
>          needed. That is, I think it would be nice if "git fetch" or
>          "git clone" could accept the "URL branch" string above and
>          just do the right thing with it.
> 
[...]
> Also, if I'm willing to assume (or insist) that users have git 1.5 or
> newer, it'd be nice to be able to drop the "-b build" thing thanks to
> the new detached HEAD support. But if I suggest doing just:
> 
>               git checkout origin/proposed-fix
> 
> the user is presented with the following message which is much more
> scary than useful in this situation:
> 
>       warning: you are not on ANY branch anymore.
>       If you meant to create a new branch from the commit, you need -b to
>       associate a new branch with the wanted checkout.  Example:
>         git checkout -b <new_branch_name> origin/proposed-fix
> 
> The user is getting warned, getting told they perhaps wanted to do
> something else, and getting told that if so they would need to use a
> different command. But the command I gave does exactly what they
> wanted, and following git's advice here would be a bad idea.
> 
> I propose this warning be removed here. Otherwise, I either add text
> to my instructions telling the user to ignore the warning message they
> get, or else I go back to "-b build" and back to all the old problems
> it causes.

I rather leave warning, but (perhaps around 1.5.1) remove the
instructions. RTFM (err... I'm not sure we have one about detached HEAD).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
