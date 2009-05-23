From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Revert "git gui: show diffs with a minimum of 1 context line"
Date: Sat, 23 May 2009 19:28:47 +0200
Message-ID: <1243099727-5272-1-git-send-email-markus.heidelberg@web.de>
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 23 19:32:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7v5U-0003ft-5F
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 19:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbZEWR3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZEWR3Y
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 13:29:24 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50031 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZEWR3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 13:29:23 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6B1A2103C3075;
	Sat, 23 May 2009 19:29:24 +0200 (CEST)
Received: from [89.59.125.192] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M7v2C-0005xQ-00; Sat, 23 May 2009 19:29:24 +0200
X-Mailer: git-send-email 1.6.3.1.160.g45b30
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/2aL14R+TBNzNy1PGrYO+/5EBjFwipUnIvvoI5
	cAkVUDOs20PZewpYgvFNTeveSoGBmp3AZIL1vLgbb5FpWKDm5E
	hULm3SjzQP7F6uSREpWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119781>

This reverts commit 55ba8a3474102eb8d638834d2b9bfe58d5014a40.

Conflicts:

	lib/option.tcl

Diffs without context can actually be useful. Depending on the changes
it can be less distracting to read them or to get an overview.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-gui.sh     |    2 +-
 lib/diff.tcl   |    2 +-
 lib/option.tcl |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 14b92ba..604fdad 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2287,7 +2287,7 @@ proc show_more_context {} {
 
 proc show_less_context {} {
 	global repo_config
-	if {$repo_config(gui.diffcontext) > 1} {
+	if {$repo_config(gui.diffcontext) >= 1} {
 		incr repo_config(gui.diffcontext) -1
 		reshow_diff
 	}
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 925b3f5..71b250b 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -282,7 +282,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 
 	lappend cmd -p
 	lappend cmd --no-color
-	if {$repo_config(gui.diffcontext) >= 1} {
+	if {$repo_config(gui.diffcontext) >= 0} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
 	}
 	if {$w eq $ui_index} {
diff --git a/lib/option.tcl b/lib/option.tcl
index 1d55b49..eb216f6 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -149,7 +149,7 @@ proc do_options {} {
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
-		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
-- 
1.6.3.1.160.g45b30
