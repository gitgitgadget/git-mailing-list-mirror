From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/3] diffstat generation in hooks--update was passing "^baserev" to git-diff-tree
Date: Tue, 13 Feb 2007 14:24:21 +0000
Message-ID: <200702131424.21665.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 15:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGyf5-0006Xt-9Y
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 15:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbXBMO1A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 09:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXBMOYu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 09:24:50 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:17851 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932126AbXBMOYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 09:24:24 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 13 Feb 2007 14:27:00 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HGyZz-0007k4-00
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 14:24:23 +0000
X-TUID: 1d01ea98f77605e4
X-UID: 236
X-Length: 1355
Content-Disposition: inline
X-OriginalArrivalTime: 13 Feb 2007 14:27:00.0234 (UTC) FILETIME=[05ED06A0:01C74F7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39525>

For generating the diffstat after a branch update, git-diff-tree is
simply comparing the new revision with the base revision.  However, the
baserev was being passed with a "^" operator proceeding it - this (I
think) made git-diff-tree think that a path was being specified for
comparison rather than a second path, so only a single revision was
being summarised.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 7e8258a..ee3859c 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -193,8 +193,8 @@ case "$refname_type" in
 			git-rev-parse --not --all | git-rev-list --stdin --pretty $newrev ^$baserev
 			echo $LOGEND
 			echo ""
-			echo "Diffstat:"
-			git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev ^$baserev
+			echo "Diffstat against $baserev:"
+			git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev $baserev
 		fi
 		;;
 	"annotated tag")
-- 
1.5.0.rc4.364.g85b1
