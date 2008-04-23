From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 21:05:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804232104160.20267@eeepc-johanness>
References: <> <1208979757-30860-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:06:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JolEJ-00069E-5r
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 22:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbYDWUFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 16:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbYDWUFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 16:05:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:45641 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752762AbYDWUFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 16:05:24 -0400
Received: (qmail invoked by alias); 23 Apr 2008 20:05:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp016) with SMTP; 23 Apr 2008 22:05:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LPqQQyQkLioyIQCqV84hxckefuiA8Vw1r5GAnHw
	hwytLMlOUzT/FP
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1208979757-30860-1-git-send-email-apenwarr@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80254>

Hi,

On Wed, 23 Apr 2008, Avery Pennarun wrote:

> From: Jeff King <peff@peff.net>
> 
> On Tue, Apr 22, 2008 at 12:51:14PM -0400, Avery Pennarun wrote:
> 
> > Do you think git would benefit from having a generalized version of
> > this script?  Basically, the user provides a "munge" script on the
> > command line, and there's a git-filter-branch mode for auto-munging
> > (with a cache) every file in every checkin.  Even if it's *only* ever
> > used for CRLF, I can imagine this being useful to a lot of people.
> 
> It was easy enough to work up the patch below, which allows
> 
>   git filter-branch --blob-filter 'tr a-z A-Z'
> 
> However, it's _still_ horribly slow. Shell script is nice and flexible,
> but running a tight loop like this is just painful. I suspect
> filter-branch in something like perl would be a lot faster and just as
> flexible (you could even do it in C, but you'd probably have to invent a
> little domain-specific scripting language).
> 
> It is still much better performance than a tree filter, though:
> 
>   $ cd git && time git filter-branch --tree-filter '
>       find . -type f | while read f; do
>         tr a-z A-Z <"$f" >tmp
>         mv tmp "$f"
>       done
>     ' HEAD~10..HEAD
> 
>   real    4m38.626s
>   user    1m32.726s
>   sys     2m51.163s
> 
>   $ cd git && git filter-branch --blob-filter 'tr a-z A-Z' HEAD~10..HEAD
>   real    1m40.809s
>   user    0m36.822s
>   sys     1m14.273s
> 
> Lots of system time in both. I'm sure we spend a fair bit of time
> hitting our very large map and blob-cache directories, which would be
> much more nicely implemented as associative arrays in memory (if we were
> using a more featureful language).
> 
> Anyway, here is the patch. I don't know if it is even worth applying,
> since it is still painfully slow.

Not all of this belongs in the commit messaage.

> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This does.

A good general rule is: if you think it would be funny/strange to read 
this message in the output of "git log", it should be changed.

Ciao,
Dscho
