From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] completion: use new 'git config' options to reliably list variable names
Date: Wed, 27 May 2015 22:07:20 +0200
Message-ID: <1432757240-4445-2-git-send-email-szeder@ira.uka.de>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxhcA-0006uj-2W
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbbE0UHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 16:07:40 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36897 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753634AbbE0UHj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 16:07:39 -0400
Received: from x590c2e9c.dyn.telefonica.de ([89.12.46.156] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Yxhbz-0006X1-1u; Wed, 27 May 2015 22:07:36 +0200
X-Mailer: git-send-email 2.4.2.347.ge926c0d
In-Reply-To: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1432757256.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270076>

List all set config variable names with 'git config --list-names' inste=
ad
of '--list' post processing.  Similarly, use 'git config
--get-name-regexp' instead of '--get-regexp' to get config variables in=
 a
given section.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6abbd56..121aa31 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -744,9 +744,8 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section=3D"$1" i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "^$secti=
on\..*" 2>/dev/null); do
-		i=3D"${i#$section.}"
-		echo "${i/ */}"
+	for i in $(git --git-dir=3D"$(__gitdir)" config --get-name-regexp "^$=
section\..*" 2>/dev/null); do
+		echo "${i#$section.}"
 	done
 }
=20
@@ -1774,15 +1773,7 @@ __git_config_get_set_variables ()
 		c=3D$((--c))
 	done
=20
-	git --git-dir=3D"$(__gitdir)" config $config_file --list 2>/dev/null =
|
-	while read -r line
-	do
-		case "$line" in
-		*.*=3D*)
-			echo "${line/=3D*/}"
-			;;
-		esac
-	done
+	git --git-dir=3D"$(__gitdir)" config $config_file --list-names 2>/dev=
/null
 }
=20
 _git_config ()
--=20
2.4.2.347.ge926c0d
