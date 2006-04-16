From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 10:58:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161052310.3701@g5.osdl.org>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVBWT-0004kS-9u
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDPR6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWDPR6y
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:58:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbWDPR6x (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:58:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3GHwotH007104
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 10:58:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3GHwoEo011457;
	Sun, 16 Apr 2006 10:58:50 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18798>



On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> 
> I finally found the commit which removed parse_whatchanged_opt() from 
> log-tree.c by
> 
> 	git-rev-list 4a617..next | while read commit; do \
> 		echo $commit; \
> 		git diff $commit^..$commit log-tree.c | \
> 			grep parse_whatchanged; \
> 	done | less

Heh. You really should learn about "-m -p", which does the above, but 
better (it compares against _all_ parents - you would have missed the 
thing _again_ if the "lt/logopt" branch had been the main branch ;)

> However, the combined diff of that commit does not show it, while the diff 
> to the first parent does:
> 
> 	git-show --cc 43f934aa90 | grep parse_whatchanged

Combined merges really only show conflicts where the different parents do 
something different from the end result. Since the whole file was taken 
from the lt/logopt branch, even

	git show -c 43f934aa90

won't show that "log-tree.c" file AT ALL, because there was no content 
conflict: the whole file was taken from one branch, unmodified. 

If you want to see all changes against all parents, you really do need 
"-m -p" (or just "-m", which will show the raw diffs, and which will 
show how the file changes from one parent, but not the other).

Note that NORMALLY, you'd really never want to use "-m -p". It's a very 
very inconvenient format, since normally you want to see only the stuff 
that changed wrt the end result.

So "--cc" really does ignore everything that is irrelevant for the end 
result, and in this case you are very much trying to find somethign that 
is totally irrelevant for the end result, since the function you look for 
had never even _existed_ in the file as far as the end result goes..

		Linus
