From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/6] git-merge: refactor option parsing
Date: Mon, 24 Sep 2007 00:51:42 +0200
Message-ID: <1190587905-700-4-git-send-email-hjemli@gmail.com>
References: <1190587905-700-1-git-send-email-hjemli@gmail.com>
 <1190587905-700-2-git-send-email-hjemli@gmail.com>
 <1190587905-700-3-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaIQ-000243-AG
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbXIWWvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbXIWWvR
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:17 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42775 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbXIWWvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:15 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91O023085;
	Mon, 24 Sep 2007 00:51:10 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190587905-700-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58994>

Move the option parsing into a separate function as preparation for reuse
by the next commit.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-merge.sh |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 3857634..68b3503 100755
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
