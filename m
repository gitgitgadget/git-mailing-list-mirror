From: Samuel Lijin <samuel.lijin@formlabs.com>
Subject: Minor Bug in Renaming Branches
Date: Mon, 6 Jun 2016 13:52:55 -0400
Message-ID: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 19:53:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9yhx-0001mU-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 19:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbcFFRw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 13:52:58 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37732 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcFFRw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 13:52:57 -0400
Received: by mail-wm0-f43.google.com with SMTP id k204so37230213wmk.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formlabs.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=yE6+zsNPXiDkvpiJ46YEn+Mzln/SRJ0ire+kXzu6uWQ=;
        b=U8jN3l85N+Z4B0HFw7U7iGvtYjVqi0PM2wUYVJJxaT7fGB4NzgwsoVh/YuDV55IWZr
         JQStpR3l+IRX8FbZKS/YYiGG5reNc7dR5JnF2mL1AanN+VzhDwLFN4GHS12mn1+uJL5S
         AIU61Vz+xuILyLSDIIAJc8kWhYtM/bbhKk4Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yE6+zsNPXiDkvpiJ46YEn+Mzln/SRJ0ire+kXzu6uWQ=;
        b=ZUOwM7SO7SVSxMzrX4AxPlmVbnj+czn6Gy4NX0bKmqod14NJtzolDhsSYcrcsXlZed
         8tcWMW/z9yXgkcCMzd9T3K8jJpFva2FD7JIMHu1pMyIr+d8cAt+ogmIn/c8QN/zS3t2d
         DFtGorx8Igp4psHIpkxp50XvEzJw5w+KMvSJPI6fXpYRf93tjqldw4+6VHbOqgLm1ARa
         lzoqgc9i+yh+cVmnpzc1lXDl0AfUO+T9j777+plYjTFSJg8cZVwZHrQpykZs7wfJbWrQ
         pLhfZOn4tjTROKUtrFtYZ0qjKe5HRQSb7FQe7GUM8RQ9W47jIu30Q0kN9zA9ODjvTJOL
         sf0Q==
X-Gm-Message-State: ALyK8tKG3jqPt9dO7wUJQtzhWn77etljj+Z+WRkAX3Pxao35xqUXZvJ1KbKD698tUNx2cqwqrxr494uB1jQ90eY8
X-Received: by 10.194.47.5 with SMTP id z5mr18912248wjm.41.1465235576041; Mon,
 06 Jun 2016 10:52:56 -0700 (PDT)
Received: by 10.194.178.201 with HTTP; Mon, 6 Jun 2016 10:52:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296542>

Hi,

Not quite sure where to submit bug reports about Git, this was the
best I could find, so if there's a better place to do this, please let
me know and I will.

The short of this issue is that on Mac and Windows, if a branch has a
slash in its name, changing it from lowercase to uppercase requires
diving into .git/refs/heads/ and manually moving stuff around - I
think the behavior should be at least something like this:
http://stackoverflow.com/questions/26810252/how-to-change-my-local-github-branch-name-to-uppercase.

It happens that on both Windows box, to rename a branch from
"branch/name" to "BRANCH/NAME", one has to actually dive into
.git/refs/heads/ because of how Windows handles upper/lowercase in
directory paths. (Win7, mingw64 via Git for Bash, git version
2.7.0.windows.1)
user@windows-box MINGW64 ~
$ mkdir sandbox && cd sandbox && git init
Initialized empty Git repository in C:/Users/user/sandbox/.git/
user@windows-box MINGW64 ~/sandbox (master)
$ touch empty.txt && git add empty.txt && git commit -m 'initialize repo'
[master (root-commit) 761113d] initialize repo
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 empty.txt
user@windows-box MINGW64 ~/sandbox (master)
$ git branch
* master
user@windows-box MINGW64 ~/sandbox (master)
$ git checkout -b branch/name
Switched to a new branch 'branch/name'
user@windows-box MINGW64 ~/sandbox (branch/name)
$ git branch
* branch/name
  master
user@windows-box MINGW64 ~/sandbox (branch/name)
$ git branch -m BRANCH/NAME
fatal: A branch named 'BRANCH/NAME' already exists.
user@windows-box MINGW64 ~/sandbox (branch/name)
$ git branch -m tmp
user@windows-box MINGW64 ~/sandbox (tmp)
$ git branch -m BRANCH/NAME
user@windows-box MINGW64 ~/sandbox (BRANCH/NAME)
$ git branch
  branch/NAME
  master
user@windows-box MINGW64 ~/sandbox (BRANCH/NAME)
$ mv .git/refs/heads/branch/ .git/refs/heads/BRANCH/
user@windows-box MINGW64 ~/sandbox (BRANCH/NAME)
$ git branch
* BRANCH/NAME
  master

Interestingly, from inside an Ubuntu VM (with the directory in
question mounted as a VBox fileshare), this is not an issue.

A colleague on a Mac also reproduces the issue successfully (OSX
10.11.5, git 2.8.3):

mac-box:sandbox user$ touch empty.txt && git add empty.txt && git
commit -m 'initial commit'
[master (root-commit) 1f4f1fa] initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 empty.txt
mac-box:sandbox user$ git branch
* master
mac-box:sandbox user$ git checkout -b branch/name
Switched to a new branch 'branch/name'
mac-box:sandbox user$ git branch -m BRANCH/NAME
fatal: A branch named 'BRANCH/NAME' already exists.
mac-box:sandbox user$ git branch
* branch/name
  master
mac-box:sandbox user$ git branch -m tmp
mac-box:sandbox user$ git branch
  master
* tmp
mac-box:sandbox user$ git branch -m BRANCH/NAME
mac-box:sandbox user$ git branch
  branch/NAME
  master
mac-box:sandbox user$ mv .git/refs/heads/branch/ .git/refs/heads/BRANCH/
mac-box:sandbox user$ git branch
* BRANCH/NAME
  master

Thanks,
Sam
