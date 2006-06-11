From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 09:40:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606110933040.5498@g5.osdl.org>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com> 
 <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
 <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com>
 <Pine.LNX.4.64.0606110902090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 11 18:40:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpSzW-0000l1-3p
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 18:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFKQkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWFKQkn
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 12:40:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbWFKQkm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 12:40:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5BGeagt022342
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 09:40:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5BGeaFc026112;
	Sun, 11 Jun 2006 09:40:36 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0606110902090.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21660>



On Sun, 11 Jun 2006, Linus Torvalds wrote:
> 
> See? No renames. The renames is not what is fundamental here. What is 
> fundamental is the _STATE_ of the tree. Remember: that's what git tracks, 
> and that is what "git log" shows you.

Btw, this is also why I suggested adding a "--no-simplify-history" flag, 
because in this case, that's exactly what _you_ want. The reason git is 
doing something unexpected - and in your case inferior - is exactly that 
what you want in this case is really not "explain the STATE of this file", 
but you want "give me ALL THE HISTORY concerning this filename".

Both are very valid things to ask for, it just happens that "git log" by 
default answers the _other_ question. It does NOT answer the "what is all 
the history" question that you're asking, it answers the "how did this 
state come to be" question.

Btw, the original "git whatchanged -p" answered exactly the question you 
had, and the semantics changed when we rewrite "git whatchanged" to act 
like "git log -p". But you can still get the old semantics by hand, if you 
really want it, by doing

	git-rev-list --all | git-diff-tree -p -- <filename>

because (and this actually makes total sense when you look at it), you now 
actually say "first give me all the history" and then "show the actual 
changes in that history as it pertains to <filename>".

See? 

I hope this explains the not-so-subtle (but still easy to overlook) 
difference between the two.

And I do agree that we should teach "git log" and friends to be able to 
answer both questions, and that's what my suggested patch (fleshed out 
properly, of course) should do.

Not that I ever _tested_ it, of course. Me? Testing? You make me laugh. Ho 
Ho Ho.

			Linus
