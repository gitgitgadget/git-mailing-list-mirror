From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 12:03:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702061202260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <eq6tj6$80m$2@sea.gmane.org>
 <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
 <20070205194508.GD8409@spearce.org> <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
 <20070205225505.GA9222@spearce.org> <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
 <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070206110015.GA10231@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 12:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEO77-0007L3-Ew
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 12:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXBFLDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 06:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbXBFLDr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 06:03:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:43809 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750860AbXBFLDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 06:03:47 -0500
Received: (qmail invoked by alias); 06 Feb 2007 11:03:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 06 Feb 2007 12:03:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070206110015.GA10231@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38834>

Hi,

On Tue, 6 Feb 2007, Jeff King wrote:

> On Tue, Feb 06, 2007 at 11:45:24AM +0100, Johannes Schindelin wrote:
> 
> > > git gc (repack -d of it) is too dangerous in a shared repo: it breaks
> > > the repos which depend on the master repository, have sent (by some
> > > means) some objects over to the master, and accidentally removed
> > > the reference, and were pruned afterwards.
> > 
> > We no longer call git-prune automatically in git-gc. You have to say 
> > "git-gc --prune" to trigger that behaviour.
> 
> repack -d can lose objects, too:
> 
> # fully packed test repo with 2 commits
> mkdir repo && cd repo
> git init
> touch foo
> git add foo
> git commit -m foo
> echo bar >foo
> git commit -a -m bar
> git repack -a -d
> 
> # remember the latest commit
> commit=`git rev-parse HEAD`
> 
> # now make it dangling
> git reset --hard HEAD^

This is the culprit.

The solution is very easy: do not --reference a repository which resets or 
deletes branches. IMHO this is all too obvious.

Ciao,
Dscho
