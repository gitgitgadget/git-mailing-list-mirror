From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-merge: record merge strategy in the log message on auto resolved merges
Date: Mon, 25 Jun 2007 07:16:23 +0000
Message-ID: <20070625071624.7919.qmail@82fa8ed4561cac.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 09:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ix4-0001KO-5f
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXFYHZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbXFYHZd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:25:33 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:39367 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbXFYHZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:25:32 -0400
Received: (qmail 7920 invoked by uid 1000); 25 Jun 2007 07:16:24 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50870>

If a strategy module auto resolved the merge cleanly, record the used
strategy in the log message, e.g.:

  Merge branch 'maint' using strategy ours

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

> I personally find this useful especially for the 'ours' strategy.
Resend, maybe it's not that interesting, there was no followup when sent
the first time.

 git-merge.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 981d69d..b661f74 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -440,7 +440,8 @@ done
 if test '' != "$result_tree"
 then
     parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
-    result_commit=$(printf '%s\n' "$merge_msg" | git-commit-tree $result_tree $parents) || exit
+    result_commit=$(printf '%s\n' "$merge_msg using strategy $wt_strategy" |
+	git-commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
     exit 0
-- 
1.5.2
