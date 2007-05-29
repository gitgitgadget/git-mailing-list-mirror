From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] super indexes to span multiple packfiles
Date: Tue, 29 May 2007 12:19:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705291210130.11491@xanadu.home>
References: <20070529071622.GA8905@spearce.org>
 <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Dana How <danahow@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 18:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht4Pu-0000kp-8e
	for gcvg-git@gmane.org; Tue, 29 May 2007 18:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbXE2QTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 12:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbXE2QTR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 12:19:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27956 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbXE2QTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 12:19:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIT00F179C2GMA0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 May 2007 12:19:14 -0400 (EDT)
In-reply-to: <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48700>

On Tue, 29 May 2007, Jon Smirl wrote:

> Object's are not accessed in random order with git. Once an object
> reference hits a pack file it is very likely that following references
> will hit the same pack file. That's because you always find object
> SHA's by following the chains.
> 
> So first place to look for an object is the same place the previous
> object was found. If it isn't there order the search of the pack files
> by creation data (just a heuristic). Make this list a circle and start
> the search in the pack where the previous object was found. This can
> all be done with the existing indexes.
> 
> I haven't been reading all of the messages on this subject, but is
> this strategy enough to eliminate the need for a super index?

I think it could.

Personally I'm not a big fan of the super index notion.  It needs extra 
maintenance to keep in synch, and when it is not in synch it requires 
extra work at run time to fall back to traditional lookup.  And Shawn's 
testing didn't provide significant performance gains either.

But a simple heuristic like the presumption that the next object is 
likely to be in the same pack as the previous is the kind of thing that 
could provide significant improvements with really little effort.


Nicolas
