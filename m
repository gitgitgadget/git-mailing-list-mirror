From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 23:06:57 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142306130.12484@xanadu.home>
References: <20080713011512.GB31050@spearce.org>
 <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <alpine.LFD.1.10.0807132220570.12484@xanadu.home>
 <20080714031242.GA14542@spearce.org>
 <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
 <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se>
 <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se>
 <alpine.LFD.1.10.0807142203530.12484@xanadu.home>
 <20080715024741.GB1700@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIatm-0006sr-4d
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761394AbYGODHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761997AbYGODHB
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:07:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60269 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761986AbYGODG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:06:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100DQB1ZLK9B0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 23:06:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080715024741.GB1700@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88508>

On Tue, 15 Jul 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > 
> > Those delta chains aren't simple chained lists.  They are trees of 
> > deltas where one object might be the base for an unlimited number of 
> > deltas of depth 1, and in turn each of those deltas might constitute the 
> > base for an unlimited number of deltas of depth 2, and so on.
> > 
> > So what the code does is to find out which objects are not deltas but 
> > are the base for a delta.  Then, for each of them, all deltas having 
> > given object for base are found and they are recursively resolved so 
> > each resolved delta is then considered a possible base for more deltas, 
> > etc.  In other words, those deltas are resolved by walking the delta 
> > tree in a "depth first" fashion.
> > 
> > If we discard previous delta bases, we will have to recreate them each 
> > time a delta sibling is processed.  And if those delta bases are 
> > themselves deltas then you have an explosion of delta results to 
> > re-compute.
> 
> Yes, it would be horrible if we had to recompute 10 deltas in order
> to recover a previously discarded delta base in order to visit new
> siblings.
> 
> But its even more horrible that we use 512M of memory in our working
> set size on a 256M machine to process a pack that is only 300M in
> size, due to long delta chains on large objects.  In such a case
> the system will swap and perform fairly poorly due to the huge disk
> IO necessary to keep moving the working set around.
> 
> We're better off keeping our memory usage low and recomputing
> the delta base when we need to return to it to process a sibling.

Please relax!  ;-)

And have a look in your mbox.


Nicolas
