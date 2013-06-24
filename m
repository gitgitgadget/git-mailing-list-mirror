From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 14/16] bash prompt: avoid command substitution when checking
 for untracked files
Date: Mon, 24 Jun 2013 18:39:24 +0200
Message-ID: <1372091966-19315-15-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9tY-0004fL-9e
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab3FXQpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:45:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:57082 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab3FXQpc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:45:32 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M9RBC-1UzNLw0Ym6-00ChpT; Mon, 24 Jun 2013 18:45:30 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:BGzuKj+y23dxG+vPc/TbypTXG0cZrQ1lu1zJD7N4ncd
 kciIKD6awYDam0GMXZNY2+IpzOkATf/SCuSxVCThkRDfb8RMdm
 5zmL6fW9YdOS/n9FnP5JcbwppLq3dDrRnlWkof3PpuS3zNHUkc
 zcNc5U3rV84V0e8mDL8o/Paf63m7GQRUbIFh6AWy2gVTQdwHki
 HbsCGTpKXktlmt7pL5R4bEXZBRImgLH+t6j8O4HOH2q3hC8DQY
 +c2RVJYpZTakxS82G/qiAVGB/1tN24ujimuO8lYVekufvirNPG
 XU4a28gEQPl904AMZx6yvLYBBTiBR66DVa8aQCCIF9ka67e8MR
 qlCzIARTBdOjFy/wfv6ue5dW1hz98MA7ybODUV9QgzY7cH0Vj6
 x875gw+FlbKSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228866>

When enabled, the bash prompt can indicate the presence of untracked
files with a '%' sign.  __git_ps1() checks for untracked files by runni=
ng the
'$(git ls-files --others --exclude-standard)' command substitution,
and displays the indicator when there is no output.

Avoid this command substitution by additionally passing
'--error-unmatch *', and checking the command's return value.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index afa86703..5ea6a68b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -442,7 +442,7 @@ __git_ps1 ()
=20
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
 		   [ "$(git config --bool bash.showUntrackedFiles)" !=3D "false" ] &=
&
-		   [ -n "$(git ls-files --others --exclude-standard)" ]
+		   git ls-files --others --exclude-standard --error-unmatch -- '*' >=
/dev/null 2>/dev/null
 		then
 			u=3D"%${ZSH_VERSION+%}"
 		fi
--=20
1.8.3.1.599.g4459181
