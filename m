From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Teach git-pull about --[no-]ff, --no-squash and --commit
Date: Mon, 29 Oct 2007 09:41:18 +0100
Message-ID: <1193647278-2616-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 09:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImQBA-0003Ou-GJ
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 09:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbXJ2Ikr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 04:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXJ2Ikr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 04:40:47 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:55173 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbXJ2Ikq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 04:40:46 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l9T8eeKj012446;
	Mon, 29 Oct 2007 09:40:41 +0100 (MET)
X-Mailer: git-send-email 1.5.3.4.1404.g65af
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62611>

These options are supported by git-merge, but git-pull didn't know about
them.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-pull.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 74bfc16..39e5222 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -27,8 +27,16 @@ do
 		;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=--no-commit ;;
+	--c|--co|--com|--comm|--commi|--commit)
+		no_commit=--commit ;;
 	--sq|--squ|--squa|--squas|--squash)
 		squash=--squash ;;
+	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+		squash=--no-squash ;;
+	--ff)
+		no_ff=--ff ;;
+	--no-ff)
+		no_ff=--no-ff ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -133,5 +141,5 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-exec git-merge $no_summary $no_commit $squash $strategy_args \
+exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.5.3.4.1404.g65af
