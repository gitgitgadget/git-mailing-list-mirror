From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 09:24:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
References: <20050416132231.GJ2551@abridgegame.org>
 <Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org> <20050417121712.GA22772@abridgegame.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Sun Apr 17 18:18:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCTq-0000G4-S5
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDQQWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVDQQWb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:22:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:1216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261349AbVDQQW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:22:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HGMMs4032502
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 09:22:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HGMLnl025224;
	Sun, 17 Apr 2005 09:22:22 -0700
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20050417121712.GA22772@abridgegame.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, David Roundy wrote:
> 
> That's all right.  Darcs would only access the cached data through a
> git-caching layer, and we've already got an abstraction layer over the
> pristine cache.  As long as the git layer can quickly retrieve the contents
> of a given file, we should be fine.

Yes.

In fact, one of my hopes was that other SCM's could just use the git
plumbing. But then I'd really suggest that you use "git" itself, not any
"libgit". Ie you take _all_ the plumbing as real programs, and instead of
trying to link against individual routines, you'd _script_ it.

In other words, "git" would be an independent cache of the real SCM,
and/or the "old history" (ie an SCM that uses git could decide that the
git stuff is fine for archival, and really use git as the base: and then
the SCM could entirely concentrate on _only_ the "interesting" parts, ie
the actual merging etc).

That was really what I always personally saw "git" as, just the plumbing
beneath the surface. For example, something like arch, which is based on
"patches and tar-balls" (I think darcs is similar in that respect), could
use git as a _hell_ of a better "history of tar-balls".

The thing is, unless you take the git object database approach, using 
_just_ the index part doesn't really mean all that much. Sure, you could 
just keep the "current objects" in the object database, but quite 
frankly, there would probably not be a whole lot of point to that. You'd 
waste so much time pruning and synchronizing with your "real" database 
that I suspect you'd be better off not using it.

(Or you could prune nightly or something, I guess).

		Linus
