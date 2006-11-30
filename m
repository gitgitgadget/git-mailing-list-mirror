X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 19:52:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611291900550.20138@iabervon.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 00:52:22 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32691>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpa9s-0006W1-O4 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967751AbWK3AwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967753AbWK3AwJ
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:52:09 -0500
Received: from iabervon.org ([66.92.72.58]:40453 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S967751AbWK3AwI (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:52:08 -0500
Received: (qmail 20319 invoked by uid 1000); 29 Nov 2006 19:52:07 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 29
 Nov 2006 19:52:07 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Junio C Hamano wrote:

> The above paragraph is not the important part of my message.
> What was much more important is what immediately followed it,
> which you did not quote:
> 
>     And at that point, I trust "git commit" to do the right thing --
>     the damn thing I just checked with "git diff --cached" _is_ what
>     will be committed.

Perhaps you'd be happier if the command to commit what "git diff --cached" 
shows were "git commit --cached" rather than "git commit -i"? (Or if they 
were both --index; how did we miss that last September?)

It seems logical to me that "git commit" would commit the changes shown by 
"git diff" (in addition to changes in the index, of course, which are so 
obvious as to need no mention). I personally check with "git diff" and 
commit if everything there looks good; otherwise I tweak stuff until it 
does. And if there are a lot of changes, and all of those in some files 
look good, but those in other files need work, I can "git update-index" 
the ones I know I like so I don't have to go through them each time I'm 
checking on other stuff next time.

> This is where "git commit" that does "-a" by default goes quite
> against the underlying mental model of git.  You staged what
> should appear in the next commit in the index because you did
> not want to worry about the local changes you still want to keep
> in your working tree. 

That is not so clear to me. Maybe you're putting changes into the index to 
reduce the noise in "git diff", by updating everything that's 
unquestionable while you examine the other stuff. I think that everything 
in the index is clearly in the next commit, but it's obviously not true 
that everything in the next commit is in the index (because you might not 
be done updating things yet).

> Doing the "screw the index" commit by default to these people is slap in 
> the face.  You do not want to get your index suddenly screwed at the 
> final moment of making the commit, which happened to me when I did 
> "commit --amend" with the version with those two patches applied.

I personally think that --amend should default to retaining the same tree, 
with options available for using the index or -a or paths. Using the index 
by default is just as wrong as -a; you're just more careful about it by 
experience. The index holds stuff to go in the *next* commit, but --amend 
generates a new version of the *previous* commit, so the logical basis for 
the new previous commit is the old previous commit's tree, leaving the 
index alone.

	-Daniel
