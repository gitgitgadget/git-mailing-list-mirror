From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] http clone does not checkout working tree
Date: Wed, 4 Jun 2008 15:59:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806041535230.19665@iabervon.org>
References: <20080604183858.GA7095@sigill.intra.peff.net> <alpine.LFD.1.10.0806041145170.3473@woody.linux-foundation.org> <alpine.LFD.1.10.0806041222300.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3z9q-000107-5W
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759597AbYFDT7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759430AbYFDT7h
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:59:37 -0400
Received: from iabervon.org ([66.92.72.58]:55097 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174AbYFDT7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:59:36 -0400
Received: (qmail 5062 invoked by uid 1000); 4 Jun 2008 19:59:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Jun 2008 19:59:34 -0000
In-Reply-To: <alpine.LFD.1.10.0806041222300.3473@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83816>

On Wed, 4 Jun 2008, Linus Torvalds wrote:

> On Wed, 4 Jun 2008, Linus Torvalds wrote:
> > 
> > and quite frankly, it's rather possible that we should get rid of the 
> > "void *buffer" and "unsigned long size" in the tree *entirely*, because 
> > the above would likely be better written as
> ..
> 
> Side note: the actual historical context here is that "parse_tree()" used 
> to create that "tree_entry_list" of all the entries in the tree. So we 
> used to do things like
> 
> 	struct tree_entry_list *list;
> 
> 	if (parse_tree(tree))
> 		die(..)
> 	list = tree->entries;
> 	while (list) {
> 		...
> 
> so "parse_tree()" was something much bigger (and generated much slower and 
> less dense data structures).
> 
> These days, parse_tree() basically just reads the object buffer and 
> length. So it boils down to just caching the result of "read_sha1_file()", 
> but we have all those legacy uses that come from the old historical thing. 
> And to some degree it may have made sense to drop the buffer, but keep the 
> actual list of entries in that old model.
> 
> See commit 2d9c58c69d1bab601e67b036d0546e85abcee7eb.

I think the lineage of walker.c is to the version in fetch.c, which, in 
that commit, you added the same "drop the buffer" optimization from 
rev-list. If the old style ever dropped the buffer, it would have been in 
parse_tree_buffer() and you'd have had to remove it to get the new style 
to work at all.

	-Daniel
*This .sig left intentionally blank*
