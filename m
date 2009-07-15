From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: git add on existing sub-repository
Date: Wed, 15 Jul 2009 13:50:56 +0000 (UTC)
Message-ID: <loom.20090715T134313-679@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 15 15:51:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR4tC-0003XC-JV
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 15:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbZGONvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 09:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbZGONvK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 09:51:10 -0400
Received: from main.gmane.org ([80.91.229.2]:52757 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148AbZGONvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 09:51:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MR4t1-0000KM-PK
	for git@vger.kernel.org; Wed, 15 Jul 2009 13:51:08 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 13:51:07 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 13:51:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/531.0 (KHTML, like Gecko) Iron/3.0.189.0 Safari/531.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123309>

I found a weirdness with git add and submodules. 
I did:
 - create 2 repos: subtest, mod1
 - cloned mod1 into subtest
 - in 'subtest': git add mod1

'mod1' gets added as a submodule, but no '.gitmodules' files is written.

Bug ? Feature ?

Thanks for any reply.

Stefan


P.S. Here's a 'script' log of what 
I did (git-make-initial simply creates a new repo with a single commit):

~/tmp$ git version
git version 1.6.3.3

~/tmp$ cat ~/bin/git-make-initial
#!/bin/sh
me=$(basename $0)
if [ ! -z "$1" ]; then
	dir=$1
	test -d $dir || mkdir $dir
else
	dir=.
fi
test -d $dir/.git && (echo "$me: '.git' exists; Not creating initial commit" ; 
exit -1)
test -d $dir/.git || (cd $dir ; git init ; test -f .gitignore || cp 
.git/info/exclude .gitignore ; git add . ; git ci -s -m"Initial commit created 
by $me")

~/tmp$ git-make-initial subtest
Initialized empty Git repository in /home/naewe/tmp/subtest/.git/
[master (root-commit) 8ab9920] Initial commit created by git-make-initial
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore

~/tmp$ git-make-initial mod1
Initialized empty Git repository in /home/naewe/tmp/mod1/.git/
[master (root-commit) 3671274] Initial commit created by git-make-initial
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore

~/tmp$ ls -la subtest mod1
mod1:
insgesamt 11
drwxr-xr-x  3 naewe naewe  104 2009-07-15 15:38 .
drwx------ 13 naewe naewe 6992 2009-07-15 15:38 ..
drwxr-xr-x  8 naewe naewe  328 2009-07-15 15:38 .git
-rw-r--r--  1 naewe naewe  240 2009-07-15 15:38 .gitignore

subtest:
insgesamt 11
drwxr-xr-x  3 naewe naewe  104 2009-07-15 15:38 .
drwx------ 13 naewe naewe 6992 2009-07-15 15:38 ..
drwxr-xr-x  8 naewe naewe  328 2009-07-15 15:38 .git
-rw-r--r--  1 naewe naewe  240 2009-07-15 15:38 .gitignore

~/tmp$ cd subtest
~/tmp/subtest$ git clone ~/tmp/mod1
Initialized empty Git repository in /home/naewe/tmp/subtest/mod1/.git/
~/tmp/subtest$ git add mod1
~/tmp/subtest$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   mod1
#
# Modified submodules:
#
# * mod1 0000000...3671274 (1):
#   > Initial commit created by git-make-initial
#
~/tmp/subtest$ ls -a
.  ..  .git  .gitignore  mod1
~/tmp/subtest$
