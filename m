From: Robert Wohlrab <robert.wohlrab@gmx.de>
Subject: Wrong url using relative submodule over gitorious-ssh
Date: Tue, 27 Jan 2009 14:37:43 +0100
Message-ID: <200901271437.43737.robert.wohlrab@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 14:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRoA0-0007T8-Tp
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 14:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbZA0Nhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 08:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZA0Nhy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 08:37:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:36028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753373AbZA0Nhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 08:37:53 -0500
Received: (qmail invoked by alias); 27 Jan 2009 13:37:51 -0000
Received: from unknown (EHLO sven-desktop.localnet) [89.246.192.191]
  by mail.gmx.net (mp044) with SMTP; 27 Jan 2009 14:37:51 +0100
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX182/VwMGrM2WZVQTxoO6M6CVmHpYNp4UAkfFu1dMS
	nK4fle+EC8lZOz
User-Agent: KMail/1.11.0 (Linux/2.6.28.1; KDE/4.2.0; x86_64; ; )
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107345>

Hi,
I tried to use submodules in git. Since I am using gitorious at the moment it 
would be nice to have relative urls to be able to checkout as user and as 
developer. When I am using a checkout over git's native protocol it works fine 
but when I am trying to use ssh it creates a bogus url and nothing changes if 
I am using more ../ before the url.
Lets explain it by example. First thing is that we are assuming that we 
checked out it over git's own protocol (it is emulated by setting the origin 
url in my example)

$ mkdir test1
$ cd test1
$ git init
$ git remote add origin git://gitorious.org/test/mainline.git
$ git submodule init
$ git submodule add ../../test2/mainline.git subdir
 Initialized empty Git repository in ~/test1/subdir/.git/
 remote: Counting objects: 123, done.
 ....

Ok, you will receive a 
 Initialized empty Git repository in ~/test1/subdir/.git/
 fatal: The remote end hung up unexpectedly
 Clone of 'git://gitorious.org/test2/mainline.git' into submodule path 
'subdir' failed
but that is fine because git://gitorious.org/test2/mainline.git is a valid 
gitorious url (if somebody would create test2 as project).

Lets take a look at gitorious urls for ssh push access. They look like 
git@gitorious.org:test1/mainline.git - similar to the ones used for pull over 
the public git daemon.

$ mkdir test1
$ cd test1
$ git init
$ git remote add origin git@gitorious.org:test1/mainline.git
$ git submodule init
$ git submodule add ../../test2/mainline.git subdir
 Initialized empty Git repository in ~/test1/subdir/.git/
 Access denied or bad repository path
 fatal: The remote end hung up unexpectedly
 Clone of 'git@gitorious.org:test1/test2/mainline.git' into submodule path 
'subdir' failed

This is definitely not the url I expected. It is unimportant how many more ../ 
I add but the test1/ will not get away. It is also important that their is no 
/ after : or otherwise the clone will fail too.

This is an important issue for KDE because they want to use (Qt's) gitorious 
and maybe submodules when they want switch to git.

$ git --version                                                                                                                                                 
 git version 1.6.1.1.230.gdfb04
and on my origin/next test
$ git --version                                                                                                                                                 
 git version 1.6.1.1.363.g2a3bd
-- 
Robert Wohlrab
