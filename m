From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: [StGit] Import file(s) problem
Date: Fri, 28 Nov 2008 01:08:21 +0900
Message-ID: <492EC5F5.2050807@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Thu Nov 27 17:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5jfH-0007yq-G6
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 17:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYK0QXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 11:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbYK0QXI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 11:23:08 -0500
Received: from smtp14.dti.ne.jp ([202.216.231.189]:56124 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYK0QXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 11:23:07 -0500
X-Greylist: delayed 877 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Nov 2008 11:23:07 EST
Received: from shinya-kuribayashis-macbook.local (PPPax805.tokyo-ip.dti.ne.jp [210.159.155.55]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id mARG8MVa015917;Fri, 28 Nov 2008 01:08:22 +0900 (JST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101815>

Hi Catalin and Karl,

Today I encountered a problem when importing a patch.  I don't know this
is a known issue or not. If there are good workarounds for this, I'd
like to know that.  Any comments are appreciated.


Steps to reproduce
-------------------

1. Prepare a patch, say stg-test.patch

2. Rename it to have '..' extension

   $ mv stg-test.patch stg-test..patch

3. Import it

   $ stg import /path/to/stg-test..patch

   You can see a lot of errors.  See the log below.

4. At this point, just few stg operations are available.  I had to
   switch to an other branch, then force deleting the corrupted branch
   to return to the original state.

Note
-----

The same goes to stg import -m [e-mail file].  So this seems to be
trigged due to the wrong '..' extension.

Log
----

skuribay@ubuntu:~/kernel/stgit.git$ (modify some file(s))
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg diff >> ../stg-test.patch
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg status --reset
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg branch --create foo
Checking for changes in the working directory ... done
Recording as a local branch
Branch "foo" created
skuribay@ubuntu:~/kernel/stgit.git$ cd ../
skuribay@ubuntu:~/kernel$ 
skuribay@ubuntu:~/kernel$ mv stg-test.patch stg-test..patch
skuribay@ubuntu:~/kernel$ 
skuribay@ubuntu:~/kernel$ cd -
/home/skuribay/kernel/stgit.git
skuribay@ubuntu:~/kernel/stgit.git$ stg import ../stg-test..patch
Checking for changes in the working directory ... done
fatal: Cannot lock the ref 'refs/patches/foo/stg-test..patch'.
Traceback (most recent call last):  
  File "/home/skuribay/bin/stg", line 43, in <module>
    main()
  File "home/skuribay/lib/python2.5/site-packages/stgit/main.py", line 175, in main
  File "home/skuribay/lib/python2.5/site-packages/stgit/main.py", line 154, in _main
  File "home/skuribay/lib/python2.5/site-packages/stgit/commands/common.py", line 482, in write_log
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 372, in compat_log_entry
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 322, in log_entry
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 179, in from_stack
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 179, in <genexpr>
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 157, in get
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/git.py", line 486, in __getitem__
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 147, in create_patch
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 26, in commit
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/git.py", line 449, in get
KeyError: 'refs/patches/foo/stg-test..patch'
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg diff
Error: Unhandled exception:
Traceback (most recent call last):  
  File "home/skuribay/lib/python2.5/site-packages/stgit/main.py", line 142, in _main
  File "home/skuribay/lib/python2.5/site-packages/stgit/commands/common.py", line 491, in setup
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 524, in compat_log_external_mods
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 511, in log_external_mods
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 322, in log_entry
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 179, in from_stack
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 179, in <genexpr>
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 157, in get
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/git.py", line 486, in __getitem__
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 147, in create_patch
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 26, in commit
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/git.py", line 449, in get
KeyError: 'refs/patches/foo/stg-test..patch'
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg series
> stg-test..patch
skuribay@ubuntu:~/kernel/stgit.git$ stg branch master
Error: Unhandled exception:
Traceback (most recent call last):  
  File "home/skuribay/lib/python2.5/site-packages/stgit/main.py", line 142, in _main
  File "home/skuribay/lib/python2.5/site-packages/stgit/commands/common.py", line 501, in setup
  File "home/skuribay/lib/python2.5/site-packages/stgit/commands/common.py", line 495, in setup
  File "home/skuribay/lib/python2.5/site-packages/stgit/commands/common.py", line 491, in setup
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 524, in compat_log_external_mods
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 511, in log_external_mods
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 322, in log_entry
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 179, in from_stack
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/log.py", line 179, in <genexpr>
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 157, in get
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/git.py", line 486, in __getitem__
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 147, in create_patch
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/stack.py", line 26, in commit
  File "home/skuribay/lib/python2.5/site-packages/stgit/lib/git.py", line 449, in get
KeyError: 'refs/patches/foo/stg-test..patch'
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ git checkout master
Switched to branch "master"
skuribay@ubuntu:~/kernel/stgit.git$ stg branch -l
Available branches:
  s     foo     |
> s     master  |
skuribay@ubuntu:~/kernel/stgit.git$ stg branch --delete foo
Deleting branch "foo" ...
  stg branch: Cannot delete: the series still contains patches
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg branch --delete --force foo
Deleting branch "foo" ...
  Warning: refs/patches/foo/stg-test..patch does not exist
done
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg branch -l
Available branches:
> s     master  |
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ rm -f ../stg-test..patch
skuribay@ubuntu:~/kernel/stgit.git$ 
skuribay@ubuntu:~/kernel/stgit.git$ stg version
Stacked GIT 0.14.3.285.g62874
git version 1.5.4.3
Python version 2.5.2 (r252:60911, Jul 31 2008, 17:28:52) 
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
skuribay@ubuntu:~/kernel/stgit.git$ 

Thanks,

  Shinya
