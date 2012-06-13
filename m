From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: put main git and gitk completion functions back
 into git namespace
Date: Wed, 13 Jun 2012 10:08:50 +0200
Message-ID: <1339574930-28149-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 10:09:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seidq-0006YC-VX
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 10:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab2FMIJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 04:09:18 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:1146 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab2FMIJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 04:09:15 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 13 Jun
 2012 10:08:51 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 13 Jun
 2012 10:08:53 +0200
X-Mailer: git-send-email 1.7.11.rc2.65.g240b4fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199879>

Commit 7f02f3d7 (completion: rename internal helpers _git and _gitk,
2012-05-19) renamed said functions to _main_git() and _main_gitk(),
respectively.  By convention the name of our git-completion-specific
functions start with '_git' or '__git' prefix, so rename those
functions once again to put them back into our "namespace".  Use the
two underscore prefix, because _git_main() could be mistaken for the
completion function of the (not yet existing) 'git main' command.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 1689f995..d486948a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2597,7 +2597,7 @@ _git_whatchanged ()
 	_git_log
 }
=20
-_main_git ()
+__git_main ()
 {
 	local i c=3D1 command __git_dir
=20
@@ -2648,7 +2648,7 @@ _main_git ()
 	fi
 }
=20
-_main_gitk ()
+__gitk_main ()
 {
 	__git_has_doubledash && return
=20
@@ -2703,22 +2703,22 @@ __git_complete ()
 # wrapper for backwards compatibility
 _git ()
 {
-	__git_wrap_main_git
+	__git_wrap__git_main
 }
=20
 # wrapper for backwards compatibility
 _gitk ()
 {
-	__git_wrap_main_gitk
+	__git_wrap__gitk_main
 }
=20
-__git_complete git _main_git
-__git_complete gitk _main_gitk
+__git_complete git __git_main
+__git_complete gitk __gitk_main
=20
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; then
-__git_complete git.exe _main_git
+__git_complete git.exe __git_main
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9a80c609..256e6a0b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -63,7 +63,7 @@ run_completion ()
 	local _cword
 	_words=3D( $1 )
 	(( _cword =3D ${#_words[@]} - 1 ))
-	__git_wrap_main_git && print_comp
+	__git_wrap__git_main && print_comp
 }
=20
 test_completion ()
--=20
1.7.11.rc2.65.g240b4fe
