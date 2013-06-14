From: worley@alum.mit.edu (Dale R. Worley)
Subject: Difficulty adding a symbolic link
Date: Fri, 14 Jun 2013 12:15:12 -0400
Message-ID: <201306141615.r5EGFCH2015143@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 18:22:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWlo-0001Zz-O1
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3FNQWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:22:24 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:52794
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752879Ab3FNQWV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 12:22:21 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2013 12:22:21 EDT
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id oCur1l0061wpRvQ57GFEwW; Fri, 14 Jun 2013 16:15:14 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id oGFD1l01M1KKtkw3eGFEdD; Fri, 14 Jun 2013 16:15:14 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r5EGFDjX015144;
	Fri, 14 Jun 2013 12:15:13 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r5EGFCH2015143;
	Fri, 14 Jun 2013 12:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1371226514;
	bh=qIz4UdEpuvyx9kxxoQpDoR9EN1C2FFzHJjcbZ0hH6Vw=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=J03wD+lj4cCyXIpS6dHrpquE/5YRC44LvIlORlUwMZ3mfgNsQa5qivXPhyuJQntzy
	 8HI6OqTFyxoHWC0JhcqI7hLnZwu+oZBrSvFkI5dzB9cxOYjf6UPV5if1zfp8/HHdz+
	 cFWW0h9wLtpnL8RytRHSGDzBuNN1aA1ROzPA8drvFzLLEMzUfGlv3V/fw6qvSbMqq1
	 ksnliZ3WXiujQRmVmJV18mjRsBcVmkyC+YC6pV0VvmPfWSdjLO64iYQYT4qZAx8vU9
	 JvoDRKL31bvIQAn4hX6IkWH8J98Hy4uuHBPapWjt6XyT1xLqYg/Xu7BL6JBY5gepk8
	 DbAHI/FAFP7XQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227895>

I'm having a problem with "git add" in version 1.7.7.6.

The situation is that I have a repository that is contained in a
second-level directory, a sub-sub-directory of "/".  The core.worktree
of the repository is "/", so the working directory is the entire file
tree.  I want this repository to track selected files, which I add
with "git add".

The difficulty is that "git add" seems to not add specific files,
depending on how they are specified as arguments to "git add".  In
particular, /dev/dvd (which is a symbolic link) can be added with "git
add ../../dev/dvd" but not with "git add /dev/dvd".  On the other
hand, /etc/hosts (an ordinary file) can be added with either "git add
/etc/hosts" or "git add ../../etc/hosts".

To demonstrate the problem, I've written a script.  A typical
execution of the script is as follows.  The lines at the left margin
start with "$", and are the lines of the script.  The lines indented 4
spaces start with "+", and are the "simple commands" as they are
executed by the shell, showing the values substituted for the shell
variables.  The lines indented 8 spaces are the output of the various
commands.

Someone suggested that the problem may be triggered by the fact that
/dev is in a different filesystem than / and /etc.  I added a third
section to the script by creating a symbolic link from /etc/hosts.link
to /etc/hosts, which is thus in the same filesystem as / and the
repository.  Git handles it as expected.

Any help with this would be appreciated.

Dale

$ set -x
$ 
$ # Show git version.
$ git version
    + git version
        git version 1.7.7.6
$ 
$ # To be run in a directory that is contained in /.
$ pwd
    + pwd
        /git-add-issue
$ 
$ # Make a test directory.
$ DIR=temp.$$
    + DIR=temp.10714
$ mkdir $DIR
    + mkdir temp.10714
$ cd $DIR
    + cd temp.10714
    ++ pwd
$ DIR_ABSOLUTE=$( pwd )
    + DIR_ABSOLUTE=/git-add-issue/temp.10714
$ 
$ # Create a new repository.
$ git init
    + git init
        Initialized empty Git repository in /git-add-issue/temp.10714/.git/
$ # Set the worktree to be /
$ git config core.worktree /
    + git config core.worktree /
$ # Create empty commit.
$ git commit --allow-empty -m Empty.
    + git commit --allow-empty -m Empty.
        [master (root-commit) 62d86cb] Empty.
$ 
$ # Show empty status
$ git status -uno
    + git status -uno
        # On branch master
        nothing to commit (use -u to show untracked files)
