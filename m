From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree for the first commit
Date: Thu, 19 May 2005 13:31:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505191323060.2322@ppc970.osdl.org>
References: <20050519195110.GG8105@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 22:30:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrdL-0007EG-Fa
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVESU3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVESU3U
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:29:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261241AbVESU3O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 16:29:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JKT9U3013067
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 13:29:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JKT7au007442;
	Thu, 19 May 2005 13:29:08 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050519195110.GG8105@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Thomas Glanzmann wrote:
>
> I would like to see output for the first commit (initial import) in:
> 
> 	git-rev-list HEAD | git-diff-tree -r --stdin
> 
> is it supposed to just be empty or is that a bug?

Hmm.. That's a bug and/or a feature, entirely depending on how you feel.

The first commit doesn't have a parent, so in the world where this is a 
feature, this is 100% consistent with the notion that since there is 
nothing to diff against, diff-tree has nothing to do.

In an alternate world, you can decide that not having a parent is 
equivalent to being parented with an empty tree.

In yet a third world, you'd decide that all git projects should start off 
from the empty tree root parent, and that the kernel project (and the git 
archive itself) is invalid.

I don't think there is a right answer, except that I think the third
version is likely wrong, since by definition the kernel archive is
perfect.

There's actually some reason to consider the current behaviour correct, in
that the initial tree really _is_ special: it was imported from somewhere
else, and as such anybody who wants to know "what changed" really doesn't
want to see the explosion that happened at the beginning of time: that
wasn't a "change" at all, that was something else.

So the current behaviour actually is (in my opinion) the right one, at
least when considering something like git-whatchanged. Similarly, if you
use a variation of git-whatchanged to implement the equivalent of "cvs
annotate", leaving the lines that don't have a diff _non-annotated_ is
actually the right thing to do, since it would be wrong to say "they came
from the person who did the initial import".

That said, a new flag that says "diff the root against the NUL tree" 
wouldn't be wrong either, for when that is what you want.

			Linus
