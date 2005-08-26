From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Fri, 26 Aug 2005 16:48:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508261558550.23242@iabervon.org>
References: <20050826184731.GA13629@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 22:46:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8l4O-0005tl-PN
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 22:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVHZUoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVHZUoz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 16:44:55 -0400
Received: from iabervon.org ([66.92.72.58]:4357 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030262AbVHZUoz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 16:44:55 -0400
Received: (qmail 25446 invoked by uid 1000); 26 Aug 2005 16:48:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2005 16:48:32 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050826184731.GA13629@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7824>

On Fri, 26 Aug 2005, Fredrik Kuivinen wrote:

> I will try to describe how the algorithm works. The problem with the
> usual 3-way merge algorithm is that we sometimes do not have a unique
> common ancestor. In [1] B and C seems to be equally good. What this
> algorithm does is to _merge_ the common ancestors, in this case B and
> C, into a temporary tree lets call it T. It does then use this
> temporary tree T as the common ancestor for D and E to produce the
> final merge result. In the case described in [1] this will work out
> fine and we get a clean merge with the expected result.

The only problem I can see with this is that it's likely to generate
conflicts between the shared heads, and the user is going to be confused
trying to resolve them, because the files with the conflicts will be
missing all of the more recent changes. Other than that, I think it should
give the right answer, although it will presumably involve a lot of
ancient history doing the internal merge. (Which would probably be really
painful if you've got two branches that cross-merge regularly and never
actually completely sync)

I'm getting pretty close to having a version of read-tree that does the
trivial merge portion based comparing the sides against all of the shared
heads. I think yours will be better for the cases we've identified, giving
the correct answer for Tony's case rather than reporting a conflict, but
it's clearly more complicated. I think my changes are worthwhile anyway,
since they make the merging logic more central, but obviously
insufficient.

I've been thinking that could be useful to have read-tree figure out the
history itself, instead of being passed ancestors, in which case it could
use your method, except more efficiently (and only look further at the
history when needed).

	-Daniel
*This .sig left intentionally blank*
