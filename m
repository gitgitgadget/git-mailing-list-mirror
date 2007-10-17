From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2 v3] mergetool: add support for ECMerge
Date: Wed, 17 Oct 2007 19:16:12 +0200
Message-ID: <11926413721755-git-send-email-prohaska@zib.de>
References: <11926413722362-git-send-email-prohaska@zib.de>
 <11926413723666-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 19:20:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiCZH-0008AY-Fe
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760680AbXJQRTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760751AbXJQRTr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 13:19:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:45209 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765520AbXJQRTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 13:19:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9HHGC2M000423
	for <git@vger.kernel.org>; Wed, 17 Oct 2007 19:19:42 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9HHGCnh013018;
	Wed, 17 Oct 2007 19:16:12 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11926413723666-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61395>

Add support to mergetool for ECMerge available from
http://www.elliecomputing.com/Products/merge_overview.asp

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-mergetool.txt |    2 +-
 git-mergetool.sh                |   12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 78b2f43..a26c260 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 1e4583f..fdf4912 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -250,6 +250,16 @@ merge_file () {
 	    check_unchanged
 	    save_backup
 	    ;;
+	ecmerge)
+	    touch "$BACKUP"
+	    if base_present; then
+		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --mode=merge3 --to="$path"
+	    else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$path"
+	    fi
+	    check_unchanged
+	    save_backup
+	    ;;
 	emerge)
 	    if base_present ; then
 		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
@@ -299,7 +309,7 @@ done
 
 valid_tool() {
 	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff)
+		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
 			;; # happy
 		*)
 			return 1
-- 
1.5.3.4.222.g2830
