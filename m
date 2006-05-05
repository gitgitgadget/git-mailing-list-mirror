From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 11:31:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
References: <20060505005659.9092.qmail@science.horizon.com>
 <20060505181540.GB27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 20:31:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc55D-0003C7-SL
	for gcvg-git@gmane.org; Fri, 05 May 2006 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWEESbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 14:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWEESbR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 14:31:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751205AbWEESbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 14:31:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k45IV7tH011818
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 May 2006 11:31:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k45IV7YX010277;
	Fri, 5 May 2006 11:31:07 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060505181540.GB27689@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19624>



On Fri, 5 May 2006, Petr Baudis wrote:
> 
> The automatic vs. explicit movement tracking is a lot more
> controversial. Explicit movement tracking is pretty easy to provide for
> file-level movements, it's just that the user says "I _did_ move file
> A to file B" (I never got the Linus' argument that the user has no idea
> - he just _performed_ the move, also explicitly, by calling *mv).

THE USER DID NO SUCH THING.

Moving data around happens with a whole lot more than "mv".

It happens with patches (somebody _else_ may have done an "mv", without 
using git at all), and it happens with editors (moving data around until 
most of it exists in another file).

So doing "*mv" is just a special case.

And supporting special cases is _wrong_. If you start depending on data 
that isn't actually dependable, that's WRONG.

There's another reason why encoding movement information in the commit is 
totally broken, namely the fact that a lot of the actions DO NOT WALK THE 
COMMIT CHAIN!

Try doing

	git diff v1.3.0..

and think about what that actually _means_. Think about the fact that it 
doesn't actually walk the commit chain at all: it diffs the trees between 
v1.3.0 and the current one. What if the rename happened in a commit in the 
middle?

The "track contents, not intentions" approach avoids both these things. 
The end result is _reliable_, not a "random guess".

Adding file movement note to commits is simply WRONG.

Why does this come up every three months or so? I was right the first 
time. You'd think that as time passes, people would just notice more and 
more how right I was and am, instead of forgetting and bringing this 
idiotic idea up over and over and over again.

		Linus
