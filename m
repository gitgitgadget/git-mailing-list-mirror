From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 15:35:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 15:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBu5P-0003pa-AQ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 15:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435AbXA3Ofs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 09:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965506AbXA3Ofs
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 09:35:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:58041 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965435AbXA3Ofr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 09:35:47 -0500
Received: (qmail invoked by alias); 30 Jan 2007 14:35:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 30 Jan 2007 15:35:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38156>

Hi,

On Mon, 29 Jan 2007, Linus Torvalds wrote:

> Can you elaborate about any performance differences, especially with 
> cygwin? Does this make git perform reasonably on Windows, or are the 
> performance problems as bad as with cygwin?

On the git repository, using MinGW:

	$ time git-rev-list next > /dev/null

	real    0m0.320s
	user    0m0.031s
	sys     0m0.000s

	$ time git-rev-list next > /dev/null

	real    0m0.320s
	user    0m0.015s
	sys     0m0.015s

	$ time git-rev-list next > /dev/null

	real    0m0.352s
	user    0m0.015s
	sys     0m0.000s

Using cygwin:

	$ time git-rev-list next > /dev/null

	real    0m0.750s
	user    0m0.421s
	sys     0m0.140s

	$ time git-rev-list next > /dev/null

	real    0m0.750s
	user    0m0.374s
	sys     0m0.233s

	$ time git-rev-list next > /dev/null

	real    0m0.750s
	user    0m0.374s
	sys     0m0.218s

IOW MinGW wins hands down with an average 0.33s vs cygwin with an average 
0.75s. (I am fairly certain that you must not trust sys times.)

I have no idea why, as the big show-stopper fork() is not even involved.

Now, for something different: git-log. On MinGW:

	$ time git-log next > /dev/null

	real    0m1.594s
	user    0m0.015s
	sys     0m0.015s

	$ time git-log next > /dev/null

	real    0m1.562s
	user    0m0.031s
	sys     0m0.000s

	$ time git-log next > /dev/null

	real    0m1.610s
	user    0m0.015s
	sys     0m0.015s

On Cygwin:

	$ time git-log next > /dev/null

	real    0m2.063s
	user    0m0.827s
	sys     0m1.031s

	$ time git-log next > /dev/null

	real    0m2.085s
	user    0m0.780s
	sys     0m1.061s

	$ time git-log next > /dev/null

	real    0m2.047s
	user    0m0.686s
	sys     0m1.171s

That's a bit less obvious: 1.589s for MinGW vs. 2.065s for Cygwin.

These are all hot-cache numbers, since the cold-cache performance 
of Windows is not easily triggered. (FWIW the first git-log on Cygwin -- 
which was cold-cache -- took over 10 seconds.)

Ciao,
Dscho
