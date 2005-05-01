From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 19:46:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011923110.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 01:40:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSO38-0005la-U5
	for gcvg-git@gmane.org; Mon, 02 May 2005 01:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVEAXqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 19:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVEAXqb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 19:46:31 -0400
Received: from iabervon.org ([66.92.72.58]:42757 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261353AbVEAXqQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 19:46:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSO8X-0006tq-00; Sun, 1 May 2005 19:46:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 1 May 2005, Linus Torvalds wrote:

> On Sun, 1 May 2005, Daniel Barkalow wrote:
> > 
> > I added a get_ref_sha1() that just does the .git/refs/ case; I think that
> > most things that want to accept various forms will also want to know what
> > form they got and do something with it, so get_sha1() isn't a big win.
> 
> I really really disagree.
> 
> For example, take something like "git-diff-cache". I think it's a big
> bonus if you can just write
> 
> 	git-diff-cache HEAD
> 
> and it will pick up the sha1 ID from .git/HEAD. 

True, but with -p, you'd probably want to give lines like

--- HEAD/Makefile
+++ (cache)/Makefile

when it's not just hex (and "linus/Makefile" for heads/linus, not
"heads/linus/Makefile", which would break things). I think it's generally
best to call each of the things in the list to try and not only use the
first one that understands, but also do program-specific special things
depending on which one that was.

> In general, I think a "get_sha1()" that tries as many user-friendly things 
> as possible is good for the command line. Within reason. I really don't 
> like the "try to autocomplete a partial sha1" thing, but I wouldn't at all 
> mind having various helpers like
> 
> 	git-diff-tree HEAD.p1 HEAD
> 
> where the ".p1" would just make it look up the first parent of the thing 
> in HEAD (which in turn would mean "look up the sha1 from the .git/HEAD 
> file".

Maybe :p1, to use characters that aren't frequently in filenames?

> Many of these are really easy to do, and I think most people would tend to 
> prefer having the choice.

I agree with that, but I'm not sure how useful having one function that
just looks up the sha1 without further reporting is. In any case, it's an
easy addition, and it's plausible that similar functions would work for
any similar information needed.

	-Daniel
*This .sig left intentionally blank*

