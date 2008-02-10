From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 18:47:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101845320.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <alpine.LSU.1.00.0802101640570.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 19:48:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOHEB-0002jD-VV
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 19:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYBJSrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 13:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYBJSrj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 13:47:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:40921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754168AbYBJSrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 13:47:32 -0500
Received: (qmail invoked by alias); 10 Feb 2008 18:47:30 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 10 Feb 2008 19:47:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hUsgTCaehmrJV8aadYxPj/Xjh0/fu5mfDTtwil/
	fgI57k9pDLEWed
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802101640570.11591@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73388>

Hi,

On Sun, 10 Feb 2008, Johannes Schindelin wrote:

> On Sat, 9 Feb 2008, Nicolas Pitre wrote:
> 
> > On Sat, 9 Feb 2008, Jan Holesovsky wrote:
> > 
> > > On Friday 08 February 2008 20:00, Jakub Narebski wrote:
> > > 
> > > > Both Mozilla import, and GCC import were packed below 0.5 GB. 
> > > > Warning: you would need machine with large amount of memory to 
> > > > repack it tightly in sensible time!
> > > 
> > > As I answered elsewhere, unfortunately it goes out of memory even on 
> > > 8G machine (x86-64), so...  But still trying.
> > 
> > Try setting the following config variables as follows:
> > 
> > 	git config pack.deltaCacheLimit 1
> > 	git config pack.deltaCacheSize 1
> > 	git config pack.windowMemory 1g
> > 
> > That should help keeping memory usage somewhat bounded.
> 
> I tried that:
> 
> $ git config pack.deltaCacheLimit 1
> $ git config pack.deltaCacheSize 1
> $ git config pack.windowMemory 2g
> $ #/usr/bin/time git repack -a -d -f --window=250 --depth=250
> $ du -s objects/
> 2548137 objects/
> $ /usr/bin/time git repack -a -d -f --window=250 --depth=250
> Counting objects: 2477715, done.
> fatal: Out of memory, malloc failed411764)
> Command exited with non-zero status 1
> 9356.95user 53.33system 2:38:58elapsed 98%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (31929major+18088744minor)pagefaults 0swaps
> 
> Note that this is on a 2.4GHz Quadcode CPU with 3.5GB RAM.
> 
> I'm retrying with smaller values, but at over 2.5 hours per try, this is 
> getting tedious.

Now, _that_ is strange.  Using 150 instead of 250 brings it down even 
quicker!

$ /usr/bin/time git repack -a -d -f --window=150 --depth=150
Counting objects: 2477715, done.
Compressing objects:  19% (481551/2411764)
Compressing objects:  19% (482333/2411764)
fatal: Out of memory, malloc failed411764)
Command exited with non-zero status 1
7118.37user 54.15system 2:01:44elapsed 98%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (29834major+17122977minor)pagefaults 0swaps

(I hit the Return key twice during the time I suspected it would go out of 
memory, so it might have been really at 20%.)

Ideas?

Ciao,
Dscho
