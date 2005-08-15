From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Sun, 14 Aug 2005 19:49:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508141937251.3553@g5.osdl.org>
References: <46a038f905081417241f9598cc@mail.gmail.com> 
 <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> <46a038f905081419057cc6b5cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>, Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Mon Aug 15 04:50:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4V2j-0005h3-J1
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 04:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVHOCtj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 22:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVHOCtj
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 22:49:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932646AbVHOCti (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 22:49:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7F2nRjA016302
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 Aug 2005 19:49:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7F2nQ6h029709;
	Sun, 14 Aug 2005 19:49:26 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905081419057cc6b5cd@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 15 Aug 2005, Martin Langhoff wrote:
> 
> > So in a cvsimport, you'll never see a merge back to the head, even if one
> > technically took place.
> 
> There may be some surprises in here! gitk --all shows at least one
> branch opening and merging back into origin, and it has figured it out
> correctly

Oh, wow. The new cvsimport is obviously being a hell of a lot smarter than 
my original one was. Goodie.

> Except for the keyword expansion. surely there's a way to tell cvsps
> to not do it. Why would we ever want it?

Ahh. I don't think we should blame cvsps, I think cvsimport should use the 
"-ko" flag to disable keyword expansion or whatever the magic flag is.

Sven, Matthias, opinions? I've never used CVS keyword expansion, and 
always felt it was pointless, but hey..

> > branches and heads are the same thing in git. 
> 
> right. There are two separate directories in .git for them, so I was
> misled by that. Should I assume git is safe from name clashes or is it
> up to porcelain to deal with such minutiae?

Well, you actually are _expected_ to get clashes.

What happens normally (at least for core git) is that the ".git/branches"  
directory contains external sources for the branches (for example, a "git
clone" will fill in the "origin" source, while I often have a
".git/branches/parent" in my tree because). That is just a pointer to 
where the external branch exists.

Then, when you do something like

	git fetch parent

it will look up the source of "parent" by looking in the
".git/branches/parent" file, and update the ".git/refs/heads/parent" 
branch appropriately from that external branch.

So in this example the parent "head" ("local branch") points to the actual
_commit_ we have, while the ".git/branches/parent thing points to what 
_external_ branch it came from.

But yes, you _can_ mess this up if you want to. If you have the same 
"external branch" name that you use for an "internal branch", you deserve 
all the confusion you get ;)

		Linus
