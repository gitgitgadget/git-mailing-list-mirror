From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: Do not hard-code "encoding" in attribute lookup functions
Date: Tue, 21 Jul 2009 10:09:48 +0200
Message-ID: <4A6577CC.2000403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 10:10:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTAQG-0007xz-71
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 10:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbZGUIJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 04:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZGUIJw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 04:09:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54667 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZGUIJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 04:09:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MTAQ1-0004nn-73; Tue, 21 Jul 2009 10:09:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D52A6735; Tue, 21 Jul 2009 10:09:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123650>

From: Johannes Sixt <j6t@kdbg.org>

Commit 39ee47e (Clean up file encoding code and add enable/disable option,
2008-10-15) rewrote the attribute lookup functions gitattr and
cache_gitattr, but in the process hard-coded the attribute name "encoding"
instead of using the functions' parameters. This fixes it.

This is not a serious regression because currently all callers look only
for "encoding".

Further note that this fix assumes that future callers will not pass an
attribute name that contains regex special characters.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..8aafb19 100755
--- a/gitk
+++ b/gitk
@@ -10901,7 +10901,7 @@ proc gitattr {path attr default} {
     } else {
 	set r "unspecified"
 	if {![catch {set line [exec git check-attr $attr -- $path]}]} {
-	    regexp "(.*): encoding: (.*)" $line m f r
+	    regexp "(.*): $attr: (.*)" $line m f r
 	}
 	set path_attr_cache($attr,$path) $r
     }
@@ -10929,7 +10929,7 @@ proc cache_gitattr {attr pathlist} {
 	set newlist [lrange $newlist $lim end]
 	if {![catch {set rlist [eval exec git check-attr $attr -- $head]}]} {
 	    foreach row [split $rlist "\n"] {
-		if {[regexp "(.*): encoding: (.*)" $row m path value]} {
+		if {[regexp "(.*): $attr: (.*)" $row m path value]} {
 		    if {[string index $path 0] eq "\""} {
 			set path [encoding convertfrom [lindex $path 0]]
 		    }
-- 
1.6.4.rc1.1032.g74cb
