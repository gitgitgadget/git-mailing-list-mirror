From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-merge: record merge strategy in the log message on auto resolved merges
Date: Wed, 6 Jun 2007 08:24:28 +0000
Message-ID: <20070606082428.10588.qmail@3eecbb0978967b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 10:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvqob-0000qb-9A
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbXFFIYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbXFFIYN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:24:13 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56133 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754844AbXFFIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:24:12 -0400
Received: (qmail 10589 invoked by uid 1000); 6 Jun 2007 08:24:28 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49264>

If a strategy module auto resolved the merge cleanly, record the used
strategy in the log message, e.g.:

  Merge branch 'maint' using strategy ours

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

I personally find this useful especially for the 'ours' strategy.

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
