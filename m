From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: git update-index not delete lock file when using different worktree
Date: Wed, 16 Jul 2014 20:18:45 -0700 (PDT)
Message-ID: <1405567125455-7615300.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 05:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7cDa-0000n5-My
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 05:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbaGQDSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 23:18:47 -0400
Received: from sam.nabble.com ([216.139.236.26]:55883 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbaGQDSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 23:18:46 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1X7cDV-0007TT-Fg
	for git@vger.kernel.org; Wed, 16 Jul 2014 20:18:45 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253719>

This is a [issue from
TortoiseGit](https://code.google.com/p/tortoisegit/issues/detail?id=2233).
After doing some test, I report it here.
The following is the testing information I have tested.

### Folder Structure
```
Test
  |-- myrepo
  |     |-- bar.txt
  |     |-- foo.txt
  |
  |-- myrepo.git
        |-- .git
```
Testing repository is
[here](https://code.google.com/p/tortoisegit/issues/detail?id=2233#c2).

### Using different worktree
Set the config file (in the .git folder)
```
[core]
	worktree = ../../myrepo
```

### Test 1 - Git Bash
```
User@PC /d/Repo/myrepo.git (master)
$ git --version
git version 1.9.4.msysgit.0

User@PC /d/Repo/myrepo.git (master)
$ git update-index --refresh
fatal: Unable to write new index file
```
D:\Repo\myrepo.git\\**index.lock** is not deleted.

### Test 2 - Git 2.0.0
Copy testing repository into ```C:\msysgit\MyTest```

Execute```msys.bat```
```$ vagrant up```
```$ vagrant ssh```
```vagrant@precise64:/vagrant/git$ cd /vagrant```
```vagrant@precise64:/vagrant$ cd mytest/myrepo.git```
```
vagrant@precise64:/vagrant/mytest/myrepo.git$ git --version
git version 2.0.0
```
```
vagrant@precise64:/vagrant/mytest/myrepo.git$ git update-index --refresh
fatal: Unable to write new index file
```
Also, **index.lock is not deleted.**

### Test 3 - gitdll of TortoiseGit 
(git version 1.9.0)
Tracing the source code into **compat/mingw.c**
line 289 : xutftowcs_canonical_path() get the value of var. wpathname
```
D:\Repo\myrepo\.git\index.lock
```
It should be
```
D:\Repo\myrepo.git\.git\index.lock
```

line 294 : _wunlink() try to delete the
file.(```D:\Repo\myrepo\.git\index.lock```)
line 295 : GetLastError() return 3(ERROR_PATH_NOT_FOUND)
(Actually, there is no ```D:\Repo\myrepo\.git``` folder.)





--
View this message in context: http://git.661346.n2.nabble.com/git-update-index-not-delete-lock-file-when-using-different-worktree-tp7615300.html
Sent from the git mailing list archive at Nabble.com.
