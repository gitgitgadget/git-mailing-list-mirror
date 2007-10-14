From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 21:21:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710142118590.25221@racer.site>
References: <20071014143628.GA22568@atjola.homenet> <47122D02.9060204@op5.se>
 <20071014152327.GA24003@atjola.homenet> <Pine.LNX.4.64.0710141830050.25221@racer.site>
 <20071014201813.GA26872@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, gitster@pobox.com,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:21:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9xd-0004F9-R3
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbXJNUVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 16:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXJNUVG
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:21:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:60989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755167AbXJNUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:21:05 -0400
Received: (qmail invoked by alias); 14 Oct 2007 20:21:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 14 Oct 2007 22:21:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/RolTz8s/IvAlzktNhSK6G56WyKMiz/bs3CAXiv
	9RfTl+jokqBUbV
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014201813.GA26872@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60901>

Hi,

On Sun, 14 Oct 2007, Bj?rn Steinbrink wrote:

> On 2007.10.14 18:32:44 +0100, Johannes Schindelin wrote:
> > 
> > On Sun, 14 Oct 2007, Bj?rn Steinbrink wrote:
> > 
> > > On 2007.10.14 16:51:46 +0200, Andreas Ericsson wrote:
> > > > Bj?rn Steinbrink wrote:
> > > >> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the current
> > > >> master and all of them crashed. A small shell script to reproduce the
> > > >> problem is attached.
> > > >
> > > > Manual bisect? Ugh. This *is* the century of the competent developer
> > > > tools, you know... ;-)
> > > 
> > > Then, how do I search for a good version with git bisect if I only have
> > > the one data-point "master is bad"?
> > 
> > AFAIK Junio introduced the option to start with just a bad commit, and no 
> > known "good" one.
> > 
> > Yep, just found it.  Since v1.5.2-rc0~77^2(git-bisect: allow bisecting 
> > with only one bad commit.) it is supported.
> > 
> > >From the commit message:
> > 
> >     This allows you to say:
> > 
> >         git bisect start
> >         git bisect bad $bad
> >         git bisect next
> 
> OK, using that approach, I bisected it, and even found a "guilty"
> commit, although it is pretty much useless:
> 
> 1cfe77333f274c9ba9879c2eb61057a790eb050f is first bad commit
> commit 1cfe77333f274c9ba9879c2eb61057a790eb050f
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Tue Jan 30 01:11:08 2007 -0800
> 
>     git-blame: no rev means start from the working tree file.

I think it is not useless.  It says exactly the same as I did, in another 
reply:  git blame starts with your working tree.  As such, it has to do 
some operations which happen to fail on unmerged files.

So the solution in your case _really_ is:

	git blame HEAD file2

Explanation: with that command line, you ask git blame to start with a 
given revision (instead of the working tree), which just so happens to be 
the HEAD revision.

Hth,
Dscho
