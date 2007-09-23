From: Dmitry Potapov <dpotapov@gmail.com>
Subject: git-rebase--interactive needs a better message
Date: Mon, 24 Sep 2007 02:45:02 +0400
Message-ID: <20070923224502.GB7249@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 00:45:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaCR-0000r7-15
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbXIWWpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbXIWWpG
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:45:06 -0400
Received: from smtp01.mtu.ru ([62.5.255.48]:57523 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609AbXIWWpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:45:05 -0400
Received: from potapov.private (ppp85-140-169-177.pppoe.mtu-net.ru [85.140.169.177])
	by smtp01.mtu.ru (Postfix) with ESMTP id 12B56A423D8;
	Mon, 24 Sep 2007 02:44:56 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8NMj2sZ013990;
	Mon, 24 Sep 2007 02:45:02 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8NMj2KR013989;
	Mon, 24 Sep 2007 02:45:02 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58991>

I have tried to use git-rebase --interactive today, and run into a strange
error message saying:

/usr/bin/git-rebase--interactive: line 333: $GIT_DIR/.dotest-merge/author-script: No such file or directory

I had to scratch my head for a while before I realized that I forgot to
say git-commit. So, it was mine mistake, but I think that it should be
possible to have a better error message suggesting the user what to do.
I have looked at the git-rebase--interactive script, but I am not sure
that I understand it good enough to propose a patch.

To reproduce the problem, run the following script in an empty directory:
===
#!/bin/sh
set -e

git-init
echo 'version 1' > foo
git-add foo
git-commit -m 'commit 1' foo
echo 'versionn 2' >> foo
git-commit -m 'commit 2' foo
echo 'version 3' >> foo
git-commit -m 'commit 3' foo

GIT_EDITOR='sed -i -e "/commit 2/{s/^pick/edit/}"' git-rebase -i HEAD~2
sed -i -e "s/versionn/version/" foo
git-update-index foo
# Missing git-commit --amend
git-rebase --continue
===

Error message:
==
/usr/bin/git-rebase--interactive: line 333: /tmp/zzz/.git/.dotest-merge/author-script: No such file or directory
===

I use git version 1.5.3.1

Dmitry Potapov
