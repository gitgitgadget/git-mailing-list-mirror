From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 21:42:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0708092131030.10711@iabervon.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 03:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJJWO-0008Lm-E3
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 03:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbXHJBmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 21:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbXHJBmd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 21:42:33 -0400
Received: from iabervon.org ([66.92.72.58]:1632 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbXHJBmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 21:42:32 -0400
Received: (qmail 10392 invoked by uid 1000); 10 Aug 2007 01:42:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Aug 2007 01:42:30 -0000
In-Reply-To: <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55497>

On Thu, 9 Aug 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Thu, 9 Aug 2007, Linus Torvalds wrote:
> >> 
> >> So "builtin-read-tree.c" (or rather unpack-trees.c) would need the same 
> >> kind of logic.
> >
> > The path seems to be:
> >
> >   cmd_read_tree ->
> >     unpack_trees ->
> >       unpack_trees_rec ->
> >         [ recursive .. unpack_trees_rec ] ->
> > 	  oneway_merge ->
> > 	    keep_entry ->
> > 	      add_index_entry()
> >
> > and here again we end up having the same insertion sort issue.
> 
> Quite honestly, I was this (shows the "thumb and index finger
> almost touching" gesture) close to declare that unpack-trees is
> unsalvageable, and was planning to redo the one-tree (and
> perhaps two-tree) read-tree without using that mess after 1.5.3.

Yeah, that's probably the right thing to do; I wrote it with the idea that 
we'd be doing many-parent merges with it, but merge-recursive turned out 
to be a better idea, so I designed it to be comprehensible for a 
complicated case we never actually do.

	-Daniel
*This .sig left intentionally blank*
