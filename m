From: Nicolas Pitre <nico@cam.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Tue, 20 Mar 2007 11:23:01 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703201113180.18328@xanadu.home>
References: <200702281036.30539.litvinov2004@gmail.com>
 <200703191932.26856.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703190804350.6730@woody.linux-foundation.org>
 <200703201013.39169.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703192212280.6730@woody.linux-foundation.org>
 <7vd5349x97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:23:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTgB3-0007Qt-11
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933764AbXCTPXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbXCTPXE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:23:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65532 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933779AbXCTPXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:23:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF7007ALK2DO570@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 11:23:02 -0400 (EDT)
In-reply-to: <7vd5349x97.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42743>

On Tue, 20 Mar 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > But to really look at this we should probably add a "really_careful" flag 
> > that actually re-verifies the SHA1 on read so that we'd catch these kinds 
> > of corruptions early. 
> > ...
> > I'm hoping somebody has any ideas. We really *could* check the SHA1 on 
> > each read (and slow down git a lot) and that would catch corruption much 
> > faster and hopefully pinpoint it more quickly where exactly it happens. 
> 
> At least, we could do something like this to catch the breakage
> when we (re)pack, to prevent damage from propagating.

I think it would be better to retest the SHA1 when we're about to 
_write_ the object out to the pack, replacing check_pack_inflate() and 
revalidate_loose_object() with the full SHA1 check, and testing objects 
which data isn't reused from a pack too.  And make it conditional on 
!pack_to_stdout like we already do of course.


Nicolas
