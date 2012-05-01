From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Tue, 01 May 2012 13:47:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205011342160.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205011259200.21030@xanadu.home>
 <20120501172201.GA23527@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:47:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHAm-00030P-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297Ab2EARrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:47:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40943 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab2EARrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:47:15 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3C009ASUQQ6HC0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2012 13:47:15 -0400 (EDT)
In-reply-to: <20120501172201.GA23527@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196711>

On Tue, 1 May 2012, Jeff King wrote:

> On Tue, May 01, 2012 at 01:17:03PM -0400, Nicolas Pitre wrote:
> 
> > However, this is possibly a good baseline to determine a default value 
> > for window-memory though.  Given your number, we clearly see that good 
> > packing can be achieved with relatively little memory and therefore it 
> > might be a good idea not to leave this parameter unbounded by default in 
> > order to catch potential pathological cases.  Maybe 64M would be a good 
> > default value?  Having a repack process eating up more than 16GB of RAM 
> > because its RAM usage is unbounded is certainly not nice.
> 
> Would that preclude a 65M object from being delta'd at all? If you are
> putting a limit of 64M and it means we look at 50 delta candidates
> instead of 60, then that is probably not going to hurt our size too
> much. But if you have large objects that do happen to delta, the
> difference between looking at 0 and 1 objects could have a big impact.

If I remember correctly (long time ago since I wrote that code) there is 
always a minimum of one object in the search window.  So with 32M 
objects you'd have only 2 candidates, with 33M objects and bigger there 
would be only one candidate.  Obviously the window could still be filled 
with smaller objects if the total object size is less than 64M.


Nicolas
