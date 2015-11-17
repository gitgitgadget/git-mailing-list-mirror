From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: race condition when pushing
Date: Tue, 17 Nov 2015 14:25:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511171419130.1686@s15462909.onlinehome-server.info>
References: <SNT153-DS223275FC4D60A266EE7E28F6290@phx.gbl> <CAPig+cSGSe=7PY7HVuAdy=4chbkkACiEBZzvDA4AktMKFiRfPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Lyle Ziegelmiller <lyle_z@hotmail.com>,
	git bug report <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 14:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZygGj-0003eM-PH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 14:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbbKQNZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 08:25:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:63178 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbbKQNZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 08:25:52 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Lkx9B-1aYqUk2Zrp-00aiHF;
 Tue, 17 Nov 2015 14:25:43 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPig+cSGSe=7PY7HVuAdy=4chbkkACiEBZzvDA4AktMKFiRfPw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:a2ihaF0S6CJ2GkRcgQeOMAh3x9AhvsahcW+eT26IQCYhagQ11Li
 5FvDRuCJAfwLiuAVEwnTFlXN7vr6QLh9u30cHMm1UxYCbho1jYuVPguu6hRVJiShEMUEkVj
 6QOB81+lIaeYu6mk1F7x0Zr+DsHcAZu77VXz/H/lFqrWjLE0DgaSbrg8pgjFURX8wgGF8Fz
 73lgZeJVMwzqLgND3taHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:na4grrNhS2w=:3TpE1EuZqW3HmiSDO3vK7p
 OhQaUx3LPn7q7Qhhvot93zqaRod6FoF96r2AjT7sPaYJXMdbd9zbc3MiwubNE9fnBDhGWKOk4
 orx29Z6gdIqVuWhTbw0aPVqTY0zucQqBEai9m3rPeNFcptA14xtLWscsp37NeB1+3Fm0d4XAW
 +yS9AEj0cpE6AqRWQVzsU+9Y5EMGEc5CIHzrfzr+f0CBCwm/G2G2ej0vnTiiUPKOCbrn8R71u
 lmannxyHwrZ3UHP8wrApmFnd5sq/J/2JavlDPOjd23htBnVtgpnDpA9AVgiopqqzBkk3Dm+CE
 USqKCh6tojQ3i8iJrec5mZos9Eq8nmp7uzhanCnNRNiiehIDDbfILsBDtzNIaMlHQMK+O5ojM
 L1/5FVvqK5aRwul5L81JrwFxyZEcSUputYTUbbbE6ArfnU2aCX0vOVjvgnrxrASHz78lnbR43
 HjNGouBO/BuJH1iDRb4Q4zdy9Pa4/W3+pfjE5r8G5RZyH09KEMT94pi/A2WrKKnNUbMcB55/d
 sFIfCHefdCRmYZvav+lbBdsL9/u5371lb8svzY6ZIzC8Z1Hrdv+kYWU/s/7vC7Z8axkmYmsMU
 dRwZmTFwwkm5RPIp9Uy17gGaYFlG9f6US0BogMwATPVqekxc5x7XLUWNvyLjJVKlBbPt93eYK
 ditzAk25wQjRl9ZR/Wj13UTOzGU35kwvUjdu+Psz+BeMFJIyPLGhoZkuSIcfWTqlOrMqxmX6I
 gqpgEHJJdGwD89TIQk+4Xkxwu/q2QqZ1dSannMIvVyt6/3VY+0ygrWnsngLpDGb/ZN0MtJb+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281407>

Hi Lyle & Eric,

On Thu, 5 Nov 2015, Eric Sunshine wrote:

> On Thu, Nov 5, 2015 at 11:11 AM, Lyle Ziegelmiller <lyle_z@hotmail.com> wrote:
> > git push --set-upstream  has some sort of race condition. Some times
> > when I execute it, it works. Other times, it does not. Below is from
> > my command window. I've executed the exact same command (using bash
> > history re-execution, so I know I didn't make a typo), repeatedly.
> > Notice the last execution results in an error. I am the only person on
> > my machine. This is non-deterministic behavior.
> >
> > lylez@LJZ-DELLPC ~/gittest/local
> > $ git push --set-upstream origin localbranch1
> > Branch localbranch1 set up to track remote branch localbranch1 from origin.
> > Everything up-to-date
> >
> > lylez@LJZ-DELLPC ~/gittest/local
> > $ git push --set-upstream origin localbranch1
> > Branch localbranch1 set up to track remote branch localbranch1 from origin.
> > Everything up-to-date
> >
> > lylez@LJZ-DELLPC ~/gittest/local
> > $ git push --set-upstream origin localbranch1
> > error: could not commit config file .git/config
> > Branch localbranch1 set up to track remote branch localbranch1 from origin.
> > Everything up-to-date
> >
> > I'm using Git in a Cygwin window on a 32-bit Windows 10 machine.

Are you using Cygwin's own Git, or Git for Windows, or something else?

> If I recall correctly, the typical culprit is a Windows virus scanner
> (or even an indexer) locking the file, so git is unable to manipulate
> it.

In Git for Windows, we have code to work around this issue by detecting
in-use files and waiting for a staggered amount of time to re-try:

https://github.com/git-for-windows/git/blob/c6f19b078bf05643c4d50dd520280a80f19f0002/compat/mingw.c#L208-L231

This is used e.g. by our `rename()` wrapper:

https://github.com/git-for-windows/git/blob/c6f19b078bf05643c4d50dd520280a80f19f0002/compat/mingw.c#L1859-L1904

Please note that this code is active in Git for Windows (i.e. the *MinGW*
version of Git) but not in Cygwin Git (nor the MSys2 version of Git).

Ciao,
Dscho
