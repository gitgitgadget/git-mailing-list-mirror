From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Treat D/F conflict entry more carefully in
 unpack-trees.c::threeway_merge()
Date: Sat, 7 Apr 2007 15:08:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704071456470.27922@iabervon.org>
References: <7vabxkcknp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 21:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaGGk-0004iZ-Nj
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 21:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966300AbXDGTIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 15:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966281AbXDGTIL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 15:08:11 -0400
Received: from iabervon.org ([66.92.72.58]:4996 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966300AbXDGTIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 15:08:09 -0400
Received: (qmail 25903 invoked by uid 1000); 7 Apr 2007 19:08:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Apr 2007 19:08:06 -0000
In-Reply-To: <7vabxkcknp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43980>

On Sat, 7 Apr 2007, Junio C Hamano wrote:

> This fixes three buglets in threeway_merge() regarding D/F
> conflict entries.
> 
> * After finishing with path D and handling path D/F, some stages
>   have D/F conflict entry which are obviously non-NULL.  For the
>   purpose of determining if the path D/F is missing in the
>   ancestor, they should not be taken into account.
> 
> * D/F conflict entry is a phony entry and does not record the
>   path being processed, so do not pick up the name from there.

This bit is unnecessary, because the first bit means we treat D/F conflict 
as missing in that conditional, and don't count it as an entry at all, let 
alone one with a useful name.

> * D/F conflict entry is a marker to say "this stage does _not_
>   have the path", so do not send them to keep_entry().
> 
> There might be more glitches, but I am slowly digging this mess
> through, which unfortunately was made even more work since
> merge-recursive is a built-in now.

Looks good, although it might be wise to add an "exists" function that 
returns false for df_conflict_entry and for NULL, to make the tests 
clearer, and to get a comment to point out the meaning of 
df_conflict_entry. Also, I think df_conflict_entry can be static bss in 
unpack-trees and not accessed through o->df_conflict_entry, since it's 
always the same value (being now universally initialized to a static 
pointer to heap...).

	-Daniel
*This .sig left intentionally blank*
