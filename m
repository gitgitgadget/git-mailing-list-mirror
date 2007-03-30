From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Packing large repositories
Date: Fri, 30 Mar 2007 09:01:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
 <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
 <20070330062324.GU13247@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 15:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXGjP-0001pC-KE
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 15:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbXC3NBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 09:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXC3NBY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 09:01:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28604 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbXC3NBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 09:01:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFP00M1CW6AQZ90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 30 Mar 2007 09:01:23 -0400 (EDT)
In-reply-to: <20070330062324.GU13247@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Mar 2007, Shawn O. Pearce wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Wed, 28 Mar 2007, Dana How wrote:
> > > Of course this is unusable, since object_entry's in an .idx
> > > file have only 32 bits in their offset fields.  I conclude that
> > > for such large projects,  git-repack/git-pack-objects would need
> > > new options to control maximum packfile size.
> > 
> > Either that, or update the index file format. I think that your approach 
> > of having a size limiter is actually the *better* one, though. 
> 
> Nico and I were hoping we could push the index file format change back
> until pack v4 was also worthy of merging.  So I had also started work
> on an index-pack splitter:
> 
>   URL:    git://repo.or.cz/git/fastimport.git
>   Branch: sp/splitpack
>  
> Its far from complete.

Well... actually I really think the best solution might simply be a new 
index format right now.  All the preparatory work has been done already 
anyway.

IMHO that's the solution that would require the least work at this 
point, with the least possibility of issues/bugs.

Pack v4 could just use an index v3 which would be almost the same as 
index v2.

Remains only to determine what this new index format should look like.  
I think that the SHA1 table and the offset table should be separate.  
For one it will require less mmap space to binary search through 
the SHA1 table, and it will make things much easier if pack v4 stores 
the SHA1 table itself.


Nicolas
