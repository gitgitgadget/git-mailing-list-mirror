From: Nicolas Pitre <nico@cam.org>
Subject: Re: Initial push of a fully packed repo - why repack?
Date: Mon, 16 Apr 2007 22:49:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704162235350.4504@xanadu.home>
References: <46a038f90704161812r143b6d27scbcc401ee77c4597@mail.gmail.com>
 <alpine.LFD.0.98.0704162215520.4504@xanadu.home>
 <46a038f90704161928q4597c97ajd33106f119516328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 04:49:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hddkp-0004aU-Jw
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 04:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031056AbXDQCtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 22:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031057AbXDQCtM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 22:49:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64406 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031056AbXDQCtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 22:49:11 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGM00AE7FTYNCG0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 22:49:11 -0400 (EDT)
In-reply-to: <46a038f90704161928q4597c97ajd33106f119516328@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44712>

On Tue, 17 Apr 2007, Martin Langhoff wrote:

> On 4/17/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 17 Apr 2007, Martin Langhoff wrote:
> > > Does it make sense to detect and optimise for this case?
> > Maybe...  Although the second repack during the push should be much much
> > faster than the first one.
> 
> It is - but it still burns through perhaps 1 minute of CPU and IO
> rewriting the exact same pack as you can see:

Sure.  On the IO you can't save.  You'll have to copy the packanyway and 
with all objects being "reused" the pack-objects code is basically not 
doing much more than a straight cp would do.

What is costly is figuring out if the single pack you have actually
contains all the objects you wish to push, and _only_ the objects you 
wish to push.  That is the real cost.  By the time all those objects are 
listed and accounted then repacking is basically copying the data 
over with almost no CPU usage.  In other words, the cost to determine if 
it is OK to simply send the pack you already have and actually 
sending it would be sensibly the same.


Nicolas
