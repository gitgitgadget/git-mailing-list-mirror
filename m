From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 1/5] rebase with preserve merges should not show merged commits
Date: Sat, 22 Mar 2008 15:08:23 +0100
Message-ID: <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 15:10:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd4Qk-0004oD-3Z
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbYCVOKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 10:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYCVOJs
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:09:48 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1551 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176AbYCVOJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:09:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 6C2F5488033; Sat, 22 Mar 2008 15:09:45 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4OX-0002Ln-VB; Sat, 22 Mar 2008 15:08:26 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4OZ-0000sD-9b; Sat, 22 Mar 2008 15:08:27 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77808>

The current version of git-rebase--interactive shows the user the commi=
ts
coming from a merge.

M---A---B
 \       \
  o---o---+---o branch

Rebasing branch on M with preserve merges gives the commits A and B. Bu=
t
if you mark them for editing or remove them the rebase fails. You must
keep them as they are. It's useless to bother the user with these commi=
ts
and might lead to mistakes.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8aa7371..e1ce44e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -162,6 +162,8 @@ pick_one_preserving_merges () {
 				new_parents=3D"$new_parents $new_p"
 				;;
 			esac
+		else
+			new_parents=3D"$new_parents $p"
 		fi
 	done
 	case $fast_forward in
@@ -513,7 +515,7 @@ do
 				echo $ONTO > "$REWRITTEN"/$c ||
 					die "Could not init rewritten commits"
 			done
-			MERGES_OPTION=3D
+			MERGES_OPTION=3D--first-parent
 		else
 			MERGES_OPTION=3D--no-merges
 		fi
--=20
1.5.4.4
