From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 10/12] notes.c: Implement simple memory pooling of leaf
 nodes
Date: Thu, 27 Aug 2009 11:49:10 +0200
Message-ID: <200908271149.11003.johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <1251337437-16947-11-git-send-email-johan@herland.net>
 <81b0412b0908270039l7a937c3bmd745274c71526ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, gitster@pobox.com,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 11:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgbcN-0002ZW-IS
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 11:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbZH0Jt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 05:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbZH0Jt5
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 05:49:57 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54728 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752032AbZH0Jt5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 05:49:57 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP100BH54NAAR70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 11:49:58 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP100BWT4LZQ540@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 11:49:58 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.93616
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <81b0412b0908270039l7a937c3bmd745274c71526ce1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127150>

On Thursday 27 August 2009, Alex Riesen wrote:
> On Thu, Aug 27, 2009 at 03:43, Johan Herland<johan@herland.net> wrote:
> > When allocating a new memory pool, the older pool is leaked, but this
> > is no worse than the current situation, where (pretty much) all
> > leaf_nodes are leaked anyway.
>
> Could you return the unused nodes back into the mempool?
> By making the pool a preallocated list, perhaps?

Yes, maintaining a free-list is certainly possible. However, the number of 
free()d leaf_nodes is relatively small (only subtree entries are free()d 
after unpacking them into the tree structure), so I'm not sure it pays off, 
runtime-wise.

> And then it is trivial to provide a deallocation function for the
> mempool, which something really concerned about the memleak can call
> (like when or if libgit get more usable in an application context).

Yes, I plan to provide a free_notes() function that free()s all the memory 
associated with the notes data structure. This would of course keep 
references to all the mempools, and deallocate them (along with all the 
int_nodes).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
