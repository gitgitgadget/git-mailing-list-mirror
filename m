From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 15:00:14 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
 <20070815171152.GA15155@auto.tuwien.ac.at>
 <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILO6a-0006KO-14
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 21:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbXHOTAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 15:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXHOTAV
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 15:00:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39665 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbXHOTAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 15:00:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMT00EI1WSE7IR0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Aug 2007 15:00:15 -0400 (EDT)
In-reply-to: <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55937>

On Wed, 15 Aug 2007, Jon Smirl wrote:

> On 8/15/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > git-pack-objects knows the order, in which it will use the objects.  A
> > seperate thread could pre-read the next object and wait until the main
> > thread starts processing it. After the read is complete, another
> > thread could start computing the delta index.
> 
> The hope is that the new adaptive read ahead code in the kernel will
> get this right and you won't need the second thread. Letting the
> kernel handle the read ahead will dynamically scale as other demands
> are made on the host. There's effectively only one read ahead cache in
> the system, only the kernel really knows how to divide it up between
> competing apps.

No read ahead will ever help the delta search phase.  Objects listed for 
deltification against each other are sorted in a way that results in 
reads from completely random location in the object store.

Normally the delta search phase is so compute intensive that the read 
shouldn't matter much.


Nicolas
