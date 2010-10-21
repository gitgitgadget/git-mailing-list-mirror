From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 14/21] Documentation: Preliminary docs on 'git notes merge'
Date: Thu, 21 Oct 2010 04:08:49 +0200
Message-ID: <1287626936-32232-15-git-send-email-johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 04:09:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kaw-0007cL-Py
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab0JUCJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 22:09:18 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33116 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756898Ab0JUCJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 22:09:14 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM00IS4BB8YX70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:08 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BC21A1EA5804_CBFA0C4B	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:08 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 939CD1EA2990_CBFA0C4F	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:07 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM0096KBB03500@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:03 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287626936-32232-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159459>

This patch has been improved by the following contributions:
- Stephen Boyd: Use "automatically resolves" instead of "auto-resolves"
- Stephen Boyd: Remove unbalanced '('

Thanks-to: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   44 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 2981d8c..07a5042 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
+'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
 'git notes' remove [<object>]
 'git notes' prune [-n | -v]
 
@@ -83,6 +84,16 @@ edit::
 show::
 	Show the notes for a given object (defaults to HEAD).
 
+merge::
+	Merge the given notes ref into the current notes ref.
+	This will try to merge the changes made by the given
+	notes ref (called "remote") since the merge-base (if
+	any) into the current notes ref (called "local").
++
+If conflicts arise and a strategy for automatically resolving
+conflicting notes (see the -s/--strategy option) is not given,
+the merge fails (TODO).
+
 remove::
 	Remove the notes for a given object (defaults to HEAD).
 	This is equivalent to specifying an empty note message to
@@ -133,9 +144,23 @@ OPTIONS
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
+-s <strategy>::
+--strategy=<strategy>::
+	When merging notes, resolve notes conflicts using the given
+	strategy. The following strategies are recognized: "manual"
+	(default), "ours", "theirs" and "union".
+	See the "NOTES MERGE STRATEGIES" section below for more
+	information on each notes merge strategy.
+
+-q::
+--quiet::
+	When merging notes, operate quietly.
+
 -v::
 --verbose::
-	Report all object names whose notes are removed.
+	When merging notes, be more verbose.
+	When pruning notes, report all object names whose notes are
+	removed.
 
 
 DISCUSSION
@@ -163,6 +188,23 @@ object, in which case the history of the notes can be read with
 `git log -p -g <refname>`.
 
 
+NOTES MERGE STRATEGIES
+----------------------
+
+The default notes merge strategy is "manual", which is not yet
+implemented (TODO).
+
+"ours" automatically resolves conflicting notes in favor of the local
+version (i.e. the current notes ref).
+
+"theirs" automatically resolves notes conflicts in favor of the remote
+version (i.e. the given notes ref being merged into the current notes
+ref).
+
+"union" automatically resolves notes conflicts by concatenating the
+local and remote versions.
+
+
 EXAMPLES
 --------
 
-- 
1.7.3.98.g5ad7d9
