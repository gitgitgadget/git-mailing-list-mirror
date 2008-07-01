From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: How do I stop git enumerating my working directory
Date: Tue, 1 Jul 2008 15:01:19 -0400
Message-ID: <F90E06B1-CCD3-4A36-8838-22BEC59DFBF3@silverinsanity.com>
References: <486A53CC.4020803@glidos.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gardiner <lists@glidos.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 21:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDl7O-0000Bm-Ia
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 21:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbYGATBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 15:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbYGATBZ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 15:01:25 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:40109 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbYGATBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 15:01:24 -0400
Received: from [172.24.32.208] (dfpub107.digitalfocus.com [65.120.79.7])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id EA8B71FFC023;
	Tue,  1 Jul 2008 19:01:15 +0000 (UTC)
In-Reply-To: <486A53CC.4020803@glidos.net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87061>


On Jul 1, 2008, at 11:57 AM, Paul Gardiner wrote:

> I don't think I can make .gitignore files do the job, because
> it seems that you can set up to ignore a whole directory,
> and then partially countermand that by placing a .gitignore
> file (containing ! commands) inside the directory. That
> makes me think that ignoring doesn't prevent the
> enumeration.

That's where you're wrong.  You can't get git to pay attention to  
anything inside an ignored directory using the .gitignore files.  Once  
you ignore a directory, git stops looking at it completely.  You can  
force git to look at a file inside an ignored directory by adding it  
directly, though.  Git will pay attention to files you add for  
changes, but won't pay any attention to other files around it.

See the log below for what I mean:

$ mkdir temp
$ cd temp
$ git init
Initialized empty Git repository in /Users/brian/dev/temp/.git/
$ cat > .gitignore
ignoredir/
$ mkdir ignoredir
$ touch A
$ touch ignoredir/B
$ git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       A
nothing added to commit but untracked files present (use "git add" to  
track)
$ cat > ignoredir/.gitignore
!B
$ git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       A
nothing added to commit but untracked files present (use "git add" to  
track)
$ git add ignoredir/B
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file: ignoredir/B
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       A
$ git commit -m "A"
Created initial commit 36ade7a: A
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 ignoredir/B
$ echo new > ignoredir/B
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   ignoredir/B
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       A
no changes added to commit (use "git add" and/or "git commit -a")
