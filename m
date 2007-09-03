From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 3 Sep 2007 15:38:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031536060.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <46DC10FE.1080805@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISD4a-0001OJ-6c
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 16:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXICOig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXICOig
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 10:38:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:39709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751680AbXICOif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 10:38:35 -0400
Received: (qmail invoked by alias); 03 Sep 2007 14:38:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 03 Sep 2007 16:38:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GsGZpHFrGxNM4RAMAFJBxptsYseBq0swkf+t475
	/ZRTkK4jcPARaM
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC10FE.1080805@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57490>

Hi,

On Mon, 3 Sep 2007, Johannes Sixt wrote:

> Marius Storm-Olsen schrieb:
> > There was a problem with racy conditions, which this revision fixes.
> > The problem was that fstat was using the builtin implementation, which for
> > for some reason is off by some amount of seconds. (This is probably due to
> > some leap-year issue in one of the implementations. However, Microsoft
> > tells
> > us to use 116444736000000000 in http://support.microsoft.com/kb/167296, so
> > I'll stick with that.)
> 
> Thanks for the analysis and new patch. Indeed, FILETIME is UTC, which is
> good; the native implementation returns local time, if I read the code (of
> msvcrt) correctly.
> 
> > With the our own implementations of lstat & fstat, the following test cases
> > are now fixed:
> >     t4116-apply-reverte.sh
> >         ok 3: apply in reverse
> >     t4200-rerere.sh
> >         ok 17: young records still live
> > However, the following test cases seems to fail now:
> >     t6024-recursive-merge.sh
> >         FAIL 1: setup tests
> >         FAIL 3: result contains a conflict
> >         FAIL 4: virtual trees were processed
> >         FAIL 5: refuse to merge binaries
> > 
> > See attached test case logs.
> > Are some of these test cases unstable, so the result will fluctuate on
> > Windows?
> 
> I see many more failures. in:
> 
> t4001-diff-rename.sh: 5
> t4101-apply-nonl.sh: all
> t4102-apply-rename.sh: 2,3,4
> t4116-apply-reverse.sh: 3
> t4200-rerere.sh: 12,13,17
> t5515-fetch-merge-logic.sh: 54
> etc...

Funny.  I do not get most of these:

t4200-rerere,
t5510-fetch,
t5515-fetch-merge-logic,
t5700-clone-reference,
t5701-clone-local,
t7004

This is all on top of 4msysgit's "devel" branch, and the t5* and t7004 
failed there already.

Oh, and I actually run from sh, not from cmd.  (Wouldn't you have 
guessed?)

Ciao,
Dscho
