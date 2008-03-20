From: Nicolas Pitre <nico@cam.org>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 23:13:52 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803192228260.2947@xanadu.home>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191910170.2947@xanadu.home>
 <7vd4pq1el3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 04:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcBEm-0004oJ-UN
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 04:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbYCTDNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 23:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbYCTDNy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 23:13:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28568 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYCTDNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 23:13:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JY0008NBEB4FKJ0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 23:13:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vd4pq1el3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77618>

On Wed, 19 Mar 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >On Wed, 19 Mar 2008, Junio C Hamano wrote:
> >
> >> I do not think "very tight" was the reason, but on the other hand, my
> >> personal feeling is that 20 was already 10 too many pack idx files we have
> >> to walk linearly while looking for objects at runtime.
> >
> > Since commit f7c22cc68ccb this is no longer such an issue.
> 
> Notice that I did not say "19 too many".  I know f7c22cc (always start
> looking up objects in the last used pack first, 2007-05-30) was meant to
> alleviate the situation, but isn't "no longer" a gross exaggeration?

Not at all.  Please have a second look at the performance numbers in 
that commit log, and take into accound the most important metric that I 
unfortunately failed to mention there (although I subsequently posted it 
to the list: http://marc.info/?l=git&m=118058197921642&w=2), wich is the 
time to perform the same operation with a single pack.

So you have 17.1 seconds for a single pack vs 18.4 seconds for 66 packs.

Compare that to 24.9s without that patch.

And I still have some further optimizations to implement eventually 
(http://marc.info/?l=git&m=118062793413099&w=2), but which would 
probably make a significant difference only in the hundreds-of-packs 
case anyway.

So I really think that the default gc.autopacklimit could be raised.


Nicolas
