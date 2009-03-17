From: Jonas Bernoulli <jonas@bernoul.li>
Subject: GIT_WORK_TREE=dir git ls-files --deleted
Date: Tue, 17 Mar 2009 02:41:50 +0100
Message-ID: <201bac3a0903161841y6bc59fe5iaf0c221c08db5f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 02:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjOL1-0000v9-JD
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 02:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbZCQBly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 21:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755148AbZCQBly
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 21:41:54 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:49088 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbZCQBlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 21:41:53 -0400
Received: by ewy25 with SMTP id 25so3699983ewy.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=f9WTTove4d3M0B+K+idM4HTsvUPh6GOTtwK86OpEHVE=;
        b=YdJm3b5lbB318ucJISONZsjyQ4wUxEmytVcZZC7jbdP3v6th+ePsgd3VGSB1Ylfc8A
         u/VFH3fYZQ92WDJaH7OaS0gPiZXARJk5A0vSRe60pjQpcqxy/evtC5SkLc5IAjYY7Fcp
         +JeCsrB50TuBY09KZLorVd9WqC5pMD8eYhGks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=sS0VzpKEca5pAS7rQrH43LJNpuXiuWPW5hPTaNtDnc7GZIsPwz89iwuhv733Y7DWE5
         H1OPPZC6DrWtC4cAPMuCbOTexfbgg/3tXFnCjebvkvI93a2rTmSrHByeC5B+ru49w/A2
         7oy+HJReiB0dX+W4zLaUIjsYFzKsSC98320UQ=
Received: by 10.210.139.15 with SMTP id m15mr4026941ebd.84.1237254110466; Mon, 
	16 Mar 2009 18:41:50 -0700 (PDT)
X-Google-Sender-Auth: c2a47bb3be1129f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113415>

Hello

git ls-files --deleted seams to be broken when GIT_WORK_TREE is set as
can be observed below.

Instead of just showing deleted files it also shows at least unchanged
and modified files.

I have observed this behaviour with git.git and do not know if
released versions are affected.

#### setup

$ mkdir -p base/worktree
$ cd base/
$ export GIT_DIR=/tmp/base/.git
$ export GIT_WORK_TREE=/tmp/base/worktree
$ git init
Initialized empty Git repository in /tmp/base/.git/
$ touch worktree/deleted worktree/modified worktree/unchanged
$ git add .
$ git commit -m init
[master (root-commit) f4e1bd3] init
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 deleted
 create mode 100644 modified
 create mode 100644 unchanged
$ rm worktree/deleted
$ echo modified > worktree/modified

#### expected result

$ git ls-files --deleted
deleted

#### actual result

$ git ls-files --deleted
deleted
modified
unchanged

#### untracked and out-of-worktree seam to be fine

$ touch worktree/untracked
$ touch not-in-worktree
$ git ls-files --deleted
deleted
modified
unchanged

#### related options / commands seam to be fine

$ git ls-files --modified
deleted
modified
$ git ls-files --others
$ git ls-files --cached
deleted
modified
unchanged
$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    deleted
#       modified:   modified
#
no changes added to commit (use "git add" and/or "git commit -a")

Best regards,

-- Jonas Bernoulli

Ps: Is there a way to show modified files excluding deleted files
other than this?
( git ls-files --deleted; git ls-files --modified ) | uniq --unique
Pps: The description of --others is ambitious, what is "other files"?
