From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [BUG] git merge does not prune empty directories
Date: Wed, 24 Sep 2008 18:32:22 +0200
Message-ID: <87k5d1v71l.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 18:34:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXJI-0003Nh-5T
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbYIXQc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYIXQc1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:32:27 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:49800 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbYIXQc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:32:26 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 53BD014062
	for <git@vger.kernel.org>; Wed, 24 Sep 2008 18:32:26 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4A15E1405A
	for <git@vger.kernel.org>; Wed, 24 Sep 2008 18:32:25 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96657>

I got an empty directory left over today, and have reduced the problem
to this sequence. If I leave out the second add (so the merge is a
fast forward), the directory is removed as I would expect.

This is with Git 1.6.0.2.


    Anders



and@dylle:~$ mkdir repo ; cd repo
and@dylle:~/repo$ git init
Initialized empty Git repository in /home/and/repo/.git/
and@dylle:~/repo$ mkdir a ; date >a/b ; git add a/b ; git commit -m'Add 1'
Created initial commit 72194c7: Add 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a/b
and@dylle:~/repo$ git checkout -b other
Switched to a new branch "other"
and@dylle:~/repo$ git rm a/b ; git commit -m'Remove 1'
rm 'a/b'
Created commit 9c0282c: Remove 1
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 a/b
and@dylle:~/repo$ git checkout master
Switched to branch "master"
and@dylle:~/repo$ date >c ; git add c ; git commit -m'Add 2'
Created commit 39d60d4: Add 2
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 c
and@dylle:~/repo$ git merge other
Removed a/b
Merge made by recursive.
 a/b |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 a/b
and@dylle:~/repo$ rmdir a
and@dylle:~/repo$ rmdir a
rmdir: failed to remove `a': No such file or directory
