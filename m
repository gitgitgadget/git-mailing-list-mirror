From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Test case for "git diff" outside a git repo
Date: Tue, 24 Jul 2007 10:24:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241024350.14781@racer.site>
References: <20070723132248.GA24122@midwinter.com> <7vy7h6ib0b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGdh-0001Ys-OI
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763628AbXGXJZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762494AbXGXJZE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:25:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:36272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758426AbXGXJZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:25:02 -0400
Received: (qmail invoked by alias); 24 Jul 2007 09:25:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 24 Jul 2007 11:25:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w1ENEOw3wvLFDBOsC/ptBps51LgPEUx8PAvwkj7
	q1dboUXun/FvdC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7h6ib0b.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53542>

Hi,

On Mon, 23 Jul 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Steven Grimm <koreth@midwinter.com> writes:
> >
> >> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> >> ---
> >> 	git-diff --quiet is pretty broken right now. If you do
> >> 	"strace git diff --quiet file1 file2" you will see that
> >> 	it never calls open() on either file! And it always
> >> 	returns a zero exit code whether or not the files are
> >> 	different.
> >>
> >> 	I'm trying to follow the code to figure out what's going on,
> >> 	but meanwhile, here's a test case. Perhaps someone more
> >> 	familiar with the diff code will beat me to a fix.
> 
> The code to do "untracked diff" is an ugly stepchild and not really part 
> of git-diff proper.  In fact, --quiet also is an afterthought and I 
> would not be too surprised if the "untracked diff" code does not work 
> with it.

Not that ugly, mind you.  Every third day or so I congratulate myself for 
having "git diff --color-words" or "git diff -M", without having to suffer 
initialising a git repository.

But yes, I agree, the --quiet code came after the --no-index code, and 
thus it is well possible that the latter ignores the former.

> >> diff --git a/t/t4021-diff-norepo.sh b/t/t4021-diff-norepo.sh
> >> new file mode 100755
> >> index 0000000..dfee3d7
> >> --- /dev/null
> >> +++ b/t/t4021-diff-norepo.sh
> >> @@ -0,0 +1,26 @@
> >> +#!/bin/sh
> >> +
> >> +test_description='test git diff outside a repo'
> >> +
> >> +. ./test-lib.sh
> >> +
> >> +rm -rf .git
> 
> Unless you are testing the t/ directory and git.git suite from a 
> tarball, the only effect of this is to make t/trash controlled by its 
> ../../.git repository (i.e. the git.git repository).  You are still 
> inside a git repository.

Yes, this is no good.

However, you can force --no-index.  IMHO that is the way to go.

Ciao,
Dscho
