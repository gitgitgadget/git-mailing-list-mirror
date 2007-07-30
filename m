From: Craig Boston <craig@olyun.gank.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 17:20:28 -0500
Message-ID: <20070730222028.GE64467@nowhere>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 00:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFdbX-0001o5-Bk
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 00:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967659AbXG3WUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 18:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967055AbXG3WUh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 18:20:37 -0400
Received: from ion.gank.org ([69.55.238.164]:4378 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966360AbXG3WUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 18:20:36 -0400
Received: by ion.gank.org (Postfix, from userid 1001)
	id 825DD10FD9; Mon, 30 Jul 2007 17:20:28 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54286>

> 
> [ snip lots of helpful comments from various people ]
> 

I just wanted to say thanks to Linus and Junio and everyone who
commented, I think I have a much more workable solution now.  With my
brute-force remove and re-add everything script the times for import
looked like this:

Importing /compile/co/RELENG_4 (no changes):
svk import: 166.86 seconds
       git: 455.82 seconds

Importing /compile/co/RELENG_6:
svk import: 203.69 seconds
       git: 796.48 seconds

Importing /compile/co/HEAD:
svk import: 243.90 seconds
       git: 837.13 seconds

Ok, so I remembered wrong, git was only 4x slower.  Still, I knew it
could do better than that...

After transplanting the .git directory from 3 cloned repositories
checked out to the appropriate branch into the CVS checkout directories,
priming them with a 'git status', and using the git ls-file | git
update-index trick followed by commit -a, here are the revised times:

# On branch cvs_RELENG_4
nothing to commit (working directory clean)
git: 67.65 seconds

Created commit 106bc0b: Import 20070730 snapshot
 7 files changed, 259 insertions(+), 75 deletions(-)
 Git repository at /compile/co/RELENG_6/src updated
git: 62.02 seconds

Created commit 776031b: Import 20070730 snapshot
 86 files changed, 10929 insertions(+), 587 deletions(-)
 [snip lots of lines for added files]
 Git repository at /compile/co/HEAD/src updated
git: 61.77 seconds

_MUCH_ better.  I knew it had to be capable of faster :-)

Again, thanks for all the help.  I look forward to seeing what else git
can do!

Craig
