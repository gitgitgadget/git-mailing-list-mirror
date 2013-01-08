From: =?ISO-8859-2?Q?Pavel_Posp=ED=B9il?= <pospispa@gmail.com>
Subject: troublesome branch name in remote repo causes .git/config
 inconsistency in cloned repo
Date: Tue, 8 Jan 2013 19:30:58 +0100
Message-ID: <CADDfn-L_VWk5Rkn_P8aTf3pwBcbbYT=PZTrG=pFvJpNjgRg-5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 19:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tse2R-0005ns-FU
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab3AHSgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:36:19 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:57952 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab3AHSgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:36:17 -0500
Received: by mail-la0-f54.google.com with SMTP id fp12so817999lab.41
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=aytqsVXMFMHYVFxVxwfLsAgY5d7NlpNxRNOk2SiwnXs=;
        b=JpXzZG54FBpK8FE0v3cKiNdesWgdNVpynYXte/X11qutvQOaIteHhHleZN9UsHBXeg
         xj4hommfZzxmGQ2yjEfkzhjrCCENAW3arEyEDeGP+KfKYZFAri/XeQReJ1tLYusoFc/J
         FhkPrEs//ixppVrovp+CGWpLZb+chJTsnTph8H8SLRSG9eXBHuKiUzWjZOK3ufR+ziJb
         sc9hyVMcUEJQWxW8O+ufDYOLEDlfwipdWL/cTZnyNSpC1Ir7p3jq2yLE7jOjxGDAUGTG
         8vRcE5zbBmPiZ/dqAna+ha9SYVIqhzCTwHUCyg6aA3NTX7rqk3fU1W+WMvWkzaTHka1Q
         rbig==
Received: by 10.152.47.75 with SMTP id b11mr61519040lan.14.1357669858384; Tue,
 08 Jan 2013 10:30:58 -0800 (PST)
Received: by 10.112.137.232 with HTTP; Tue, 8 Jan 2013 10:30:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212993>

Hi,
I think I came across a bug. I use git version 1.7.10.4 on Ubuntu
12.10. I haven't tried to find out if it's a known bug.

Reproduction scenario:
1. create a git repo:
$ mkdir -p tmp/bezdek
$ cd tmp/bezdek/
$ echo "*.swp" > .gitignore
$ git init
$ git add .
$ git commit -m "Initial commit"

2. clone the "remote" repo:
$ cd ../..
$ mkdir -p tmp/cloned
$ git clone ../bezdek/

3. create the troublesome branch in the "remote" repo
$ cd ../bezdek
$ git checkout -b
MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
$ echo "*.bak" >> .gitignore
$ git add .
$ git commit -m "Some changes"

4. pull and checkout to the
MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
branch in the cloned repo
$ cd ../cloned/bezdek
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = /home/pospispa/tmp/tmp/cloned/../bezdek/
[branch "master"]
        remote = origin
        merge = refs/heads/master
$ git pull
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects:  33% (1/3)
Unpacking objects:  66% (2/3)
Unpacking objects: 100% (3/3)
Unpacking objects: 100% (3/3), done.
From /home/pospispa/tmp/tmp/cloned/../bezdek
 * [new branch]
MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
-> origin/MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
Already up-to-date.
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = /home/pospispa/tmp/tmp/cloned/../bezdek/
[branch "master"]
        remote = origin
        merge = refs/heads/master
$ git checkout MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
fatal: bad config file line 12 in .git/config
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = /home/pospispa/tmp/tmp/cloned/../bezdek/
[branch "master"]
        remote = origin
        merge = refs/heads/master
[branch "MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek"]
        remote = origin

I think that the problem may be with the branch name length. I think
that git branch allows to created branches with very long names,
however, such long name are not allowed in .git/config or the git
checkout <very-long-remote-branch-name> has some problems with it.

I recovered from this problem in this way:
1. deleted last two lines in tmp/cloned/bezdek/.git/config file and
deleted index and working tree
$ git reset HEAD *
$ git checkout -- *
2. renamed the troublesome branch in "remote" repo:
$ cd ../../bezdek
$ git branch -m
MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek
3. pull from "remote" to cloned again
$ cd ../cloned/bezdek
$ git pull
From /home/pospispa/tmp/tmp/cloned/../bezdek
 * [new branch]
MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek ->
origin/MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek
Already up-to-date.
$ git branch -r
  origin/HEAD -> origin/master
  origin/MCRD0106586-CR00023206-Configuration-management-of-MCO-shall-be-integrated-with-AMS-2.0-current-cm-config.xml-file-from-Peter-Bezdek
  origin/MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek
  origin/master
$ git checkout MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek
Branch MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek
set up to track remote branch
MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek
from origin.
Switched to a new branch
'MCRD0106586-CR00023206-current-cm-config.xml-file-from-Peter-Bezdek'

Best regards,
Pavel Pospisil
