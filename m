From: Petr Baudis <pasky@suse.cz>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 15:32:04 +0200
Message-ID: <20050926133204.GB21019@pasky.or.cz>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 15:34:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJt61-0002Mk-AU
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 15:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVIZNcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 09:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbVIZNcN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 09:32:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37060 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751628AbVIZNcM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 09:32:12 -0400
Received: (qmail 18645 invoked by uid 2001); 26 Sep 2005 15:32:04 +0200
To: Martin Coxall <quasi@cream.org>
Content-Disposition: inline
In-Reply-To: <4d4586301dca616f42880612fae01492@cream.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9305>

Dear diary, on Sun, Sep 25, 2005 at 09:06:37PM CEST, I got a letter
where Martin Coxall <quasi@cream.org> told me that...
> On 25 Sep 2005, at 17:32, Zack Brown wrote:
> >Hi folks,
> >
> >When I use cogito, it gives a warning saying the rsync method is 
> >deprecated and
> >will be removed in the future. But when I visit kernel.org/git, the 
> >page says to
> >use an rsync URL with cg-clone.
> >
> >Maybe kernel.org should be updated?
> >
> 
> It does seem to be sending out a confusing message to us users too, 
> since an initial clone of Linus's tree with rsync is on my machine 10x 
> faster than an http clone, so it seems to be sending out something of a 
> confused/confusing message re: rsync.
> 
> Am I right in thinking it's because rsync didn't originally have pack 
> support, but now it does, Petr has simply forgotten to deprecate the 
> deprecation message?

Nope. rsync always did packs, I actually un-deprecated it for the time
period when HTTP didn't. The thing is, rsync is bad - it will happily
put duplicate, redundant, and especially unwanted data to your
repository, especially when the shared GIT repositories happen. HTTP and
git-daemon are much better access methods in this regard - actually, I
still like HTTP the most:

+ Works everywhere - no special setup, no dedicated service, firewalls
and proxies won't stop it
+ Works properly, i.e. only getting stuff you want, unlike rsync
+ Replicates packs setup - would be even better if it would kill objects
and packs which the new pack makes redundant

	It would be best to have some smarter git-prune-packed, which
	would process just a single pack. The other alternative would be
	that it would prune packs being subsets of other packs as well,
	but that scaled bad. I will write another mail about that.

- It is slow. Actually, I think it should be much faster for incremental
fetches, and the initial fetch should take about the same time if you
use packs. But the question is, did we already hit the limit? Are we
using HTTP keepalive connections, do we parallelize the requests?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
