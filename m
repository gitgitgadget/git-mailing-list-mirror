From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-diff fixed to work with BSD xargs
Date: Tue, 30 Aug 2005 22:00:10 +1200
Message-ID: <11253960093915-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Aug 30 12:01:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EA2ui-00084g-Lc
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 12:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVH3KAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 06:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVH3KAQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 06:00:16 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7]:50637 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750926AbVH3KAP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 06:00:15 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 088B08AAC3;
	Tue, 30 Aug 2005 22:00:10 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7953>

Calls to cg-diff without filename parameters were dependent on GNU xargs
traits. BSD xargs is hardcoded to do --no-run-if-empty -- so if the filter
is effectively empty we avoid calling xargs.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

 cg-diff |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

7b1d159f557ee06a0358217cdc29c2a2b2ee52fc
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -155,7 +155,11 @@ if [ "$id2" = " " ]; then
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
+	if [ -s $filter ]; then
+		cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager  
+	else
+		git-diff-cache -r -p $tree | colorize | pager
+	fi
 
 	rm $filter
 
