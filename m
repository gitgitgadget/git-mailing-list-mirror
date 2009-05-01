From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Fri, 01 May 2009 15:32:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905011522580.6741@xanadu.home>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
 <m3ocugod96.fsf@localhost.localdomain>
 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
 <20090430142244.GA23550@coredump.intra.peff.net>
 <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
 <20090501190854.GA13770@coredump.intra.peff.net>
 <alpine.DEB.1.10.0905011211080.15782@asgard>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri May 01 21:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzyTW-0005SI-IL
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 21:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759007AbZEATc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 15:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756075AbZEATc3
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 15:32:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29324 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152AbZEATc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 15:32:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIZ007M6CXU7IH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 May 2009 15:32:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.10.0905011211080.15782@asgard>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118093>

On Fri, 1 May 2009, david@lang.hm wrote:

> the key thing for his problem is the support for large binary objects. there
> was discussion here a few weeks ago about ways to handle such things without
> trying to pull them into packs. I suspect that solving those sorts of issues
> would go a long way towards closing the gap on this workload.
> 
> there may be issues in doing a clone for repositories that large, I don't
> remember exactly what happens when you have something larger than 4G to send
> in a clone.

If you have files larger than 4G then you definitively need a 64-bit 
machine with plenty of RAM for git to at least be able to cope at the 
moment.

That should be easy to add a config option to determine how big is a big 
file, and store those big files directly in a pack of their own instead 
of a loose object (for easy pack reuse during a further repack), and 
never attempt to deltify them, etc. etc.  At which point git will handle 
big files just fine even on a 32-bit machine but it won't do more than 
copying them in and out, and possibly deflating/inflating them while at 
it, but nothing fancier.


Nicolas
