From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 16:27:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221621280.2344@ppc970.osdl.org>
References: <20050422030931.GA14565@pasky.ji.cz> <20050422064936.GA10854@kroah.com>
 <20050422230551.GI21204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:20:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7S1-0005b4-9K
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVDVXZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDVXZT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:25:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:4583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261301AbVDVXZM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:25:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MNP9s4015778
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 16:25:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MNP8Bd018699;
	Fri, 22 Apr 2005 16:25:08 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422230551.GI21204@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Petr Baudis wrote:
> 
> Just FYI, this is bug in core git's diff-cache;

Nice find. 

Yes, I told you guys I hadn't tested it well ;)

"diff-cache" does the same "diff trees in lockstep" thing that "diff-tree" 
does, but it's actually more complex, since the _tree_ part always needs 
to be recursively followed, while the _cache_ part is this linear list 
that is already expanded.

Which just made the whole algorithm very messy.

Once I found out how nasty it was to do that compare, I was actually
planning to re-write the thing using the same approach that "read-tree -m
<tree>" does - ie move the tree information _into_ the in-memory cache, at
which point it should be absolutely trivial to compare the two. But since 
the horrid algorithm seemed to end up working, I never did.

I'm not even going to debug this bug. I'm just going to rewrite diff-cache 
to do what I should have done originally, ie use the power of the 
in-memory cache. That's also automatically going to properly warn about 
unmerged files.

Give me five minutes ;)

		Linus
