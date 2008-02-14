From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 19:20:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141917420.30505@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <alpine.LSU.1.00.0802101640570.11591@racer.site> <alpine.LSU.1.00.0802101845320.11591@racer.site>
 <alpine.LSU.1.00.0802122036150.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 20:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPje2-0001gg-Fa
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 20:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981AbYBNTUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 14:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757841AbYBNTUn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 14:20:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:47883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757701AbYBNTUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 14:20:42 -0500
Received: (qmail invoked by alias); 14 Feb 2008 19:20:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 14 Feb 2008 20:20:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tWUFlBwwtfRdkPDFhJxLt3r1mPA0eVZh+HnkdQZ
	zjwUa8Uu79yNgn
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802122036150.3870@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73907>

Hi,

On Tue, 12 Feb 2008, Johannes Schindelin wrote:

> On Sun, 10 Feb 2008, Johannes Schindelin wrote:
> 
> > $ /usr/bin/time git repack -a -d -f --window=150 --depth=150
> > Counting objects: 2477715, done.
> > Compressing objects:  19% (481551/2411764)
> > Compressing objects:  19% (482333/2411764)
> > fatal: Out of memory, malloc failed411764)
> > Command exited with non-zero status 1
> > 7118.37user 54.15system 2:01:44elapsed 98%CPU (0avgtext+0avgdata 
> > 0maxresident)k
> > 0inputs+0outputs (29834major+17122977minor)pagefaults 0swaps
> 
> I made the window much smaller (512 megabyte), and it still runs, after 27 
> hours:
> 
> Compressing objects:  20% (484132/2411764)
> 
> However, it seems that it only worked on about 4000 objects in the last 
> 20(!) hours.  So, the first 19% were relatively quick.  The next percent 
> not at all.

Finally!

I updated to newest git+patches (git version 1.5.4.1.1353.g0d5dd), reset 
windowMemory to 512m and restarted the process:

$ /usr/bin/time git repack -a -d -f --window=250 --depth=250
Counting objects: 2477715, done.
Compressing objects: 100% (2411764/2411764), done.
Writing objects: 100% (2477715/2477715), done.
Total 2477715 (delta 1876242), reused 0 (delta 0)
21733.55user 175.32system 6:10:37elapsed 98%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (81921major+63880453minor)pagefaults 0swaps

A little over 6 hours, with one core (of the four available).  Not bad, I 
say.

The result is:

$ ls -la objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
-rwxrwxrwx 1 root root 1638490531 2008-02-14 17:51 
objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack

1.6G looks much better than 2.4G, wouldn't you say?  Jan, if you want it, 
please give me a place to upload it to.

Ciao,
Dscho
