From: Luke Campagnola <luke.campagnola@gmail.com>
Subject: Error "fatal: not a git repository" after auto packing
Date: Mon, 11 Aug 2014 18:56:16 -0400
Message-ID: <CACZXET_qPzBtqJLXBbou+iZ_Muj=VqCBe5qMADN72VScsuHRVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 00:56:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGyWK-0006KU-5j
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 00:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbaHKW4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 18:56:48 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:46920 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbaHKW4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 18:56:47 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so6645317oag.35
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 15:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Ls+0Qp7nMkjwLQDD74utPI6udYLqxSDtCQVqf7f0viM=;
        b=dFtouZnay3bX7yCpIIp5lOmbSXl9zik2ZCdoIbP3xFeNc1aJB8uHG+NUQHNJmv2hdX
         Ia9rrkqhqSd5cR/NGvsn1gwheY0nYO91pLVp2MU+tYwn2R+yNo6xzC/NLcT/UZeTOxzZ
         vKTS/AAPL4bGVw0t7J5VzyMd9w6Wz047vchaDpVKc+VTpT8m/DOxox13mDIc+25Tj9Du
         QbnvjaDM6qlwVn9W21/YazQvGWB7khvJ1J1zjEqAfRHuzPIiH6fMekcHWjSguxgYm6Kl
         vXSPrwFB4wBFnVVi65YD/zhRXg/GbpLbLcwrxxRbEOleNnbrph/VSVlnFH8UMHLEdP8q
         FbMg==
X-Received: by 10.182.24.38 with SMTP id r6mr841224obf.10.1407797806661; Mon,
 11 Aug 2014 15:56:46 -0700 (PDT)
Received: by 10.202.18.203 with HTTP; Mon, 11 Aug 2014 15:56:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255141>

Greetings,

I have been working happily with git for a couple of years, and ran
into a mysterious issue today: after running a git-pull during which I
saw the message "Auto packing the repository for optimum performance".
I now receive the error "Fatal: not a git repository" when running any
git commands, and a little investigation revealed that my .git/refs
directory has gone missing, presumably because the refs were all
combined into .git/packed-refs. To restore access to the repository,
all I needed was to `mkdir .git/refs`. Is this a known bug? It seems
like either git should tolerate the absence of a .git/refs directory,
or the auto packer should not remove it.

I am using git 1.9.1 on kubuntu 14.04. The surrounding console output follows:

raven:/home/luke/vispy (transform-cache)$ git commit -a
[transform-cache 15a0fe3] Optimizations for grid_large
 6 files changed, 91 insertions(+), 52 deletions(-)

raven:/home/luke/vispy (transform-cache)$ git push lcampagn transform-cache
Counting objects: 114, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (31/31), done.
Writing objects: 100% (31/31), 4.00 KiB | 0 bytes/s, done.
Total 31 (delta 25), reused 0 (delta 0)
To git@github.com:lcampagn/vispy.git
   24b37a6..15a0fe3  transform-cache -> transform-cache

raven:/home/luke/vispy (transform-cache)$ git fetch vispy
remote: Counting objects: 78, done.
remote: Compressing objects: 100% (78/78), done.
remote: Total 78 (delta 34), reused 0 (delta 0)
Unpacking objects: 100% (78/78), done.
From https://github.com/vispy/vispy
   ec740af..fd8aa37  master     -> vispy/master
Auto packing the repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 5349, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (5315/5315), done.
Writing objects: 100% (5349/5349), done.
Total 5349 (delta 3977), reused 0 (delta 0)
Removing duplicate objects: 100% (256/256), done.

raven:/home/luke/vispy (transform-cache)$ git checkout master
Switched to branch 'master'
Deleted 103 .pyc files
Deleted 11 empty directories

raven:/home/luke/vispy$ git pull vispy master
fatal: Not a git repository (or any of the parent directories): .git

raven:/home/luke/vispy$ git status
fatal: Not a git repository (or any of the parent directories): .git

raven:/home/luke/vispy$ ls -al .git
total 288
drwxr-xr-x   6 luke luke   4096 Aug 11 17:09 .
drwxr-xr-x   9 luke luke   4096 Aug 11 09:25 ..
-rw-r--r--   1 luke luke    601 Aug 11 12:22 COMMIT_EDITMSG
-rw-rw-r--   1 luke luke   1088 Aug 11 09:21 config
-rw-r--r--   1 luke luke     73 Mar  2 08:41 description
-rw-r--r--   1 luke luke    323 Aug 11 16:56 FETCH_HEAD
-rw-r--r--   1 luke luke    337 Mar  3 10:18 GIT_COLA_MSG
-rw-r--r--   1 luke luke 193478 Aug 11 11:14 gitk.cache
-rw-rw-r--   1 luke luke     23 Aug 11 17:09 HEAD
drwxr-xr-x   2 luke luke   4096 Mar  8 07:30 hooks
-rw-rw-r--   1 luke luke  31104 Aug 11 17:09 index
drwxr-xr-x   2 luke luke   4096 Aug 11 16:57 info
drwxr-xr-x   3 luke luke   4096 Aug 11 16:56 logs
drwxr-xr-x 105 luke luke   4096 Aug 11 16:57 objects
-rw-rw-r--   1 luke luke     41 Aug 11 09:25 ORIG_HEAD
-rw-rw-r--   1 luke luke   8210 Aug 11 16:56 packed-refs
