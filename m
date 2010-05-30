From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Improve error message in rebase conflict
Date: Sun, 30 May 2010 14:20:44 +0200
Message-ID: <1275222044-511-1-git-send-email-artagnon@gmail.com>
Cc: Dale Rowley <ddrowley@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 30 14:20:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIhVO-0006ac-V5
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 14:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab0E3MT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 08:19:28 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:58857 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab0E3MT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 08:19:28 -0400
Received: by ewy8 with SMTP id 8so748864ewy.28
        for <git@vger.kernel.org>; Sun, 30 May 2010 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5wBTuOdsj3DH80y7m0aVD6Wo+saXjnh+DVFXThUF+EY=;
        b=ChSVz7fRQn2ovX1jFwPFlPGCTasmQuyv5Ev83PH4xOGkswO3vwRgP2imO1hJ37HWJc
         6qcHBc/4XOCsrrbA68jFrGGTb+DupcdUKHubp4OcZgawpO+ZSZQq9L6GOYP/N57aW9Zn
         e1iHK3CpGSvNOwgWMzDMxDBe2Xfgcyx8bV7Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hUrj8MwSFTU9YLioI4Dnnisu9nwX85YidnIX9XmcmPhUVmKkN6QueXU6/Dc1UBvM5e
         KFkyQhRw+pcksElwZ7Uk4SuMy7hlfezuZn265G5f6rmq8PQZ5DK63mxUtdg+0fCmHYjj
         kGsnIfIGCxgL2GDCs4UuWCRIIABeQWtE5pGck=
Received: by 10.213.33.135 with SMTP id h7mr4605542ebd.56.1275221966696;
        Sun, 30 May 2010 05:19:26 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm2358666ewy.5.2010.05.30.05.19.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 05:19:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148001>

When the index is unchanged during a rebase conflict resolution,
prompt the user to "git add", or alternatively drop the patch using
"git rebase --skip".

Noticed-by: Dale Rowley <ddrowley@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh     |    4 +++-
 git-rebase.sh |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 87ffae2..3c46f60 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -725,7 +725,9 @@ do
 		# working tree.
 		resolved=
 		git diff-index --quiet --cached HEAD -- && {
-			echo "No changes - did you forget to use 'git add'?"
+			echo "No changes - did you forget to use 'git add'? " \
+				"If you dropped the changes introduced by the patch, " \
+				"you should use \"$cmdline --skip\"."
 			stop_here_user_resolve $this
 		}
 		unmerged=$(git ls-files -u)
diff --git a/git-rebase.sh b/git-rebase.sh
index 44f5c65..60cc0e9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -217,8 +217,8 @@ do
 			die "No rebase in progress?"
 
 		git diff-files --quiet --ignore-submodules || {
-			echo "You must edit all merge conflicts and then"
-			echo "mark them as resolved using git add"
+			echo "You must edit all merge conflicts and then" \
+			    "mark them as resolved using 'git add'"
 			exit 1
 		}
 		if test -d "$dotest"
-- 
1.7.1
