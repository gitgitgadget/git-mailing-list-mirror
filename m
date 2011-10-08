From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 7/9] completion: improve ls-remote output filtering in
	__git_refs_remotes()
Date: Sat,  8 Oct 2011 16:54:41 +0200
Message-ID: <1318085683-29830-8-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYKS-0000qI-AJ
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1JHO4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:56:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:64964 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab1JHO4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:56:39 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MYrHb-1RZIHE43xz-00V5eP; Sat, 08 Oct 2011 16:56:32 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:uLdI1I+1QFAATLUt2JasvompJv+FLlpXKUus3t2Z8Ad
 /LnaxN5Eih/oyjJ6QqneEJ9pjxdLYE6V5tGd5fWgRfzxtAb8eo
 wRwwmZz6reM3ulYZNcb4iV6Bgvpvah5tMrukYYEMvS7Fg+sKni
 36Zr4w/cmtpsENoJDHWkit26LcREtophCqnZRfnFoiICjdRE6v
 NzKcxynBzTDx1G3OxcuV3QN4LqDdQt3D+LBWjKboBlkI8T7XIw
 H//UGD2h+4VfnqaZ3dKVwENkP3wpcDe7QiFLNT+XE1pGOmeVAD
 32FF8T9KIEqw4Jr+kzs56xxl1h1I+ePUvgpoeqrzkT4OvV1MGM
 8OIjPuTzggVJ8LdgifrZydnTQdESQ2v0Wq/Kokqu4YnhemJ/mt
 0buLCt3Oofarw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183151>

This follows suit of a previous patch for __git_refs(): use a
while-read loop and let bash's word splitting get rid of object names
from 'git ls-remote's output.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index dc1d5e90..658df3a7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -650,15 +650,10 @@ __git_refs2 ()
 # __git_refs_remotes requires 1 argument (to pass to ls-remote)
 __git_refs_remotes ()
 {
-	local i is_hash=3Dy
-	for i in $(git ls-remote "$1" 'refs/heads/*' 2>/dev/null); do
-		case "$is_hash" in
-		n)
-			is_hash=3Dy
-			echo "$i:refs/remotes/$1/${i#refs/heads/}"
-			;;
-		y) is_hash=3Dn ;;
-		esac
+	local i hash
+	git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	while read hash i; do
+		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
 }
=20
--=20
1.7.7.187.ga41de
