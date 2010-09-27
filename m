From: Stephen Bash <bash@genarts.com>
Subject: git push on tracking branches
Date: Mon, 27 Sep 2010 12:00:41 -0400 (EDT)
Message-ID: <15793457.371451.1285603241207.JavaMail.root@mail.hq.genarts.com>
References: <6958088.371432.1285602164529.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:00:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0G8N-00021H-6H
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759064Ab0I0QAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:00:49 -0400
Received: from hq.genarts.com ([173.9.65.1]:23380 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755967Ab0I0QAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:00:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 582651E26BCB
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:00:47 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NCZBbhiskGx for <git@vger.kernel.org>;
	Mon, 27 Sep 2010 12:00:41 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4F3AE1E26BC9
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:00:41 -0400 (EDT)
In-Reply-To: <6958088.371432.1285602164529.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157343>

Hi all-

A coworker alerted me to some strange behavior with git push on tracking branches (maybe a documentation error?).  Pro Git (http://progit.org/book/ch3-5.html) says:

"To set up a local branch with a different name than the remote branch, you can easily use the first version with a different local branch name:
   $ git checkout -b sf origin/serverfix
   Branch sf set up to track remote branch refs/remotes/origin/serverfix.
   Switched to a new branch "sf"
Now, your local branch sf will automatically push to and pull from origin/serverfix."

When I do this on my local machine (current master on Mac 10.6.4):

snowg5-2:temp stephen$ git clone ssh://bash@penguin/home/git/repos/test-repo.git
Cloning into test-repo...
warning: templates not found /Users/stephen/share/git-core/templates
remote: Counting objects: 100109, done.
remote: Compressing objects: 100% (23394/23394), done.
remote: Total 100109 (delta 76733), reused 99567 (delta 76231)
Receiving objects: 100% (100109/100109), 620.24 MiB | 28.36 MiB/s, done.
Resolving deltas: 100% (76733/76733), done.
snowg5-2:temp stephen$ cd test-repo
snowg5-2:test-repo stephen$ git checkout -b tmp origin/real-branch-name
Branch tmp set up to track remote branch real-branch-name from origin.
Switched to a new branch 'tmp'
... edit some files ...
snowg5-2:test-repo stephen$ git add -u .
snowg5-2:test-repo stephen$ git commit -m "made some changes"
[tmp 0440ace] made some changes
 1 files changed, 1 insertions(+), 0 deletions(-)
snowg5-2:test-repo stephen$ git push
Everything up-to-date
snowg5-2:test-repo stephen$ git rev-parse tmp
0440ace51b4ab18eee39305cd2af070f572e38d7
snowg5-2:test-repo stephen$ git ls-remote origin real-branch-name
92ebff3a7c332079bcbf84e9cf699ab635e6ba3c	refs/heads/real-branch-name
snowg5-2:test-repo stephen$ git --version
git version 1.7.3.2.g9027fa
snowg5-2:test-repo stephen$ 

Git doesn't push the change.  If I either use 
  a) git checkout --track origin/real-branch-name 
or
  b) git checkout -b real-branch-name origin/real-branch-name
the push succeeds.

Was the behavior of git push intentionally changed or is this a bug?

Thanks,
Stephen
