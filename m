From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] The "table-of-contents" in the update hook script should match the body
Date: Wed, 14 Feb 2007 11:20:32 +0000
Message-ID: <200702141120.32776.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 12:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHIBj-0001a9-0h
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 12:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbXBNLUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 06:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXBNLUg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 06:20:36 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:36568 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932217AbXBNLUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 06:20:35 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 14 Feb 2007 11:23:13 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HHIBe-0007Q4-00
	for <git@vger.kernel.org>; Wed, 14 Feb 2007 11:20:34 +0000
X-TUID: 1d86ce3a1958bd6e
X-UID: 239
X-Length: 1576
Content-Disposition: inline
X-OriginalArrivalTime: 14 Feb 2007 11:23:13.0671 (UTC) FILETIME=[83FEC970:01C7502A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39635>

44478d99ee0 introduced a filter using "git-rev-parse --not --all" to the
log display to prevent the display of revisions already in the
repository.  However, the table of contents generation didn't get that
same update.

This patch fixes that.  The table of contents before the log and the log
now both display the same list of revisions.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
Apologies.  I should always wait a day before posting patches.

 templates/hooks--update |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index a7cf604..fd1f73d 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -57,7 +57,7 @@ announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
 # --- Check types
-newrev_type=$(git-cat-file -t "$newrev")
+newrev_type=$(git-cat-file -t $newrev)
 
 case "$refname","$newrev_type" in
 	refs/tags/*,commit)
@@ -165,7 +165,7 @@ case "$refname_type" in
 			baserev=$(git-merge-base $oldrev $newrev)
 
 			# Commit with a parent
-			for rev in $(git-rev-list $newrev ^$baserev)
+			for rev in $(git-rev-parse --not --all | git-rev-list --stdin $newrev ^$baserev)
 			do
 				revtype=$(git-cat-file -t "$rev")
 				echo "       via  $rev ($revtype)"
-- 
1.5.0.rc4.365.g5eff6-dirty
