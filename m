From: Nicolas Pitre <nico@cam.org>
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 09 Jul 2007 15:13:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707091503000.26459@xanadu.home>
References: <20070709044326.GH4087@lavos.net>
 <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707090954550.26459@xanadu.home>
 <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net> <20070709185353.GL4087@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Jul 09 21:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ygK-0005WR-GH
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 21:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbXGITN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbXGITN5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 15:13:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27143 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbXGITN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 15:13:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKX009EVER6QXW0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Jul 2007 15:13:55 -0400 (EDT)
In-reply-to: <20070709185353.GL4087@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52013>

On Mon, 9 Jul 2007, Brian Downing wrote:

> On Mon, Jul 09, 2007 at 09:39:44AM -0700, Junio C Hamano wrote:
> > > OK here it is.  And results on the GIT repo and another patalogical test 
> > > repo I keep around are actually really nice!  Not only the pack itself 
> > > is a bit smaller, but the delta depth distribution as shown by 
> > > git-verify-pack -v is much nicer with the bulk of deltas in the low 
> > > depth end of the spectrum and no more peak at the max depth level.
> > 
> > Looks obviously correct.  Brian, it would be very interesting to
> > see what Nico's patch does to your dataset.
> 
> Nico's patch makes the overall statistics look better, but the
> version.lisp-expr file still goes 593 levels deep, as opposed to about
> 65 with my patch.  (That's better than 980 with stock Git, though.)

Tuning for such an extreme without impacting normal cases is rather 
hard.

My patch was meant to be used on top of yours.  Is that what you tested?

Also I'd suggest you do not use a max depth of 1000.  It is simply 
insane and might possibly make the existing logic less effective.  Even 
for runtime pack access you want it to be reasonably short, say 100 
maximum, or even the current default of 50.  Any improvements you might 
come with (like automatic depth determined on replay cost) should be 
compared with that default which is known to work well already.


Nicolas
