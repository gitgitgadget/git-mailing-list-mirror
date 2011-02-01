From: Ivan Kanis <expire-by-2011-02-06@kanis.fr>
Subject: problem when pulling a specific branch from origin
Date: Tue, 01 Feb 2011 18:25:55 +0100
Message-ID: <877hdjy8d8.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 18:45:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKHq-0000af-3a
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab1BARo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 12:44:59 -0500
Received: from kanis.fr ([75.127.73.245]:3605 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485Ab1BARo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 12:44:58 -0500
X-Greylist: delayed 1139 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2011 12:44:58 EST
Received: from nantes.visionobjects.com ([92.103.229.106] helo=yan)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <expire-by-2011-02-06@kanis.fr>)
	id 1PkJzJ-0000O7-10
	for git@vger.kernel.org; Tue, 01 Feb 2011 12:25:57 -0500
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165834>

Hello,

When I pull a specific branch from a repository I get in a state where
git thinks I am ahead of the branch by one commit. The use case is a
programmer that doesn't want to pull all the branches of the server.

I have made a small script to reproduce the problem:

----
#!/bin/sh

rm -rf foo bar
git --version
mkdir foo
cd foo
git init
echo foo > foo.txt
git add foo.txt
git commit -am"foo"
git checkout -b branch
cd ..
git clone foo bar
cd foo
echo bar > foo.txt
git commit -am"bar"
cd ..
cd bar
git pull origin branch
git status
git branch -rv
----

I get the following output:

----
git version 1.7.3.5
Initialized empty Git repository in /home/ivan/tmp/foo/.git/
[master (root-commit) eefa065] foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo.txt
Switched to a new branch 'branch'
Cloning into bar...
done.
[branch 7ecd065] bar
 1 files changed, 1 insertions(+), 1 deletions(-)
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /home/ivan/tmp/foo
 * branch            branch     -> FETCH_HEAD
Updating eefa065..7ecd065
Fast-forward
 foo.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
nothing to commit (working directory clean)
  origin/HEAD   -> origin/master
  origin/branch eefa065 foo
  origin/master eefa065 foo
----

I expected to not be ahead of origin/master and that origin/branch
points to 7ecd065. Is this a bug? 

Take care,
-- 
Ivan Kanis

Sure, ninety percent of science fiction is crud. That's because ninety
percent of everything is crud.
    -- Theodore Sturgeon 
