From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 17:39:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211730560.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
 <7vu0genlc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org>
 <20050921.172849.103555057.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 02:40:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIF8I-0000Jp-84
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 02:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVIVAkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 20:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVIVAkK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 20:40:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965196AbVIVAkI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 20:40:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8M0dsBo028637
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 17:39:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8M0drd3006642;
	Wed, 21 Sep 2005 17:39:53 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050921.172849.103555057.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9089>



On Wed, 21 Sep 2005, David S. Miller wrote:
> 
> You know, I personally was unaware that this was supported until now.
> I have been always reverting local debugging changes in order to merge
> other people's work in, then reapply the debugging changes afterwards.
> 
> I guess I won't have to do that any more. :-)

Absolutely. 

It will happily merge a dirty tree, as long as none of the dirty files 
were modified.

And by "dirty" I mean "index matches HEAD, but contents do not match 
index".

It's very convenient. I usually have my local Makefile updated for the
next version for a few days before actually committing it, and I tend to
have any experimental patches that I sent out to people uncommitted in my
tree too, just to remind me and to test them.

> So as long as they don't interfere, you can keep local debugging
> changes out of GITs way for just about anything right?  For example,
> as long as you don't "git-update-cache foo.c" those files in your
> local debugging hack, you can just "git commit" afterwards and
> only put in the changes you want.  It won't myseriously find those
> modified files and what to do something with them right?

That's correct. Also, since this is how I work, I've tried to make sure 
that the tools I work with are "safe". For example, git-applymbox will 
happily apply patches to a dirty tree, because it uses "git-apply --index" 
that refuses to apply a patch to a file that is modified. 

So it's perfectly safe to merge somebody elses _patch_ too - even with a
tree with patches. But git-applymbox will refuse to apply patches on a
tree where your index doesn't match the HEAD commit. So it's safe to have
a _dirty_ tree, but if you've done an "update-cache" and have an index
that doesn't match the parent any more, git-applymbox will refuse to run.

(Btw, that's something that I haven't checked whether I verified properly
in git-read-tree.. I basically never have my index out of sync with my
HEAD, but I should probably verify).

			Linus
