From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Bug: git log --follow doesn't show history for a file created while merge
Date: Fri, 17 Sep 2010 16:13:44 +0400
Message-ID: <E68F7D53-50A6-4FD3-B176-600942B8A66C@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 14:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwZpR-0001S1-Kb
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 14:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0IQMNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 08:13:47 -0400
Received: from mail.intellij.net ([213.182.181.98]:50776 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab0IQMNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 08:13:46 -0400
Received: (qmail 20445 invoked by uid 89); 17 Sep 2010 12:13:44 -0000
Received: by simscan 1.1.0 ppid: 20406, pid: 20436, t: 0.0256s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 17 Sep 2010 12:13:44 -0000
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156380>


When a file is created during a conflicting merge merge and then committed, 'git log --follow' shows no history, while 'git log' behaves correctly.

Steps to reproduce:
1. Make a conflicting merge.
2. While manually resolving the merge, create a file.
3. Commit the new file together with the merge resolve.

More precisely (trivial outputs are skipped):
# git init
# echo 'initial content' > a.txt
# git add .
# git commit -m "initial"

# git checkout -b mybranch
Switched to a new branch 'mybranch'
# echo 'branchy' > a.txt
# git add . 
# git commit -m "branchy to a"

# git checkout master
# echo 'mastery' > a.txt 
# git add . 
# git commit -m "mastery to a"

# git merge mybranch
Auto-merging a.txt
CONFLICT (content): Merge conflict in a.txt
Automatic merge failed; fix conflicts and then commit the result.
# echo 'content' > b.txt
# git add .
# git commit -m "resolved merge for a.txt, added b.txt"

# git log b.txt 
commit 1bf7b74c8e53ed065dd615771a602de803f87b6f
Merge: 7b9b988 a82daa2
Author: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Date:   Fri Sep 17 16:01:24 2010 +0400

    resolved merge for a.txt, added b.txt
# git log --follow b.txt 
#

I know that Linus doesn't like following renames :) but in this case there are no renames at all. It seems to be just a bug in --follow.

Btw, after additional commits to b.txt, the history gets not empty, but the merge commit is still not listed there. 

Thanks.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
