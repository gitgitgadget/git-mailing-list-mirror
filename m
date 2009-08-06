From: Nicolas Pitre <nico@cam.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 05 Aug 2009 21:52:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908052144430.16073@xanadu.home>
References: <20090805181755.22765.qmail@science.horizon.com>
 <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 03:53:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsAG-00079H-Sm
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 03:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZHFBwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 21:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbZHFBwl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 21:52:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12219 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZHFBwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 21:52:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNX0039CM12Y4D1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Aug 2009 21:41:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125017>

On Wed, 5 Aug 2009, Linus Torvalds wrote:

> But while looking at 32-bit issues, I noticed that I really should also 
> cast 'len' when shifting it. Otherwise the thing is limited to fairly 
> small areas (28 bits - 256MB). This is not just a 32-bit problem ("int" is 
> a signed 32-bit thing even in a 64-bit build), but I only noticed it when 
> looking at 32-bit issues.

Even better is to not shift len at all in SHA_update() but shift 
ctx->size only at the end in SHA_final().  It is not like if 
SHA_update() could operate on partial bytes, so counting total bytes 
instead of total bits is all you need.  This way you need no cast there 
and make the code slightly faster.


Nicolas
