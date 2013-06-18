From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 12/13] bash prompt: avoid command substitution when
 checking for untracked files
Date: Tue, 18 Jun 2013 04:17:05 +0200
Message-ID: <1371521826-3225-13-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolVS-00082T-J7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3FRCSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60590 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab3FRCSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:46 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MUCN0-1UwygG2lBC-00R4Z6; Tue, 18 Jun 2013 04:18:38 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:KfaoF5i2ii0Ibjg/RxLzGqWmEsNku4tr02MWIBipwIa
 7g0b/M/Stfw7vIJfYCMkgWp3E7ufpKv0UV3/SE6jlMtCj43jTB
 VNqWnSXtm/LJ6o9w8EKSZEDuIQecm5lE2JcJ7LJd0wHiHHoDHm
 S1PUoXTXW43PDKnCYUGvPI5DlQnA87eJJLzltRAbMvE6TuCivz
 gRwPEkOXVxrdn53StfHzWNGRntjuvNS4zK/reQs2XYauoqWgbZ
 py/R0xlppzkKqtS/nXyWyl2oSDmLKqIu8s8USuDO1oEkf6V7ob
 XAT9QSw8VwU0BUN7I9v4WbBi0KWdh12UPLzdOWmIMmSXQwdIDC
 qgRxP1oMkA0R61Ci4BIcdasiT4xZby1agkYh38EzfWl7ebYIuv
 HIre3DT4Guhrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228145>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

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
index 208e2ec7..77575b2d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -428,7 +428,7 @@ __git_ps1 ()
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
1.8.3.1.487.g8f4672d
