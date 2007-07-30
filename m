From: Craig Boston <craig@olyun.gank.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 15:10:23 -0500
Message-ID: <20070730201023.GC64467@nowhere>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFbZf-0005CH-0h
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 22:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967472AbXG3UKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968318AbXG3UKa
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 16:10:30 -0400
Received: from ion.gank.org ([69.55.238.164]:1656 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968248AbXG3UK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 16:10:28 -0400
Received: by ion.gank.org (Postfix, from userid 1001)
	id E156A110D3; Mon, 30 Jul 2007 15:10:23 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54259>

On Mon, Jul 30, 2007 at 12:52:52PM -0700, Linus Torvalds wrote:
> On Mon, 30 Jul 2007, Craig Boston wrote:
> > 1. Will it notice deleted files?
> 
> Yes, although I think you need to do "git commit -a" for that. 

Ah, nice.  I had underestimated how smart git is, that was the whole
reason I did the 'git rm -r .' dance at first :-)

> > 2. How can I tell it what branch to commit to?
> 
> Whatever branch is checked out in the GIT_DIR will be the one that it 
> commits to.

Hmm, ok.  I tried it out and it was unhappy with GIT_DIR pointing at the
bare repository (no index file I presume), so I'll need a minimum of one
clone.  With clone -s the repository itself shouldn't take up hardly any
space.  It sounds like my options are:

1) Have a separate repository clone for each branch that I want to
import to and leave that branch permanently checked out.  I lose the
disk space for N working copies, but on the server I'm doing the import
on, it's not a huge issue, especially with ZFS compression ;-)

 * This might not actually be so bad if I put the .git directory inside
   of the CVS checkout directory and used it as my "working copy".  I
   just need to insure that git doesn't create any additional files in
   there, as cvsup is really picky about not deleting files that it
   didn't create, even if they were removed from CVS.

2) Have one repository clone that gets re-used for each import, with the
   "checked out" branch getting changed before the import.  As far as I can
   tell this means suffering the "git checkout" overhead for 30,000 files,
   which is conceptually inefficient but in real time only a minute or so.

 * Unless of course there's a way to forcibly change the state that the
   repository thinks it's in without physically checking out the files.
   I think it would still need to update index however.

   I tried git reset --soft without success.  If this is possible, it
   also makes option 1 more attractive if I can safely delete the
   working copy files that it won't be using anyway.

Craig
