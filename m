From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: git and gitweb inconsistencies
Date: Sat, 22 Oct 2005 20:14:12 -0400
Message-ID: <20051023001412.GA22679@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 23 02:15:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETTVa-0006Fg-Vj
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 02:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVJWAOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 20:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVJWAOO
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 20:14:14 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:20400 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751314AbVJWAOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 20:14:14 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023001411.KCCJ28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 22 Oct 2005 20:14:11 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1ETTV6-0005wo-UC
	for git@vger.kernel.org; Sat, 22 Oct 2005 20:14:12 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10478>

I've been experimenting with git and gitweb, but I've reached deadend.
Maybe someone can help?


Short Version:

In sub git_get_type in gitweb.cgi, this line:
  open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;

results in:
error: unable to find e71b869f3333ad10a492251e099ed9176248a420
fatal: git-cat-file e71b869f3333ad10a492251e099ed9176248a420: bad file

BUT, from the shell:
$ git-cat-file -t e71b869f3333ad10a492251e099ed9176248a420
commit


Longer explanation:

Initially I created the git repository using git-cvsimport as
described in the cvs-migration document.  I also installed gitweb.cgi
and everything seemed to be fine.  In particular the refs/heads/* files
referred to the tips of current branches in cvs.  I was quite pleased.

A few days later, I ran git-cvsimport again, with -i.  This imported
just the recent changes, but the view from gitweb didn't change.  :(

At first, I thought that the git-cvsimport hadn't worked.  But,
git-whatchanged clearly showed the new changes.  (I later learned that
git-rev-list also returned the tip-of-branch commits.)  After reading
gitweb.cgi, I realized that the refs/heads/* files had not been
changed, so they still referred to the tip-of-branch for the initial
import.  (I expected the refs/heads/* to point to the last commit on
each branch.  Was that wrong?)

Anyway, I tried to make a new head that actually pointed to what I
expected: 

$ echo `git-rev-list tip --max-count=1` > refs/heads/mytest
$ git-cat-file -t `cat refs/heads/mytest`
commit

No problem.  But, this same task doesn't seem to work from gitweb.cgi:

$ ./gitweb.cgi http://localhost/cgi-bin/gitweb.cgi?p=test\;a=heads > /dev/null
error: unable to find e71b869f3333ad10a492251e099ed9176248a420
fatal: git-cat-file e71b869f3333ad10a492251e099ed9176248a420: bad file

How can this be?  Have I messed something up, or am I just totally confused?

-chris

ps. please cc, not subscribed.
