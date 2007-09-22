From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/5] git-merge: refactor option parsing
Date: Sat, 22 Sep 2007 02:33:03 +0200
Message-ID: <1190421186-21784-3-git-send-email-hjemli@gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsvc-0000uq-QG
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033AbXIVAcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757874AbXIVAcv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:32:51 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46799 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512AbXIVAcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:32:50 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8M0WYsP018896;
	Sat, 22 Sep 2007 02:32:35 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190421186-21784-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58904>

Move the option parsing into a separate function as preparation for reuse
by the next commit.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-merge.sh |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..a3ef676 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -119,11 +119,7 @@ merge_name () {
 	fi
 }
 
-case "$#" in 0) usage ;; esac
-
-have_message=
-while case "$#" in 0) break ;; esac
-do
+parse_option () {
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
 		--no-summa|--no-summar|--no-summary)
@@ -166,9 +162,21 @@ do
 		have_message=t
 		;;
 	-*)	usage ;;
-	*)	break ;;
+	*)	return 1 ;;
 	esac
 	shift
+	args_left="$#"
+}
+
+case "$#" in 0) usage ;; esac
+
+have_message=
+while parse_option "$@"
+do
+	while test $args_left -lt $#
+	do
+		shift
+	done
 done
 
 if test -z "$show_diffstat"; then
-- 
1.5.3.2.82.g75c8d
