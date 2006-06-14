From: Nicolas Pitre <nico@cam.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 15:25:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606141514000.2703@localhost.localdomain>
References: <1150269478.20536.150.camel@neko.keithp.com>
 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
 <1150307715.20536.166.camel@neko.keithp.com>
 <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
 <1150311567.30681.28.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 21:25:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqazQ-0007D3-0z
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWFNTZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 15:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWFNTZQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 15:25:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51438 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750826AbWFNTZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 15:25:15 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0V004OH7A2NBC0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Jun 2006 15:25:14 -0400 (EDT)
In-reply-to: <1150311567.30681.28.camel@neko.keithp.com>
X-X-Sender: nico@localhost.localdomain
To: Keith Packard <keithp@keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21854>

On Wed, 14 Jun 2006, Keith Packard wrote:

> On Wed, 2006-06-14 at 11:18 -0700, Linus Torvalds wrote:
> 
> > You don't _need_ to shuffle. As mentioned, it will only affect the 
> > location of the data in the pack-file, which in turn will mostly matter 
> > as an IO pattern thing, not anything really fundamental.  If the pack-file 
> > ends up caching well, the IO patterns obviously will never matter.
> 
> Ok, sounds like shuffling isn't necessary; the only benefit packing
> gains me is to reduce the size of each directory in the object store;
> the process I follow is to construct blobs for every revision, then just
> use the sha1 values to construct an index for each commit. I never
> actually look at the blobs myself, so IO access patterns aren't
> relevant.
> 
> Repacking after the import is completed should undo whatever horror show
> I've created in any case.

The only advantage of feeding object names from latest to oldest has to 
do with the delta direction.  In doing so the delta are backward such 
that objects with deeper delta chain are further back in history and 
this is what you want in the final pack for faster access to the latest 
revision.

Of course the final repack will do that automatically, but only if you 
use -a -f with git-repack.  But when -f is not provided then already 
deltified objects from other packs are copied as is without any delta 
computation making the repack process lots faster.  In that case it 
might be preferable that the reuse of already deltified data is made of 
backward delta which is the reason you might consider feeding object in 
the prefered order up front.


Nicolas
