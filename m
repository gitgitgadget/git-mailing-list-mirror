From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 18:13:25 -0700
Message-ID: <7vpst9huq2.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<1122068634.7042.35.camel@localhost.localdomain>
	<7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	<20050723090433.GA11814@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 03:14:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwV3g-0005gT-HG
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 03:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVGXBN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 21:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVGXBN3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 21:13:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36772 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262284AbVGXBN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 21:13:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724011324.KYNL17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 21:13:24 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050723090433.GA11814@pasky.ji.cz> (Petr Baudis's message of "Sat, 23 Jul 2005 11:04:33 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> I have it the other way around, with the rationale that your default
> settings should be in your ~/.gitrc, not environment, which is always
> the highest priority.

That's true.  I just never hand commit other people's patches (I
use applymbox for that) and never needed to give one-shot set of
environment variables to commit-tree by hand from the command
line.

> (Quite some things came to git from Cogito anyway. ;-) And well, that's
> completely natural.)

I am not the one who did the barebone, so I'd let Linus to tell
"coming from" and "done independently while retaining
compatibility" apart if he wants to ;-).

>> Personally, I think having to have ignore pattern like .cvsignore
>> per-directory is simply _ugly_.
>
> No, I think it's great. That increases the locality of things, which is
> good. Think about it as of variables - it's nicer to have them local.

Seeing Catalin also expressed the intention to add .gitignore in
directory tree everywhere, I would keep my personal opinion to myself.

How about we do something like this:

    git-ls-files --others
        --exclude-from=.git/ignore \
    	--exclude-per-directory=.gitignore

When the new flag --exclude-per-directory is specified,
git-ls-files uses the file with that name in each directory it
looks at to match against the files in that directory (and its
subdirectories, perhaps?)  just like it uses --exclude-from for
the entire tree today.

If I added that, would both of you be able to lose a lot of
lines from cg-status and git.__tree_status()?  If so, then that
is worth the core-side support.

What should the pattern matching rules be?  I think the current
git-ls-files one may be a bit too weak.
