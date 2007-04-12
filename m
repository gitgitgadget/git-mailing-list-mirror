From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [RFC] git-clone: add --track <headname> support
Date: Fri, 13 Apr 2007 09:46:45 +1200
Message-ID: <461EA8C5.1070503@catalyst.net.nz>
References: <1176372539871-git-send-email-martin@catalyst.net.nz> <87veg1tuuv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc78C-0007th-0d
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 23:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXDLVq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbXDLVq6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 17:46:58 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:34943 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXDLVq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 17:46:57 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hc782-0006aE-GU; Fri, 13 Apr 2007 09:46:54 +1200
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
In-Reply-To: <87veg1tuuv.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44356>

Carl Worth wrote:
> Whether we're talking about cogito migration or not, I also want these
> operations to be dead simple. So I really appreciate seeing your
> efforts on this front.

Hi Carl! Yes - this stuff should be simple, and _really hard to fsck up_.

> I seem to recall Linus complaining about the <repo>#branchname syntax
> because it allows for only one branch name. So one thing to think
> about is how to allow for multiple branches to be tracked while
> cloning, ("--track branch1 --track branch2" ?).

That wouldn't be hard to implement. Actually, we could support both.

> Separately, something I've always wanted is a succint way to advertise
> a complete specification of a branch that users could conveniently
> take, (read, "cut-and-paste, preferably with double-click"), and use
> whether they wanted to do any one of the following operations:
(...)
> For this, I think the <repo>#branch syntax is actually worthing
> thinking about. With it, the above three operations could be provided
> with operations something like:
> 
> 	git clone <repo>#branch
> 
> 	git fetch <repo>#branch
> 
> 	git track <repo>#branch

So you are proposing (or maybe I am re-interpreting things so) that

  git track <repo>#branch

should Do The Right Thing:

 - perform a clone if we aren't in a repo
 - set things up for tracking the branch if we are in a repo

I like the idea. :-)

> Where this new git-track command would encompass a lot of the work
> that git-clone is doing currently. That is, the git-clone rewrite
> that Junio is envisioning could be implemented something like:
> 
> 	mkdir <branch>
> 	cd <branch>
> 	git init-db
> 	git track <repo>#branch

Oops - looks like we are talking about different things. What you write
above can be done with "git-branch --track" on 1.5.1 so it's already in
existence.

> By the way, the <repo>#branch syntax isn't essential for what I'm
> describing here. This syntax does provide something that could be
> usefully provided to either git-clone or git-fetch as a single
> command. This is opposed to the current state where I have to say
> things like:
> 
> 	If you've got a clone already, do: [*]
> 
> 		git fetch <repo> branch:branch
> 		git checkout branch
> 
> 	If you don't have a clone yet, do:
> 
> 		git clone <repo>
> 		git checkout -b branch origin/branch

With my proposed git-track as a wrapper around git-clone _and_
git-branch --track, you only need to say

    To start working on foo, do

      git track <repo>#branch

And if the user has an existing checkout they can do if from inside the
checkout, or perhaps better, saying

     git track --reference <myoldcheckout> <repo>#branch

to avoid the biiig download.


cheers,



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
