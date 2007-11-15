From: Sergei Organov <osv@javad.com>
Subject: [PATCH v2] Documentation: customize diff-options depending on particular command
Date: Thu, 15 Nov 2007 16:19:29 +0300
Message-ID: <87d4ub3a2o.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 14:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isetf-0007nY-Hg
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 14:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024AbXKONgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 08:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757064AbXKONgP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 08:36:15 -0500
Received: from javad.com ([216.122.176.236]:2401 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964AbXKONgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 08:36:15 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAFDa7i68303;
	Thu, 15 Nov 2007 13:36:08 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Isesx-000508-Gb; Thu, 15 Nov 2007 16:35:59 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65119>

Customize diff-options depending on particular command as follows,
mostly to make git-diff and git-format-patch manuals less confusing:

* git-format-patch:

  - Mark --patch-with-stat as being the default.

  - Change -p description so that it matches what it actually does and
    so that it doesn't refer to absent "section on generating
    patches".

* git-diff: mark -p as being the default.

* git-diff-index/git-diff-files/git-diff-tree: mark --raw as being
  the default.

Signed-off-by: Sergei Organov <osv@javad.com>
---

This patch is very similar to v1, except that asciidoc bug is avoided
(see comment in the first diff hunk).

 Documentation/diff-options.txt     |   24 +++++++++++++++++++++++-
 Documentation/git-diff.txt         |    1 +
 Documentation/git-format-patch.txt |    1 +
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b1f528a..e4af393 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -1,5 +1,25 @@
+// Please don't remove this comment as asciidoc behaves badly when
+// the first non-empty line is ifdef/ifndef. The symptom is that
+// without this comment the <git-diff-core> attribute conditionally
+// defined below ends up being defined unconditionally.
+// Last checked with asciidoc 7.0.2.
+
+ifndef::git-format-patch[]
+ifndef::git-diff[]
+:git-diff-core: 1
+endif::git-diff[]
+endif::git-format-patch[]
+
+ifdef::git-format-patch[]
 -p::
-	Generate patch (see section on generating patches)
+	Generate patches without diffstat.
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+-p::
+	Generate patch (see section on generating patches).
+	{git-diff? This is the default.}
+endif::git-format-patch[]
 
 -u::
 	Synonym for "-p".
@@ -13,6 +33,7 @@
 
 --raw::
 	Generate the raw format.
+	{git-diff-core? This is the default.}
 
 --patch-with-raw::
 	Synonym for "-p --raw".
@@ -41,6 +62,7 @@
 
 --patch-with-stat::
 	Synonym for "-p --stat".
+	{git-format-patch? This is the default.}
 
 -z::
 	NUL-line termination on output.  This affects the --raw
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 11c4216..2808a5e 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -75,6 +75,7 @@ and the range notations ("<commit>..<commit>" and
 
 OPTIONS
 -------
+:git-diff: 1
 include::diff-options.txt[]
 
 <path>...::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f0617ef..268f227 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -65,6 +65,7 @@ reference.
 
 OPTIONS
 -------
+:git-format-patch: 1
 include::diff-options.txt[]
 
 -<n>::
-- 
1.5.3.4
