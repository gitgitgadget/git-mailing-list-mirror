From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 2/2] Support shell scripts that run from symlinks into a git working dir
Date: Sat, 15 Nov 2008 07:11:35 -0800
Message-ID: <fff3a66296d7150a3ce07d39032bce668aa3ebd5.1226759762.git.marcel@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
 <096bfa3393a6c5ccaa550ae6363e7fcfc90867d1.1226759762.git.marcel@oak.homeunix.org>
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 16:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1MwC-0002IV-Gi
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 16:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYKOPSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 10:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYKOPS3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 10:18:29 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:26572 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751536AbYKOPS2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 10:18:28 -0500
Received: (qmail 27686 invoked from network); 15 Nov 2008 15:11:46 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp111.sbc.mail.mud.yahoo.com with SMTP; 15 Nov 2008 15:11:46 -0000
X-YMail-OSG: U3qc568VM1kKfMRANSHUqsuiWCyyCTup4JNCpWzdjmNWzNtqXsUkYSnvowhAjFN2etsKRk6P7gHtptGo71ZocX7oXmgRjrB11K4wVlfUNz1UEEGw9szcu.QuxO0fHRV.vXOKVxU6_Oqt_CQTUpCmK7FUoDBLYfUJIIJ7.C8NAT1xWZXe
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L1MoC-0006gV-Gi; Sat, 15 Nov 2008 07:11:36 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <096bfa3393a6c5ccaa550ae6363e7fcfc90867d1.1226759762.git.marcel@oak.homeunix.org>
In-Reply-To: <cover.1226759762.git.marcel@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101073>

Use "cd -P" instead of just "cd" when switching to the top level
of the git working directory.  When working from a symlink
into GIT_WORK_TREE, the shell function cd_to_toplevel will now
change to GIT_WORK_TREE rather than the parent of the symlink,
which may not even be the root of a git working directory.

Unfortunately this solution looks non-portable.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 git-sh-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dbdf209..4006150 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -85,7 +85,7 @@ cd_to_toplevel () {
 	cdup=$(git rev-parse --show-cdup)
 	if test ! -z "$cdup"
 	then
-		cd "$cdup" || {
+		cd -P "$cdup" || {
 			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
 			exit 1
 		}
-- 
1.6.0.3
