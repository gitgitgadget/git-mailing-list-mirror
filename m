From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git gui: show diffs with a minimum of 1 context line
Date: Sat, 30 Aug 2008 22:46:32 +0200
Message-ID: <20080830204632.GA14564@localhost>
References: <20080830164527.GA25370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXLx-0001eX-Ag
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYH3UqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbYH3UqU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:46:20 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:35534 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYH3UqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:46:19 -0400
Received: from darc.dyndns.org ([84.154.72.105]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 Aug 2008 22:46:17 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KZXL6-0003o9-9u; Sat, 30 Aug 2008 22:46:32 +0200
Content-Disposition: inline
In-Reply-To: <20080830164527.GA25370@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 Aug 2008 20:46:17.0745 (UTC) FILETIME=[7370A010:01C90AE1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94421>

Staging hunks without context does not work, because line number
information would have to be recomputed for individual hunks.  Since it is
already possible to stage individual lines using 'Stage Line for Commit',
zero context diffs are not really necessary for git gui, however.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Same patch, different commit message.

 git-gui/git-gui.sh     |    2 +-
 git-gui/lib/diff.tcl   |    2 +-
 git-gui/lib/option.tcl |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ad65aaa..86402d4 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1932,7 +1932,7 @@ proc show_more_context {} {
 
 proc show_less_context {} {
 	global repo_config
-	if {$repo_config(gui.diffcontext) >= 1} {
+	if {$repo_config(gui.diffcontext) > 1} {
 		incr repo_config(gui.diffcontext) -1
 		reshow_diff
 	}
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 52b79e4..4a7138b 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -175,7 +175,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 
 	lappend cmd -p
 	lappend cmd --no-color
-	if {$repo_config(gui.diffcontext) >= 0} {
+	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
 	}
 	if {$w eq $ui_index} {
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index ffb3f00..5e1346e 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -125,7 +125,7 @@ proc do_options {} {
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
-		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		} {
-- 
1.6.0
