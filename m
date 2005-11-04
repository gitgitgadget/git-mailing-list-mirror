From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trying to Update All Heads of a Repository
Date: Thu, 3 Nov 2005 17:04:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511031655350.27915@g5.osdl.org>
References: <E1EXpN9-00034x-7g@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 02:07:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXq2Z-0006uu-37
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 02:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbVKDBFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 20:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVKDBEh
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 20:04:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161028AbVKDBEX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 20:04:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA414FnO025909
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Nov 2005 17:04:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA414Aoe013760;
	Thu, 3 Nov 2005 17:04:13 -0800
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EXpN9-00034x-7g@jdl.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11114>



On Thu, 3 Nov 2005, Jon Loeliger wrote:
> 
> I don't know how to say "Grab all the updates for
> all the heads for which I have heads in my .git/refs".

Well, you can't per se - there's no guarantee that the heads on the other 
side match, and in fact usually they won't (at the very minimum, the 
remote "master" tends to be the local "origin", although if you never do 
any development at _all_, you can make even that match).

I sent out a patch some time ago that added "--all" and "--tags", but only 
the "--tags" part was accepted. Arguably for good reasons.

But "git fetch" will take a list of heads. So you can do

	git fetch repo master:origin pu todo

and it will update the three local heads (origin, pu and todo) from the 
remote heads master, pu and todo respectively).

IF you have a 100% match between heads names locally and remotely, you 
could also do something like

	git fetch repo $(cd .git/refs ; echo heads/*)

which is pretty cheesy, but should work ;)

As to your experiences with "git pull" - it should work fine too, but you 
really do need to make sure that the branch you are in always matches the 
branch you're pulling. Otherwise you'll be doing a merge between two 
different branches - which is a valid operation, but not what you're 
trying to achieve here.

As we saw earlier, the way to undo an unsuccessful "git pull" is to do a 
"git reset --hard". Undoing a _successful_ git pull is actually slightly 
harder in the general case (it's really undoing a series of commit), but 
if you do it right after the pull, you can do

	git reset --hard ORIG_HEAD

because "git pull" will save the original head before pulling.

			Linus
