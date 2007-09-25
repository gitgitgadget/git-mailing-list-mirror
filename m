From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] rebase -i: Fix numbers in progress report
Date: Tue, 25 Sep 2007 16:43:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251642560.28395@racer.site>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 17:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaCaB-0002Pq-SL
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbXIYPoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756758AbXIYPoI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:44:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:51722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756552AbXIYPoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:44:07 -0400
Received: (qmail invoked by alias); 25 Sep 2007 15:44:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 25 Sep 2007 17:44:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AKgku3TfAroZekfk06xeBDb9aRVgtEjlZKqGdlH
	zMd1H9vU+VEvu6
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709251640360.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59140>


Instead of counting all lines in done and todo, we now count the actions
before outputting "$Rebasing ($count/$total)".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c850411..4f46a15 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -72,8 +72,8 @@ mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
-	count=$(($(wc -l < "$DONE")))
-	total=$(($count+$(wc -l < "$TODO")))
+	count=$(($(grep -ve '^$' -e '^#' < "$DONE" | wc -l)))
+	total=$(($count+$(grep -ve '^$' -e '^#' < "$TODO" | wc -l)))
 	printf "Rebasing (%d/%d)\r" $count $total
 	test -z "$VERBOSE" || echo
 }
-- 
1.5.3.2.1057.gf4dc1
