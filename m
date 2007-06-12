From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn set-tree bug
Date: Tue, 12 Jun 2007 11:21:05 +0200
Organization: Transmode AB
Message-ID: <1181640065.30670.200.camel@gentoo-jocke.transmode.se>
References: <466C8B35.3020207@midwinter.com>
	 <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
	 <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle>
	 <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy2Yz-0002tz-Fm
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 11:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXFLJVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 05:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbXFLJVN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 05:21:13 -0400
Received: from mail.transmode.se ([83.241.175.147]:25237 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbXFLJVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 05:21:12 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 12 Jun 2007 11:21:05 +0200
In-Reply-To: <20070612083910.GA28369@muzzle>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49939>

On Tue, 2007-06-12 at 01:39 -0700, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > 
> > > If dcommit detects a merge commit when doing rev-list When looking at
> > > commit objects, is it safe to assume that the first parent is always the
> > > "mainline" and that parents after it are the ones to merge from?
> > >
> > > So if I saw:
> > >
> > > commit $X
> > > parent $A
> > > parent $B
> > >
> > > I'd basically do:
> > >   reset --hard $A
> > >   merge --squash $B
> > >
> > > And resulting in $C which would have the same tree as $X,
> > > then, when dcommit-ting, $D would be created with two parents:
> > >   $D~1 (svn), $B (git), but not $A
> > 
> > I am not sure what you mean by "mainline", but I assume that you
> > mean "SVN is the main and we are tracking it while taking
> > advantage of more efficient and merge-capable git in guerrilla
> > fashion".  Because the tip of the current branch is what the
> > user is pushing back to SVN via dcommit, I would say it is safe
> > to assume that the first parent of such a merge is the line that
> > corresponds to the SVN branch you are keeping track.
> 
> Yes, "mainline" meaning the history that would be committed to SVN if
> history were linear.
> 
> I've gotten the following patch working for Joakim's second test script
> (with dcommit before merge).  However, without the dcommit before merge
> in the first test script, git-svn has trouble figuring out which history
> to follow.  It'll take more work to figure out what to do in this
> situation, and how to deal with more complex history...
> 
> Subject: git-svn: Allow dcommit to handle certain single-parent merge commits
> 
> This only works if a merge is the first commit to be committed
> in a chain of commits.
[SNIP patch]

Nice!, now I get to keep the merge between the "svn" and the "merge" branch. The parents are swapped though:
before last dcommit:
  Parent: b31cef1d3c6655441854ea8649359f0fc27f3e87 (friend)
  Parent: ed95b698c2e3336d387fed3763b213b3b90ebf4e (add some stuff)
  Branch: svn
  Follows: 
  Precedes: 

    Merge branch 'merge' into svn

after dcommit:

Parent: ed95b698c2e3336d387fed3763b213b3b90ebf4e (add some stuff)
Parent: b31cef1d3c6655441854ea8649359f0fc27f3e87 (friend)
Branches: svn, remotes/trunk
Follows: 
Precedes: 

    Merge branch 'merge' into svn
    
    
    git-svn-id: file:////usr/local/src/tst-git-svn/mysvnrepo/trunk@3 1585b9b0-b13 ....


Will this also work for merging stuff from latest u-boot?

I am doing dev. on my own u-boot branch and from time to time I want
to merge in the latest from WD tree, then dcommit that merge. Later
I want repeat that cycle.

I have a SVN repo with my changes in it and I have grafted the beginning of
that tree into a clone of WDs tree.

 Jocke
