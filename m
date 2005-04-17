From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 15:09:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171458310.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504171114020.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:06:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNF59-0000o5-DT
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDQTJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVDQTJL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:09:11 -0400
Received: from iabervon.org ([66.92.72.58]:13318 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261416AbVDQTJF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:09:05 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNF8z-0005hi-00; Sun, 17 Apr 2005 15:09:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171114020.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Daniel Barkalow wrote:
> >
> > --- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/revision.h  (mode:100644 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
> > +++ 37a0b01b85c2999243674d48bfc71cdba0e5518e/revision.h  (mode:100644 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
> > @@ -24,6 +24,7 @@
> >  	unsigned int flags;
> >  	unsigned char sha1[20];
> >  	unsigned long date;
> > +	unsigned char tree[20];
> >  	struct parent *parent;
> >  };
> >  
> 
> I think this is really wrong.
> 
> The whole point of "revision.h" is that it's a generic framework for 
> keeping track of relationships between different objects. And those 
> objects are in no way just "commit" objects.
>
> For example, fsck uses this "struct revision" to create a full free of 
> _all_ the object dependencies, which means that a "struct revision" can be 
> any object at all - it's not in any way limited to commit objects, and 
> there is no "tree" object that is associated with these things at all.

I entirely missed this. No wonder my fsck-cache conversion wasn't going
so well...

> Besides, why do you want the tree? There's really nothing you can do with 
> the tree to a first approximation - you need to _first_ do the 
> reachability analysis entirely on the commit dependencies, and then when 
> you've selected a set of commits, you can just output those.

I actually want the tree for http-pull, not merging stuff. I was trying to
get a commit parser, not reachability at that point.

I think the right thing is to make a separate struct commit that has the
stuff I want in it, and probably do a struct tree at the same time.

	-Daniel
*This .sig left intentionally blank*

