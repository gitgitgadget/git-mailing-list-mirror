From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Pasky problem with 'git init URL'
Date: Thu, 21 Apr 2005 22:29:28 +0200
Message-ID: <20050421202928.GH7443@pasky.ji.cz>
References: <1114100518.17551.31.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 22:26:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOiEb-0007QM-7T
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVDUU3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVDUU3l
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:29:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31367 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261858AbVDUU3g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:29:36 -0400
Received: (qmail 19018 invoked by uid 2001); 21 Apr 2005 20:29:28 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1114100518.17551.31.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 06:21:58PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Hi,

Hi,

> Just pulled linux-2.6.git, and got this:
> 
> ----
> New branch: 3a6fd752a50af92765853879f4a11cc0cfcd0320
> Tracked branch, applying changes...
> Merging 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9 -> 3a6fd752a50af92765853879f4a11cc0cfcd0320
>         to a2755a80f40e5794ddc20e00f781af9d6320fafb...
> 
> Enter commit message, terminated by ctrl-D on a separate line:
> Merge with 3a6fd752a50af92765853879f4a11cc0cfcd0320
> ----
> 
> Weird thing was that I made no changes.

did you compensate for the renamed hashes? Didn't you before update from
some very old git-pasky version?

Actually, did you do that git init _after_ the unsuccessful pull, or
before?

> Digging a bit deeper, I saw that .git/HEAD was a symlink
> to .git/heads/master, and the tracked branch was 'origin'.  Due to the
> fact that Linus only have a .git/heads/master on his rsync, and this
> thus updated to the new sha1, but the 'origin' (and tracked) head is
> still pointing to an older sha1 caused this confusion.

Duh. The remote branch always grabs the HEAD over there; you don't need
to care about the various branches over there, and you really do not
*want* to care. Actually I might add some ^branchname to the rsync URL,
to be able to refer to particular branches inside of the repository.

> I replicated the linux tree via:
> 
> ----
> git init URL
> ----
> 
> So I had a look at gitinit.sh, which first creates the .git/heads/master
> and symlinks HEAD to it, then on seeing a URL was supplied, creates
> a .git/heads/origin, track it, but do *not* change the .git/HEAD
> symlink ... Is this intended?  I see also that gittrack.sh do not update
> the HEAD symlink ...  Is this also intended?

Yes.

You never work directly on the remote branch. Ever. That's what this
tracking stuff is for; you set up a local branch which follows the
remote one.

Otherwise, you fork to two trees, one is remote branch, second is local
branch, and you do git pull remotebranch in the second. You are in
trouble now. Also, if you do some local commit on the remote branch,
what would happen? This kind of stuff is why I decided that you just
cannot work on remote branches directly.

> The last option however brings a problem or two.  First, how do you do
> the multi-head thing?  Maybe add a command 'git lsheads' (and while at
> it, also add 'git lstags'?)?  Secondly, if there was more than one head,

Perhaps it would be useful to have some "command classes" (with at least
cg-*-(add|ls|rm)), like:

	cg-branch-ls
	cg-remote-rm
	cg-tag-add

> the local copy needs to be checked out ... don't know if 'git cancel' is
> the logical thing the user will think to do ('git clone' perhaps?) ...

I don't know what do you mean here.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
