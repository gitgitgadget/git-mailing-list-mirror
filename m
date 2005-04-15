From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 13:31:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151313450.7211@ppc970.osdl.org>
References: <000d01c541ed$32241fd0$6400a8c0@gandalf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 22:27:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMXOc-0002rW-J4
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVDOU3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDOU3c
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:29:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVDOU3J (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 16:29:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FKT3s4021663
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 13:29:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FKT2R1013533;
	Fri, 15 Apr 2005 13:29:02 -0700
To: Barry Silverman <barry@disus.com>
In-Reply-To: <000d01c541ed$32241fd0$6400a8c0@gandalf>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ I'm cc'ing the git list even though Barry's question wasn't cc'd. 
  Because I think his question is interesting and astute per se, even
  if I disagree with the proposal ]

On Fri, 15 Apr 2005, Barry Silverman wrote:
>
> If git is totally project based, and each commit represents total state
> of the project, then how important is the intermediate commit
> information between two states. 

You need it in order to do further merges.

> IE, Area maintainer has A1->A2->A3->A4->A5 in a repository with 5
> commits, and 5 comments. And I last synced with A1.
> 
> A few days later I sync again. Couldn't I just pull the "diff-tree A5
> A1" and then commit to my tree just the record A1->A5. Why does MY
> repository need trees A2,A3,A4?

Because that second merge needs the first merge to work well. The first 
merge might have had some small differences that ended up auto-merging (or 
even needing some manual help from you). The second time you sync, there 
migth be some more automatic merging. And so on.

If you don't keep track of the incremental merges, you end up with one 
really _difficult_ merge that may not be mergable at all. Not 
automatically, and perhaps not even with help.

So in order to keep things mergable, you need to not diverge. And the 
intermediate merges are the "anchor-points" for the next merge, keeping 
the divergences minimal. 

I'm personally convinced that one of the reasons CVS is a pain to merge is 
obviously that it doesn't do a good job of finding parents, but also 
exactly _because_ it makes merges so painful that people wait longer to do 
them, so you never end up fixing the simple stuff. In contrast, if you
have all these small merges going on all the time, the hope is that 
there's never any really painful nasty "final merge".

So you're right - the small merges do end up cluttering up the revision 
history. But it's a small price to pay if it means that you avoid having 
the painful ones.

> Isn't preserving the A1,A2,A3,A4,A5 a legacy of BK, which required all
> the changesets to be loaded in order, and so is a completely "file"
> driven concept? 

Nope. In fact, to some degree git will need this even _more_, since the
git merger is likely to be _weaker_ than BK, and thus more easily
confused.

I do believe that BK has these things for the same reason.

			Linus
