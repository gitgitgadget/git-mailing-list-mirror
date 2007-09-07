From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-gui: lib/index.tcl: handle files with % in the filename properly
Date: Fri, 7 Sep 2007 17:16:59 +0000
Message-ID: <20070907171659.28846.qmail@3fa9e2237b61c9.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IThRk-0005iV-Mv
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 19:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbXIGRQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 13:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757942AbXIGRQj
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 13:16:39 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:38495 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757891AbXIGRQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 13:16:39 -0400
Received: (qmail 28847 invoked by uid 1000); 7 Sep 2007 17:16:59 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58054>

Steps to reproduce the bug:

 $ mkdir repo && cd repo && git init
 Initialized empty Git repository in .git/
 $ touch 'foo%3Fsuite'
 $ git-gui

Then click on the 'foo%3Fsuite' icon to include it in a changeset, a
popup comes with:
'Error: bad field specifier "F"'

Vincent Danjean noticed the problem and also suggested the fix, reported
through
 http://bugs.debian.org/441167

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 lib/index.tcl |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index b3f5e17..78e2101 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -13,7 +13,8 @@ proc update_indexinfo {msg pathList after} {
 	if {$batch > 25} {set batch 25}
 
 	ui_status [format \
-		"$msg... %i/%i files (%.2f%%)" \
+		"%s... %i/%i files (%.2f%%)" \
+		$msg \
 		$update_index_cp \
 		$totalCnt \
 		0.0]
@@ -68,7 +69,8 @@ proc write_update_indexinfo {fd pathList totalCnt batch msg after} {
 	}
 
 	ui_status [format \
-		"$msg... %i/%i files (%.2f%%)" \
+		"%s... %i/%i files (%.2f%%)" \
+		$msg \
 		$update_index_cp \
 		$totalCnt \
 		[expr {100.0 * $update_index_cp / $totalCnt}]]
@@ -86,7 +88,8 @@ proc update_index {msg pathList after} {
 	if {$batch > 25} {set batch 25}
 
 	ui_status [format \
-		"$msg... %i/%i files (%.2f%%)" \
+		"%s... %i/%i files (%.2f%%)" \
+		$msg \
 		$update_index_cp \
 		$totalCnt \
 		0.0]
@@ -145,7 +148,8 @@ proc write_update_index {fd pathList totalCnt batch msg after} {
 	}
 
 	ui_status [format \
-		"$msg... %i/%i files (%.2f%%)" \
+		"%s... %i/%i files (%.2f%%)" \
+		$msg \
 		$update_index_cp \
 		$totalCnt \
 		[expr {100.0 * $update_index_cp / $totalCnt}]]
@@ -163,7 +167,8 @@ proc checkout_index {msg pathList after} {
 	if {$batch > 25} {set batch 25}
 
 	ui_status [format \
-		"$msg... %i/%i files (%.2f%%)" \
+		"%s... %i/%i files (%.2f%%)" \
+		$msg
 		$update_index_cp \
 		$totalCnt \
 		0.0]
@@ -218,7 +223,8 @@ proc write_checkout_index {fd pathList totalCnt batch msg after} {
 	}
 
 	ui_status [format \
-		"$msg... %i/%i files (%.2f%%)" \
+		"%s... %i/%i files (%.2f%%)" \
+		$msg \
 		$update_index_cp \
 		$totalCnt \
 		[expr {100.0 * $update_index_cp / $totalCnt}]]
-- 
1.5.3.1
