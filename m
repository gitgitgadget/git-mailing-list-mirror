From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access candidates
Date: Thu, 13 Aug 2009 16:13:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908131603240.10633@xanadu.home>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
 <alpine.LFD.2.01.0908130934400.28882@localhost.localdomain>
 <alpine.LFD.2.00.0908131304520.10633@xanadu.home>
 <7v63crbja2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbgq6-00081p-0Z
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbZHMUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbZHMUN2
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:13:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54687 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbZHMUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:13:23 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOC00DA4064GIO0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Aug 2009 16:13:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v63crbja2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125866>

On Thu, 13 Aug 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > As it is now, I was about to suggest:
> >
> > 	git mv block-sha1/sha1.[ch] .
> > 	rmdir block-sha1
> > 	rm -r mozilla-sha1
> > 	rm -r arm
> > 	rm -r ppc 
> >
> > and remove support for openssl's SHA1 usage, making this implementation 
> > unconditional.  After all it is faster, or so close to be faster than 
> > the alternatives, that we should probably cut on the extra dependency 
> > and simplify portability issues at the same time.
> 
> Wow.  Is it now faster than the arm/ and ppc/ hand-tweaked assembly?

It is indeed faster than the ARM assembly version by far, and faster 
than all the alternative implementations too, but with a 7x increase in 
compiled code size.  In the context of Git I think this is a good 
compromize.  Making the assembly version faster than the C version could 
be possible, but that would require quite some work and I don't expect 
the gain to be significant, certainly not worth the trouble.

Furthermore the C version can be used to generate ARM Thumb code while 
the asm version cannot without yet more work.


Nicolas
