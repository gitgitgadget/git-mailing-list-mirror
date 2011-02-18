From: Johan Herland <johan@herland.net>
Subject: Re: Directory replaced with a file confuses cherry-pick
Date: Fri, 18 Feb 2011 15:44:05 +0100
Message-ID: <201102181544.06045.johan@herland.net>
References: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Alexey Feldgendler <alexeyf@opera.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 15:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqRZ9-0001pE-9I
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 15:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab1BROoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 09:44:09 -0500
Received: from smtp.getmail.no ([84.208.15.66]:49759 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab1BROoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 09:44:08 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGT003KOI9IRIC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Feb 2011 15:44:06 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8362E1EA5501_D5E85B6B	for <git@vger.kernel.org>; Fri,
 18 Feb 2011 14:44:06 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 679B01EA2B4C_D5E85B6F	for <git@vger.kernel.org>; Fri,
 18 Feb 2011 14:44:06 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGT005YYI9IYQ20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Feb 2011 15:44:06 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167216>

On Friday 18 February 2011, Alexey Feldgendler wrote:
> Hello!
> 
> I think I've found a bug. Here is how to reproduce.
> 
> 1. Create an empty repo.
> 2. Add the following: file.txt containing "before" and directory problem/
> with file problem/content containing "data". Commit this.
> 3. From here, create a branch and commit a change to file.txt: change it
> to say "after".
> 4. Checkout master.
> 5. Remove directory problem/ and add a file with the same name (problem)
> containing "newdata". Commit this.
> 6. Try to cherry-pick the commit you made on the side branch on step 3.
> 
> Here is what you see:
> 
> Automatic cherry-pick failed.
> [...]

Unable to reproduce. Here are the commands I used (please post yours):

$ git init
$ echo before > file.txt
$ mkdir problem
$ echo data > problem/content
$ git add .
$ git commit -m first
$ git checkout -b side
$ echo after > file.txt 
$ git commit -a -m side-commit
$ git checkout master
$ git rm -r problem # or: rm -rf problem
$ echo newdata > problem
$ git add problem # this is important!
$ git commit -m second
$ git cherry-pick side
[master b975587] side-commit
 1 files changed, 1 insertions(+), 1 deletions(-)

No conflict in the cherry-pick.

> And git-status says:
> 
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   file.txt
> #
> # Unmerged paths:
> #   (use "git reset HEAD <file>..." to unstage)
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #       added by us:        problem
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       problem~HEAD

I cannot easily see how you got into this state. Maybe you forgot to 'git 
add' the "problem" file before making the second commit?

> Expected result: the cherry-pick goes smoothly. The change I'm
> cherry-picking (modification of file.txt) has nothing to do with the
> problem file/directory.

Agreed. And that's exactly what I'm seeing above.

> Trying to cherry-pick anything from branches that
> stem off from before the change of a directory to a file fails like this.

This should not be the case. Which Git version are you using?

> Known? Is replacing directories with files maybe a taboo?

Nope. dir->file replacements should not be problematic.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
