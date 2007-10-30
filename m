From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GIT-GUI PATCH 1/3] po2msg: ignore entries marked with "fuzzy"
Date: Tue, 30 Oct 2007 11:24:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301124220.4362@racer.site>
References: <Pine.LNX.4.64.0710301122300.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: stimming@tuhh.de, spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 12:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImpDy-0008FY-7v
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 12:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbXJ3LZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbXJ3LZT
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 07:25:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:35486 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751828AbXJ3LZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 07:25:18 -0400
Received: (qmail invoked by alias); 30 Oct 2007 11:25:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 30 Oct 2007 12:25:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0BDAJK0r0uD8z5QfmA8DrP5CEuXHTAUY+C2lApN
	gm0gKG78l94NDi
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710301122300.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


As Christian Stimming pointed out, entries which are "fuzzy" need to
be checked by human translators, and cannot be used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/po2msg.sh |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/po/po2msg.sh b/po/po2msg.sh
index da0765d..48a2669 100644
--- a/po/po2msg.sh
+++ b/po/po2msg.sh
@@ -48,12 +48,16 @@ for {set i 1} {$i < $argc} {incr i} {
 }
 
 proc flush_msg {} {
-	global msgid msgstr mode lang out
+	global msgid msgstr mode lang out fuzzy
 
 	if {![info exists msgid] || $mode == ""} {
 		return
 	}
 	set mode ""
+	if {$fuzzy == 1} {
+		set fuzzy 0
+		return
+	}
 
 	if {$msgid == ""} {
 		set prefix "set ::msgcat::header"
@@ -64,6 +68,7 @@ proc flush_msg {} {
 	puts $out "$prefix \"[u2a $msgstr]\""
 }
 
+set fuzzy 0
 foreach file $files {
 	regsub "^.*/\(\[^/\]*\)\.po$" $file "$output_directory\\1.msg" outfile
 	set in [open $file "r"]
@@ -73,7 +78,11 @@ foreach file $files {
 	set mode ""
 	while {[gets $in line] >= 0} {
 		if {[regexp "^#" $line]} {
-			flush_msg
+			if {[regexp ", fuzzy" $line]} {
+				set fuzzy 1
+			} else {
+				flush_msg
+			}
 			continue
 		} elseif {[regexp "^msgid \"(.*)\"$" $line dummy match]} {
 			flush_msg
-- 
1.5.3.4.1423.g7c7a7
