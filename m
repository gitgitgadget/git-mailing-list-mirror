From: Josef Wolf <jw@raven.inka.de>
Subject: git-svn clone behaves non-deterministic
Date: Thu, 27 Nov 2008 08:53:51 +0100
Message-ID: <20081127075351.GA12716@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 09:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5bor-0001FJ-FX
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 09:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYK0IAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 03:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYK0IAW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 03:00:22 -0500
Received: from quechua.inka.de ([193.197.184.2]:37732 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbYK0IAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 03:00:20 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1L5bnO-00038g-Nd; Thu, 27 Nov 2008 09:00:18 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id AAF973A72C; Thu, 27 Nov 2008 08:53:51 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101797>

Hello,

I am new to git and decided to get my feet wet by first cloning and
playing with my existing svn repositories.  Thus, I've done this:

 cd /my/test/repos
 for i in repo1 repo2 repo3; do
   repos=https://my.repos.server/repos/$i/trunk
   svn co        $repos svn/$i
   git-svn clone $repos git/$i
 done

 for i in `cd svn; echo *`; do diff --exclude /.svn -Nruw */$i; done

With this, I see that four of the repositories are cloned as expected,
but the fifth has only the .git directory in it.  It appears that
the clone command stopped cloning at r2008, while the repository is
currently at r3761.  So almost the half of the history was not
cloned at all.  I've investigated the offending revision and the
revisions around it, but I can't see anything special about them.
The effect is perfectly reproducible and it stops always on the very
same revision.  I get no error message at all.  I've attached the
last lines of the clone operation at the end of this mail.

Then I go to another machine and enter exactly the same commands as
above.  Both machines are fresh ubuntu-8.10 default installs.

To my surprise, on this other machine the clone operation seems to
have worked for all the repositories.  But the diff command shows
me that arbitrary files are missing in _all_ of the repositories.

Since the repositories were not modified in the mean time, it looks
to me like there's a problem with the "git-svn clone" command.

Any ideas?

  r2005 = e487699eb8f94d6c5e9b732ba75e1c50cae3bb5e (git-svn)
          A       misc/ubuntu-remaster/Rakefile
  r2006 = 8b15a1a5bdc8e6a3bfd7e6eb717ef4c2db0f1dbf (git-svn)
          M       misc/ubuntu-remaster/Rakefile
  r2007 = 27678a3bd98400abdaaaf9af543f9558593fc224 (git-svn)
          M       misc/ubuntu-remaster/Rakefile
  r2008 = bbc2d0cbe4419a499d29afda281b85b5e744a5e6 (git-svn)
  Auto packing your repository for optimum performance. You may also
  run "git gc" manually. See "git help gc" for more information.
  Counting objects: 12446, done.
  Compressing objects: 100% (11999/11999), done.
  Writing objects: 100% (12446/12446), done.
  Total 12446 (delta 7657), reused 0 (delta 0)
  jw@vdr1:/my/test/repos$ l git/misc/
  total 12
  drwxr-xr-x 3 jw jw 4096 Nov 27 08:27 ./
  drwxr-xr-x 3 jw jw 4096 Nov 27 08:27 ../
  drwxr-xr-x 9 jw jw 4096 Nov 27 08:38 .git/
