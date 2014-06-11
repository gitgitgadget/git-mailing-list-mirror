From: Jacek Konieczny <jajcus@jajcus.net>
Subject: [PATCH] pull: Do not abuse 'break' inside a shell 'case'
Date: Wed, 11 Jun 2014 10:47:45 +0200
Message-ID: <1402476465-27177-1-git-send-email-jajcus@jajcus.net>
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacek Konieczny <jajcus@jajcus.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 10:54:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WueJ7-0007Fo-MI
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 10:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaFKIyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 04:54:52 -0400
Received: from tropek.jajcus.net ([84.205.176.49]:40225 "EHLO
	tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbaFKIyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 04:54:51 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jun 2014 04:54:51 EDT
Received: from jajo.eggsoft.pl (jajo.nigdzie [10.252.0.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tropek.jajcus.net (Postfix) with ESMTPS id B31B55002
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 10:48:27 +0200 (CEST)
Received: by jajo.eggsoft.pl (Postfix, from userid 1000)
	id D7045B002; Wed, 11 Jun 2014 10:48:11 +0200 (CEST)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251346>

It is not C. The code would break under mksh when 'pull.ff' is set:

  $ git pull
  /usr/lib/git-core/git-pull[67]: break: can't break
  Already up-to-date.

Signed-off-by: Jacek Konieczny <jajcus@jajcus.net>
---
 git-pull.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 6cd8ebc..7358fac 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -58,11 +58,9 @@ pull_ff=$(git config pull.ff)
 case "$pull_ff" in
 false)
 	no_ff=--no-ff
-	break
 	;;
 only)
 	ff_only=--ff-only
-	break
 	;;
 esac
 
-- 
2.0.0
