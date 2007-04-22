From: Nicolas Pitre <nico@cam.org>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 14:47:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704221443070.28339@xanadu.home>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
 <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
 <7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
 <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221422250.28339@xanadu.home>
 <7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221431430.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfh6p-0004sh-RN
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXDVSr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbXDVSrw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:47:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62675 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbXDVSrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:47:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGW00B00XIPJB10@VL-MH-MR002.ip.videotron.ca>; Sun,
 22 Apr 2007 14:47:13 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0704221431430.28339@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45264>

On Sun, 22 Apr 2007, Nicolas Pitre wrote:

> On Sun, 22 Apr 2007, Junio C Hamano wrote:
> 
> > Nicolas Pitre <nico@cam.org> writes:
> > 
> > > On Sun, 22 Apr 2007, Junio C Hamano wrote:
> > >
> > >> With recent glibc, mkstemp() creates 0400 file.  Updated
> > >> pack-objects uses it in pack/idx writing without fixing this,
> > >> hence this problem.
> > >
> > > Oops.  I guess I'm guilty for this.  I didn't bother looking at the 
> > > permission on the pack for git-pack-objects since git-repack seemed to 
> > > take care of that.  But it only _remove_ write permissions.
> > 
> > Ok, then probably we can change the 0444 in my "quickfix" patch
> > to 0644.  That should also let the 5300 test pass.
> 
> Well, actually there is no point making pack files writable.  If they're 
> modified, they get corrupted.

OK there are those test cases.

Well...  Either we chmod to 0644, or we fix the tests to 'chmod +w' like 
it is already done in t5302.

In any case I wouldn't die() but only error() on a failure to chmod().  
It is sure inconvenient if the pack isn't world readable, but it is not 
a "fatal" problem for the repack.


Nicolas
