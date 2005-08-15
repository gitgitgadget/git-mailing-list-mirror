From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Cloning speed comparison
Date: Mon, 15 Aug 2005 17:27:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508151652290.21501@iabervon.org>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.63.0508151321270.12816@iabervon.org>
 <7vacjjx70u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 23:25:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4mRb-0005Zb-6o
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 23:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVHOVY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVHOVY2
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 17:24:28 -0400
Received: from iabervon.org ([66.92.72.58]:14340 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964976AbVHOVY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 17:24:27 -0400
Received: (qmail 22661 invoked by uid 1000); 15 Aug 2005 17:27:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Aug 2005 17:27:46 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacjjx70u.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I should be able to get http-pull down to the neighborhood of 
> > (current) ssh-pull; http-pull is that slow (when the source repository 
> > isn't packed) because it's entirely sequential, rather than overlapping 
> > requests like ssh-pull now does.
> 
> I like those prefetch() and process() code in pull.c very much.
> 
> I have been wondering if increasing parallelism more by
> prefetching beyond the immediate parents of the current commit,
> in "if (get_history)" part of process_commit().  Maybe it is not
> worth it because doing a commit, its associated tree(s) and its
> parents would already give us enough parallelism already.

It is actually already maxing out the parallelism; it has a FIFO of 
objects which it needs, and calls prefetch() when it enqueues an object 
and fetch() when it dequeues it. It only cares about the dependancies for 
this purpose, not the types.

	-Daniel
*This .sig left intentionally blank*
