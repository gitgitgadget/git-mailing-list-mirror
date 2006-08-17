From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 14:24:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608171416030.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org>
 <Pine.LNX.4.64.0608171233370.11359@localhost.localdomain>
 <9e4733910608171103j545a7fd5x2b61b97376de04be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 20:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDmY7-0004av-BY
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 20:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWHQSY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWHQSY4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 14:24:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28900 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932567AbWHQSYz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 14:24:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4500BRZN5IJN70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Aug 2006 14:24:55 -0400 (EDT)
In-reply-to: <9e4733910608171103j545a7fd5x2b61b97376de04be@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25602>

On Thu, 17 Aug 2006, Jon Smirl wrote:

> On 8/17/06, Nicolas Pitre <nico@cam.org> wrote:
> > We're streaving for optimal data storage here so don't be afraid to use
> > one of the available types for an "object stream" object.  Because when
> > you think of it, the deflating of multiple objects into a single zlib
> > stream can be applied to all object types not only deltas.  If ever
> > deflating many blobs into one zlib stream is dimmed worth it then the
> > encoding will already be ready for it.  Also you can leverage existing
> > code to write headers, etc.
> 
> Here are two more case that need to be accounted for in the packs.
> 
> 1) If you zip something and it gets bigger. We need an entry that just
> stores the object without it being zipped. Zipping jpegs or mpegs will
> likely make them significantly bigger. Or does zlib like already
> detect this case and do a null compression?

zlib appears to do the right thing here.

> 2) If you delta something and the delta is bigger than the object
> being deltaed. The delta code should detect this and store the full
> object instead of the delta. Again jpegs and mpegs will trigger this.
> You may even want to say that the delta has to be smaller than 80% of
> the full object.

I'd invite you to read te try_delta() code in 
[builtin-]builtin-pack-objects.c.  You might find that we're already way 
more agressive than that with rather simple heuristics that have been 
tweaked and tuned for over a year now.  The commit logs for that file 
(before the rename to builtin-pack-objects.c) is also quite 
enlightening.


Nicolas
