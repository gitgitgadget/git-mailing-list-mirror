From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-filter-branch exits early
Date: Tue, 10 Jul 2007 22:57:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707102222430.4047@racer.site>
References: <20070710205202.GA3212@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 00:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Nq7-0001dh-63
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759899AbXGJWFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760801AbXGJWF3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 18:05:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:57968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759693AbXGJWF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 18:05:28 -0400
Received: (qmail invoked by alias); 10 Jul 2007 22:05:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 11 Jul 2007 00:05:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p1nQDPe+pisZkNf3ljdVOZSdTu1nwP2zlIOK6Sl
	SnebjQraIHZUdL
X-X-Sender: gene099@racer.site
In-Reply-To: <20070710205202.GA3212@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52115>

Hi,

On Tue, 10 Jul 2007, Alex Riesen wrote:

> I have a Debian system where git-filter-branch exits immediately after
> "unset CDPATH" in git-sh-setup (the command exits with 1, as CDPATH is
> not defined). The system still has bash-2.05a.
> 
> git-filter-branch has "set -e", which is why the script finishes
> prematurely. If this is not really needed, maybe it can be removed?
> 
> I'll see if the system can be upgraded, but I suspect someone can get
> a similar problem.

I do not really understand why "unset CDPATH" should trigger an error.  I 
guess that this is one of the nice braindamages in dash, right?

Anyway, "set -e" was one thing I wanted to fix.  But I'm not sure I want 
to work on filter-branch now, what with skimo (possibly? hopefully?) 
working on my wishlist for rewrite-commits.  If rewrite-commits gets the 
features I wished for, IMHO filter-branch is obsolete.

Using rewrite-commits would have a couple of advantages:

- the name is much better,

- since we have reflogs enabled by default now, there is really no good 
  reason why you should have to copy the rewritten branches back to their 
  original name (we would need a way to redirect that, though, for 
  example for subdirectory filters),

- it is faster,

- since it is a C program, it should be more stable, eventually, than a 
  shell script, where you have to work around limitations all the time,

- with the trick I described in the mail to skimo, you can have 
  convenience functions (think "map") in the commit filter, too,

- and it would be less work for me.

Your case is a really good illustration for why C is a better language 
than shell in the long run.

Oh, BTW, if the index filter gets the current (original) commit SHA1 as an 
environment variable, like it does in filter-branch, it can act as a 
the first half of a subdirectory filter:

	--index-filter "git read-tree $COMMIT_SHA1:sub/directory/"

The second half of it is to add "-- sub/directory/" to the command line.

Ciao,
Dscho
