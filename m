From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "gitk" work better with dense revlists
Date: Thu, 27 Oct 2005 07:51:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510270743490.4664@g5.osdl.org>
References: <Pine.LNX.4.64.0510251253110.10477@g5.osdl.org>
 <17248.28857.90315.543669@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 27 16:57:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV96g-0006U7-EX
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 16:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVJ0Ovm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 10:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVJ0Ovm
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 10:51:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbVJ0Ovm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 10:51:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9REpXFC019819
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Oct 2005 07:51:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9REpWgJ016537;
	Thu, 27 Oct 2005 07:51:32 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17248.28857.90315.543669@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10714>



On Thu, 27 Oct 2005, Paul Mackerras wrote:
>
> Linus Torvalds writes:
> >
> > So this makes gitk just show the diff of _that_ commit.
> 
> Committed and pushed out, but ...

Btw, the "show diff for commit" fails for the root case - you never see 
the initial commit. 

That is definitely correct for big archives that started out of nothing 
(due to being imported), but it's sad/wrong for something like git itself, 
and it'a usually wrong when using --dense and a filename, since then the 
diff is often smaller (ie it might be a simple rename).

> > Also, having now tested the previous "handle root commit in the 
> > TREECHANGED" logic a bit more, I think it's (a) stable and (b) the right 
> > thing to do. Sign me off on that one too.
> 
> What is that about?

That's just me improving how --dense works wrt root commits. Junio already 
merged it ("git-rev-list: fix --dense flag")

> I'm hoping to get back to gitk hacking RSN - I've been going flat out
> on the ppc32/ppc64 merge.  Thanks for doing the --dense thing; I was
> thinking about doing something like that inside gitk but doing it in
> git-rev-list is better.

A _lot_ better. You'd have been totally screwed performance-wise trying to 
do it in tcl/tk and executing git-diff-tree for everything.

>		  It does mean that I now want to be able to
> get gitk to contract the view to just a given set of files or
> directories and then expand back to the whole tree view, which means
> running git-rev-list multiple times, which gitk can't do at the
> moment...

Yes. And please also give the option to contract the diffs to a set of 
files (I think that should be independently controlled, although perhaps 
with some way to set them both at the same time).

		Linus
