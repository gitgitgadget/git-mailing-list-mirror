From: Johannes Sixt <j6t@kdbg.org>
Subject: Unexpected messages by git rebase -m
Date: Wed, 22 Apr 2009 21:55:54 +0200
Message-ID: <200904222155.54422.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiZY-0002Q4-WB
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbZDVTz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbZDVTz7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:55:59 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59202 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbZDVTz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:55:58 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BD210CDF8A
	for <git@vger.kernel.org>; Wed, 22 Apr 2009 21:55:55 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 65ED43BE01
	for <git@vger.kernel.org>; Wed, 22 Apr 2009 21:55:55 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117244>

I did the usual fix-up-the-second-commit procedure, this time with 'git 
rebase -m'. The result is OK, but rebase writes something unexpected:

git init
echo a > x && git add x && git commit -m A
echo b > x && git add x && git commit -m B
echo c > x && git add x && git commit -m C
git checkout HEAD^
echo b1 > x && git add x && git commit --amend -m B1

Here we have this history:

  A--B--C  <- master
   \
    B1  <- detached HEAD

git rebase -m HEAD master
git rebase --skip	# B is in conflict; we don't need it
git checkout master x	# resolve another conflict

Now look what rebase has to say:

$ git rebase --continue 
[detached HEAD 90c7916] C
 1 files changed, 1 insertions(+), 1 deletions(-)
Committed: 0001 C
Already applied: 0002 C
All done.

Notice "Committed: 0001 C" followed by "Already applied: 0002 C". I'd expect 
only "Committed: 0002 C". What's up?

-- Hannes
