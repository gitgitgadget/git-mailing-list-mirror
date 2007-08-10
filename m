From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] mergetool: refactored kdiff3 -> KDIFF3
Date: Sat, 11 Aug 2007 01:56:00 +0200
Message-ID: <11867901612954-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, torgil.svensson@gmail.com,
	Johannes.Schindelin@gmx.de, tytso@mit.edu
X-From: git-owner@vger.kernel.org Sat Aug 11 01:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJeL3-0003jZ-CK
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 01:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbXHJX4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 19:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbXHJX4N
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 19:56:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:62215 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbXHJX4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 19:56:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7ANu2jt007588;
	Sat, 11 Aug 2007 01:56:02 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7ANu1eM023484;
	Sat, 11 Aug 2007 01:56:02 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55577>

Use shell variable KDIFF3 instead of kdiff3 to call
kdiff3. This will be used in detection of the absolute
absolute path.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-mergetool.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


This change is needed to be able to provide an absolute
path to kdiff3, which will be looked up in the Windows
Registry. See the following patch.


diff --git a/git-mergetool.sh b/git-mergetool.sh
index e6bbb6b..90a69b3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -13,6 +13,8 @@ SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
 
+KDIFF3=kdiff3
+
 # Returns true if the mode reflects a symlink
 is_symlink () {
     test "$1" = 120000
@@ -191,10 +193,10 @@ merge_file () {
     case "$merge_tool" in
 	kdiff3)
 	    if base_present ; then
-		(kdiff3 --auto --L1 "$path (Base)" -L2 "$path (Local)" --L3 "$path (Remote)" \
+		("$KDIFF3" --auto --L1 "$path (Base)" -L2 "$path (Local)" --L3 "$path (Remote)" \
 		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
-		(kdiff3 --auto -L1 "$path (Local)" --L2 "$path (Remote)" \
+		("$KDIFF3" --auto -L1 "$path (Local)" --L2 "$path (Remote)" \
 		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
-- 
1.5.3.rc4.744.g68381
