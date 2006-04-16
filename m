From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 11:27:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161117360.3701@g5.osdl.org>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161052310.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604162006050.19560@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 20:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVBy6-0000Jb-7Z
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWDPS1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDPS1T
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 14:27:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750787AbWDPS1T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 14:27:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3GIRGtH007827
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 11:27:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3GIRFwg012059;
	Sun, 16 Apr 2006 11:27:15 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604162006050.19560@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18800>



On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> 
> There's another reason it does not show it. ATM, you have to add "-p" to 
> the command line, or "-c" will not show *any* patch, let alone a combined 
> one.

Oh, it will show the "raw" patch, which is often very useful. I've grown 
quite fond of it, because it shows what happened on a bigger level, 
without showing the details within a file ("--name-status" makes it more 
readable, but I'm too lazy to type it, so I often just look at the raw 
git patch).

> Thanks for all your help, but in this case it was not irrelevant. Because 
> I *had* the function in my working copy. And I had changed it. So I had to 
> find out where to move the change.

Right, but it was irrelevant as far as "top-of-head" was concerned (which 
is all that "git log" shows you - it doesn't care about your working 
tree).

The fact that it _had_ been relevant in the state you used to be at is not 
something "git log" and friends know or care about.

Now, I'm not disputing that we might want to make it easier to see what 
_had_ been relevant at some earlier time. But you'd have to specify that 
earlier time somehow. I assume you had tried to do a "git rebase", and the 
problem with that is that git rebase really doesn't help you at all when 
things go wrong, exactly because "rebase" - by design - screws up the 
history and loses that information for you.

If your problem state had been as a result of a "git merge", you'd 
actually have had much better tools available to you, exactly because 
merge doesn't screw up history, so you've got both sides of the merge you 
can look at (HEAD and MERGE_HEAD, and "git diff --ours" and "--theirs").

That said, even "rebase" will help somewhat. You've got "ORIG_HEAD" to 
use, and that should help at least a _bit_. In particular, you can do

	gitk ORIG_HEAD.. 

to see all the changes you rebased across. But right now you'd have to 
fall back on the "-m -p" thing if you wanted to see it all..

		Linus
