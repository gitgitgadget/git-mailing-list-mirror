From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 12:28:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101221020.4939@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601102010100.27199@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101151090.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 21:29:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQ7R-0001GZ-H1
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWAJU3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWAJU3F
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:29:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932597AbWAJU2p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 15:28:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AKSgDZ031494
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 12:28:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AKSext013112;
	Tue, 10 Jan 2006 12:28:41 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0601101151090.4939@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14448>



On Tue, 10 Jan 2006, Linus Torvalds wrote:
> 
> If a _different_ bug was introduced (even if it had the same effects), 
> yes, you now have two separate bugs. And bisecting two bugs is hard. You 
> need to separate them out some way.

Side note: this is seldom a problem in practice. If it was effectively the 
same bug, just finding the one case that triggered it is sufficient: you 
then know what to look for, and if undoing that one commit isn't enough to 
fix it in the current tree (because the same bug existed in another form 
on another branch), you wouldn't actually start bisecting again. You'd 
start grepping the tree for other cases of that bug.

So the biggest advantage of "git bisect" is _not_ that you can just undo 
the buggy commit. In fact, usually you don't even want to undo it, because 
it probably had a raison-d'etre to begin with. The huge deal about "git 
bisect" is that it pinpoints what caused the bug, and then the fix is 
often something else.

Often it's a "Duh! I fixed one thing, but my fix didn't take Xyz into 
account, so it now broke for another reason" moment.

Most bugs are stupid, in other words.

The _real_ problem with git bisect is when you have a non-technical user 
(common) and there are silly bugs that you know of and already fixed that 
aren't really a problem, but that are show-stoppers for the user who isn't 
a kernel developer (or is, but doesn't know git). They're show-stoppers 
not because we care about them, but because they make the "purely 
mechanical" thing be one where you have to have some manual input.

Another problem (that I've not seen in practice yet, but that I bet _will_ 
be the worst issue) is non-reproducible bugs. They are the nastiest kind 
to debug in the first place, and sadly, "git bisect" simply doesn't help 
you with them. There, nothing but some luck and a lot of thinking and 
testing will help you.

			Linus
