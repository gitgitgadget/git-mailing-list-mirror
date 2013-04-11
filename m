From: Christopher Yee Mon <christopher.yeemon@gmail.com>
Subject: git p4 submit failing
Date: Thu, 11 Apr 2013 15:01:03 -0400
Message-ID: <CAG4Fb8ejKCpUqZ+YVQT=S2-p6YcNo5+s81j2Jrx8q1ijtu8yqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 21:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMkk-00076e-IY
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab3DKTB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:01:28 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47903 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3DKTBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:01:25 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj8so903067wib.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=9tmHYDhAWu9VJOQ1cSH2C5/oqGJj3XNiyxvEZi1lv3Y=;
        b=fXwpLApDH54Iud8pVPqAVStvwwLBcdjQ6CJSczsjH3Enth/Q5sXn0OAWanF67HzJQ9
         GOJx+x+xoizcinTJ2A0bFuLzT10DmcyzeUwuPXDz26lirtbg5WxOSKySBjAqMtYSyfpf
         5hnQbsvUXuXIdjRf9tR+FP4c4Dt1UAxeDPq7uVwy3q84EokCnQ5llvr8OL9C3S/jmoSm
         XDrNUt1LTx3icFRk/LSJ1W4LgO9GXdvaKgduW6wiua4+D9a+9XJT/4STRykjfyQwOGq2
         p22xYRXfhfIJikK+mCdVsOTgYs/o6Yuw0Kon88SJVL7PSn4jhp+WRE2+LVQgc3pYXm6S
         C7mw==
X-Received: by 10.194.121.129 with SMTP id lk1mr4403380wjb.45.1365706883814;
 Thu, 11 Apr 2013 12:01:23 -0700 (PDT)
Received: by 10.216.75.65 with HTTP; Thu, 11 Apr 2013 12:01:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220913>

I tried running git p4 submit on a repo that I've been running as an
interim bridge between git and perforce. Multiple people are using the
repo as a remote and its being periodically submitted back to
perforce.

It's been working mostly fine. Then one day out of the blue I get this
error. I can no longer push any git commits to perforce. (This is from
the remote repo which I am pushing back to perforce)

user@hostname:~/Source/code$ git p4 submit -M --export-labels
Perforce checkout for depot path //depot/perforce/workspace/ located
at /home/user/Source/git-p4-area/perforce/workspace/
Synchronizing p4 checkout...
... - file(s) up-to-date.
Applying ffa390f comments in config xml files
//depot/perforce/workspace/sub/folder/structure/first.xml#3 - opened for edit
//depot/perforce/workspace/sub/folder/structure/second.xml#3 - opened for edit
//depot/perforce/workspace/sub/folder/structure/third.xml#3 - opened for edit
//depot/perforce/workspace/sub/folder/structure/forth.xml#3 - opened for edit
//depot/perforce/workspace/sub/folder/structure/fifth.xml#1 - opened for edit
error: patch failed: sub/folder/structure/first.xml:1
error: sub/folder/structure/first.xml: patch does not apply
error: patch failed: sub/folder/structure/second.xml:1
error: sub/folder/structure/second.xml: patch does not apply
error: patch failed: sub/folder/structure/third.xml:1
error: sub/folder/structure/third.xml: patch does not apply
error: patch failed: sub/folder/structure/forth.xml:1
error: sub/folder/structure/forth.xml: patch does not apply
error: patch failed: sub/folder/structure/fifth.xml:1
error: sub/folder/structure/fifth.xml: patch does not apply
Unfortunately applying the change failed!
//depot/perforce/workspace/sub/folder/structure/first.xml#1 - was edit, reverted
//depot/perforce/workspace/sub/folder/structure/second.xml#3 - was
edit, reverted
//depot/perforce/workspace/sub/folder/structure/third.xml#3 - was edit, reverted
//depot/perforce/workspace/sub/folder/structure/forth.xml#3 - was edit, reverted
//depot/perforce/workspace/sub/folder/structure/fifth.xml#3 - was edit, reverted
No commits applied.

I thought it could be the .gitattributes setting that I had which was
this at the time was this:

* text eol=lf

My global core.autocrlf setting was also false.

So I remade a new remote repo, and changed core.autocrlf to input and
changed .gitattributes to this

* text=auto

*.php text eol=lf
*.pl text eol=lf
*.pm text eol=lf
*.sh text eol=lf

*.vbs text eol=crlf
*.bat text eol=crlf
*.ps1 text eol=crlf

*.bdb binary
*.mtr binary

Then I started to realize that it could just be the files in the
initial commit that are suspect, because when i made edits to other
files in the repo then tried to push them back with git p4 submit,
those files submitted successfully  But the files in the commit where
I initially got the failure still give me this problem.

Here's what it looks like when I retested with a fresh git repo cloned
from perforce with git p4 clone and tried to do the git p4 submit with
verbose turned on on only one of the suspecting files

user@hostname:/code$ git p4 submit -M --export-labels --verbose
Reading pipe: git name-rev HEAD
Reading pipe: ['git', 'config', 'git-p4.allowSubmit']
Reading pipe: git rev-parse --symbolic --remotes
Reading pipe: git rev-parse p4/master
Reading pipe: git cat-file commit 0457c7589ea679dcc0c9114b34f8f30bc2ee08cf
Reading pipe: git cat-file commit HEAD~0
Reading pipe: git cat-file commit HEAD~1
Reading pipe: ['git', 'config', 'git-p4.conflict']
Origin branch is remotes/p4/master
Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']
Opening pipe: ['p4', '-G', 'where', '//depot/perforce/workspace/...']
Perforce checkout for depot path //depot/perforce/workspace/ located
at /home/user/Source/git-p4-area/perforce/workspace/
Synchronizing p4 checkout...
... - file(s) up-to-date.
Opening pipe: p4 -G opened ...
Reading pipe: ['git', 'rev-list', '--no-merges', 'remotes/p4/master..master']
Reading pipe: ['git', 'config', '--bool', 'git-p4.skipUserNameCheck']
Reading pipe: ['git', 'config', 'git-p4.detectCopies']
Reading pipe: ['git', 'config', '--bool', 'git-p4.detectCopiesHarder']
Reading pipe: ['git', 'show', '-s', '--format=format:%h %s',
'ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e']
Applying ef3b95f making test change
Opening pipe: p4 -G users
Reading pipe: ['git', 'log', '--max-count=1', '--format=%ae',
'ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e']
Reading pipe: git diff-tree -r -M
"ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e^"
"ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e"
//depot/perforce/workspace/sub/folder/structure/first.xml#3 - opened for edit
<stdin>:17: trailing whitespace.
<!-- comment line 1 -->
<stdin>:18: trailing whitespace.
<!-- comment line 2 -->
<stdin>:19: trailing whitespace.
<!-- comment line 3 -->
error: patch failed: sub/folder/structure/first.xml:1
error: sub/folder/structure/first.xml: patch does not apply
Unfortunately applying the change failed!
Reading pipe: ['git', 'config', '--bool', 'git-p4.attemptRCSCleanup']
//depot/perforce/workspace/sub/folder/structure/first.xml#3 - was edit, reverted
No commits applied.
Reading pipe: ['git', 'config', '--bool', 'git-p4.exportLabels']
Opening pipe: ['p4', '-G', 'labels', '//depot/ipstor.maple/automation/...']
Reading pipe: ['git', 'tag']
Reading pipe: ['git', 'config', 'git-p4.labelExportRegexp']

In any case, I'm starting to think it could be a legitimate bug, which
is why I am submitting it here. Does anyone have any ideas for
suggestions on diagnosing what could be wrong?
