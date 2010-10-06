From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] Improve the "diff --git" format documentation
Date: Wed, 6 Oct 2010 18:23:47 +0200
Organization: SUSE Labs
Message-ID: <201010061823.47475.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 18:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Wmh-0006jw-0g
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 18:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759343Ab0JFQXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 12:23:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60402 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab0JFQXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 12:23:50 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 17C2D8891E
	for <git@vger.kernel.org>; Wed,  6 Oct 2010 18:23:49 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.31.12-0.2-desktop; KDE/4.3.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158294>

Hello,

here is a small improvement to the documentation of git's extended diff
format.  Can this please be included?

Thanks,
Andreas

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 Documentation/diff-generate-patch.txt |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-
generate-patch.txt
index 8f9a241..05f2164 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -18,7 +18,8 @@ diff format.
 +
 The `a/` and `b/` filenames are the same unless rename/copy is
 involved.  Especially, even for a creation or a deletion,
-`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
+`/dev/null` is _not_ used in place of `a/` or `b/` filenames in the
+`diff --git` line.
 +
 When rename/copy is involved, `file1` and `file2` show the
 name of the source file of the rename/copy and the name of
@@ -38,11 +39,31 @@ the file that rename/copy produces, respectively.
        dissimilarity index <number>
        index <hash>..<hash> <mode>
 
+    Path names in extended header lines do not include the `a/` and `b/`
+    prefixes.  The index header includes the <mode> only if the file
+    mode does not change; otherwise, explicit mode headers are included.
+
 3.  TAB, LF, double quote and backslash characters in pathnames
     are represented as `\t`, `\n`, `\"` and `\\`, respectively.
     If there is need for such substitution then the whole
     pathname is put in double quotes.
 
+    Space characters are not quoted and so when files are copied or
+    renamed, the file names in the "diff --git" line can be
+    ambiguous.
+
+4.  All the `a/` files refer to files before the commit, and all the `b/`
+    files refer to files after the commit; it is incorrect to apply the
+    changes to each file sequentially.  For example, this patch will
+    swap a and b:
+
+      diff --git a/a b/b
+      rename from a
+      rename to b
+      diff --git a/b b/a
+      rename from b
+      rename to a
+
 The similarity index is the percentage of unchanged lines, and
 the dissimilarity index is the percentage of changed lines.  It
 is a rounded down integer, followed by a percent sign.  The
