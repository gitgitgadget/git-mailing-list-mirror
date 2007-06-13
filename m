From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] git-svn: allow dcommit to retain local merge
	information
Date: Thu, 14 Jun 2007 01:17:39 +0200
Organization: Transmode AB
Message-ID: <1181776659.30670.340.camel@gentoo-jocke.transmode.se>
References: <466C8B35.3020207@midwinter.com>
	 <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
	 <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle>
	 <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle>
	 <20070613092328.GA30318@muzzle>
	 <1181754781.30670.323.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:17:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyc66-0005sX-13
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 01:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbXFMXRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbXFMXRq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 19:17:46 -0400
Received: from mail.transmode.se ([83.241.175.147]:10487 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750758AbXFMXRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 19:17:45 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 14 Jun 2007 01:17:39 +0200
In-Reply-To: <1181754781.30670.323.camel@gentoo-jocke.transmode.se>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50145>

On Wed, 2007-06-13 at 19:13 +0200, Joakim Tjernlund wrote:
> On Wed, 2007-06-13 at 02:23 -0700, Eric Wong wrote:
> > dcommit will still rewrite the HEAD commit and the history of the first
> > parents of each HEAD~1, HEAD~2, HEAD~3 as it always has.
> > 
> > However, any merge parents (HEAD^2, HEAD^^2, HEAD~2^2) will now be
> > preserved when the new HEAD and HEAD~[0-9]+ commits are rewritten to SVN
> > with dcommit.  Commits written to SVN will still not have any merge
> > information besides anything in the commit message.
> > 
> > Thanks to Joakim Tjernlund, Junio C Hamano and Steven Grimm
> > for explanations, feedback, examples and test case.
> > 
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> > 
> >  This is a better patch that replaces the previous one.
> > 
> >  Junio:
> >    This one is a big change and should probably sit in pu or next
> >    for a bit.  Double-checking the logic in linearize_history()
> >    would be greatly appreciated, too.
> >    
> >    I don't think there are any regressions for the
> >    already-linear-history case besides slightly reduced performance for
> >    new calls to cat-file.
> > 
> >  Joakim/Steven:
> >    Any further testing and test cases would be appreciated.  Be very
> >    careful with real-world repositories, and run dcommit with the
> >    '-n' flag before actually committing to verify the diffs are sane.
> > 
> >   Thanks
> > 
> 
> Did a little testing and so far it looks good :)
> 
> Sidenote:
> Doing this 
>   git-svn init -t tags -T trunk -b branches  file:///usr/local/src/tst-git-svn/svn-uboot-repo
>   git-svn fetch --quiet
> makes git svn fetch stop for rather long periods in do_update:
>   Found possible branch point: file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk => file:///usr/local/src/tst-git-svn/svn-uboot-repo/tags/snap-uboot-1.1.4, 2
>   Found branch parent: (tags/snap-uboot-1.1.4) 81eef14963597cc99ba375f52e6d0b3bc09e25f8
>   Following parent with do_update
>   Successfully followed parent
> 
> Is it possible to speed up do_update?
> 
> 
> Lastly, when adding the above u-boot svn repo into a fresh u-boot clone from WD,
> can I attach the svn tree to git u-boot tree without using a graft?
> 
> I want to be able to recreate my own git repo by cloning the orginal u-boot
> repo and the svn repo.
> 
>  Jocke

Tried using --no-metadata(git svn clone --no-metadata) in my little test
script I sent earlier and got
  "Unable to determine upstream SVN information from HEAD history"
when dcommiting, -i trunk didn't help either.

It is not entierly clear to me what --no-metadata means to me.
Does git-svn still rewrite commits?
I can't rebuild rev_db file, if lost, but I guess I could still
do a new git-svn clone and restore my repo? I guess I lose something
if I do that but what?
Also don't really understand why git-svn log doesn't work, can't it get
that info from the svn repo?

 Jocke
