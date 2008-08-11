From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] Documentation: rev-list-options: move --simplify-merges documentation
Date: Tue, 12 Aug 2008 01:55:37 +0200
Message-ID: <9c8cd2c95aba3ca921099a28b07b2b7f2e497b2f.1218498923.git.trast@student.ethz.ch>
References: <ac1b3fe540b183acc8cdd87d36c55256cc56a204.1218498922.git.trast@student.ethz.ch>
 <eada6ecf77a858b2f1fe91c13c6a68b9d0351621.1218498923.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KShG1-0003O6-89
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbYHKXz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbYHKXz5
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:55:57 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9004 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098AbYHKXzz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:55:55 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:55:50 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:55:50 +0200
X-Mailer: git-send-email 1.6.0.rc2.56.g86ca
In-Reply-To: <eada6ecf77a858b2f1fe91c13c6a68b9d0351621.1218498923.git.trast@student.ethz.ch>
In-Reply-To: <200808120151.56067.trast@student.ethz.ch>
References: <200808120151.56067.trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Aug 2008 23:55:50.0838 (UTC) FILETIME=[C87BA560:01C8FC0D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92030>

Fits --simplify-merges documentation into the 'History Simplification'
section, including example.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/rev-list-options.txt |   48 +++++++++++++++++++++++++++++++----
 1 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index c6b0bf1..1d0048e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -193,12 +193,6 @@ endif::git-rev-list[]
 
 	Stop when a given path disappears from the tree.
 
---simplify-merges::
-
-	Simplify away commits that did not change the given paths, similar
-	to `--full-history`, and further remove merges none of whose
-	parent history changes the given paths.
-
 --no-merges::
 
 	Do not print commits with more than one parent.
@@ -414,6 +408,48 @@ Note that without '\--full-history', this still simplifies merges: if
 one of the parents is TREESAME, we follow only that one, so the other
 sides of the merge are never walked.
 
+Finally, there is a fourth simplification mode available:
+
+--simplify-merges::
+
+	First, build a history graph in the same way that
+	'\--full-history' with parent rewriting does (see above).
++
+Then simplify each commit `C` to its replacement `C'` in the final
+history according to the following rules:
++
+--
+* Set `C'` to `C`.
++
+* Replace each parent `P` of `C'` with its simplification `P'`.  In
+  the process, drop parents that are ancestors of other parents, and
+  remove duplicates.
++
+* If after this parent rewriting, `C'` is a root or merge commit (has
+  zero or >1 parents), a boundary commit, or !TREESAME, it remains.
+  Otherwise, it is replaced with its only parent.
+--
++
+The effect of this is best shown by way of comparing to
+'\--full-history' with parent rewriting.  The example turns into:
++
+-----------------------------------------------------------------------
+	  .-A---M---N---O
+	 /     /       /
+	I     B       D
+	 \   /       /
+	  `---------'
+-----------------------------------------------------------------------
++
+Note the major differences in `N` and `P` over '\--full-history':
++
+--
+* `N`'s parent list had `I` removed, because it is an ancestor of the
+  other parent `M`.  Still, `N` remained because it is !TREESAME.
++
+* `P`'s parent list similarly had `I` removed.  `P` was then
+  removed completely, because it had one parent and is TREESAME.
+--
 
 ifdef::git-rev-list[]
 Bisection Helpers
-- 
1.6.0.rc2.56.g86ca
