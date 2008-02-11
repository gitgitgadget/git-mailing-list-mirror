From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Mon, 11 Feb 2008 11:00:25 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802111054080.2732@xanadu.home>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
 <alpine.LSU.1.00.0802111519300.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOb5b-0003AR-Qi
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbYBKQA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbYBKQA2
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:00:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64890 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbYBKQA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:00:26 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW3003YA0GP3FB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 11:00:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802111519300.3870@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73545>

On Mon, 11 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 11 Feb 2008, Martin Koegler wrote:
> 
> > What about this not really tested patch for dealing with memory pressure 
> > in git-pack-objects?
> > 
> > It will slow down the repack in the case of memory pressure, but missing 
> > memory will not affect the results.
> 
> It almost helped:
> 
> $ /usr/bin/time git repack -a -d -f --window=250 --depth=250
> Counting objects: 2477715, done.
> fatal: Out of memory, malloc failed411764)
> Command exited with non-zero status 1
> 10050.12user 240.63system 2:53:37elapsed 98%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (29555major+94032945minor)pagefaults 0swaps
> 
> So, it ran longer until it ran out of memory.

What it can do for you is to limit the window memory usage much more 
without affecting the end result, say to 128MB.  Of course the repack is 
then going to progress much slower if active purging of the window 
memory is involved.

If you still run out of memory at that point then there is not much more 
to do besides using a new memory allocator that doesn't suffer as much 
from memory fragmentation, or find the possible memory leak that no one 
else found so far.


Nicolas
