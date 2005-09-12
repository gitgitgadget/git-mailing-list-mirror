From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 16:22:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509121614140.23242@iabervon.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chuck Lever <cel@citi.umich.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 22:21:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEulJ-0006QM-Jw
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVILUSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVILUSk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:18:40 -0400
Received: from iabervon.org ([66.92.72.58]:15116 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932205AbVILUSj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 16:18:39 -0400
Received: (qmail 25073 invoked by uid 1000); 12 Sep 2005 16:22:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Sep 2005 16:22:44 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8421>

On Mon, 12 Sep 2005, Junio C Hamano wrote:

> I've only skimmed the surface of your patchset and cannot
> comment on the correctness of all the conversion of active_cache
> users; today is my day-job day not a GIT day.
> 
> I have to say you did quite a lot of work, and I am pleasantly
> surprised to see the massive clean-up this change brings us.  It
> seems like this makes the active_cache users a lot easier to
> read.
> 
> I have a couple of comments on the API, though.
> 
> * Doesn't function to be applied usually want to have its own
>   data when passed to walk, maybe something like this?
> 
>   This was a question I had when I read [PATCH 01/22] before
>   reading the rest of the patches, but the actual conversion
>   does not seem to find much need for it.  A new global variable
>   pathspec is introduced to pass information the API is unable
>   to pass to diff_one() in diff-index.c, which may be a sign
>   that an extra "user data" parameter might help.  Your call.

I agree that it only works for the current conversion, due to there only 
being a limited amount you might try to do in a single git executable 
currently. Long-term, that should be fixed.

> * It may make sense to give another param to describe which
>   cache the caller is talking about so that we can later have
>   more than one cache at the same time:
> 
>   We could argue that this should be left for later rounds.  On
>   the other hand, we will be changing all the cc_* function call
>   sites during that round, which is by definition the places you
>   are touching in this round anyway. 

Wouldn't it be better to only take it in cc_init(), and have the cursor 
remember what it's iterating through?

I'm actually particularly interested in having a pair of caches for 
read-tree, because it would actually like to keep the old index separate 
from the index it's building.

	-Daniel
*This .sig left intentionally blank*
