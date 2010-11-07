From: Benjamin Poirier <benjamin.poirier@polymtl.ca>
Subject: [PATCH] fixup in git log's history simplification example
Date: Sun,  7 Nov 2010 17:51:05 -0500
Message-ID: <1289170265-994-1-git-send-email-benjamin.poirier@polymtl.ca>
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 08 00:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFEX3-00017q-MU
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 00:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab0KGXUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 18:20:08 -0500
Received: from smtp.polymtl.ca ([132.207.4.11]:60581 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120Ab0KGXUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 18:20:08 -0500
X-Greylist: delayed 1714 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Nov 2010 18:20:07 EST
Received: from d1.synalogic.ca (test.dorsal.polymtl.ca [132.207.72.60])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id oA7MpRgK009299;
	Sun, 7 Nov 2010 17:51:28 -0500
X-Mailer: git-send-email 1.7.2.3
X-Poly-FromMTA: (test.dorsal.polymtl.ca [132.207.72.60]) at Sun,  7 Nov 2010 22:51:27 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160906>

According to the description in git-log(1), at E, foo's content is
"asdf" and at P it is "foobarbaz". Therefore, a diff filtered for foo
between E and P is non-empty and P is !TREESAME to E.

Correct the statement regarding that in the example.

Signed-off-by: Benjamin Poirier <benjamin.poirier@polymtl.ca>
Cc: Thomas Rast <trast@student.ethz.ch>
---
It's a small change but I confirmed it by creating a repository with the
commits from the example. It can be accessed at:
	git clone git://github.com/benthaman/git-doc-hs_example.git

I also tested that the rest of the example is accurate nevertheless.

The claim that P and E are !TREESAME is supported by the following
operations:
1)
A diff filtered for foo between E and P is non-empty, therefore they
are !TREESAME:
	$ git diff :/E :/P -- foo
	diff --git a/foo b/foo
	index 8bd6648..b33c138 100644
	--- a/foo
	+++ b/foo
	@@ -1 +1 @@
	-asdf
	+foobarbaz

2)
	$ git log --sparse --oneline master -- foo
	b0ee555 P
	c930763 O
	6282898 D
	5cb421e N
	d7c4f29 C
	fc9e858 M
	6be6304 A
	e06936d I

E is not included because it is !TREESAME, as the documentation for
'--sparse' predicts:
	"Note that without --full-history, this still simplifies merges: if
	one of the parents is TREESAME, we follow only that one, so the
	other sides of the merge are never walked."
---
 Documentation/rev-list-options.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7a42567..46b98a0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -436,8 +436,9 @@ each merge.  The commits are:
   `N` and `D` to "foobarbaz"; i.e., it is not TREESAME to any parent.
 
 * `E` changes `quux` to "xyzzy", and its merge `P` combines the
-  strings to "quux xyzzy".  Despite appearing interesting, `P` is
-  TREESAME to all parents.
+  strings to "quux xyzzy".  `P` is TREESAME to `O` and !TREESAME to
+  `E`.
+
 
 'rev-list' walks backwards through history, including or excluding
 commits based on whether '\--full-history' and/or parent rewriting
-- 
1.7.2.3
