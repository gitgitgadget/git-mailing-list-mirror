From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Git 1.6.0.1 breaks git-svn with perl 5.8.0
Date: Mon, 1 Sep 2008 11:27:59 +0200
Message-ID: <48BBB59F.9080204@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 11:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka5o4-0005Fr-Bd
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYIAJda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYIAJda
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:33:30 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:12742 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269AbYIAJda (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 05:33:30 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Sep 2008 05:33:29 EDT
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Mon, 1 Sep 2008 11:28:01 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94548>

The problem is that Git.pm depends on the "new" method of File::Temp 
introduced in 0.14.
perl 5.8.0 only has File::Temp 0.13 while 0.14 was included with 5.8.1 
and later.
The breakage was introduced in this commit:
e41352b24e29eba43d00a3fd117befaef1d594bc

-tgc

mock-chroot> ./t9100-git-svn-basic.sh -i -v
Initialized empty Git repository in 
/builddir/build/BUILD/git-1.6.0.1/t/trash directory/.git/
* define NO_SVN_TESTS to skip git-svn tests
* expecting success:
         mkdir import &&
         cd import &&
         echo foo > foo &&
         ln -s foo foo.link
         mkdir -p dir/a/b/c/d/e &&
         echo "deep dir" > dir/a/b/c/d/e/file &&
         mkdir bar &&
         echo "zzz" > bar/zzz &&
         echo "#!/bin/sh" > exec.sh &&
         chmod +x exec.sh &&
         svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
         cd .. &&
         rm -rf import &&
         git-svn init "$svnrepo"
Parentheses missing around "my" list at 
/builddir/build/BUILD/git-1.6.0.1/t/../git-svn line 4387.
*   ok 1: initialize git-svn

* expecting success: git-svn fetch
Parentheses missing around "my" list at 
/builddir/build/BUILD/git-1.6.0.1/t/../git-svn line 4387.
Can't locate object method "new" via package "File::Temp" at 
/builddir/build/BUILD/git-1.6.0.1/t/../perl/blib/lib/Git.pm line 1024.

* FAIL 2: import an SVN revision into git
         git-svn fetch
mock-chroot> exit
