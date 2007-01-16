From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 21:35:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45AC3B5D.6080700@midwinter.com>
 <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 21:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6v1m-0002Dv-M6
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 21:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXAPUf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 15:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXAPUf2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 15:35:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751422AbXAPUf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 15:35:27 -0500
Received: (qmail invoked by alias); 16 Jan 2007 20:35:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 16 Jan 2007 21:35:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45AD2AE7.2010908@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36962>

Hi,

On Tue, 16 Jan 2007, Steven Grimm wrote:

> Steven Grimm wrote:
> > Johannes Schindelin wrote:
> > > I had the impression that the use of "--ignore-if-in-upstream" in
> > > git-rebase avoids exactly this case: re-applying changes which are already
> > > in upstream.  
> > Where's that option documented? The manpage makes no mention of it at all.
> 
> Ah, okay, poking around in the git-rebase source, I see you mean that
> git-format-patch is called with that option. Gotcha. The problem is that after
> a rebase, the revisions in question *aren't* in the upstream. Here's my
> understanding of why. Say I have this in my integration repository:
> 
> a---b---c---d (master)
> \
>  e---f---g   (integration)
> 
> Now, I rebase the integration branch onto master:
> 
> a---b---c---d
>             \
>              e'---f'---g'
> 
> The problem is that, since e' contains all the changes in e *and* in 
> b/c/d, it does not have the same SHA1 as the original e revision, nor in 
> fact the same hash as any of the revisions in the pre-rebase tree. And 
> after rebase succeeds, it wipes the original e, f, and g from the 
> history of the integration branch.

That is correct, but --ignore-if-in-upstream actually tests the hash of 
the _diff_, not of the commit. So, if c really introduces the same change 
as f (i.e. the diffs are identical), git-rebase will ignore f:

a---b---c---d
             \
              e'---g'

Totally untested, of course. But this is what --ignore-if-in-upstream was 
written for.

Ciao,
Dscho
