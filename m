From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Sun, 17 Feb 2008 22:16:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172210470.30505@racer.site>
References: <871w7bz1ly.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQrpT-0004bN-9G
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133AbYBQWRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbYBQWRA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:17:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:50156 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754586AbYBQWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:16:59 -0500
Received: (qmail invoked by alias); 17 Feb 2008 22:16:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 17 Feb 2008 23:16:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18I4RAdzJwIlZDfR94KqhgsC8eTKoIquSAozxYmr7
	gN27jxvMsY4YlA
X-X-Sender: gene099@racer.site
In-Reply-To: <871w7bz1ly.fsf@rho.meyering.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74196>

Hi,

On Sun, 17 Feb 2008, Jim Meyering wrote:

> It is equivalent not just because POSIX has required free(NULL) to work 
> for a long time, but simply because it has worked for so long that no 
> reasonable porting target fails the test. Here's some evidence from 
> nearly 1.5 years ago:
> 
>     http://www.winehq.org/pipermail/wine-patches/2006-October/031544.html

>From this mail, we see that there is at least one target where this leads 
to a crash (remember, git should run on more platforms than Wine).

However, such a crash is pretty obvious in our test-suite, I guess, and 
thus we could easily introduce something like this into git-compat-util.h 
should the need ever arise:

#ifdef FREE_NULL_CRASHES
inline void gitfree(void *ptr)
{
	if (ptr)
		free(ptr);
}
#define free gitfree
#endif

IOW I like that type of cleanup.

FWIW I tested MinGW (which is the only system I have access to that I 
suspect of misbehaving), and it groks free(NULL) just fine.

Ciao,
Dscho
