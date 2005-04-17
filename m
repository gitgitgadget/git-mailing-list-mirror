From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 20:30:02 +0200
Message-ID: <20050417183002.GE1461@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org> <Pine.LNX.4.58.0504171114020.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 20:26:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNETb-0005CI-BR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDQSaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVDQSaO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:30:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63892 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261288AbVDQSaE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:30:04 -0400
Received: (qmail 6186 invoked by uid 2001); 17 Apr 2005 18:30:02 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504171114020.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 08:18:47PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
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

Someone started the avalanche by adding date to the structure. Of
course, date is smaller, but it leads people (including me) out of the
way.

Perhaps struct commit which will have struct revision (ugh - what about
rather struct object?) as a member?

> For example, fsck uses this "struct revision" to create a full free of 
> _all_ the object dependencies, which means that a "struct revision" can be 
> any object at all - it's not in any way limited to commit objects, and 
> there is no "tree" object that is associated with these things at all.

That's some really bad naming then.

> Besides, why do you want the tree? There's really nothing you can do with 
> the tree to a first approximation - you need to _first_ do the 
> reachability analysis entirely on the commit dependencies, and then when 
> you've selected a set of commits, you can just output those.
> 
> Later phases will indeed look up what the tree is, but that's only after
> you've decided on the commit object. There's no point in looking up (or
> even trying to just remember) _all_ the tree objects.

The goal was to have a commit record parser which would spit out this
structure containing all the relevant info, but I can agree that wasting
memory with it makes no sense. Perhaps it could take a possibly-NULL
buffer pointer where it would drop the tree ID, Daniel?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
