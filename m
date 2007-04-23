From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 16:24:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 01:24:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7tl-00080e-DC
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbXDWXYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbXDWXYm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:24:42 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:42945 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754526AbXDWXYl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 19:24:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3NNOO1J013953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 16:24:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3NNONOO027811;
	Mon, 23 Apr 2007 16:24:23 -0700
In-Reply-To: <87vefm7l6g.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-3.037 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45380>



On Mon, 23 Apr 2007, Carl Worth wrote:
>
> And with the recent talk about phasing cogito out and just merging its 
> functionality into git itself, why not just use the cogito syntax for 
> this:
> 
> 	git clone <url>#<branch>

That's a fundamentally weaker operation than the current "git clone", so I 
really don't think it's a good idea. The syntax also absolutely sucks, 
it's so horribly non-unixy.

I'd personally be ok with a

	git clone --default=<branch> <url>

to create something where "master" defaults to some other remote branch, 
but that just addresses the syntax. And quite frankly, I don't think we 
*need* to. We shoud just tell people how _easy_ it is to track some other 
branch now.

So I don't really see the problem with just saying:

 - the remote *has* a default branch. That's the one you get by default 
   with "git clone".

 - if you want to track another branch, you should just tell git that you 
   want to track it, and switch to that instead:

	git branch --track mybranch origin/otherbranch
	git checkout mybranch

   and be happy with it.

Yes, it's two extra commands, but they aren't *that* hard to explain, 
after all. You really can basically explain each stage both very simply 
and naturally with just

 - first you clone the repository. This gets you all remote branches, and 
   sets "master" to track the default remote branch.

	git clone remote [local-dir]

 - then, you create a new branch that you want to track another of the 
    branches in origin

	git branch --track mybranch origin/otherbranch

 - then you check that branch out

	git checkout mybranch

and notice how each stage really was not only pretty logical, but even the 
command to do it didn't really look *that* strange: even without the 
explanation of what the commands are doing, somebody reading just the pure 
commands could probably _guess_ what they do!

Really, all three stages are pretty simple, and they are not really that 
hard to explain. And it's not even like you do this very often - so this 
is the _perfect_ kind of thing to have on a "git reference card" kind of 
thing (think O'Reilly reference card series).

So I _really_ think that if we just had the "this is how to use 'git' as a 
replacement for 'anonymous CVS'-like usage" documentation, you could 
explain all of this very concisely, and with absolutely zero confusion 
even to a total non-git person. Give a few example command lines from real 
life (eg, tracking the "next" branch from git itself), and make it easy to 
find, and you're all done.

The advantage is that unlike that *idiotic* cogito syntax, you don't 
actually *lose* anything. If somebody says "but I'd like to track *two* 
branches", the sequence is _exactly_ the same. There is no "special magic" 
at clone time.

And the syntax is also much clearer. No magic and horribly non-unixy 
URL#branch syntax.

			Linus
