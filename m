From: Andreas Gal <gal@uci.edu>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 14:46:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251442480.12019@sam.ics.uci.edu>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
 <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBLG-00048O-4T
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDYVrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDYVrE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:47:04 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:8637 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261226AbVDYVqg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 17:46:36 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3PLkNRT012046;
	Mon, 25 Apr 2005 14:46:23 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3PLkNk2012042;
	Mon, 25 Apr 2005 14:46:23 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, if tags are standalone objects then I don't see how they get 
propagated. Right now all I need to do to pull a version from a remote 
repository is to get the commit object and everything it depends on. Any tags 
involved would not be pulled as there are no dependencies from the commit 
object to the tag. Thats why I was asking whether they are part of any 
tree or not.

So how do we want to do this? Maybe a file TAGS right next to HEAD that 
lists all active tags in my tree by SHA1 hash? Or maybe make tags a linked 
list, with all tags refering to some parent tag? That would give a nice 
list to walk back to find older tags (again, we use something like TAG as 
root).

Andreas

On Mon, 25 Apr 2005, Linus Torvalds wrote:

> 
> 
> On Mon, 25 Apr 2005, Andreas Gal wrote:
> > 
> > Are tag objects referenced by trees (and thus limited in scope) or are 
> > they stand-alone entities in the repository? The latter would be bad for 
> > shared object storages.
> 
> They are totally stand-alone, and I don't see why that would be bad for 
> shared object storage.
> 
> In fact, the whole point of them is that since they are named by the SHA1 
> hash of the content, there are no shared object issues. Two different tags 
> by two different developers will have different names, exactly the same 
> way two different releases will have different names.
> 
> And if two different developers tag exactly the same object with exactly 
> the same tag-name and exactly the same signature, then they get the same 
> tag object, and that's fine. They should.
> 
> > Also, if I delete and recreate tags, will the old tag remain in the tree
> > or will the file in the object storage disapear?
> 
> Tags in no way affect the entry they name. When you remove - or add - a
> tag object, nothing happens to anything else.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