$ 
$ # First test:  /dev/dvd, which is a symbolic link.
$ 
$ # Try to add /dev/dvd
$ ABSOLUTE_NAME=/dev/dvd
    + ABSOLUTE_NAME=/dev/dvd
$ ll $ABSOLUTE_NAME
    + ls -al /dev/dvd
        lrwxrwxrwx. 1 root root 9 Jun 12 22:23 /dev/dvd -> /dev/dvd1
$ git add $ABSOLUTE_NAME
    + git add /dev/dvd
$ git status -uno
    + git status -uno
        # On branch master
        nothing to commit (use -u to show untracked files)
$ git reset
    + git reset
$ 
$ # Try with alternative name ../../dev/dvd
$ RELATIVE_NAME=../../dev/dvd
    + RELATIVE_NAME=../../dev/dvd
$ ll $RELATIVE_NAME
    + ls -al ../../dev/dvd
        lrwxrwxrwx. 1 root root 9 Jun 12 22:23 ../../dev/dvd -> /dev/dvd1
$ git add $RELATIVE_NAME
    + git add ../../dev/dvd
$ git status -uno
    + git status -uno
        # On branch master
        # Changes to be committed:
        #   (use "git reset HEAD <file>..." to unstage)
        #
        #	new file:   ../../dev/dvd
        #
        # Untracked files not listed (use -u option to show untracked files)
$ git reset
    + git reset
$ 
$ # Second test:  /etc/hosts, which is an ordinary file.
$ 
$ # Try to add /etc/hosts
$ ABSOLUTE_NAME=/etc/hosts
    + ABSOLUTE_NAME=/etc/hosts
$ ll $ABSOLUTE_NAME
    + ls -al /etc/hosts
        -rw-r--r--. 1 root root 222 Nov  4  2012 /etc/hosts
$ git add $ABSOLUTE_NAME
    + git add /etc/hosts
$ git status -uno
    + git status -uno
        # On branch master
        # Changes to be committed:
        #   (use "git reset HEAD <file>..." to unstage)
        #
        #	new file:   ../../etc/hosts
        #
        # Untracked files not listed (use -u option to show untracked files)
$ git reset
    + git reset
$ 
$ # Try with alternative name ../../etc/hosts
$ RELATIVE_NAME=../../etc/hosts
    + RELATIVE_NAME=../../etc/hosts
$ ll $RELATIVE_NAME
    + ls -al ../../etc/hosts
        -rw-r--r--. 1 root root 222 Nov  4  2012 ../../etc/hosts
$ git add $RELATIVE_NAME
    + git add ../../etc/hosts
$ git status -uno
    + git status -uno
        # On branch master
        # Changes to be committed:
        #   (use "git reset HEAD <file>..." to unstage)
        #
        #	new file:   ../../etc/hosts
        #
        # Untracked files not listed (use -u option to show untracked files)
$ git reset
    + git reset
$ 
$ # Third test:  /etc/hosts.link, which is a link to /etc/hosts
$ 
$ # Try to add /etc/hosts.link
$ ABSOLUTE_NAME=/etc/hosts.link
    + ABSOLUTE_NAME=/etc/hosts.link
$ ll $ABSOLUTE_NAME
    + ls -al /etc/hosts.link
	lrwxrwxrwx. 1 root root 5 Jun 14 12:04 /etc/hosts.link -> hosts
$ git add $ABSOLUTE_NAME
    + git add /etc/hosts.link
$ git status -uno
    + git status -uno
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   ../../etc/hosts
	#
	# Untracked files not listed (use -u option to show untracked files)
$ git reset
    + git reset
$ 
$ # Try with alternative name ../../etc/hosts.link
$ RELATIVE_NAME=../../etc/hosts.link
    + RELATIVE_NAME=../../etc/hosts.link
$ ll $RELATIVE_NAME
    + ls -al ../../etc/hosts.link
	lrwxrwxrwx. 1 root root 5 Jun 14 12:04 ../../etc/hosts.link -> hosts
$ git add $RELATIVE_NAME
    + git add ../../etc/hosts.link
$ git status -uno
    + git status -uno
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   ../../etc/hosts.link
	#
	# Untracked files not listed (use -u option to show untracked files)
$ git reset
    + git reset
