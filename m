From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/4] Teach git-submodule.sh about the .git file
Date: Wed, 20 Feb 2008 23:13:15 +0100
Message-ID: <1203545596-6337-4-git-send-email-hjemli@gmail.com>
References: <1203545596-6337-1-git-send-email-hjemli@gmail.com>
 <1203545596-6337-2-git-send-email-hjemli@gmail.com>
 <1203545596-6337-3-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxFQ-0006kZ-6p
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699AbYBTWQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756291AbYBTWQ0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:16:26 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:47466 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961AbYBTWQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:16:25 -0500
Received: from localhost.localdomain (ti231210a341-0590.bb.online.no [88.88.170.78])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m1KMEQAL024249;
	Wed, 20 Feb 2008 23:14:29 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
In-Reply-To: <1203545596-6337-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74553>

When git-submodule tries to detect 'active' submodules, it checks for the
existence of a directory named '.git'. This isn't good enough now that .git
can be a file pointing to the real $GIT_DIR so the tests are changed to
reflect this.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..e7c08b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -288,7 +288,7 @@ cmd_update()
 			continue
 		fi
 
-		if ! test -d "$path"/.git
+		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
 			subsha1=
@@ -362,7 +362,7 @@ cmd_status()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		if test -z "url" || ! test -d "$path"/.git
+		if test -z "url" || ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			say "-$sha1 $path"
 			continue;
-- 
1.5.4.1.188.g3ea1f5
