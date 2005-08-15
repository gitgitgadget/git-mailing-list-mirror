From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Cloning speed comparison
Date: Mon, 15 Aug 2005 13:50:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508151321270.12816@iabervon.org>
References: <20050813015402.GC20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 19:48:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4j3M-0002ZB-L5
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 19:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVHORrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 13:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVHORrN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 13:47:13 -0400
Received: from iabervon.org ([66.92.72.58]:10246 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964824AbVHORrM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 13:47:12 -0400
Received: (qmail 21385 invoked by uid 1000); 15 Aug 2005 13:50:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Aug 2005 13:50:31 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813015402.GC20812@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 13 Aug 2005, Petr Baudis wrote:

>   Hello,
> 
>   I've wondered how slow the protocols other than rsync are, and the
> (well, a bit dubious; especially wrt. caching on the remote side)
> results are:
> 
> 	git	clone-pack:ssh	25s
> 	git	rsync		27s
> 	git	http-pull	47s
> 	git	dumb-http	54s
> 	git	ssh-pull	660s
> 
> 	cogito	clone-pack:ssh	35s (!)
> 	cogito	rsync		140s
> 	cogito	ssh-pull	480s
> 	cogito	http-pull	extrapolated to about an hour!

I should be able to get http-pull down to the neighborhood of 
(current) ssh-pull; http-pull is that slow (when the source repository 
isn't packed) because it's entirely sequential, rather than overlapping 
requests like ssh-pull now does.

I should also be able to get ssh-pull down to the area of clone-pack, but 
that's lower-priority, since there's clone-pack.

(I've written an untested patch for local-pull, which I'll be testing, 
cleaning, and submitting tonight, assuming my newly-arrived monitor 
actually works)

>   PS:
> 	With the latest git version as of time of writing this:
> 	$ time cg-clone git+ssh://pasky@localhost/home/pasky/WWW/dev/git/.g cogito
> 	...
> 	progress: 5759 objects, 10292457 bytes
> 	$ time cg-clone http://localhost/~pasky/dev/git/.g cogito
> 	...
> 	progress: 8681 objects, 14881571 bytes

I've noticed that ssh connections don't actually disconnect at the end 
with recent versions of ssh sometimes. In my experience, this occasionally 
happens with git, but always happens with scp, suggesting that it's an ssh 
bug of some sort; I've also only noticed this with openssh 3.9_p1 with 
some of Gentoo's -r2 patches.

	-Daniel
*This .sig left intentionally blank*
