From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 17:14:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602131706460.3691@g5.osdl.org>
References: <20060213002502.5c23122c.akpm@osdl.org> <7virrj1v44.fsf@assigned-by-dhcp.cox.net>
 <20060213013205.4ba47836.akpm@osdl.org> <7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
 <20060213021917.742b2b10.akpm@osdl.org> <7v8xsezsni.fsf@assigned-by-dhcp.cox.net>
 <20060213165620.11ec6051.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 02:14:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8omN-0000Jw-9b
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 02:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWBNBOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 20:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWBNBOd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 20:14:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWBNBOc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 20:14:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1E1EQDZ007246
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 17:14:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1E1EP5f017344;
	Mon, 13 Feb 2006 17:14:26 -0800
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213165620.11ec6051.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16095>



On Mon, 13 Feb 2006, Andrew Morton wrote:
> 
> The bug is in Jeff's tree only
> (git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL)
> so I wanted to perform the bisection on the git-netdev-all branch.

Actually, what you should do, is not play any games at all, but just tell 
"git bisect" what the problem is. It will do the right thing.

So in this case, what you do is _literally_ to

	# fetch Jeff's tree (you obviously had this already, but I just 
	# want to point it out as a "name that branch" thing)
	git fetch netdev-all

	# we know that that tree is broken
	git bisect start
	git bisect bad netdev-all

	# We know that Linus' top-of-tree doesn't have the bug
	git bisect good origin

and off you go. It absolutely magically does the right thing, and will 
bisect stuff that is only in the netdev branch and not in my tree. No 
guessing necessary, no need to try to figure out what the differences are. 
git will do it all for you.

And notice how it will work perfectly well, even if the two points you 
have tested AREN'T EVEN DIRECTLY RELATED! The "good" and "bad" points do 
not have to have any direct relationship other than a common parent 
_somewhere_. "git bisect" really is that good.

(The above is obviously assuming that "origin" is set to my tree, 
self-aggrandizing bastard that I am, and that you've set up a 
.git/remotes/netdev-all file pointing to Jeff's tree - your setup may vary 
from this, so you'd have to change the lines to match)

			Linus
