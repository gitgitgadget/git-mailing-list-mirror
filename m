From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Moving a directory with history from one repository to another
 while renaming
Date: Thu, 21 Jun 2007 15:05:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211504060.4059@racer.site>
References: <200706211337.32978.andyparkins@gmail.com>
 <20070621130137.GB4487@coredump.intra.peff.net> <200706211457.29030.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 16:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1NO5-0007H5-Vu
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 16:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbXFUOLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXFUOLu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 10:11:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:41038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751876AbXFUOLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 10:11:49 -0400
Received: (qmail invoked by alias); 21 Jun 2007 14:05:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 21 Jun 2007 16:05:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182V2xe2Jw2PwV7dD9uShsNNbqz8AHZXZdPKzE8Oh
	ksC6TDUU5vJ+GK
X-X-Sender: gene099@racer.site
In-Reply-To: <200706211457.29030.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50629>

Hi,

On Thu, 21 Jun 2007, Andy Parkins wrote:

> On Thursday 2007 June 21, Jeff King wrote:
> 
> > You can do this much more efficiently by just operating on the index.
> > Something like:
> >
> > git-filter-branch --index-filter \
> >  'git-ls-files -s | sed -n 's/change/paths/p' | git-update-index
> > --index-info' \ directorymoved
> 
> :-D  Even better.  I am definitely in the "fan of git-filter-branch" camp.
> 
> Thanks for sharing that line; I've actually found it instructive for more than 
> just git-filter-branch.  I definitely hadn't appreciated the fact that the 
> index can be so easily manipulated.

You have to adapt the line minimally: As is, it will possibly catch the 
wrong names, and it does not _move_ the directory, but rather _copy_ it.

So I think something like

git-ls-files -s | sed "s-\t-&newsubdir/-" |
  GIT_INDEX_FILE="$GIT_INDEX_FILE".new git-update-index --index-info &&
mv "$GIT_INDEX_FILE".new "$GIT_INDEX_FILE"

is needed.

Ciao,
Dscho
