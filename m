From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] git mergetool: Don't repeat merge tool candidates
Date: Wed, 21 Jan 2009 21:24:02 +0100
Message-ID: <1232569442-12480-1-git-send-email-heipei@hackvalue.de>
Cc: Johannes Gilger <heipei@hackvalue.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 22:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkHD-0003gi-UW
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbZAUVEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZAUVEw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:04:52 -0500
Received: from avalon.gnuzifer.de ([78.46.211.2]:47656 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZAUVEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:04:51 -0500
X-Greylist: delayed 2448 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jan 2009 16:04:51 EST
Received: from u-7-240.vpn.rwth-aachen.de ([137.226.103.240]:45861 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1LPjcD-0000Kp-3f; Wed, 21 Jan 2009 21:23:57 +0100
X-Mailer: git-send-email 1.6.1.40.g8ea6a
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.103.240
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106669>

git mergetool listed some candidates for mergetools twice, depending on
the environment.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
 git-mergetool.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..8f09e4a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -390,21 +390,18 @@ fi
 
 if test -z "$merge_tool" ; then
     if test -n "$DISPLAY"; then
-        merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
         if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld $merge_tool_candidates"
-        fi
-        if test "$KDE_FULL_SESSION" = "true"; then
-            merge_tool_candidates="kdiff3 $merge_tool_candidates"
+            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
+        else
+            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates emerge"
+        merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates vimdiff"
+        merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
     fi
-    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
         init_merge_tool_path $i
-- 
1.6.1.40.g8ea6a
