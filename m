From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] rebase: don't invoke the pager for each commit summary
Date: Sat, 30 Jan 2010 17:23:37 +0100
Message-ID: <1264868617-18547-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 17:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbG75-00007K-Jj
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 17:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab0A3QXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 11:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752930Ab0A3QXx
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 11:23:53 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57343 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0A3QXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 11:23:52 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6B3AB145E09FC;
	Sat, 30 Jan 2010 17:23:51 +0100 (CET)
Received: from [91.19.0.24] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NbG6v-0003Oo-00; Sat, 30 Jan 2010 17:23:50 +0100
X-Mailer: git-send-email 1.7.0.rc0.71.g95b6e
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/1ecCuFadh1DQK/sbubvzswk+BdlvQriYW6SNs
	T2yTIez5v6B5MITOWNwjHrXApz6tj1aJ+mo33wtyAMCJLIHS3O
	LJPRRRbxgCtTOCabbOEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138479>

This regression was introduced by commit 0aa958d (rebase: replace
antiquated sed invocation, 2010-01-24), which changed the invocation of
"git rev-list | sed" to "git log".

It can be reproduced by something like this:
$ git rebase -s recursive origin/master

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b5d9178..fb4fef7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -86,7 +86,7 @@ continue_merge () {
 		fi
 	fi
 	test -z "$GIT_QUIET" &&
-	git log --format=%s -1 "$cmt"
+	GIT_PAGER='' git log --format=%s -1 "$cmt"
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
-- 
1.7.0.rc0.71.g95b6e
