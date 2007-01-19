From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 00:54:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 00:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83ZS-00050h-6M
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 00:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbXASXyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbXASXyz
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 18:54:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:41088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965007AbXASXyz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 18:54:55 -0500
Received: (qmail invoked by alias); 19 Jan 2007 23:54:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 20 Jan 2007 00:54:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37224>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:
> >
> >> Johannes Schindelin wrote:
> >> > On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:
> >> > 
> >> > >  for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
> >> > > -			| @@PERL@@ -e 'print reverse <>'`
> >> > > +			| sed -ne '1!G;$p;h'`
> >> > 
> >> > Why not teach the revision machinery to output in reverse with "--reverse"?
> >> 
> >> I'm more in favour of "small is beautiful".  Also from looking at the code,
> >> this seems to be a bit complicated.
> >
> > I'm more in favour of "less shell dependecy is beautiful". And from what I 
> > can tell, it should be relatively easy:
> >
> > ---
> >
> > 	14 insertions and 11 deletions stem from moving (and extern'ing) 
> > 	reverse_commit_list() from merge-recursive.c to commit.c
> >
> > 	So the change is actually 9 insertions and one deletion.
> 
> I think this is sane but I hate to having to worry about
> possible fallouts from giving --reverse in setup_revisions() to
> make it available to everybody.  E.g. things like "what happens
> when you say "git format-patch --reverse HEAD~3".

It would

	1) traverse all commits, storing them in a commit_list,
	2) reverse the commits, and then
	3) continue as before.

So I don't really see a problem (after all, you don't have to use it if 
you don't want to). It would need a little longer to start up, since all 
the commits have to be traversed first, but this is inevitable if you want 
to show the last commit first.

> Nevertheless, moving reverse_commit_list out of merge-recursive is a 
> good clean-up.

Not unless we actually use it elsewhere.

Ciao,
Dscho
