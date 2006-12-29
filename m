From: Pavel Roskin <proski@gnu.org>
Subject: Re: branch.pu.forcefetch
Date: Thu, 28 Dec 2006 20:22:06 -0500
Message-ID: <1167355326.15189.34.camel@dv>
References: <1167251519.2247.10.camel@dv>
	 <7vfyb159dn.fsf@assigned-by-dhcp.cox.net> <1167341346.12660.17.camel@dv>
	 <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 29 02:22:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H06Rs-00025g-Qv
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 02:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbWL2BWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbWL2BWM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 20:22:12 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:53695 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbWL2BWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 20:22:10 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1H06RY-00040e-HD
	for git@vger.kernel.org; Thu, 28 Dec 2006 20:21:56 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1H06Ri-0004Ae-Fw; Thu, 28 Dec 2006 20:22:06 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35571>

On Thu, 2006-12-28 at 14:44 -0800, Junio C Hamano wrote: 
> [jc: some people CC'ed because I'll talk about logallrefupdates
>  at the end]

OK.

> Pavel Roskin <proski@gnu.org> writes:
> 
> > Actually, it's strange that I don't actually have refs/heads/pu
> > under .git, and it doesn't get created even if I run "git-pull" or
> > "git-pull origin pu".
> 
> "git-pull" without argument (and "git-pull origin") are affected
> by the config (and .git/remotes/origin), so we will look at your
> config later.
> 
> With "git-pull origin pu", you are saying "use URL for origin
> but this time I am not interested in the set of branches to
> fetch by default specified in my config".  And single token "pu"
> means you do not want to store the fetch result in any tracking
> branch (otherwise you would explicitly say "pu:refs/heads/pu" or
> "pu:/refs/remotes/origin/pu").

OK, I'm going to take a "bird's view" of it.  If you happen to think I'm
saying stupid things, it's just because I'm playing an even less
experienced user than I am.

I don't think it's a good idea to expose the layout under .git to the
end user.  I do realize that git is just "plumbing", but things like
"refs/heads/" should probably be hidden from the user in any case.
Using path as an indicator that something should be saved looks like a
kludge.

Maybe we could have a notation for branches on remotes (e.g. pu@origin
or origin#pu), tracking branches and non-tracking branches?  I would be
happy if the same name could be used for all of them.  After all, that's
the way CVS and Subversion do it, and it's fine for most users.  As for
the locations under refs, let's leave it to git.

> > We have a line that says: "pull from pu branch of origin and merge it
> > into local pu branch even if fast-forward is impossible".
> 
> Are you talking about "remote.origin.fetch = +pu:refs/heads/pu"?

Yes, I'm talking about that line.  And I don't like that I have to use a
magic token "refs/heads/pu" that doesn't correspond to a real file to
make it possible to keep git up-to-date.

[skip]

> > However,
> > there it no local pu branch.  Yet not having this line blocks updating
> > of master branch.
> 
> Now that is worrisome.  "git pull"  and "git pull origin" (but
> not "git pull pu" for the reason I mentioned earlier) should
> create your "pu" branch if you have the configuration.
> 
> Let me understand the situation.  Your config file is:
> 
> > My .git/config file is:
> >
> > [core]
> >         repositoryformatversion = 0
> >         filemode = true
> >         logallrefupdates = true
> > [remote "origin"]
> >         url = git://www.kernel.org/pub/scm/git/git.git
> >         fetch = refs/heads/*:refs/remotes/origin/*
> > [branch "master"]
> >         remote = origin
> >         merge = refs/heads/master
> 
> So you may not have refs/heads/pu (iow, you do not build on top
> of my 'pu'), but the config says refs/remotes/origin/ is used to
> track all my branches.  Do you have refs/remotes/origin/pu?

Yes.  I'm doing a clean checkout now with the current git from the
"master" branch:

[proski@dv git]$ git-clone git://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /home/proski/tmp/git/git/.git/
remote: Generating pack...
remote: Done counting 35273 objects.
remote: Deltifying 35273 objects.
remote:  100% (35273/35273) done
Indexing 35273 objects.
remote: Total 35273, written 35273 (delta 24484), reused 35217 (delta 24444)
 100% (35273/35273) done
Resolving 24484 deltas.
 100% (24484/24484) done
Checking files out...
 100% (761/761) done
[proski@dv git]$ git --version
git version 1.5.0.rc0.g4a4d
[proski@dv git]$ ls git/.git/refs/remotes/origin/
HEAD  html  maint  man  master  next  pu  todo
[proski@dv git]$ ls git/.git/refs/heads/         
master
[proski@dv git]$ cd git/
[proski@dv git]$ git-pull
Already up-to-date.
[proski@dv git]$ ls .git/refs/heads/
master
[proski@dv git]$

> If so, then "git fetch" would error out exactly because 'pu'
> would not fast forward and the config says it does not allow
> non-fast-forward fetch.
> 
> It might make sense to make the default configuration git
> clone creates to say
> 
>         [remote "origin"]
>                 url = git://www.kernel.org/pub/scm/git/git.git
>                 fetch = +refs/heads/*:refs/remotes/origin/*
> 
> instead.
> 
> I think I suggested this once but vaguely recall some people
> objected, for the reason that an unusual situation such as
> non-fast-forward should always error out for safety and should
> require an explicit override by the user.

In this particular case of the GIT project, it's very rare that I would
be interested in the "pu" branch.  I'm mostly interested in "master",
and I can be occasionally interested in "next".

The default for git-clone is to clone all branches.  It's OK for me
because I'm on a fast connection (I hear angry voices of modem users).
Actually, I don't see an option to git-clone to clone HEAD or selected
branches only.  The "-o" option seems to be something different, even
though the manual mention branches.

Unfortunately, updating the current branch fails because pu is not
fast-forwarding.  Why fail if I'm not even on pu?

In other words, the basic default functionality is hampered because of a
branch the user is not even using in any way.  And the fix involves
editing the config file.

> But come to think of it, I think failing to update the remote
> tracking branch for non-fast-forward does not buy us very much.
> Letting the user to be aware of the situation has value, but at
> that point, I do not think there is much else the user can do.
> The purpose of the tracking branches is to track what happens on
> the remote side, and the user is in no position to override what
> has already happend on the remote side (otherwise it stops being
> "tracking branches").  If reflogs are enabled on remote tracking
> braches, you can always get back the older state if you wanted
> to.

I tend to agree.  Of course, if any porcelains require or prefer
fast-forward, they should be able to prevent non-fast-forward updates.
Perhaps they would be OK with non-fast-forward updates on branches other
than those they are specifically managing?

> That makes me notice another thing.  We do not seem to create
> reflog for remotes/ hierarchy even when logallrefupdates is set
> to true.  Would people object if we did this?

No objection on my part.

-- 
Regards,
Pavel Roskin
