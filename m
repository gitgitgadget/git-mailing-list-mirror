From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: index file screwed up
Date: Wed, 28 Sep 2005 08:37:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509280831130.3308@g5.osdl.org>
References: <433AB170.90608@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 17:39:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKdzr-0007aU-H9
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 17:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVI1PhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 11:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVI1PhY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 11:37:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbVI1PhY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 11:37:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8SFbL4s016112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Sep 2005 08:37:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8SFbKRH003360;
	Wed, 28 Sep 2005 08:37:21 -0700
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <433AB170.90608@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9434>



On Wed, 28 Sep 2005, Chuck Lever wrote:
>
> i was working with a version of git that had a bug in add_cache_entry() 
> that introduced a sorting error in my index.
> 
> [cel@dexter main]$ stg refresh -f
> Refreshing patch "git-switch-branch"...AUTHORS: unmerged 
> (098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62)
> AUTHORS: unmerged (098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62)
> COPYING: unmerged (d60c31a97a544b53039088d14fe9114583c0efc3)
> COPYING: unmerged (d60c31a97a544b53039088d14fe9114583c0efc3)
> INSTALL: unmerged (8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74)
> INSTALL: unmerged (8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74)
> MANIFEST.in: unmerged (581d0be2a5fb3569b06681b7d559f1279aa4104b)
> MANIFEST.in: unmerged (581d0be2a5fb3569b06681b7d559f1279aa4104b)
> README: unmerged (184ded8e08cb92a14b79c79f9919469ba352ab70)
> README: unmerged (184ded8e08cb92a14b79c79f9919469ba352ab70)
> ...
> fatal: git-write-tree: verify_merged: not able to write tree
> stg refresh: git-write-tree failed
> 
> [cel@dexter main]$
> 
> how do i recover?

You don't. Your index is toast.

Let's hope you didn't write any unsorted trees with _earlier_ (non-merge) 
commits.

Do this:

 - build a new and trustworthy git somewhere else (from a tar-file if 
   nothing else). Install it.

 - get rid of the index and any half-way data in your working tree (you 
   might want to save any diffs with "git diff HEAD" first, but I suspect  
   you don't really care, since the changes came from some stg stuff, so
   you can always re-create them, no?)

	git reset --hard HEAD

 - run fsck, to verify that all your trees are sorted (if they aren't, you 
   be screwed, but "git-convert-objects" should be able to fix it for 
   you - possibly with some additional logic).

	git-fsck-objects --full

 - restart and try again.

That _should_ get you running again.

		Linus
