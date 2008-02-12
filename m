From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 16:05:42 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802121553120.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz>
 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
 <alpine.LSU.1.00.0802101640570.11591@racer.site>
 <alpine.LSU.1.00.0802101845320.11591@racer.site>
 <alpine.LSU.1.00.0802122036150.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2Kp-0005kP-Ts
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163AbYBLVFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756577AbYBLVFw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:05:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45960 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175AbYBLVFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:05:51 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW5008RR99I5G11@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 16:05:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802122036150.3870@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73690>

On Tue, 12 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
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

Yeah... this repo is really a pain to repack.  I have access to a 
8-processor machine with 8GB of ram and all my repack attempts so far 
were killed after using too much memory, despite the window memory 
limit.  Those were threaded repack attempts, so the first 98% was really 
quick, like less than 15 minutes, but then all threads converged on this 
small fraction of the object space which appears to cause problems.  
And then I'm presuming I ran into the same threaded memory fragmentation 
issue.  Might be worth attaching gdb to it and extract a sample of the 
object SHA1's populating the delta window when the slowdown occurs to 
see what they actually are...

I'm attempting a single-threaded repack now.


Nicolas
