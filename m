From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects
 --compression=N
Date: Fri, 04 May 2007 12:30:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705041218130.24220@xanadu.home>
References: <463802ED.1080200@gmail.com>
 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
 <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
 <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.99.0705040937250.24220@xanadu.home>
 <56b7f5510705040910i3cac723co3aed45034c097def@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 18:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk0fw-0006sJ-WC
	for gcvg-git@gmane.org; Fri, 04 May 2007 18:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031373AbXEDQa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 12:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031033AbXEDQa3
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 12:30:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45818 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031373AbXEDQa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 12:30:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHI003YWZ6OTGC0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 May 2007 12:30:25 -0400 (EDT)
In-reply-to: <56b7f5510705040910i3cac723co3aed45034c097def@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46188>

On Fri, 4 May 2007, Dana How wrote:

> On 5/4/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Thu, 3 May 2007, Junio C Hamano wrote:
> > 
> > > "Dana How" <danahow@gmail.com> writes:
> > >
> > > > So for a 25% increase in blob size I get 33% less elapsed time
> > > > in git-add, all by changing core.compression from -1 to 1.
> > > > I'll definitely take that improvement.  [For the compressible files
> > > > we typically have, using 0 is a bad idea:  the CPU "advantage"
> > > > is swamped out by the time to write a much larger file.]
> > >
> > > The above number is about loose objects, right?
> > >
> > > > Since I don't care [to the same degree] about the responsiveness of
> > > > packing,  I'd rather pack with -1 or better to keep packs small.
> > >
> > > I see.  You are saying that the fact that core.compression is
> > > used also for packing makes the variable less useful.
> > 
> > I think that would make sense to have separate configs for pack and
> > loose object compression.  When not specified they should simply default
> > to core.compression if it exists.  Otherwise I'd suggest that pack
> > compression default level be Z_DEFAULT_COMPRESSION and loose object
> > compression default level be Z_BEST_SPEED.  This would make interactive
> > operations like git-add and git-commit even faster by default.
> 
> I agree with your Z_BEST_SPEED idea.  I did not include it in
> the patch b/c I didn't want to change any behavior in the absence
> of new config settings.
> 
> Are you actually arguing for *3* different compression-related config
> variables?

Yes.

> How about:
> (a) core.compression controls loose objects. defaults to Z_BEST_SPEED.
> (b) pack.compression controls packing. defaults to Z_DEFAULT_COMPRESSION
> if neither variable exists. defaults to core.compression if only that exists

Yes, although I wouldn't default pack.compression to core.compression  
if pack.compression doesn't exist.  The documentation about 
core.compression currently talks 
(wrongly) only about loose objects anyway, so making pack.compression 
stand on its own won't be that bad.


Nicolas
