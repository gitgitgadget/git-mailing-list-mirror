From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] max-count in terms of intersection
Date: Sun, 20 Nov 2005 07:53:57 -0800 (PST)
Message-ID: <20051120155357.833.qmail@web31807.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Nov 20 16:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdrWC-0003IC-Q8
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 16:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVKTPx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 10:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVKTPx7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 10:53:59 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:52379 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751263AbVKTPx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 10:53:58 -0500
Received: (qmail 835 invoked by uid 60001); 20 Nov 2005 15:53:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sdcu6aQ056byDH/0a9ev8yvNfaznlFlNWQiTHGEbV/YIan9aYzVMNEVscSjiqECzTWnm39lqkltjqpiHEkJ7PrX/WTeskwGPkzbzCpie/SVAFvIYBAhNXu3op9wmRfxn9atON+LoEr+ofljXd31cz+iJLBPepB9EMatNlPstxXw=  ;
Received: from [68.221.112.229] by web31807.mail.mud.yahoo.com via HTTP; Sun, 20 Nov 2005 07:53:57 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12385>

When a path designation is given, max-count counts the number
of commits therein (intersection), not globally.

This avoids the case where in case path has been inactive
for the last N commits, --max-count=N and path designation
at git-rev-list is given, would give no commits.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

---

 rev-list.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

applies-to: 5b820842ce0afb836ddbeded3a3f9e8d0ba223f9
768b79de9eadc38a839332df0fcce021f7174d6d
diff --git a/rev-list.c b/rev-list.c
index 6e6ffde..e17f928 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -124,8 +124,6 @@ static int filter_commit(struct commit *
                stop_traversal=1;
                return CONTINUE;
        }
-       if (max_count != -1 && !max_count--)
-               return STOP;
        if (no_merges && (commit->parents && commit->parents->next))
                return CONTINUE;
        if (paths && dense) {
@@ -148,6 +146,9 @@ static int process_commit(struct commit 
                return CONTINUE;
        }
 
+       if (max_count != -1 && !max_count--)
+               return STOP;
+
        show_commit(commit);
 
        return CONTINUE;
---
0.99.9.GIT
