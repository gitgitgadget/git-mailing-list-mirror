From: Jon Loeliger <jdl@freescale.com>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Mon, 26 Sep 2005 15:17:32 -0500
Message-ID: <1127765852.5735.36.camel@cashmere.sps.mot.com>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	 <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net> <87psqwzs3x.fsf@ualberta.net>
	 <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 26 22:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzPu-0006Uh-Kf
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVIZURf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIZURf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:17:35 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:19846 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932503AbVIZURe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:17:34 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id j8QKPcZX029976
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 13:25:38 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j8QKNY0Z006595
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 15:23:34 -0500 (CDT)
To: Git List <git@vger.kernel.org>
In-Reply-To: <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9326>

On Sun, 2005-09-25 at 18:46, Junio C Hamano wrote:
> Tom Prince <tom.prince@ualberta.net> writes:
> 
> >> When you already have a repository to track git.git, I would
> >> recommend to have something like this in .git/remote/origin:
> >>
> >>     URL: http://kernel.org/pub/scm/git/git.git
> >>     Pull: master:origin maint:maint +pu:pu
> >>
> >
> > A warning when you do this. If you say 
> >
> >   git pull origin
> >
> > then your master will be updated with an octopus merge of the three heads.
> 
> Ahhhhhhhh.  That is true.  I always do "git fetch" and never do
> "git pull" against anything but a local repository, heads
> explicitly specified.  You are right.  The defaulting behaviour
> is incredibly broken.
> 
> Do people agree it is a good idea to change the "git pull
> origin" to mean "fetch all the default refs specified on Pull:
> lines, and merge only the first one into the current branch"?
> 
> "git pull" without remote nor refspecs is a synonym to "git pull
> origin" as before, and 99.99% of the time "git pull" from a
> remote repo without explicit refspec is doing just one head
> merge, so I think this is a sane default, much saner than the
> current mess, while still allowing you to keep track of what's
> happening in the other branches by doing fetches of all the
> heads at once.
> 
> Opinions?

Hmmm...  Would it make sense to introduce something
like this instead:

    # When fetching, get bits from here:
    URL: http://...../git.git
    # When fetching, grab and map like this:
    Fetch: master:origin maint:maint +pu:pu
    # When merging, merge origin, maint and pu into master
    Merge: master origin maint pu

With the intent that the "Fetch:" line effectively
limits the fetching operation to git-fetch, and doesn't
specify how to merge.  Then, the "Merge:" line specifies
how to do the git-merge bits.  If you didn't want to
merge in the maint and pu bits, this would have been
the line instead:

    # Merge into master the just the origin bits
    Merge: master origin

If you want the dual-step fetch+merge, the leave the "Pull:"
line as originally written:

    # Fetch and merge
    Pull: master:origin maint:maint +pu:pu

Syntax can be argued, of course.  My point being to
introduce another line to the remote file that
distinguishes the default behavior for each step
along the way.

Thanks,
jdl
