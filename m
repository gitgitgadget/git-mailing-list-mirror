From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:26:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:27:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4uK-0005Pj-7R
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWITQ0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWITQ0l
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:26:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751738AbWITQ0k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:26:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KGQXnW021585
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 09:26:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KGQWsE003024;
	Wed, 20 Sep 2006 09:26:33 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
X-Spam-Status: No, hits=-0.506 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27367>



On Wed, 20 Sep 2006, Linus Torvalds wrote:
> 
> That's a really important point. You can trivially say "I don't care". 
> It's literally one extra character. But it should be the _user_ that says 
> so, not the SCM.
> 
> The whole point of the SCM is to care.

Btw, the "+" also protects you from local errors.

Let's say that you've committed some work of your own onto a branch that 
you happen to follow. Guess what? By default, git refuses to throw your 
hard work away.

This is not just a random thing. It is in fact one of the very core issues 
of having multiple people work together on the same remote repo. We don't 
do it very much (because it's often easier for everybody to have their 
own), but the "CVS workflow" with one common repository is another example 
why WE MUST NOT JUST RESET THE HEADS!

Think about it. You and somebody else works on a common branch, using a 
common source repo. When you "fetch", you want to get all the work that 
the other person has done. But you sure as hell don't want that work to 
overwrite your own work.

So what does git do? It notices if you have a local commit on that shared 
branch (because it no longer fast-forwards to the other end), and it tells 
you exactly that: it says that branch so-and-so doesn't fast-forward, and 
refuses to overwrite it.

What would you do? You should in that case switch to the offending branch, 
AND DO A MERGE of your work and the work you shared with another person, 
and then push out the result. 

So the _last_ thing you want to happen is for your work to be silently 
just overwritten.

Trust me, git does the right thing here. No ifs, buts or maybes about it.

			Linus
