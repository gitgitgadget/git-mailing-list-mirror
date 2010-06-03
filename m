From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/5] Documentation/rev-list-options.txt: Explain --ancestry-path
Date: Fri, 04 Jun 2010 01:17:35 +0200
Message-ID: <1275607057-26645-4-git-send-email-johan@herland.net>
References: <1275607057-26645-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 01:18:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKJg5-0007LN-P2
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 01:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab0FCXSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 19:18:15 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40874 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab0FCXSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 19:18:13 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G00DC9OQ9CWC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:18:09 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F1AA41EA554F_C083830B	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:18:08 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id B7EFE1EA27EF_C083830F	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:18:08 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G007W6OPOV330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:18:08 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1275607057-26645-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148373>

Add a short paragraph explaining --ancestry-path, followed by a more
detailed example. This mirrors how the other history simplification options
are documented.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/rev-list-options.txt |   50 ++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 81815e1..a33dd00 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -384,6 +384,14 @@ Default mode::
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.

+--ancestry-path::
+
+	When given a range of commits to display (e.g. 'commit1..commit2'
+	or 'commit2 {caret}commit1'), only display commits that exist
+	directly on the ancestry chain between the 'commit1' and
+	'commit2', i.e. commits that are both descendants of 'commit1',
+	and ancestors of 'commit2'.
+
 A more detailed explanation follows.

 Suppose you specified `foo` as the <paths>.  We shall call commits
@@ -511,8 +519,6 @@ Note that without '\--full-history', this still simplifies merges: if
 one of the parents is TREESAME, we follow only that one, so the other
 sides of the merge are never walked.

-Finally, there is a fourth simplification mode available:
-
 --simplify-merges::

 	First, build a history graph in the same way that
@@ -554,6 +560,46 @@ Note the major differences in `N` and `P` over '\--full-history':
   removed completely, because it had one parent and is TREESAME.
 --

+Finally, there is a fifth simplification mode available:
+
+--ancestry-path::
+
+	Limit the displayed commits to those directly on the ancestry
+	chain between the "from" and "to" commits in the given commit
+	range. I.e. only display commits that are ancestor of the "to"
+	commit, and descendants of the "from" commit.
++
+As an example use case, consider the following commit history:
++
+-----------------------------------------------------------------------
+	    D---E-------F
+	   /     \       \
+	  B---C---G---H---I---J
+	 /                     \
+	A-------K---------------L--M
+-----------------------------------------------------------------------
++
+A regular 'D..M' computes the set of commits that are ancestors of `M`,
+but excludes the ones that are ancestors of `D`. This is useful to see
+what happened to the history leading to `M` since `D`, in the sense
+that "what does `M` have that did not exist in `D`". The result in this
+example would be all the commits, except `A` and `B` (and `D` itself,
+of course).
++
+When we want to find out what commits in `M` are contaminated with the
+bug introduced by `D` and need fixing, however, we might want to view
+only the subset of 'D..M' that are actually descendants of `D`, i.e.
+excluding `C` and `K`. This is exactly what the '\--ancestry-path'
+option does. Applied to the 'D..M' range, it results in:
++
+-----------------------------------------------------------------------
+	        E-------F
+	         \       \
+	          G---H---I---J
+	                       \
+	                        L--M
+-----------------------------------------------------------------------
+
 The '\--simplify-by-decoration' option allows you to view only the
 big picture of the topology of the history, by omitting commits
 that are not referenced by tags.  Commits are marked as !TREESAME
--
1.7.0.4
