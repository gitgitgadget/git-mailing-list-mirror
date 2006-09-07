From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cygwin playbook?
Date: Thu, 7 Sep 2006 03:27:41 -0400
Message-ID: <20060907072741.GA10652@spearce.org>
References: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com> <7v7j0g40xh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 09:48:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLEcI-0001Zc-VC
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 09:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWIGHsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 03:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWIGHsA
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 03:48:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23517 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751070AbWIGHr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 03:47:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLEc8-00075Z-MO; Thu, 07 Sep 2006 03:47:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3FA8E20FB33; Thu,  7 Sep 2006 03:27:41 -0400 (EDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <7v7j0g40xh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26610>

Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> 
> > - What cygwin packages are needed?

I'd have to check tomorrow but I run a pretty reduced set of Cygwin
packages with Git.  I'm using something around:

	rcs (for merge)
	python (for merge-recursive, though merge-recur is a *huge* win)
	wish (for gitk)
	perl
	ssh
	openssl
	curl
	expat
	... maybe i missed something but probably not...
	make
	gcc
	binutils (sorta necessary to compile!)

iirc I build git on Windows with a command as simple as:

	make prefix=/usr/local/git NO_MMAP=1 install

I actually have it in a small shell script as I then turn around
and tar/bz2 that directory and make a Cygwin package out of it for
other folks at my site.

> > - How do I install for personal use?
> 
> make install would install under whereever you call ~/bin in
> Cygwin environment, and that is how I have mine.

I personally don't like the default prefix so I always retarget Git
to another directory.  This works just fine on Cygwin just like on
any UNIX system.
 
> > - Anything else I should know?
> 
> You would probably have great pain if on vfat.  It appears to
> work Ok on NTFS.  It appears to be quite slow, judging from
> the way it runs our standard test suite.

I see odd behavior when its not a locally mounted NTFS filesystem.
For example sometimes our SAMBA server (a Solaris system) doesn't
play nicely with our XP systems and we get bad error codes back
(still haven't figured that one out).  We also have what I believe
is a Windows 2003 server whose drive is mapped onto many 2000/XP
desktops; that drive can't properly rename the index file so we
can't use it for working directory storage.  Works fine though for
bare repositories.  Local NTFS has never been an issue.

I see large slowdowns when the number of loose objects >~100.  So I
repack frequently.  No, defragging hasn't helped.  Only repacking
has.

I just started using merge-recur (export
GIT_USE_RECUR_FOR_RECURSIVE=1 to enable) over git-merge-recursive.
Its a huge performance gain.  I'm glad Alex Riesen and Johannes
Schindelin have put so much effort into it.

gitk has layout issues on Cygwin.  I always whack my ~/.gitk
file and then have to resize the window every time it launches.
People have reported this bug in the past but I don't think anyone
has taken the time to work it out.  It hasn't annoyed me enough
(yet) to justify me spending time on it.

Git pretty much works as you would expect; its just somewhat slower
than on a good UNIX system.  Maybe its Cygwin, maybe its Windows,
maybe its the 4+ year old system its running on.  :-)

-- 
Shawn.
