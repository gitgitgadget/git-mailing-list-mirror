From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 02:22:54 -0400
Message-ID: <20070420062254.GB29069@spearce.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <200704172239.20124.andyparkins@gmail.com> <1176983993.30690.13.camel@cauchy.softax.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
To: Marcin Kasperski <Marcin.Kasperski@softax.pl>
X-From: git-owner@vger.kernel.org Fri Apr 20 08:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HemWX-0008UI-3N
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 08:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422975AbXDTGXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 02:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422997AbXDTGXI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 02:23:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56028 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422975AbXDTGXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 02:23:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HemWJ-0001Us-47; Fri, 20 Apr 2007 02:22:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0CAE220FBAE; Fri, 20 Apr 2007 02:22:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1176983993.30690.13.camel@cauchy.softax.local>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45065>

Marcin Kasperski <Marcin.Kasperski@softax.pl> wrote:
> > As for permissions, well Shawn has often spoken of his hook scripts that 
> > implement very strong permissions (and he has done so again in this 
> > thread).

I just posted it as a contrib patch.  Maybe Junio will be willing
to carry it around in his tree.  If not, gmane now has it.  :-)
 
> I am not quite sure how can you forbid johny to see the code
> in ./secret, while johny must checkout whole repo...
> 
> Permissions are not only about writing.

Indeed.  But subsetting a repository by path like that is ugly
in any DVCS.  Which is why most don't do it.  Probably better
to subset by repository, aka the subproject support.

Because odds are that if you are hiding a directory (johny cannot see
./secret) then you probably also need to hide all commit messages of
all commits that affected ./secret too.  And if those commits were to
also modify stuff in ./public, then that starts to get really iffy.
Better to just make a very clear distinction at the repository level.
 
> > Depends what you want - I installed cygwin 
> 
> This is really not an option for typical windows user. Believe me.
> Maybe it could be, if cygwin managed to create normal setup program
> one day...

Yea.  I've had a number of Git users get burned by the
git-merge-recursive script changing to git-merge-recursive.exe,
and Cygwin's installer left git-merge-recursive in the directory
when upgrading, but deleted some of the supporting Python modules.
So they were unable to execute a merge.

Better, one user succeeded in doing a `git merge -s ours foo`,
completely tossing away the work of 20+ users over 3 months,
because their HEAD was very old and their merge-recursive was
utterly broken...  They did not mean to do an ours style merge, it
just happened that merge-recursive didn't do squat...  because it
was the old Python version, partially installed...

I found out about the breakage only after those 20+ users managed
to cram another 80 or so commits onto the top of that bad merge.
Which meant that I couldn't just rewind the tree to redo the merge.
I actually had to redo the merge as a new commit ontop of the bad
history.  Without losing any of the new changes.  Ick.

Thankfully just the week before I taught merge-recursive how to
take trees (and not commits), allowing me to use it to carry the
changes through whilest ignoring the bad merge base history.

So anyway, my Git-on-Cygwin installer is now:

	...on the master system...
	make clean &&
	make prefix=/usr/local/git &&
	rm -rf /usr/local/git &&
	make install prefix=/usr/local/git &&
	tar jcf update-git.tar.bz2 /usr/local/git

	...and on other systems...
	cd / &&
	rm -rf /usr/local/git &&
	tar jxf update-git.tar.bz2

because dammit, that works, all of the time.  Unlike Cygwin's
setup.exe.

-- 
Shawn.
