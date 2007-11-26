From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 17:22:38 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261712400.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
 <alpine.LFD.0.99999.0711261433210.9605@xanadu.home>
 <56b7f5510711261217h56214321xb7acd9851b677dd6@mail.gmail.com>
 <alpine.LFD.0.99999.0711261529080.9605@xanadu.home>
 <56b7f5510711261402s35b77879xdcb2492ea14a1791@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwmWY-00056A-Hd
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 23:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbXKZWde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 17:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbXKZWde
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 17:33:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16015 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbXKZWdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 17:33:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400L3AWTPY2H0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 17:22:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <56b7f5510711261402s35b77879xdcb2492ea14a1791@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66142>

On Mon, 26 Nov 2007, Dana How wrote:

> On Nov 26, 2007 12:55 PM, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 26 Nov 2007, Dana How wrote:
> > > On Nov 26, 2007 11:52 AM, Nicolas Pitre <nico@cam.org> wrote:
> > > > On Mon, 26 Nov 2007, Dana How wrote:
> > > > Then you can do just that for big enough blobs where "big enough" is
> > > > configurable: encapsulate them in a pack instead of a loose object.
> > > > Problem solved.  Sure you'll end up with a bunch of packs containing
> > > > only one blob object, but given that those blobs are so large to be a
> > > > problem in your work flow when written out as loose objects, then they
> > > > certainly must be few enough not to cause an explosion in the number of
> > > > packs.
> > > Are you suggesting that "git add" create a new pack containing
> > > one blob when the blob is big enough?
> > Exactly.
> I will think about your suggestion
> (and the number of packs that might result),
> but I confess I am surprised by it.
> 
> When I proposed automatically extracting large blobs from source
> packs when creating a new pack under a blob size limit while
> pack-objects was running,  you objected on the grounds that
> pack-objects only creates packs and should not create blobs
> (this proposal had other problems too,  but this is the one you didn't like).
> 
> Now it's OK for git-add to sometimes create packs instead of blobs?
> I would not have predicted that!

Going back to loose objects from packs is indeed something I object to 
if it becomes part of a work flow.  Objects should move from the loose 
space towards the packed space and not the other way around.  Sure there 
is fetch.unpackLimit, but with the auto-repack recently added to Git 
this variable could probably be set even lower.

But having a pack created for huge blobs up front has many advantages, 
the most obvious is the fact that later repack can combine and/or send 
those single-blob packs with almost no cost.

Loose objects are meant to be blazingly fast to create.  Once repacked 
they have no advantage being loose again.  Obviously when your blob is 
huge you won't benefit much from a loose object.


Nicolas
