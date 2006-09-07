From: Nicolas Pitre <nico@cam.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 22:47:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609062231070.18635@xanadu.home>
References: <44FF41F4.1090906@gmail.com>
 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
 <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
 <7v1wqo5vlz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 04:47:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL9vW-0003O9-96
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 04:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWIGCrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 22:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWIGCrJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 22:47:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52855 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750709AbWIGCrG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 22:47:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J57006UTBQHJK68@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Sep 2006 22:47:05 -0400 (EDT)
In-reply-to: <7v1wqo5vlz.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26588>

On Wed, 6 Sep 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > BTW I'm half-way done with support for deltas which base object is 
> > referenced with an offset in the pack instead of a hash.  It is quite 
> > messy though since it touches pretty core code all over the place when 
> > it comes to fetching objects out of a pack.
> 
> I wonder how you made unpack-objects to work with it.  Do you
> store an extra bit in the packed stream to say "this object will
> be used as a delta base for later objects so remember its offset
> and resulting SHA1", or do you just remember every entry as you
> unpack?

Every entries.  Much simpler that way.

And the client must ask explicitly whether or not a fetched pack can 
have base objects referenced by sha1 or offset.  So if you're really 
really tight on memory (like if you cannot afford the extra 50MB of RAM 
or so for the Mozilla repo for example) then this could be turned off.

But if we decide to not explode packs upon a fetch but keep the 
downloaded pack as is (after validation) then index generation will come 
for free.


Nicolas
