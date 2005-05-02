From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 19:43:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011932220.2162@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
 <Pine.LNX.4.58.0505011638370.22864@ppc970.osdl.org> <7vsm16qyia.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505011840590.2162@ppc970.osdl.org> <7v4qdmqt8v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 04:39:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSQqX-0005Ev-97
	for gcvg-git@gmane.org; Mon, 02 May 2005 04:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVEBCpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 22:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVEBCoI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 22:44:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:22677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261814AbVEBClL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 22:41:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j422f1s4021362
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 19:41:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j422ex7E010538;
	Sun, 1 May 2005 19:41:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qdmqt8v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Junio C Hamano wrote:
> 
> That's why I said I do not think this belongs to the Plumbing.

I've removed the ugly parent format, but to make it easier to script the 
thing I removed, I just pushed out an improvement to "cat-file" which 
makes it use the "read_object_with_reference()" helper to cat the object.

That means that if you use "git-cat-file tree" on a tag object, then it
will first look up the tag object, then the commit object and finally the
tree obejct, and it will cat that tree object. Of course, normally you'd
use it with a "commit" object and get the pleasure of having it "just
work" with tags too.

So for example, to get the parent of a commit (whether a tag that points
to a commit, or a real commit), you'd script something like

	git-cat-file commit v2.6.12-rc3 | sed -n '/^parent /{s/parent //;p;q}'

which gets the first parent of the commit that was pointed to by the 
"v2.6.12-rc3" tag.

If you want to see the tag itself, you'd just do

	git-cat-file tag v2.6.12-rc3

like before, of course.

And "git-cat-file -t" always gives the top-level tag, so if you ask the 
type of "v2.6.12-rc3" it will say "tag".

			Linus
