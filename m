From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 3 Sep 2007 14:33:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031428080.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISC3i-0001Oj-AV
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 15:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbXICNdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 09:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXICNdf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 09:33:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:41306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751003AbXICNde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 09:33:34 -0400
Received: (qmail invoked by alias); 03 Sep 2007 13:33:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 03 Sep 2007 15:33:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BhNc7+8fByMpj3mHbI+QiVwgoLWo+RLK7xAwTMl
	jUyqczLSijLfEl
X-X-Sender: gene099@racer.site
In-Reply-To: <46DBFA2A.7050003@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57484>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> There was a problem with racy conditions, which this revision fixes.
> The problem was that fstat was using the builtin implementation, which for
> for some reason is off by some amount of seconds. (This is probably due to
> some leap-year issue in one of the implementations. However, Microsoft tells
> us to use 116444736000000000 in http://support.microsoft.com/kb/167296, so
> I'll stick with that.)
> Also, since both stat and lstat proved to be rather slow, having our own
> version of fstat is probably also wise. At least we now control all the
> stat'ing, so we _know_ they are compatible.
> Also note that this revision makes git_lstat call itself after modifying
> the filename, instead of the builtin stat, for the same reasons.

At least some of these informations should go into the commit message, 
too.

> With the our own implementations of lstat & fstat, the following test cases
> are now fixed:
>     t4116-apply-reverte.sh
>         ok 3: apply in reverse
>     t4200-rerere.sh
>         ok 17: young records still live
> However, the following test cases seems to fail now:
>     t6024-recursive-merge.sh
>         FAIL 1: setup tests
>         FAIL 3: result contains a conflict
>         FAIL 4: virtual trees were processed
>         FAIL 5: refuse to merge binaries
> 
> See attached test case logs.
> Are some of these test cases unstable, so the result will fluctuate on
> Windows?

I saw some funny stuff on Windows, like test cases succeeding when run 
interactively, but failing when run from "make test".

BTW it would have been way easier to apply your patch, had you followed 
SubmittingPatches...

To make it easier on others, I just uploaded it into the "teststat" branch 
on 4msysgit.git (subject to removal in a few days).

First comment: it seems git_fstat() is not declared properly, so there are 
quite a few compiler warnings.

Running the tests now.

Ciao,
Dscho
