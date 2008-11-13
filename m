From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 10:22:14 +0100 (CET)
Message-ID: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 10:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0YQN-0008QA-DS
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 10:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYKMJWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 04:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbYKMJWS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 04:22:18 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:35361 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbYKMJWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 04:22:16 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4DCAF14068
	for <git@vger.kernel.org>; Thu, 13 Nov 2008 10:22:14 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 0F1ED14062
	for <git@vger.kernel.org>; Thu, 13 Nov 2008 10:22:14 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100859>

It took a while to make a minimal test case for this, but I think that all
the below steps are required. It ends up with this message:

after/one: unmerged (e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
fatal: git write-tree failed to write a tree

and the file that was moved has disappeared from the working tree.

I have tested the script with Git 1.6.0.2, but the real scenario that made
this appear seems to also fail with master and next from git.git.

Cheers,
Anders.


Test script:

mkdir am-merge-fail
cd am-merge-fail
git init

mkdir before
touch before/one after
git add -A
git commit -minitial

rm -f after
git mv before after
git commit -mmove

git checkout -b parallel HEAD~
touch another
git add -A
git commit -mparallel

git merge master
