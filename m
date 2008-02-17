From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 4/5] git-submodule: prepare for the .git-file
Date: Sun, 17 Feb 2008 23:14:15 +0100
Message-ID: <1203286456-26033-5-git-send-email-hjemli@gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
 <1203286456-26033-3-git-send-email-hjemli@gmail.com>
 <1203286456-26033-4-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 23:16:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQroe-0004NO-9t
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYBQWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYBQWQP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:16:15 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:36783 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbYBQWQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:16:14 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m1HMFTks007281;
	Sun, 17 Feb 2008 23:15:33 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.gfde78
In-Reply-To: <1203286456-26033-4-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74193>

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
1.5.4.1.188.gdfa6c
