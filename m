From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [3/5] Add http-pull
Date: Sun, 17 Apr 2005 21:08:24 +0200
Message-ID: <20050417190824.GF1461@pasky.ji.cz>
References: <20050417181054.GB1461@pasky.ji.cz> <Pine.LNX.4.21.0504171412350.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:05:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNF4j-0000kd-O7
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVDQTIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVDQTIk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:08:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43157 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261415AbVDQTI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:08:29 -0400
Received: (qmail 8367 invoked by uid 2001); 17 Apr 2005 19:08:24 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171412350.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 08:49:11PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sun, 17 Apr 2005, Petr Baudis wrote:
> > > Index: http-pull.c
> > > ===================================================================
> > > --- /dev/null  (tree:d662b707e11391f6cfe597fd4d0bf9c41d34d01a)
> > > +++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/http-pull.c  (mode:100644 sha1:106ca31239e6afe6784e7c592234406f5c149e44)
> > > +	url = malloc(strlen(base) + 50);
> > 
> > Off-by-one. What about the trailing NUL?
> 
> I get length(base) + "object/"=8 + 40 SHA1 + 1 for '/' and 1 for NUL = 50.

Sorry, counted one '/' more. :-)

> > I think you should have at least two disjunct modes - either you are
> > downloading everything related to the given commit, or you are
> > downloading all commit records for commit predecessors.
> > 
> > Even if you might not want all the intermediate trees, you definitively
> > want the intermediate commits, to keep the history graph contignuous.
> > 
> > So in git pull, I'd imagine to do
> > 
> > 	http-pull -c $new_head
> > 	http-pull -t $(tree-id $new_head)
> > 
> > So, -c would fetch a given commit and all its predecessors until it hits
> > what you already have on your side. -t would fetch a given tree with all
> > files and subtrees and everything. http-pull shouldn't default on
> > either, since they are mutually exclusive.
> > 
> > What do you think?
> 
> I think I'd rather keep the current behavior and add a -c for getting the
> history of commits, and maybe a -a for getting the history of commits and
> their tress.

I'm not too kind at this. Either make it totally separate commands, or
make a required switch specifying what to do. Otherwise it implies the
switches would just modify what it does, but they make it do something
completely different.

-a would be fine too - basically a combination of -c and -t. I'd imagine
that is what Linus would want to use, e.g.

> There's some trickiness for the history of commits thing for stopping at
> the point where you have everything, but also behaving appropriately if
> you try once, fail partway through, and then try again. It's on my queue
> of things to think about.

Can't you just stop the recursion when you hit a commit you already
have?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
