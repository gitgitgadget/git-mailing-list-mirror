From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Mon, 11 Jul 2011 11:26:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107111121390.3379@bonsai2>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com> <alpine.DEB.1.00.1107091935210.1985@bonsai2> <4E1A0FCC.7080308@kdbg.org> <alpine.DEB.1.00.1107110057120.3379@bonsai2> <86k4bpporf.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Pat Thoyts <patthoyts@gmail.com>,
	gitster@pobox.com, msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 11:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgClL-0003d4-7h
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 11:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab1GKJ0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 05:26:42 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:32834 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751465Ab1GKJ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 05:26:42 -0400
Received: (qmail invoked by alias); 11 Jul 2011 09:26:40 -0000
Received: from pD9EB1B2E.dip0.t-ipconnect.de (EHLO noname) [217.235.27.46]
  by mail.gmx.net (mp061) with SMTP; 11 Jul 2011 11:26:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TMCx17+/TKEqDIyLCUktpa926PgA7R8oz/NQatW
	U4+o20adhLVQx7
X-X-Sender: gene099@bonsai2
In-Reply-To: <86k4bpporf.fsf@red.stonehenge.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176838>

Hi Randal,

On Sun, 10 Jul 2011, Randal L. Schwartz wrote:

> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> Johannes> You might be very surprised, but that is not true on the Linux 
> Johannes> system where one of the 4msysgit.git test cases does _not_ 
> Johannes> break, while it does on Windows.
> 
> If you ever depend on a userspace PWD to be your actual current 
> directory without at least stat()ing it, you've failed.
> 
> In my experience, it is *never* reliable.  It's just a hint.

To be precise, get_pwd_cwd() _does_ stat() what's in PWD, and _does_ 
compare with the stat() of what comes out of getcwd(), but that comparison 
uses only st_dev and st_ino, both of which happen to be 0 in my case -- 
for each and every file/directory.

I can only _guess_ at the reasoning behind get_pwd_cwd(). I _think_ it was 
meant to catch the case when getcwd() and PWD refer to the same directory, 
but PWD goes through symbolic links. I was tempted to just throw that PWD 
handling out for Windows, since we do not have symbolic link handling yet. 
But that is currently actively discussed, so we might need it in the 
future, in which case I have to figure out how to fake reliable st_dev and 
st_ino values into our stat() code.

Ciao,
Dscho
