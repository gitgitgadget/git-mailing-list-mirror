From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 09:13:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610180902580.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
 <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
 <7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610172209070.1971@xanadu.home>
 <7v64eii7hh.fsf@assigned-by-dhcp.cox.net>
 <7vu022gqji.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610181159050.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 15:13:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaBEO-0004w7-OT
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 15:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWJRNNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 09:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWJRNNJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 09:13:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23660 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030279AbWJRNNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 09:13:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00CR621SCT61@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 09:13:05 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0610181159050.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29232>

On Wed, 18 Oct 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 17 Oct 2006, Junio C Hamano wrote:
> 
> > +/*
> > + * Even if sizeof(union delta_base) == 24 on 64-bit archs, we really want
> > + * to memcmp() only the first 20 bytes.
> > + */
> > +#define UNION_BASE_SZ	20
> 
> Excuse me for joining the game, but why don't you just use the 
> recently introduced hashcmp() for that purpose? AFAIU you do exactly that, 
> you compare hashes.

Yes, and that is what I did originally.

But that could lead to false assumptions (and this thread already proved 
this code has its share of false assumption leads already).  The thing 
is that the memory chunk that is being compared is not always the same 
kind of hash as usually used with hashcmp().  Throughout the code 
hashcmp() is always used with a 20-byte sha1 digest.  In this case it 
can be either a 20-byte sha1 digest, or a long offset value.  And by 
using hashcmp() I would be afraid someone else could assume the hash is 
always a sha1 digest which it is not.


Nicolas
