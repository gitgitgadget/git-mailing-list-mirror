From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: maildir / read-tree trivial merging getting in the way?
Date: Mon, 13 Feb 2006 18:36:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602131833110.3691@g5.osdl.org>
References: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac>
 <7vy80ewu6n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Clifford <benc@hawaga.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 03:36:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8q3Z-0002X6-Va
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWBNCgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWBNCgn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:36:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750866AbWBNCgn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 21:36:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1E2aMDZ010937
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 18:36:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1E2aLr7020073;
	Mon, 13 Feb 2006 18:36:21 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy80ewu6n.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16105>



On Mon, 13 Feb 2006, Junio C Hamano wrote:
> 
> That would be more naturally done by writing that thing in a
> more reasonable scripting language (not shell, but Perl or
> Python), call ls-tree three times, do whatever merge to come up
> with the final shape of the tree, and then construct the tree
> with a single invocation of "update-index --index-info", maybe
> even starting from an empty index file.

Exactly. Except that it probably makes sense to use "git-diff-tree" to try 
to avoid doing lots of unnecessary work in a script, if the normal case is 
that there's still a lot of stuff that hasn't changed.

So conceptually you would do three "git-ls-tree" invocations, but in 
_practice_ it's probably better to do just one "git-ls-tree", and then use 
"git-diff-tree" to basically generate the differences from that one 
ls-tree to the other cases of interest.

So start with the merge-base, for example, and then basically generate the 
"what changed" between the merge base and the two branch heads. 

That was the plan for doing merges initially, it just turned out that 
doing them in the index made things easier.

			Linus
