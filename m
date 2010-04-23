From: Eric Raymond <esr@snark.thyrsus.com>
Subject: [PATCH] Documentation improvements for the description of short format.
Date: Fri, 23 Apr 2010 13:40:15 -0400
Message-ID: <20100423174517.8342D479E92@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 19:45:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5MwS-0001p6-3y
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 19:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913Ab0DWRpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 13:45:20 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34760
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895Ab0DWRpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 13:45:19 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 8342D479E92; Fri, 23 Apr 2010 13:45:17 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145630>

Incorporates the detailed explanation from Jeff King in
<20100410040959.GA11977@coredump.intra.peff.net> and fixes
the bug noted by Junio C Hamano in
<7vmxxc1i8g.fsf@alter.siamese.dyndns.org>.

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 Documentation/git-status.txt |   43 +++++++++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 1cab91b..2d4bbfc 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -72,21 +72,37 @@ In short-format, the status of each path is shown as
 
 where `PATH1` is the path in the `HEAD`, and ` -> PATH2` part is
 shown only when `PATH1` corresponds to a different path in the
-index/worktree (i.e. renamed).
-
-For unmerged entries, `X` shows the status of stage #2 (i.e. ours) and `Y`
-shows the status of stage #3 (i.e. theirs).
-
-For entries that do not have conflicts, `X` shows the status of the index,
-and `Y` shows the status of the work tree.  For untracked paths, `XY` are
-`??`.
+index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
+status code.
+
+The fields (including the `->`) are separated from each other by a
+single space. If a filename contains whitespace or other nonprintable
+characters, that field will be quoted in the manner of a C string
+literal: surrounded by ASCII double quote (34) characters, and with
+interior special characters backslash-escaped.
+
+For paths with merge conflicts, `X` and 'Y' show the modification
+states of each side of the merge. For paths that do not have merge
+conflicts, `X` shows the status of the index, and `Y` shows the status
+of the work tree.  For untracked paths, `XY` are `??`.  Other status
+codes can be interpreted as follows:
+
+* ' ' = unmodified
+* 'M' = modified
+* 'A' = added
+* 'D' = deleted
+* 'R' = renamed
+* 'C' = copied
+* 'U' = updated but unmerged
+
+Ignored files are not listed.
 
     X          Y     Meaning
     -------------------------------------------------
               [MD]   not updated
     M        [ MD]   updated in index
     A        [ MD]   added to index
-    D        [ MD]   deleted from index
+    D         [ M]   deleted from index
     R        [ MD]   renamed in index
     C        [ MD]   copied in index
     [MARC]           index and work tree matches
@@ -104,6 +120,15 @@ and `Y` shows the status of the work tree.  For untracked paths, `XY` are
     ?           ?    untracked
     -------------------------------------------------
 
+There is an alternate -z format recommended for machine parsing.  In
+that format, the status field is the same, but some other things
+change.  First, the '->' is omitted from rename entries and the field
+order is reversed (e.g 'from -> to' becomes 'to from'). Second, a NUL
+(ASCII 0) follows each filename, replacing space as a field separator
+and the terminating newline (but a space still separates the status
+field from the first filename).  Third, filenames containing special
+characters are not specially formatted; no quoting or
+backslash-escaping is performed.
 
 CONFIGURATION
 -------------
-- 
1.7.1.rc2.12.gf7bd8




-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

He that would make his own liberty secure must guard even his enemy from
oppression: for if he violates this duty, he establishes a precedent that
will reach unto himself.	-- Thomas Paine
