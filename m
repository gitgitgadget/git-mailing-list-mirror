From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 19:48:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161943360.3701@g5.osdl.org>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161052310.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604162006050.19560@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161117360.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604170138470.824@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 04:48:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVJmn-0003WW-KM
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 04:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWDQCsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 22:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWDQCsP
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 22:48:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbWDQCsO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 22:48:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3H2mBtH023662
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 19:48:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3H2mBeV024303;
	Sun, 16 Apr 2006 19:48:11 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604170138470.824@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18813>



On Mon, 17 Apr 2006, Johannes Schindelin wrote:
> 
> Since quite some time, I wanted to have a way to git-rev-list just the 
> revs between commit1 and commit2, i.e. all commits which are ancestors of 
> commit2, and which have commit1 as ancestor. With this, my task would have 
> been more than simple.

Yes. However, it's not trivial.

In fact, what you want is not what you claim you want. To be useful in 
general, you have to _also_ handle the case of "commit2" not beign a 
strict ancestor of "commit1". So what you actually want to do is

 - calculate the merge-head of cmit1 and cmit2 (and if there are multiple, 
   pick some "best" one).
 - pick the shortest path from the merge-head to the cmit1 (and, with a 
   flag, also pick the path from merge-head to cmit2 - sometimes you want 
   to see the whole path from one to the other, sometimes you might want 
   to see just the path from the last common point).

I suspect it ends up being not _that_ different from calculating the 
bisection point, but I haven't thought it through entirely.

		Linus
